<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<t:base type="jquery,easyui"></t:base>
</head>
<body >
<t:tabs id="tt" iframe="false" tabPosition="top" fit="true" >
	<t:tab iframe="processRunController.do?userImage&runId=${runId}&taskId=${taskId}" title="流程示意图" id="pnode"></t:tab>
	<t:tab iframe="taskOpinionController.do?list&runId=${runId}&taskId=${taskId }" title="流程记录" id="processImage"></t:tab>
	<t:tab iframe="processRunController.do?procTabInfo&runId=${runId}&taskId=${taskId }" title="流程运行明细" id="processInfo"></t:tab>
</t:tabs>
</body>