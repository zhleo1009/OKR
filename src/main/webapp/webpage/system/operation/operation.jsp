<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>操作信息</title>
<t:base type="jquery,easyui,tools"></t:base>
<script type="text/javascript">
  </script>
</head>
<body style="overflow-y: hidden" scroll="no">
<t:formvalid formid="formobj" layout="table" dialog="true" action="functionController.do?saveop" tiptype="4">
	<input name="id" type="hidden" value="${operation.id}">
	<input name="TSFunction.id" value="${functionId}" type="hidden">
    <input name="status" type="hidden" value="0">
    
	<table style="width: 100%" cellpadding="0" cellspacing="1" class="formtable">
		<tr>
			<td align="right" width="25%" nowrap>
                 <label class="Validform_label"> <t:mutiLang langKey="operate.name"/>: </label>
            </td>
			<td class="value" width="85%">
				 <input name="operationname" class="inputxt" value="${operation.operationname}" datatype="s2-20">
           		 <span class="Validform_checktip"> <t:mutiLang langKey="operatename.rang2to20"/></span>
            </td>
		</tr>
		
		<tr>
			<td align="right" width="25%" nowrap>
                 <label class="Validform_label"> <t:mutiLang langKey="operate.code"/>: </label>
            </td>
			<td class="value" width="85%">
				 <input name="operationcode" class="inputxt" value="${operation.operationcode}">
            </td>
		</tr>
		
		<!-- 图标字段现在不用暂时隐藏-->
        <div class="form" style="display: none;">
            <label class="Validform_label"> <t:mutiLang langKey="common.icon.name"/>: </label>
            <select name="TSIcon.id">
                <c:forEach items="${iconlist}" var="icon">
                    <option value="${icon.id}" <c:if test="${icon.id==function.TSIcon.id }">selected="selected"</c:if>>${icon.iconName}</option>
                </c:forEach>
            </select>
        </div>
        
        <tr>
			<td align="right" width="25%" nowrap>
                <label class="Validform_label"> <t:mutiLang langKey="operation.type"/>: </label>
            </td>
			<td class="value" width="85%">
				<select name="operationType">
	                <option value="0" <c:if test="${operation.operationType eq 0}">selected="selected"</c:if>>
	                <t:mutiLang langKey="common.hide"/>
		            </option>
		            <option value="1" <c:if test="${operation.operationType>0}"> selected="selected"</c:if>>
		                <t:mutiLang langKey="operationType.disabled"/>
		            </option>
	            </select>
            </td>
		</tr>
		
	</table>
	
	<%-- <fieldset class="step">
        <div class="form">
            <label class="Validform_label"> <t:mutiLang langKey="operate.name"/>: </label>
            <input name="operationname" class="inputxt" value="${operation.operationname}" datatype="s2-20">
            <span class="Validform_checktip"> <t:mutiLang langKey="operatename.rang2to20"/></span>
        </div>
        <div class="form">
            <label class="Validform_label"> <t:mutiLang langKey="operate.code"/>: </label>
            <input name="operationcode" class="inputxt" value="${operation.operationcode}">
        </div>
        <!-- 图标字段现在不用暂时隐藏-->
        <div class="form" style="display: none;">
            <label class="Validform_label"> <t:mutiLang langKey="common.icon.name"/>: </label>
            <select name="TSIcon.id">
                <c:forEach items="${iconlist}" var="icon">
                    <option value="${icon.id}" <c:if test="${icon.id==function.TSIcon.id }">selected="selected"</c:if>>${icon.iconName}</option>
                </c:forEach>
            </select>
        </div>
        <div class="form">
            <label class="Validform_label"> <t:mutiLang langKey="operation.type"/>: </label>
            <select name="operationType">
                <option value="0" <c:if test="${operation.operationType eq 0}">selected="selected"</c:if>>
                <t:mutiLang langKey="common.hide"/>
	            </option>
	            <option value="1" <c:if test="${operation.operationType>0}"> selected="selected"</c:if>>
	                <t:mutiLang langKey="operationType.disabled"/>
	            </option>
            </select>
        </div>
	</fieldset> --%>
	
	
</t:formvalid>
</body>
</html>
