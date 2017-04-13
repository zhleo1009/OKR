<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<script src="plug-in/layer/layer.js"></script>
<script type="text/javascript">





function detail(runId,subject){
		var url = "processRunController.do?procTabs&runId=" + runId;
		//createwindow("明细"+id,url,800,500);
		var index = top.layer.open({
			type : 2,
			title : "明细:" + subject,
			shadeClose : true,
			shade : 0.8,
			maxmin : true, //开启最大化最小化按钮
			area : [ '800px', '500px' ],
			content : url, //iframe的url
			zIndex : top.layer.zIndex
		});
	 
}



function toStart(taskId) {
	var taskId = taskId;
	var url = 'taskController.do?toStart&taskId='+taskId;
	top.layer.open({
  type: 2,
  title: '办理',
  shadeClose: true,
  shade: 0.8,
  area: ['80%', '80%'],
  content: url,
  end: function () {
      $("#taskAssigneeList").datagrid('reload',{});
  }
 
}); 
}

//任务追回
function recover(runId) {
	$.ajax({
		url:"${pageContext.request.contextPath}/processRunController.do?recover",
		type:"post",
		data:{runId:runId},
		dataType:"json",
		success:function(data){
			if(data.success){
				top.layer.msg('任务成功的被追回！');
				$("#taskAssigneeList").datagrid('reload',{});
			}else{
				top.layer.msg('任务已经完成或正在处理，不能进行追回处理！');
			}
		}
	});
}

	</script>
	
	
<div class="easyui-layout" fit="true">

  <div region="center" style="padding:0px;border:0px">
  
  
  
  <t:datagrid name="taskAssigneeList" checkbox="true" 
  fitColumns="false" title="我的待办事项" 
  actionUrl="myTaskController.do?datagrid" idField="id" fit="true" queryMode="group">
   
   	<t:dgCol title="id" field="id" hidden="true"></t:dgCol>
   	<t:dgCol title="taskId" field="taskId" hidden="true"></t:dgCol>
   	<t:dgCol title="runId" field="runId" hidden="true"></t:dgCol>
	<t:dgCol title="任务交办人" field="userName" queryStyle="padding-left:40px;"   autocomplete="true"  width="200"/>
	<t:dgCol title="流程标题" field="subject"  autocomplete="true"  width="200"/>
	<t:dgCol title="任务名称" field="taskName" queryStyle="padding-left:40px;"  query="true" autocomplete="true"  width="200"/>
	<t:dgCol title="交办时间" field="assigneeTime"  formatterjs="formatterTime"   />
	<t:dgCol title="执行状态" field="taskStatus" queryStyle="padding-left:40px;"  style="color:red;_1,color:green;_0"  query="true" autocomplete="true"  replace="待执行_0,已执行_1" />
	<t:dgCol title="备注" field="memo"  autocomplete="true"  />
    <t:dgCol title="操作" field="opt" ></t:dgCol>
    <t:dgFunOpt  title="明细" funname="detail(runId,subject)" ></t:dgFunOpt>
    <t:dgFunOpt exp="taskStatus#eq#0" title="办理" funname="toStart(taskId)" ></t:dgFunOpt>
    <t:dgFunOpt exp="taskStatus#eq#1" title="追回" funname="recover(runId)" ></t:dgFunOpt>
 
    </t:datagrid>
  </div>
 </div>
<script src="webpage/jeecg/cgreport/core/cgreportConfigHeadList.js"></script>
 <script type="text/javascript">
 $(document).ready(function(){
 		//给时间控件加上样式
 });

 </script>
