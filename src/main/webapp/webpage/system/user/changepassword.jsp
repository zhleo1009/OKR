<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>用户信息</title>
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
<body style="overflow-y: hidden" scroll="no">
<t:formvalid formid="pswChangeForm" refresh="false" dialog="true" action="userController.do?savenewpwd" usePlugin="password" layout="table" styleClass="formvalid">
	<input id="id" type="hidden" value="${user.id }">
	
	<table style="width: 100%" cellpadding="0" cellspacing="1" class="formtable">
		<tr>
			<td align="right" width="25%" nowrap>
                <label class="Validform_label">  原密码:  </label>
            </td>
			<td class="value" width="85%">
                <input type="password" value="" name="password" class="inputxt" datatype="*" errormsg="请输入原密码" /> <span class="Validform_checktip"> 请输入原密码 </span>
            </td>
		</tr>
		
		<tr>
			<td align="right" width="25%" nowrap>
                <label class="Validform_label">  新密码:  </label>
            </td>
			<td class="value" width="85%">
                <input type="password" value="" name="newpassword" class="inputxt" plugin="passwordStrength" datatype="*6-18" errormsg="6-18个字符！" /> <span
					class="Validform_checktip"> 6-18个字符！ </span> <span class="passwordStrength" style="display: none;"><!--  <b>密码强度：</b> --> <span>弱</span><span>中</span><span class="last">强</span> </span>
            </td>
		</tr>
		
		<tr>
			<td align="right" width="25%" nowrap>
                <label class="Validform_label">  重复密码:  </label>
            </td>
			<td class="value" width="85%">
				<input id="newpassword" type="password" recheck="newpassword" class="inputxt" datatype="*6-18" errormsg="两次输入的密码不一致！"> <span class="Validform_checktip"></span>
				<button type="submit" id="submitBtn" style="display: none"/>
            </td>
		</tr>
		
	</table>
</t:formvalid>
</body>