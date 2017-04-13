<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>任务到期提醒模板</title>
<t:base type="jquery,easyui,tools"></t:base>

<script type="text/javascript">

$(function(){
	
	$('#taskRemainderTemplate').datagrid({
        url:'bpmDefinitionController.do?taskRemainderTemplatesDatagrid&field=templateId,name,content',
        idField:'templateId',
        striped:true,
        border:true,
        singleSelect:true,
        fit:true,
        fitColumns:true,
        zIndex : top.layer.zIndex,
        columns:[[
            {field:'templateId',title:'模板id',hidden:true},
            {field:'radio',title:'',formatter:radioFormatter},
            {field:'name',title:'模板名称'},
            {field:'content',title:'模板内容'}
        ]],
        'onSelect':function(index,row){
    		$('table tr').eq(index + 1).find('input[type=\'radio\']').attr("checked","checked");
    		var row = $('#taskRemainderTemplate').datagrid('getSelected');
    		var content = row.content;
    		content = content.replace(/\'/g,'\\\"');
    		$('#selectedTmp').val(content);
    	}
    });
	
});
	


function radioFormatter(){
	return "<input type=\"radio\" name=\"template\"/>";
}

/* // 操作
function operFormatter(val,row,index){
	var content = row.content;
	content = content.replace(/\'/g,'\\\"');// 转移字符转移
	return "[<a style='margin-left:3px;' href='javascript:chooseTemplate(\""+ content+"\");'>选择</a>]";
} */



</script>

</head>
<body style="overflow-y: hidden;margin-top: 8px;" scroll="no">
	
	<table id="taskRemainderTemplate" style="width: 100%;"></table>
	<input type="hidden" id="selectedTmp">
</body>
</html>
