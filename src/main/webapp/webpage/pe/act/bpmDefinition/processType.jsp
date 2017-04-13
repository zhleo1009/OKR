<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>流程分类</title>
<t:base type="jquery,easyui,tools"></t:base>
<script type="text/javascript" src="pe/js/pe/platform/system/Share.js"></script>
</head>
<body style="overflow-y: hidden" scroll="no">
<t:formvalid formid="processTypeForm" dialog="true" layout="table" action="bpmDefinitionController.do?saveOrUpdateProcessType"
	callback="processTypeCB">

	<input id="typeId" name="typeId" type="hidden" value="${processType.typeId }">
	<input id="parentId" name="parentId" type="hidden" value="${parentId }">
	<input id="isRoot" name="isRoot" type="hidden" value="${isRoot }">
	<input id="isPrivate" name="isPrivate" type="hidden" value="${isPrivate }">
	
	<table style="width: 100%" cellpadding="0" cellspacing="1" class="formtable">
		<c:if test="${ parentName != ''}">
		
			<tr>
				<td align="right" width="25%" nowrap>
	                <label class="Validform_label">  父节点:  </label>
	            </td>
				<td class="value" width="85%">
	              	  ${parentName }
	            </td>
			</tr>
		</c:if>
		
		<tr>
			<td align="right" width="10%" nowrap><label class="Validform_label"> 名称: </label></td>
			<td class="value" width="10%">
                <input id="typeName" class="inputxt" name="typeName" value="${processType.typeName }" datatype="*">
            </td>
		</tr>
		<tr>
			<td align="right"><label class="Validform_label"> 节点key: </label></td>
			<td class="value">
				<input id="nodeKey" class="inputxt" name="nodeKey" value="${processType.nodeKey }" datatype="*">
            </td>
		</tr>
	</table>
</t:formvalid>
<script type="text/javascript">

	// 获取nodeKey拼音
	$("#typeName").change(function() {
		getFullSpell($(this).val());
	});

	function getFullSpell(typeName) {
		/* if ($("#nodeKey").val() != "")
			return; */
		Share.getPingyin({
			input : typeName,
			postCallback : function(data) {
				var obj = eval('(' + data + ')');
				$("#nodeKey").val(obj.output);
			}
		});
	}
	
	
	
</script>
</body>