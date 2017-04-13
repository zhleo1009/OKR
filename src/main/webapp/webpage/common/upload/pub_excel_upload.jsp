<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>通用Excel导入${controller_name}</title>
<t:base type="jquery,easyui,tools"></t:base>

<style type="text/css">
.uploadBtnCls{
	margin: 15px;
}
</style>

</head>
<body style="overflow-y: hidden" scroll="no">
	<t:formvalid formid="formobj" layout="table" dialog="true"
		beforeSubmit="upload">
		<tr>
			<td class="value" width="100%">
				<%-- 由于firefox不支持，使用h5的方式上传 --%>
                <%-- <t:upload name="files" buttonText="选择要导入的文件"
					uploader="${controller_name}.do?importExcel" extend="*.xls;*.xlsx"
					id="file_upload" formData="documentTitle" buttonClass="uploadBtnCls" multi="true" /> --%>
			   
					<t:h5Upload name="files" buttonText="选择要导入的文件" 
						uploadScript="${controller_name}.do?importExcel" extend="application/vnd.ms-excel"
						id="file_upload" formData="documentTitle" buttonClass="uploadBtnCls" multi="true" />
					
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
