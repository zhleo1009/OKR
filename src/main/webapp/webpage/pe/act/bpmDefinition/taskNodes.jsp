<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html >
<html>
<head>
<title>节点列表</title>
<t:base type="jquery,easyui,tools"></t:base>

<style type="text/css">
/* input[type="text"] {
    border: 1px solid #d7d7d7;
    border-radius: 3px;
    display: inline-block;
    font-size: 12px;
    height: 14px;
    line-height: 14px;
    padding: 4px 0 4px 5px;
    width: 150px;
} */
</style>
</head>
<body style="overflow-y: hidden;margin-top: 8px;" scroll="no">
	<table id="taskNodesTable"></table>
</body>
</html>
<script type="text/javascript">

$(function(){
	
	$('#taskNodesTable').datagrid({
        url:'bpmDefinitionController.do?taskNodes&actDefId=${actDefId}&nodeId=${nodeId}&field=nodeId,nodeName',
        idField:'nodeId',
        striped:true,
        rownumbers:true,
        border:true,
        singleSelect:true,
        fit:true,
        fitColumns:true,
        columns:[[
            {field:'nodeId',title:'nodeId',hidden:true},
            {field:'nodeName',title:'节点名称', width:'200px'},
        ]]
    });
});


function getSelectedTaskNode(){
	
	var taskNode = $('#taskNodesTable').datagrid('getSelected');
	if(taskNode){
		 var array = new Array(2); 
		 array[0] = taskNode.nodeId; 
		 array[1] = taskNode.nodeName; 
		return array;
	}else{
		top.layer.msg('请选择一项');
	}
	
}


</script>