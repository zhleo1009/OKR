<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>

<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  
  <t:datagrid name="myStart" checkbox="true"  fitColumns="false" title="我发起的流程" 
  actionUrl="processRunController.do?myStart&pojo=processRun" idField="runId" fit="true" queryMode="group">
   	<t:dgCol title="runId" field="runId" hidden="true" />
   	<t:dgCol title="recover" field="recover" hidden="true" />
   	<t:dgCol title="approve" field="approve" hidden="true" />
   	<t:dgCol title="actInstId" field="actInstId" hidden="true" />
   	<t:dgCol title="defKey" field="defKey" hidden="true" />
   	<t:dgCol title="businessKey" field="businessKey" hidden="true" />
	<t:dgCol title="流程名称" field="processName" query="true" autocomplete="true"  width="200"/>
	<t:dgCol title="流程标题" field="subject" query="true" autocomplete="true"  width="250" formatterjs="showDetailFormatter"/>
	<t:dgCol title="创建人" field="creator" query="true" autocomplete="true"  width="200"/>
    <t:dgCol title="创建时间" field="createTime" formatterjs="formatterTime"   width="120"/>
    <t:dgCol title="结束时间" field="endtime" formatterjs="formatterTime"   width="120"/>
    <t:dgCol title="持续时间" field="duration" formatterjs="showTime"   width="120"/>
    <t:dgCol title="状态" field="status" query="true" replace="正在运行_1,结束_2" style="color:red;_2,color:green;_1"  autocomplete="true"  />
    <t:dgCol title="管理" field="opt"  width="120"/>
    <t:dgFunOpt title="明细" funname="findAttend(runId,subject,status)" />
    <t:dgFunOpt exp="status#eq#1" title="催办" funname="urge(runId,actInstId,status)" />
	<t:dgFunOpt title="删除" funname="delProcess(runId,status,approve)" /> 
	<t:dgToolBar title="批量删除"  icon="icon-remove" url="processRunController.do?del"  funname="delProcesss"></t:dgToolBar>
    </t:datagrid>
  </div>
 </div>
<script src="webpage/jeecg/cgreport/core/cgreportConfigHeadList.js"></script>
<script type="text/javascript" src="plug-in/tools/curdtools_zh-cn.js"></script>
<script type="text/javascript">




function showTime(value,rec,index){
	 
	 
	return timeStamp(value/1000);
	 
	 
 }

    function timeStamp( second_time ){  
        
        var time = parseInt(second_time) + "秒";  
        if( parseInt(second_time )> 60){  
          
            var second = parseInt(second_time) % 60;  
            var min = parseInt(second_time / 60);  
            time = min + "分" + second + "秒";  
              
            if( min > 60 ){  
                min = parseInt(second_time / 60) % 60;  
                var hour = parseInt( parseInt(second_time / 60) /60 );  
                time = hour + "小时" + min + "分" + second + "秒";  
          
                if( hour > 24 ){  
                    hour = parseInt( parseInt(second_time / 60) /60 ) % 24;  
                    var day = parseInt( parseInt( parseInt(second_time / 60) /60 ) / 24 );  
                    time = day + "天" + hour + "小时" + min + "分" + second + "秒";  
                }  
            }  
          
        }  
        if("0秒"==time){
       	 return "";
        }
        return time;          
        }  







	//展现表单明细
	function showDetailFormatter(val, row, index) {
		var defKey = row.defKey;
		//console.debug(defKey);
		if(defKey == 'ptygqj' || defKey == 'bmfzrqj' || defKey == 'bmzrqj' || defKey == 'fycqj'){
			 return "<a onclick=\"showDetail('请假单详情【" + val + "】','leaveRequestController.do?goDetail&detail=true&id=" + row.businessKey + "','700px','400px')\" href=\"#\"><u>" 
				+ val + "</u></a>";
		}
		
		if(defKey == 'ptygxj' || defKey == 'bmfzrxj' || defKey == 'bmzrxj'){
			 return "<a onclick=\"showDetail('销假单详情【" + val + "】','leaveBackController.do?goDetail&detail=true&id=" + row.businessKey + "','700px','550px')\" href=\"#\"><u>" 
				+ val + "</u></a>";
		}else if(defKey == 'fycxj'){
			 return "<a onclick=\"showDetail('销假单详情【" + val + "】','leaveBackController.do?goDetail&detail=true&id=" + row.businessKey + "','700px','600px')\" href=\"#\"><u>" 
				+ val + "</u></a>";
		}
		
		if(defKey == 'jfsq'){
			 return "<a onclick=\"showDetail('积分换休假详情【" + val + "】','creditActivityController.do?goCheckAndAppeal&detail=true&id=" + row.businessKey + "','1000px','680px')\" href=\"#\"><u>" 
				+ val + "</u></a>";
		}
		
		
		//TODO  其他流程定义待添加
		
		return val;
		
	}
	
	
	// 员工请假单明细
	function showDetail(title, url,width,height){
		
		top.layer.open({
			title: title,
			type : 2,
			content : [ url, 'no' ],
			area : [ width, height ],
			btn : [ '取消' ]
		});
		
	}
	
	
	$(document).ready(function() {
		//给时间控件加上样式
	});
	
	
	function findAttend(id,subject, content) {
		var url = "processRunController.do?procTabs&runId=" + id;
		//createwindow("明细"+id,url,800,500);
		var index = top.layer.open({
			type : 2,
			title : "明细" + subject,
			shadeClose : true,
			shade : 0.8,
			maxmin : true, //开启最大化最小化按钮
			area : [ '800px', '500px' ],
			content : url, //iframe的url
			zIndex : top.layer.zIndex
		});
	}
	var iframe=null;
	//催办
	function urge(id, actInstId, content) {
		//检查当前任务的上一步是否为当前任务的执行人员，若不是，不允许追回
		var urls = "processRunController.do?urgeOwner&actInstId=" + actInstId;
		//createwindow("催办" + id, urls, 700, 470);
		$.dialog({
			content: 'url:'+urls,
			lock : true,
			zIndex: getzIndex(),
			width: '700px', 
			height: '470px', 
			title:'催办'+id,
			opacity : 0.3,
			cache:false,
		    ok: function(){
		    	iframe = this.iframe.contentWindow;
		    	iframe.saves(iframe);
				return false;
		    },
		    cancelVal: '关闭',
		    cancel: true
		});
	}

	function research(){
		iframe.windowapi.close();
		myStartsearch();
	}
	//删除流程
	function delProcess(runId, processstatus, approve, content) {
		var url = "processRunController.do?del";
		var warnstring;
		if (processstatus == 2) {
			warnstring = '流程已经在运行中,确认删除此条数据吗？';
		} else {
			warnstring = '确认删除吗？';
		}
		var flag = true;
		if (approve == 1 || approve == 4) {
			flag = false;
			layer.alert("提示信息", "选择的数据有的正在进行审批流程,请重新选择进行删除!");
			return;
		}
		if (approve == 2 || approve == 3) {
			flag = false;
			layer.alert("提示信息", "选择的数据有已经审批过的，请重新选择进行删除!");
			return;
		}
		if (flag) {
			top.layer.confirm(warnstring, {
				btn : [ '确定', '取消' ]
			//按钮
			}, function() {
				$.post(url, {
					"runId" : runId
				}, function(data) {
					var jsonResult = eval("(" + data + ")");
					if (jsonResult.success) {
						top.layer.msg(jsonResult.msg);
						myStartsearch();
					} else {
						top.layer.msg(jsonResult.msg);
					}
				});
			});
		}
	}
	
	
	
	function delProcesss(title,urls,id){
		var rowsData = $('#'+id).datagrid('getSelections');
		if (!rowsData || rowsData.length==0) {
			top.layer.msg('<t:mutiLang langKey="common.please.select.item"/>');
			return;
		}
		top.layer.confirm('<t:mutiLang langKey="confirm.remove.record"/>？', function(index){
				var ids=new Array();
				for(var i=0;i<rowsData.length;i++){
					ids.push(rowsData[i].runId);
				}
				$.ajax({
					url : urls,
					type : 'post',
					data : {
						runId : ids.join(',')
					},
					cache : false,
					success : function(data) {
						var d = $.parseJSON(data);
						var msg = d.msg;
						// 来源页面
						if (d.success) {
							top.layer.msg(msg);
							myStartsearch();
						}else{
							top.layer.msg(msg,{icon:2});
						}
					}
				}); 
		});
	    }
	
	
</script>
