<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<script src="plug-in/layer/layer.js"></script>
<script type="text/javascript">
function showDetail(id,runId,taskId) {
	var id = id;
	var runId =  runId;
	var taskId =  taskId;
	
	var url = 'processRunController.do?procTabs&runId='+runId;
	
	top.layer.open({
  type: 2,
  title: '明细',
  shadeClose: true,
  shade: 0.6,
  area: ['1200px', '90%'],
  content: url //iframe的url
}); 
}


//任务收回
function back(id){
	
	$.ajax({
		url:"${pageContext.request.contextPath}/taskAssigneeController.do?back",
		type:"post",
		data:{id:id},
		dataType:"json",
		success:function(data){
			if(data.success){
				top.layer.msg(data.msg);
				
				$("#taskAssigneeList").datagrid('reload',{});
			}else{
				top.layer.msg(data.msg);
			}
		}
	});

}







	
	</script>
	
	
<div class="easyui-layout" fit="true">

  <div region="center" style="padding:0px;border:0px">
  
  
  
  <t:datagrid name="taskAssigneeList" checkbox="true" 
  fitColumns="false" title="我交办的任务" 
  actionUrl="taskAssigneeController.do?datagrid" idField="id" fit="true" queryMode="group">
  
   	<t:dgCol title="id" field="id" hidden="true"></t:dgCol>
   	<t:dgCol title="taskId" field="taskId" hidden="true"></t:dgCol>
   	<t:dgCol title="runId" field="runId" hidden="true"></t:dgCol>
	<t:dgCol title="任务交办人" field="userName" queryStyle="padding-left:40px;"   autocomplete="true"  width="200"/>
	<t:dgCol title="流程定义标题" field="subject"  autocomplete="true"  width="200"/>
	<t:dgCol title="任务名称" field="taskName" queryStyle="padding-left:40px;"  query="true" autocomplete="true"  width="200"/>
	<t:dgCol title="交办时间" field="assigneeTime"  formatterjs="formatterTime" />
	<t:dgCol title="执行状态" field="taskStatus"  query="true" autocomplete="true" style="color:red;_1,color:green;_0"  replace="待执行_0,已执行_1" />
	<t:dgCol title="备注" field="memo"  autocomplete="true"  />
	
    <t:dgCol title="操作" field="opt" ></t:dgCol>
   <t:dgFunOpt  title="明细" funname="showDetail(id,runId,taskId)" ></t:dgFunOpt>
    <t:dgFunOpt  title="收回" funname="back(id)" ></t:dgFunOpt>
 
    </t:datagrid>
  </div>
 </div>
<script src="webpage/jeecg/cgreport/core/cgreportConfigHeadList.js"></script>
 <script type="text/javascript">
 $(document).ready(function(){
 		//给时间控件加上样式
 });

 </script>
