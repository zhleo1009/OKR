<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<script src="plug-in/layer/layer.js"></script>
<script src="webpage/jeecg/cgreport/core/cgreportConfigHeadList.js"></script>
<script type="text/javascript">

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
   


//为某个任务分配人员
function assignTask(title,url,id){
	
	var rowsData = $('#'+id).datagrid('getSelections');
	if (!rowsData || rowsData.length==0) {
		top.layer.msg('<t:mutiLang langKey="common.please.select.item"/>');
		return;
	}
	var taskIds=new Array();
	
	for(var i=0;i<rowsData.length;i++){
		taskIds.push(rowsData[i].id);
	}
	$.dialog({
		content: 'url:'+'userController.do?userSelect',
		lock : true,
		zIndex: getzIndex(),
		width:510,
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
					url : 'taskController.do?assign',
					type : 'post',
					data : {
						userId : userId,
						taskIds : taskIds.join(',')
					},
					cache : false,
					success : function(data) {
						var d = $.parseJSON(data);
						// 来源页面
						if (d.success) {
							var msg = d.msg;
							top.layer.msg(msg);
							iframe.windowapi.close();
							$("#mytaskList").datagrid('reload',{});
						}
					}
				}); 
	    	}
	    
			return false;
	    },
	    cancelVal: '关闭',
	    cancel: true
	});
}

   function endProcess(taskId){
		top.layer.confirm('<t:mutiLang langKey="确定结束任务吗"/>？', function(index){
			$.ajax({
				url : 'taskController.do?endProcess',
				type : 'post',
				data : {
					taskId : taskId
				},
				cache : false,
				success : function(data) {
					var d = $.parseJSON(data);
					// 来源页面
					if (d.success) {
						var msg = d.msg;
						top.layer.msg(msg);
						$("#mytaskList").datagrid('reload',{});
					}
				}
			});
	});
   }


function deleteTask(title,url,id){
	
	var rowsData = $('#'+id).datagrid('getSelections');
	if (!rowsData || rowsData.length==0) {
		top.layer.msg('<t:mutiLang langKey="common.please.select.item"/>');
		return;
	}
	top.layer.confirm('<t:mutiLang langKey="confirm.remove.record"/>？', function(index){
			var taskIds=new Array();
			for(var i=0;i<rowsData.length;i++){
				taskIds.push(rowsData[i].id);
			}
			$.ajax({
				url : 'taskController.do?delete',
				type : 'post',
				data : {
					taskIds : taskIds.join(',')
				},
				cache : false,
				success : function(data) {
					var d = $.parseJSON(data);
					// 来源页面
					if (d.success) {
						var msg = d.msg;
						top.layer.msg(msg);
						$("#mytaskList").datagrid('reload',{});
					}
				}
			}); 
		  top.layer.close(index);
	});
    }

    



	</script>
	
	
<div id="main_role_list"  class="easyui-layout" fit="true">

  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="mytaskList" checkbox="true" 
  fitColumns="false" title="流程任务" 
  actionUrl="taskController.do?taskDatagrid" idField="id" fit="true" queryMode="group">
   	<t:dgCol title="id" field="id" hidden="true"></t:dgCol>
   	<t:dgCol title="isShow" field="isShow" hidden="true"></t:dgCol>
	<t:dgCol title="事项名称" field="subject"  queryStyle="padding-left:40px;" query="true"  width="200"/>
	<t:dgCol title="任务名称" field="name"  queryStyle="padding-left:40px;" query="true"  width="200"/>
	<t:dgCol title="所属人" field="owner"  autocomplete="true" dictionary="sys_user,userId,fullname"  />
	<t:dgCol title="执行人" field="assignee"  autocomplete="true" dictionary="sys_user,userId,fullname"  />
	<t:dgCol title="状态" field="delegationState"  autocomplete="true"  />
    <t:dgCol title="创建时间" field="createTime"  formatterjs="formatterTime" />
    
    <t:dgCol title="流程定义id" field="processDefinitionId" hidden="true" />
	<t:dgCol title="流程任务定义key" field="taskDefinitionKey" hidden="true" />
    
    <t:dgCol title="操作" field="opt" ></t:dgCol>
    <t:dgFunOpt  title="办理" funname="toStart(id, processDefinitionId,taskDefinitionKey)" ></t:dgFunOpt>
	<t:dgFunOpt  title="结束" funname="endProcess(id)" ></t:dgFunOpt>
	<t:dgToolBar title="分配任务" icon="icon-add" width="900" height="600" url="taskController.do?assign" funname="assignTask"></t:dgToolBar>
	<t:dgToolBar title="删除任务" icon="icon-edit" width="900" height="600" url="taskController.do?delete" funname="deleteTask"></t:dgToolBar>
	
								
    </t:datagrid>
  </div>
 </div>
 


