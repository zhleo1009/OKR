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
                <label class="Validform_label">  标题:  </label>
            </td>
			<td class="value" width="85%">
                ${notice.noticeTitle}
            </td>
		</tr>
		<tr>
			<td align="right" width="25%" nowrap>
                <label class="Validform_label">  创建时间:  </label>
            </td>
			<td class="value" width="85%">
               <fmt:formatDate value='${notice.createTime}' type="date" pattern="yyyy-MM-dd hh:mm:ss"/>
            </td>
		</tr>
		<tr>
			<td align="right" width="25%" nowrap>
                <label class="Validform_label">   内容:  </label>
            </td>
			<td class="value" width="85%">
               ${notice.noticeContent}
            </td>
		</tr>
		
</table>
</t:formvalid>

</body>
</html>

