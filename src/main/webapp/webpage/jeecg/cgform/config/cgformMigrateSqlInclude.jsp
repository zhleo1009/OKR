<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>SQL导入</title>
<t:base type="jquery,easyui,tools"></t:base>

<style type="text/css">
.uploadBtnCls{
	margin: 15px;
}
</style>

</head>
<body style="overflow-y: hidden" scroll="no">
	<%-- <t:formvalid formid="formobj" layout="div" dialog="true"
		beforeSubmit="upload">
		<fieldset class="step">
			<div class="form">
				<t:upload name="fiels" buttonText="选择要导入的文件"
					uploader="cgformSqlController.do?doMigrateIn" extend="*.zip"
					id="file_upload" formData="documentTitle"></t:upload>
			</div>
			<div class="form" id="filediv" style="height: 50px"></div>
		</fieldset>
	</t:formvalid> --%>
	
	<t:formvalid formid="formobj" layout="table" dialog="true"
		beforeSubmit="upload">
		<tr>
			<td class="value" width="100%">
               <t:upload name="fiels" buttonText="选择要导入的文件"
					uploader="cgformSqlController.do?doMigrateIn" extend="*.zip"
					id="file_upload" formData="documentTitle"  buttonClass="uploadBtnCls" multi="true"></t:upload>
			</div>
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

