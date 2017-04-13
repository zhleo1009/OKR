<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  
  <t:datagrid name="myAttend" checkbox="true"  fitColumns="false" title="我审批的流程" 
  actionUrl="processRunController.do?myAttend&pojo=processRun" idField="runId" fit="true" queryMode="group">
   	<t:dgCol title="runId" field="runId" hidden="true" />
   	<t:dgCol title="recover" field="recover" hidden="true" />
	<t:dgCol title="流程名称" field="processName" query="true" queryStyle="padding-left:20px;" autocomplete="true"  width="200"/>
	<t:dgCol title="流程标题" field="subject" query="true" queryStyle="padding-left:20px;" autocomplete="true"  width="200"/>
	<t:dgCol title="创建人" field="creator" query="true" autocomplete="true"  width="200"/>
    <t:dgCol title="创建时间" field="createTime" formatterjs="formatterTime"   width="120"/>
    <t:dgCol title="结束时间" field="endtime" formatterjs="formatterTime"  width="120"/>
    <t:dgCol title="持续时间" field="duration" formatterjs="showTime" width="120"/>
    <t:dgCol title="状态" field="status" query="true" replace="正在运行_1,结束_2" style="color:red;_2,color:green;_1"  autocomplete="true"  />
    <t:dgCol title="操作" field="opt"  width="120"/>
    <t:dgFunOpt title="明细" funname="findAttend(runId,subject,status)" />
    <t:dgFunOpt exp="recover#eq#1" title="追回" funname="recover(runId,status)" />
    </t:datagrid>
  </div>s
 </div>
<script src="webpage/jeecg/cgreport/core/cgreportConfigHeadList.js"></script>
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





		$(document).ready(function() {
			//给时间控件加上样式
		});

		function findAttend(id,subject, content) {
			var url = "processRunController.do?procTabs&runId=" + id;
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

		//任务追回
		function recover(runId, content) {
			//检查当前任务的上一步是否为当前任务的执行人员，若不是，不允许追回
			var url = "processRunController.do?recover";
			$.post(url, {
				"runId" : runId
			}, function(data) {
				var dataObj = eval("(" + data + ")");
				if (dataObj.success) {
					top.layer.alert('任务成功的被追回！');
					myAttendsearch();
				} else {
					top.layer.alert('任务已经完成或正在处理，不能进行追回处理！', {
						icon : 2
					});
				}
			});
		}
	</script>
