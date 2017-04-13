<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<script src="plug-in/layer/layer.js"></script>

<script type="text/javascript">

var layerIndex ;
function toStart(taskId, processDefinitionId,taskDefinitionKey) {
	  var taskId = taskId;
	  var url = 'taskController.do?toStart&taskId='+taskId;
	  
	  var width = '80%';
	  var height = '80%';
	  
	  // 根据不同的业务展现不同的对话框大小
	  var pDef = processDefinitionId.split(':')[0];
	  
	  // 填写请假单
	  if((pDef == 'ptygqj' || pDef == 'bmfzrqj' || pDef == 'bmzrqj' || pDef == 'fycqj')&& taskDefinitionKey == 'task_1' ){
		  width = '850px';
		  height = '400px';
	  }
	  
	  // 销假归档
	  if((pDef == 'ptygxj' || pDef == 'bmfzrxj' || pDef == 'bmzrxj' || pDef == 'fycxj') && (taskDefinitionKey == 'task_1' || taskDefinitionKey == 'task_3')){
		  width = '850px';
		  height = '500px';
	  }
	  
	  // 考勤申诉
	  if(pDef == 'kqss' && taskDefinitionKey == 'task_1'){
		  width = '800px';
		  height = '400px';
	  }
	  
	  if(pDef == 'jfsq' && taskDefinitionKey == 'task_1'){
		  width = '800px';
		  height = '670px';
	  }
	  
	  //console.debug(top.find('body'));
	  
	  layerIndex = top.layer.open({
		  type: 2,
		  title: '流程执行',
		  shadeClose: true,
		  shade: 0.3,
		  area: [width, height],
		  zIndex : getzIndex(),
		  content: url 
		  /* ,   
		  end: function () {
		      $("#mytaskList").datagrid('reload',{});
	 	 } */
	}); 
}


function reloadDatagrid(){
	$("#mytaskList").datagrid('reload');
}
   
function detail(taskId,subject){
	// var url="taskController.do?detailTabs&isIframe&action&taskId="+taskId;
	 
		var url = "processRunController.do?procTabs&taskId=" + taskId;
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






function claim(taskId){
	
	var url = 'taskController.do?claim';
		$.ajax({
			url:"${pageContext.request.contextPath}/taskController.do?claim",
			type:"post",
			data:{taskId:taskId},
			dataType:"json",
			success:function(data){
				if(data.success){
					$("#mytaskList").datagrid('reload',{});
				}
			}
		});
		

}

function unlock(taskId){
	
	var url = 'taskController.do?unlock';
		$.ajax({
			url:"${pageContext.request.contextPath}/taskController.do?unlock",
			type:"post",
			data:{taskId:taskId},
			dataType:"json",
			success:function(data){
				if(data.success){
					$("#mytaskList").datagrid('reload',{});
				}
			}
		});
}


function closeLayer(){
	    window.parent.location.reload();
	    var index = this.layer.getFrameIndex(window.name); //获取当前窗体索引
	    this.layer.close(index); //执行关闭
}

//下属录入
function chooseUser(id) {
	$.dialog({
		content: 'url:'+'userController.do?userSelect',
		lock : true,
		zIndex: top.layer.zIndex,
		width:900,
		height:510,
		title:'选择人员',
		opacity : 0.3,
		cache:false,
	    ok: function(){
	    	var iframe = this.iframe.contentWindow;
	    	var rowsData = iframe.$('#userList1').datagrid('getSelections');
	    	if (!rowsData || rowsData.length==0) {
	    		top.layer.msg('<t:mutiLang langKey="common.please.select.item"/>');
	    		return;
	    	}
	    	var userId = rowsData[0].id;
	    	if('' != userId ){
		    	$.ajax({
					url : 'taskController.do?delegate',
					type : 'post',
					data : {
						userId : userId,
						taskId : id
					},
					cache : false,
					success : function(data) {
						var d = $.parseJSON(data);
						// 来源页面
						if (d.success) {
							var msg = d.msg;
							top.layer.msg(msg);
							iframe.windowapi.close();
							reloadTable();
						}else{
							var msg = d.msg;
							top.layer.msg(msg);
						}
					}
				}); 
	    	}
			return false;
	    },
	    cancelVal: '关闭',
	    cancel: function(){ 
		    //右上角关闭回调
			$("#mytaskList").datagrid('reload',{});
		  }   
	});
}

	</script>
	
	
<div id="main_role_list"  class="easyui-layout" fit="true">

  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="mytaskList" checkbox="false" 
  fitColumns="false" title="我的待办事项" 
  actionUrl="taskController.do?datagrid" idField="id" fit="true" queryMode="group">
   	<t:dgCol title="id" field="id" hidden="true"></t:dgCol>
   	<t:dgCol title="isShow" field="isShow" hidden="true"></t:dgCol>
	<t:dgCol title="流程名称" field="processName" queryStyle="padding-left:40px;width:100px;" query="true" autocomplete="true"  width="200"/>
	<t:dgCol title="事项名称" field="subject"  queryStyle="padding-left:40px;" query="true" autocomplete="true"  width="200"/>
	<t:dgCol title="任务名称" field="name"  queryStyle="padding-left:40px;" query="true" autocomplete="true"  width="200"/>
	<t:dgCol title="所属人" field="owner"  autocomplete="true" queryMode="single" dictionary="sys_user,userId,fullname"   />
	<t:dgCol title="流程定义id" field="processDefinitionId" hidden="true" />
	<t:dgCol title="流程任务定义key" field="taskDefinitionKey" hidden="true" />
	
	
	<t:dgCol title="执行人" field="assignee"  autocomplete="true" queryMode="single" dictionary="sys_user,userId,fullname"   />
	<t:dgCol title="状态" field="delegationState" hidden="true"  autocomplete="true"  />
    <t:dgCol title="创建时间" field="createTime"  formatterjs="formatterTime" />
    <t:dgCol title="到期时间" field="dueDate" formatterjs="formatterDate" />
    <t:dgCol title="操作" field="opt" ></t:dgCol>
    
    <t:dgFunOpt  title="明细" funname="detail(id,subject)" ></t:dgFunOpt>
	<t:dgFunOpt exp="isShow#eq#0" title="锁定" funname="claim(id)" ></t:dgFunOpt>
	<t:dgFunOpt exp="isShow#eq#1" title="主办" funname="toStart(id,processDefinitionId,taskDefinitionKey)" ></t:dgFunOpt>
	<t:dgFunOpt exp="isShow#eq#2" title="主办" funname="toStart(id,processDefinitionId,taskDefinitionKey)" ></t:dgFunOpt>
	<t:dgFunOpt exp="isShow#eq#3" title="主办" funname="toStart(id,processDefinitionId,taskDefinitionKey)" ></t:dgFunOpt>
	<t:dgFunOpt exp="isShow#eq#2" title="交办" funname="chooseUser(id)" ></t:dgFunOpt>

	
	
	<t:dgFunOpt exp="isShow#eq#3" title="交办" funname="chooseUser(id)" ></t:dgFunOpt>
	<t:dgFunOpt exp="isShow#eq#2" title="解锁" funname="unlock(id)" ></t:dgFunOpt>

	<t:dgFunOpt exp="isShow#eq#3" title="解锁" funname="unlock(id)" ></t:dgFunOpt>
	
	<c:if test="${row.id!=null} ">
    <t:dgFunOpt  title="主办" funname="claim(id)" ></t:dgFunOpt>
								</c:if> 	
								
    </t:datagrid>
  </div>
 </div>
 
 
 



<script src="webpage/jeecg/cgreport/core/cgreportConfigHeadList.js"></script>
 <script type="text/javascript">
 $(document).ready(function(){
 		//给时间控件加上样式
 });

 </script>
