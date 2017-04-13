<%@page import="com.pe.platform.model.system.SysOfficeTemplate"%>
<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>

<style type="text/css">
.uploadBtnCls{
	margin: 15px;
}
</style>

<head>

<title>导入数据</title>
<t:base type="jquery,easyui,tools"></t:base>
</head>
<body style="overflow-y: hidden" scroll="no">
	
	<t:formvalid formid="formobj" layout="table" dialog="true"
		beforeSubmit="upload">
		<tr>
			<td class="value" width="100%">
                <t:upload name="files" buttonText="选择要导入的文件"
					uploader="excelTempletController.do?importExcel&tableName=${tableName}"
					extend="*.xls" id="file_upload" formData="documentTitle" buttonClass="uploadBtnCls" multi="true" />
            </td>
		</tr>
		<tr>
			<td class="value" width="100%">
                <div id="filediv" style="height: 50px; padding-left:15px"></div>
            </td>
		</tr>
	</t:formvalid>
</body>
</html>
