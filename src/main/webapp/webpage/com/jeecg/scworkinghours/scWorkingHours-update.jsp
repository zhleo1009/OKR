<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
 <head>
  <title>项目工时表</title>
  <t:base type="jquery,easyui,tools,DatePicker"></t:base>
  <script type="text/javascript">
  //编写自定义JS代码
  </script>
 </head>
 <body>
		<t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" action="scWorkingHoursController.do?doUpdate" tiptype="4" >
					<input id="id" name="id" type="hidden" value="${scWorkingHoursPage.id }">
					<input id="deleteStatus" name="deleteStatus" type="hidden" value="${scWorkingHoursPage.deleteStatus }">
		<table style="width: 600px;" cellpadding="0" cellspacing="1" class="formtable">
					<tr>
						<td align="right">
							<label class="Validform_label">
								项目:
							</label>
						</td>
						<td class="value">
					
								  <t:dictSelect field="projectId" type="list" datatype="*"
									dictTable="project" dictField="id" dictText="project_name" defaultVal="${scWorkingHoursPage.projectId}" hasLabel="false"  title="项目"></t:dictSelect>   				
							
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">项目id</label>
						</td>
					</tr>
				
					<tr>
						<td align="right">
							<label class="Validform_label">
								日期:
							</label>
						</td>
						<td class="value">
									  <input id="workingDate" name="workingDate" datatype="*" type="text" style="width: 150px"  class="Wdate" onClick="WdatePicker()" value='<fmt:formatDate value='${scWorkingHoursPage.workingDate}' type="date" pattern="yyyy-MM-dd"/>'>
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
						     	 <input id="workingHours" name="workingHours"  datatype="*" type="text" style="width: 150px" class="inputxt"   value='${scWorkingHoursPage.workingHours}'>
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
						     	 <input id="note" name="note"  type="text" style="width: 150px" class="inputxt"  value='${scWorkingHoursPage.note}'>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">任务信息</label>
						</td>
					</tr>
			</table>
		</t:formvalid>
 </body>
  <script src = "webpage/com/jeecg/scworkinghours/scWorkingHours.js"></script>		
