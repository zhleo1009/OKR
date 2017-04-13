<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<script src="plug-in/layer/layer.js"></script>
<script src="webpage/jeecg/cgreport/core/cgreportConfigHeadList.js"></script>
<script type="text/javascript">

function showRunLog(runId){
	var url = "bpmRunLogController.do?bpmRunLogList&runId="+runId;
	var index = top.layer.open({
		type : 2,
		title : "日志" + runId,
		shadeClose : true,
		shade : 0.8,
		maxmin : true, //开启最大化最小化按钮
		area : [ '80%', '80%' ],
		content : url, //iframe的url
		zIndex : top.layer.zIndex
	});
}


   
function detail(taskId,subject){
	 var url="taskController.do?detailTabs&isIframe&action&taskId="+taskId;
	 createwindow(subject,url,800,500);
}

   function deleteProcessRun(runId){
		top.layer.confirm('<t:mutiLang langKey="确定删除实例吗"/>？', function(index){
			$.ajax({
				url : 'processRunController.do?del',
				type : 'post',
				data : {
					runId : runId
				},
				cache : false,
				success : function(data) {
					var d = $.parseJSON(data);
					// 来源页面
					if (d.success) {
						var msg = d.msg;
						top.layer.msg(msg);
						reloadTable();
					}
				}
			});
	});
   }

function removeProcessRun(title,url,runId){
	
	var rowsData = $('#'+runId).datagrid('getSelections');
	if (!rowsData || rowsData.length==0) {
		top.layer.msg('<t:mutiLang langKey="common.please.select.item"/>');
		return;
	}
	top.layer.confirm('<t:mutiLang langKey="confirm.remove.record"/>？', function(index){
		  
			var runId=new Array();
			for(var i=0;i<rowsData.length;i++){
				runId.push(rowsData[i].runId);
			}
			$.ajax({
				url : 'processRunController.do?del',
				type : 'post',
				data : {
					runId : runId.join(',')
				},
				cache : false,
				success : function(data) {
					var d = $.parseJSON(data);
					// 来源页面
					if (d.success) {
						var msg = d.msg;
						top.layer.msg(msg);
						reloadTable();
					}
				}
			}); 
	
	});
    }

		function findAttend(id, content) {
			var url = "processRunController.do?procTabs&runId=" + id;
			var index = top.layer.open({
				type : 2,
				title : "明细" + id,
				shadeClose : true,
				shade : 0.8,
				maxmin : true, //开启最大化最小化按钮
				area : [ '800px', '500px' ],
				content : url, //iframe的url
				zIndex : top.layer.zIndex
			});
		}

		
		 
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
		

	</script>
	
	
<div id="main_role_list"  class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="mytaskList" checkbox="true" 
  fitColumns="false" title="流程历史" 
  actionUrl="processRunController.do?historyDataGrid&pojo=processRun" idField="runId" fit="true" queryMode="group">
   	<t:dgCol title="runId" field="runId" hidden="true"></t:dgCol>
	<t:dgCol title="实例标题" field="subject"  queryStyle="padding-left:40px;" query="true" autocomplete="true"  width="200"/>
	<t:dgCol title="流程名称" field="processName"  queryStyle="padding-left:40px;" query="true" autocomplete="true"  width="200"/>
	<t:dgCol title="创建人" field="creator"  autocomplete="true"  />
	<t:dgCol title="创建时间" field="createtime"  formatterjs="formatterTime" />
	<t:dgCol title="结束时间" field="endTime"  formatterjs="formatterTime" />
	<t:dgCol title="持续时间" field="duration" formatterjs="showTime"/>
	<t:dgCol title="状态" field="status"  query="true" autocomplete="true" style="color:red;_2,color:green;_1" replace="正在运行_1,结束_2" />
	
    <t:dgCol title="操作" field="opt" ></t:dgCol>
    <t:dgFunOpt  title="删除" funname="deleteProcessRun(runId)" ></t:dgFunOpt>
	<t:dgFunOpt  title="日志" funname="showRunLog(runId)" ></t:dgFunOpt>
	<t:dgFunOpt  title="明细" funname="findAttend(runId,status)" />
	<t:dgToolBar title="删除" icon="icon-remove" width="900" height="600" url="processRunController.do?del" funname="removeProcessRun"></t:dgToolBar>
								
    </t:datagrid>
  </div>
 </div>
 


