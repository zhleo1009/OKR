<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>参数设置</title>
<t:base type="jquery,easyui,tools"></t:base>

<script type="text/javascript">

function reloadDefVar(){
	$('#defVarTable').datagrid('reload');
}

$(function(){
	
	$('#center').panel({
	    tools:[{
	        iconCls:'icon-reload',
	        handler:reloadDefVar
	    }]
	}); 
	
	
	var defId = $('#defId').val();
	
	 $('#defVarTable').datagrid({
	        url:'bpmDefinitionController.do?defVarList&defId=' + defId + '&field=varId,varName,varKey,varScope,nodeName',
	        idField:'varId',
	        striped:true,
	        rownumbers:true,
	        border:false,
	        singleSelect:false,
	        fit:true,
	        fitColumns:true,
	        nowrap: false,
	        toolbar: [{
	    		iconCls: 'icon-add',
	    		text : '添加',
	    		handler: addDefVar
	    	},{
	    		iconCls: 'icon-remove',
	    		text : '删除',
	    		handler: batchDelDefVar
	    	}],
	        columns:[[
				{field:'ck',checkbox:true},
	            {field:'varId',title:'varId',hidden:true,width:'80'},
	            {field:'varName',title:'变量名称',width:'80'},
	            {field:'varKey',title:'变量Key', width:'80'},
	            {field:'varScope',title:'作用域',formatter:scopeFormatter, width:'80'},
	            {field:'nodeName',title:'节点名称',width:'80'},
	            {field:'oper',title:'操作',formatter:operFormatter, width:'120'}
	        ]]
	    });
	
});

// 作用域渲染
function scopeFormatter(val,row,index){
	
	if(row.varScope == 'global'){
		return '全局';
	}else if(row.varScope == 'task'){
		return '局部';
	}
	
};


// 操作按钮渲染
function operFormatter(val,row,index){
	return "[<a style='margin-left:3px;' href='javascript:editDefVar("+ row.varId +"," + $("#defId").val() +")'>编辑</a>][<a style='margin-left:3px;' href='javascript:defVarDetail("+ row.varId +")'>明细</a>]";
}

// 编辑明细
function editDefVar(varId, defId){
	
	$.ajax({
		  type: 'POST',
		  url: 'bpmDefinitionController.do?toEditDefVarView',
		  data:  {varId: varId,
			      defId: defId},
		  success: function(html){
			  $('#east').html(html);
		  },
		  dataType: 'html'
	});
	
}


// 添加明细
function addDefVar(){
	var index = layer.load(2);
	$.ajax({
		  type: 'POST',
		  url: 'bpmDefinitionController.do?toEditDefVarView',
		  data:  {varId: '',
			      defId: $('#defId').val()},
		  success: function(html){
			  $('#east').html(html);
			  layer.close(index);
		  },
		  dataType: 'html'
	});
}

// 明细
function defVarDetail(varId){
	var index = layer.load(2);
	$.ajax({
		  type: 'POST',
		  url: 'bpmDefinitionController.do?getDefVarDetail',
		  data:  {varId: varId,
			      actDefId: $('#actDefId').val()},
		  success: function(html){
			  $('#east').html(html);
			  layer.close(index);
		  },
		  dataType: 'html'
	});
	
}

// 批量删除
function batchDelDefVar(){
    var ids = [];
    var rows = $("#defVarTable").datagrid('getSelections');
    if (rows.length > 0) {
    	top.layer.confirm('你确定永久删除该数据吗？', function(index){
    		for ( var i = 0; i < rows.length; i++) {
    			ids.push(rows[i].varId);
			}
			$.ajax({
				url : 'bpmDefinitionController.do?delDefVar',
				type : 'post',
				data : {
					ids : ids.join(',')
				},
				cache : false,
				success : function(data) {
					var d = $.parseJSON(data);
					var msg = d.msg;
					top.layer.msg(msg);
					if (d.success) {
						$("#defVarTable").datagrid('reload');
					}
					ids='';
				}
			});
    		top.layer.close(index);
    	});
    	
	} else {
		top.layer.msg("请选择需要删除的数据！");
	}
	
}


</script>

</head>
<body style="overflow-y: hidden;margin-top: 2px;padding: 2px;" scroll="no">
	
	
<input type="hidden" value="${defId}" id="defId"/>
<input type="hidden" value="${actDefId}" id="actDefId"/>

<div class="easyui-layout" fit="true">
	<div region="center" style="width: 55%;" title="流程变量" split="true" collapsed="false" id="center">
		<table id="defVarTable" ></table>
	</div>
	<div region="east" style="width: 45%;padding: 2px;" title="管理" split="true" collapsed="false" id="east">
		
	</div>
</div>

</body>
</html>
