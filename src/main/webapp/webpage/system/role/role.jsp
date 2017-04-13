<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title><t:mutiLang langKey="common.role.info"/></title>
<t:base type="jquery,easyui,tools"></t:base>
</head>
<body style="overflow-y: hidden" scroll="no">
<t:formvalid formid="formobj" layout="table" dialog="true" action="roleController.do?saveRole">

	<input name="id" type="hidden" value="${role.id}">
	<input type="hidden" class="btn_sub" id="btn_sub">
	<table style="width: 100%" cellpadding="0" cellspacing="1" class="formtable">
		<tr>
			<td align="right" width="25%" nowrap>
                <label class="Validform_label">角色编码:</label>
            </td>
			<td class="value" width="85%">
               <input name="roleName" class="inputxt" value="${role.roleName }" datatype="s2-8"> 
               <span class="Validform_checktip">角色编码在2~8位字符</span>
            </td>
		</tr>
		<tr>
			<td align="right" width="25%" nowrap>
               <label class="Validform_label"><t:mutiLang langKey="common.role.name"/>:</label>
            </td>
			<td class="value" width="85%">
               <input name="roleCode" id="roleCode" ajaxurl="roleController.do?checkRole&code=${role.roleCode }" class="inputxt" value="${role.roleCode }" datatype="s2-15"> 
               <span class="Validform_checktip"><t:mutiLang langKey="rolecode.rang2to15.notnull"/></span>
               
            </td>
		</tr>
		
	</table>
	
	<%-- <fieldset class="step">
	<div class="form"><label class="Validform_label"><t:mutiLang langKey="common.role.name"/>:</label> <input name="roleName" class="inputxt" value="${role.roleName }" datatype="s2-8"> <span class="Validform_checktip"><t:mutiLang langKey="rolescope.rang2to8.notnull"/></span>
	</div>
	<div class="form"><label class="Validform_label"> <t:mutiLang langKey="common.role.code"/>: </label> <input name="roleCode" id="roleCode" ajaxurl="roleController.do?checkRole&code=${role.roleCode }" class="inputxt"
		value="${role.roleCode }" datatype="s2-15"> <span class="Validform_checktip"><t:mutiLang langKey="rolecode.rang2to15.notnull"/></span></div>
	</fieldset> --%>
</t:formvalid>
</body>
</html>
