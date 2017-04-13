<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html >
<html>
<head>
<title>角色集合</title>
<t:base type="jquery,easyui,tools"></t:base>

<style type="text/css">
input[type="text"] {
    border: 1px solid #d7d7d7;
    border-radius: 3px;
    display: inline-block;
    font-size: 12px;
    height: 14px;
    line-height: 14px;
    padding: 4px 0 4px 5px;
    width: 150px;
}
</style>
</head>
<body style="overflow-y: hidden;margin-top: 8px;" scroll="no">
<t:datagrid  pagination="false"  name="roleList" title="common.role.select"  actionUrl="userController.do?datagridRole" idField="id" checkbox="true" showRefresh="false"  fit="true"  queryMode="group" onLoadSuccess="initCheck">
	<t:dgCol title="common.id" field="id" hidden="true"></t:dgCol>
	<t:dgCol title="common.role.name" field="roleName" width="50" query="true" ></t:dgCol>
	<t:dgCol title="common.pe.role.id" field="peId" hidden="true" ></t:dgCol>
</t:datagrid>
</body>
</html>
<script type="text/javascript">
function initCheck(data){
	var ids = "${ids}";
	var idArr = ids.split(",");
	for(var i=0;i<idArr.length;i++){
		if(idArr[i]!=""){
			$("#roleList").datagrid("selectRecord",idArr[i]);
		}
	}
}
</script>