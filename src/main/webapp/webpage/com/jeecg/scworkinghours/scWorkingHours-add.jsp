<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
 <head>
  <title>项目工时表</title>
  <t:base type="jquery,easyui,tools,DatePicker"></t:base>
  <script type="text/javascript">
  
  
  

  
 

  
  function chooseProject() {
	  	$.dialog({
	  		content: 'url:'+'projectController.do?projectSelect',
	  		lock : true,
	  		zIndex: 9999,
	  		width:600,
	  		height:510,
	  		title:'选择项目',
	  		opacity : 0.3,
	  		cache:false,
	  	    ok: function(){
	  	    	var iframe = this.iframe.contentWindow;
	  	    	var rowsData = iframe.$('#projectList1').datagrid('getSelections');
	  	    	if (!rowsData || rowsData.length==0) {
	  	    		top.layer.msg('<t:mutiLang langKey="common.please.select.item"/>');
	  	    		return;
	  	    	}
	  	    	
	  	    	var projectId = rowsData[0].id;
	  	    	var projectName =  rowsData[0].projectName;
	  	    	$("#projectId").val(projectId);
	  	    	$("#projectName").val(projectName);
	  	    	
	  	    },
	  	    cancelVal: '关闭',
	  	    cancel: function(){ 
	  		    //右上角关闭回调
	  			$("#mytaskList").datagrid('reload',{});
	  		  }   
	  	});
	  }
  </script>
 </head>
 <body>
  <t:formvalid  styleClass="vform" formid="formobj" dialog="true" usePlugin="password" layout="table" action="scWorkingHoursController.do?doAdd" tiptype="4" >
					<input id="id" name="id" type="hidden" value="${scWorkingHoursPage.id }">
		<table style="width: 600px;" cellpadding="0" cellspacing="1" class="formtable">
				<tr>
					<td align="right">
						<label class="Validform_label">
							项目名称:
						</label>
					</td>
					<td class="value">
						
				<!-- <t:dictSelect field="projectId" type="list" datatype="*"
									
			dictTable="project" dictField="id" dictText="project_name" defaultVal="" hasLabel="false"  title="项目"></t:dictSelect>   				
				-->
							<input id="projectId" name="projectId" type="hidden">
							<input id="deleteStatus" name="deleteStatus" type="hidden">
						    <input id="projectName" datatype="*" name="projectName" readonly="readonly" onfocus="chooseProject();"  style="width: 150px" class="inputxt">
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">项目名称</label>
						</td>
				</tr>
				
			<!-- <tr>
					<td align="right">
						<label class="Validform_label">
							员工名称:
						</label>
					</td>
					<td class="value">
						<input id="userId" name="userId" type="hidden">
						<input id="userName" name="userName" readonly="readonly" onfocus="chooseUser();"  style="width: 150px" class="inputxt">
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">员工id</label>
						</td>
				</tr>
			-->	
				<tr>
					<td align="right">
						<label class="Validform_label">
							日期:
						</label>
					</td>
					<td class="value">
							   <input id="workingDate" name="workingDate" type="text" style="width: 150px" 
					      			datatype="*"	nullmsg="请填写用户名!" class="Wdate" onClick="WdatePicker()"
>    
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">日期</label>
						</td>
				</tr>
				
				
				
				
				<tr>
					<td align="right">
						<label class="Validform_label">
							工时:
						</label>
					</td>
					<td class="value">
					
					  <input id="workingHours" name="workingHours" type="text" datatype="workHours" errormsg="必须为数字,范围为0-24" style="width: 150px" class="inputxt" > 
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">工时</label>
						</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							任务信息:
						</label>
					</td>
					<td class="value">
					     	 <input id="note" name="note" type="text" style="width: 150px" class="inputxt" >
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">备注信息</label>
						</td>
				</tr>
			</table>
		</t:formvalid>
 </body>
  <script src = "webpage/com/jeecg/scworkinghours/scWorkingHours.js"></script>		
