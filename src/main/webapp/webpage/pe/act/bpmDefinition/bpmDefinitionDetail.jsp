<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<%@taglib prefix="f" uri="http://www.pe.cn/functions" %>
<!DOCTYPE html>
<html>
<head>
<title>流程定义明细</title>
<t:base type="jquery,easyui,tools"></t:base>

<style type="text/css">

.formvalid{
	padding: 0px 5px;
}

td{
	height: 17px;
}

</style>
</head>
<body>
<t:formvalid formid="formobj" layout="table" dialog="false" styleClass="formvalid">
	<table style="width: 100%" cellpadding="0" cellspacing="1" class="formtable">
			<tr>
				<td align="right" width="25%" nowrap>
	                <label class="Validform_label">  分类:  </label>
	            </td>
				<td class="value" width="85%">
	                ${globalType.typeName}
	            </td>
			</tr>
			<tr>
				<td align="right" width="25%" nowrap>
	                <label class="Validform_label">  流程标题： </label>
	            </td>
				<td class="value" width="85%">
	                ${bpmDefinition.subject}
	            </td>
			</tr>
			<tr>
				<td align="right" width="25%" nowrap>
	                <label class="Validform_label">  流程定义Key： </label>
	            </td>
				<td class="value" width="85%">
	                ${bpmDefinition.defKey}
	            </td>
			</tr>
			<tr>
				<td align="right" width="25%" nowrap>
	                <label class="Validform_label">  任务标题生成规则： </label>
	            </td>
				<td class="value" width="85%">
	                ${bpmDefinition.taskNameRule}
	            </td>
			</tr>
			<tr>
				<td align="right" width="25%" nowrap>
	                <label class="Validform_label">  流程描述： </label>
	            </td>
				<td class="value" width="85%">
	                ${bpmDefinition.descp}
	            </td>
			</tr>
			<tr>
				<td align="right" width="25%" nowrap>
	                <label class="Validform_label">  创建人： </label>
	            </td>
				<td class="value" width="85%">
	                <f:userName userId="${bpmDefinition.createBy}"/>
	            </td>
			</tr>
			<tr>
				<td align="right" width="25%" nowrap>
	                <label class="Validform_label">  创建时间： </label>
	            </td>
				<td class="value" width="85%">
	                <fmt:formatDate value="${bpmDefinition.createtime}" pattern="yyyy-MM-dd HH:mm"/>
	            </td>
			</tr>
			<tr>
				<td align="right" width="25%" nowrap>
	                <label class="Validform_label">  更新人： </label>
	            </td>
				<td class="value" width="85%">
	                <f:userName userId="${bpmDefinition.updateBy}"/>
	            </td>
			</tr>
			
			<tr>
				<td align="right" width="25%" nowrap>
	                <label class="Validform_label">  更新原因： </label>
	            </td>
				<td class="value" width="85%">
	                ${bpmDefinition.reason}
	            </td>
			</tr>
			<tr>
				<td align="right" width="25%" nowrap>
	                <label class="Validform_label">  更新时间： </label>
	            </td>
				<td class="value" width="85%">
	                <fmt:formatDate value="${bpmDefinition.updatetime}" pattern="yyyy-MM-dd HH:mm"/>
	            </td>
			</tr>
			<tr>
				<td align="right" width="25%" nowrap>
	                <label class="Validform_label">  流程状态： </label>
	            </td>
				<td class="value" width="85%"><c:choose>
					<c:when test="${bpmDefinition.status==1}">
						<font color='green'>可用</font>
						</c:when>
						<c:otherwise>禁用</c:otherwise>
					</c:choose>
	            </td>
			</tr>
			
			<tr>
				<td align="right" width="25%" nowrap>
	                <label class="Validform_label">  版本号： </label>
	            </td>
				<td class="value" width="85%">
	                ${bpmDefinition.versionNo}
	            </td>
			</tr>
			
			<tr>
				<td align="right" width="25%" nowrap>
	                <label class="Validform_label">  activiti流程定义ID： </label>
	            </td>
				<td class="value" width="85%">
	                ${bpmDefinition.actDefId}
	            </td>
			</tr>
			
			<tr>
				<td align="right" width="25%" nowrap>
	                <label class="Validform_label">  act流程定义Key： </label>
	            </td>
				<td class="value" width="85%">
	                ${bpmDefinition.actDefKey}
	            </td>
			</tr>
	</table>
</t:formvalid>

</body>