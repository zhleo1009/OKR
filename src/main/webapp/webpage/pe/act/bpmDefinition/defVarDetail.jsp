<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>

<style type="text/css">
td {
    height: 17px;
}
</style>

<t:formvalid formid="formobj" layout="table" dialog="false" styleClass="formvalid">
<table style="width: 100%;" cellpadding="0" cellspacing="1" class="formtable">
		<tr>
			<td align="right" width="25%" nowrap>
                <label class="Validform_label">  流程定义ID:  </label>
            </td>
			<td class="value" width="85%">
                ${bpmDefVar.defId}
            </td>
		</tr>
		<tr>
			<td align="right" width="25%" nowrap>
                <label class="Validform_label">  变量名称:  </label>
            </td>
			<td class="value" width="85%">
				${bpmDefVar.varName}
            </td>
		</tr>
		<tr>
			<td align="right" width="25%" nowrap>
                <label class="Validform_label">   变量Key:  </label>
            </td>
			<td class="value" width="85%">
				${bpmDefVar.varKey}
            </td>
		</tr>
		<tr>
			<td align="right" width="25%" nowrap>
                <label class="Validform_label">   变量数据类型:  </label>
            </td>
			<td class="value" width="85%">
				<c:if test="${bpmDefVar.varDataType eq 'string'}">字符串</c:if>
				<c:if test="${bpmDefVar.varDataType eq 'number'}">数字</c:if>
				<c:if test="${bpmDefVar.varDataType eq 'date'}">日期</c:if>
            </td>
		</tr>
		<tr>
			<td align="right" width="25%">
                <label class="Validform_label">   默认值:  </label>
            </td>
			<td class="value" width="85%">
				${bpmDefVar.defValue}
            </td>
		</tr>
		<tr>
			<td align="right" width="25%">
                <label class="Validform_label">   actDeployId:  </label>
            </td>
			<td class="value" width="85%">
				${bpmDefVar.actDeployId}
            </td>
		</tr>
		<tr>
			<td align="right" width="25%">
                <label class="Validform_label">   作用域:  </label>
            </td>
			<td class="value" width="85%">
				<c:if test="${bpmDefVar.varScope eq 'global'}">全局</c:if>
				<c:if test="${bpmDefVar.varScope eq 'task'}">局部</c:if>
            </td>
		</tr>
		<tr>
			<td align="right" width="25%">
                <label class="Validform_label">   节点名称:  </label>
            </td>
			<td class="value" width="85%">
				${bpmDefVar.nodeName}
            </td>
		</tr>
		<tr>
			<td align="right" width="25%">
                <label class="Validform_label">   节点ID:  </label>
            </td>
			<td class="value" width="85%">
				${bpmDefVar.nodeId}
            </td>
		</tr>
</table>
</t:formvalid>

