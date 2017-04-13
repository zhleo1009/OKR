<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
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
                <label class="Validform_label">  <t:mutiLang langKey="common.username"/>:  </label>
            </td>
			<td class="value" width="85%">
                ${user.userName}
            </td>
		</tr>
		<tr>
			<td align="right" width="25%" nowrap>
                <label class="Validform_label">  <t:mutiLang langKey="common.surname"/>:  </label>
            </td>
			<td class="value" width="85%">
               ${user.realName}
            </td>
		</tr>
		<tr>
			<td align="right" width="25%" nowrap>
                <label class="Validform_label">   <t:mutiLang langKey="common.phone"/>:  </label>
            </td>
			<td class="value" width="85%">
               ${user.mobilePhone}
            </td>
		</tr>
		<tr>
			<td align="right" width="25%" nowrap>
                <label class="Validform_label">   <t:mutiLang langKey="common.office.tel"/>:  </label>
            </td>
			<td class="value" width="85%">
               ${user.officePhone}
            </td>
		</tr>
		<tr>
			<td align="right" width="25%">
                <label class="Validform_label">   <t:mutiLang langKey="common.mail"/>:  </label>
            </td>
			<td class="value" width="85%">
               ${user.email}
            </td>
		</tr>
		
</table>
</t:formvalid>

</body>
</html>

