<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>流程信息</title>
<t:base type="jquery,easyui,tools"></t:base>
<style type="text/css">
.formtable tr{
	height: 20px;
}

</style>
</head>
<body style="overflow-y: hidden" scroll="no" >
<t:formvalid formid="formobj" dialog="false"  layout="table" >
	<table style="width: 99%" cellpadding="0" cellspacing="1" class="formtable">
		<tr>
			<th align="right"  width="20%" nowrap> <label class="Validform_label">运行实例ID(runId)</label></th>
			<td class="value">${processRun.runId}</td>
		</tr>
		<tr>
			<th align="right"  width="20%" nowrap> <label class="Validform_label">流程定义ID:</label></th>
			<td class="value">${processRun.defId}</td>
		</tr>
		<tr>
			<th align="right"  width="20%" nowrap> <label class="Validform_label">流程实例标题:</label></th>
			<td class="value">${processRun.subject}</td>
		</tr>
		<tr>
			<th align="right"  width="20%" nowrap> <label class="Validform_label">创建人ID:</label></th>
			<td class="value">${processRun.creatorId}</td>
		</tr>
		<tr>
			<th align="right"  width="20%" nowrap> <label class="Validform_label">创建人:</label></th>
			<td class="value">${processRun.creator}</td>
		</tr>
		<tr>
			<th align="right"  width="20%" nowrap> <label class="Validform_label">创建时间:</label></th>
			<td class="value" id="createtime"></td>
		</tr>
		<tr>
			<th align="right"  width="20%" nowrap> <label class="Validform_label">业务表单简述:</label></th>
			<td class="value">${processRun.busDescp}</td>
		</tr>
		<tr>
			<th align="right"  width="20%" nowrap> <label class="Validform_label">状态:</label></th>
			<td class="value">
				<c:choose>
					<c:when test="${processRun.status==1}"><font color='green'>正在运行</font></c:when>
					<c:when test="${processRun.status==3}"><font color='green'>正在运行</font></c:when>
					<c:when test="${processRun.status==2}">结束</c:when>
				</c:choose>
			</td>
		</tr>
		<tr>
			<th align="right"  width="20%" nowrap> <label class="Validform_label">ACT流程实例ID:</label></th>
			<td class="value">${processRun.actInstId}</td>
		</tr>
		<tr>
			<th align="right"  width="20%" nowrap> <label class="Validform_label">ACT流程定义ID:</label></th>
			<td class="value">${processRun.actDefId}</td>
		</tr>
		<tr>
			<th align="right"  width="20%" nowrap> <label class="Validform_label">businessKey:</label></th>
			<td class="value">${processRun.businessKey}</td>
		</tr>
	</table>

</t:formvalid>
<script type="text/javascript">
$(function(){
	$("#createtime").html(formatterTime('${processRun.createtime}',null));
});

</script>
</body>
</html>
