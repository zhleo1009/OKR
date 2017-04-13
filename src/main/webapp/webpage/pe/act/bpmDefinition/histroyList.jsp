<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>表单设置</title>
<t:base type="jquery,easyui,tools"></t:base>

<script type="text/javascript">

$(function(){
	
	$('#versions').datagrid({
        url:'bpmDefinitionController.do?versions&defId=${defId}&field=defId,subject,defKey,typeName,versionNo,reason,createtime,updatetime,descp',
        idField:'nodeId',
        striped:true,
        border:true,
        singleSelect:true,
        fit:true,
        fitColumns:true,
        columns:[[
            {field:'defId',title:'defId',hidden:true},
            {field:'subject',title:'标题',width:'100'},
            {field:'defKey',title:'流程定义Key',width:'100'},
            {field:'typeName',title:'分类名称',width:'100'},
            {field:'versionNo',title:'版本号',width:'100'},
            {field:'reason',title:'修改原因',width:'100'},
            {field:'createtime',title:'创建时间',width:'120',formatter:formatterTime},
            {field:'updatetime',title:'修改时间',width:'120',formatter:formatterTime},
            {field:'descp',title:'描述',width:'100'},
            {field:'oper',title:'操作',formatter:operFormatter,width:'150'}
        ]]
    });
	
});

//操作按钮渲染
function operFormatter(val,row,index){
	return "[<a style='margin-left:3px;' href='javascript:deleteVersion("+ row.defId + ")'>删除</a>][<a style='margin-left:3px;' href='javascript:showDiagram("+ row.defId +")'>查看流程图</a>]";
}

// 展现流程图
function showDiagram(defId){
	
	/* $.dialog({
		content: 'url:bpmDefinitionController.do?design&defId=' + defId,
		lock : true,
		zIndex: top.layer.zIndex,
		width: 1000,
		height: 700,
		title: '编辑流程定义',
		opacity : 0.3,
		cache:false,
		min: false
	}).max();  */
	
	window.open('bpmDefinitionController.do?design&defId=' + defId);
}

// 删除历史版本
function deleteVersion(defId){
	
	top.layer.confirm('确认删除该条历史数据吗？', function(index){
		
		$.ajax({
			  type: 'POST',
			  url: 'bpmDefinitionController.do?delProcessDefinition',
			  data: {ids: defId, isOnlyVersion: true},
			  success: function(data){
				  top.layer.msg(data.msg);
				  if(data.success){
					  $('#versions').datagrid('reload');
					  top.layer.close(index);
				  }
			  } ,
			  dataType: 'json'
		});
		
	});
	
}


</script>

</head>
<body style="overflow-y: hidden;margin-top: 2px;padding: 2px;" scroll="no">
	
	<table id="versions"></table>

</body>
</html>
