<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>

<input type="hidden" value="${defId}" id="defId"/>
<div class="easyui-layout" fit="true" style="margin-top: 7px;">
	<div region="west" style="width: 20%;" title="流程节点" split="true" collapsed="false" id="west">
		<table id="node" ></table>
	</div>
	<div region="center" style="width: 30%;" title="节点人员" split="true" collapsed="false" id="center">
		<table id="nodePerson" ></table>
	</div>
	<div region="east" style="width: 50%;" title="规则设置(拖拽改变顺序)" split="true" collapsed="false" id="east">
		
	</div>
</div>

<script type="text/javascript">

$(function(){
	
	$('#center').panel({
	    tools:[{
	        iconCls:'icon-reload',
	        handler:reloadNodePerson
	    }]
	}); 
	
	$('#west').panel({
	    tools:[{
	        iconCls:'icon-reload',
	        handler:reloadNode
	    }]
	}); 
	
	$('#east').panel({
	    tools:[{
	        iconCls:'icon-reload',
	        handler:toUserConditionEdit
	    }]
	}); 
	
	
    $('#node').datagrid({
        url:'bpmDefinitionController.do?getProcessNode&defId=${defId}&field=setId,nodeName,nodeId',
        idField:'nodeId',
        striped:true,
        rownumbers:true,
        border:false,
        singleSelect:true,
        fit:true,
        fitColumns:true,
        columns:[[
            {field:'setId',title:'setId',hidden:true},
            {field:'nodeName',title:'节点名称'},
            {field:'nodeId',title:'节点id'},
            {field:'oper',title:'操作',formatter:formatOper}
        ]]
    });
    

});


function formatOper (val,row,index){
	return '[<a href="#" onclick="editNodeUserDatagrid('+row.setId+',\''+ row.nodeId +'\')">节点人员</a>]';  
}

var currentNodeTag = null;

// 编辑人员
function editNodeUserDatagrid(setId,nodeTag){
	
	currentNodeTag = nodeTag;
	
	 $('#nodePerson').datagrid({
	        url:'bpmDefinitionController.do?getNodePerson&setId=' + setId + '&field=id,sn,conditionname,conditionShow',
	        idField:'id',
	        striped:true,
	        rownumbers:true,
	        border:false,
	        singleSelect:true,
	        fit:true,
	        fitColumns:true,
	        nowrap: false,
	        toolbar: [{
	    		iconCls: 'icon-add',
	    		text : '添加',
	    		handler: toUserConditionAdd
	    	},{
	    		iconCls: 'icon-edit',
	    		text : '编辑',
	    		handler: toUserConditionEdit
	    	},{
	    		iconCls: 'icon-remove',
	    		text : '删除',
	    		handler: delUserCondition
	    	}],
	        columns:[[
	            {field:'id',title:'id',hidden:true},
	            {field:'sn',title:'sn',hidden:true},
	            {field:'conditionname',title:'条件名称'},
	            {field:'conditionShow',title:'条件'},
	            {field:'oper',title:'位置调整',formatter:changePosition}
	        ]]
	    });
}

// 添加人员规则页面
function toUserConditionAdd(){
	
	var index = layer.load(2);
	$.ajax({
		  type: 'POST',
		  url: 'bpmDefinitionController.do?toConditionEdit',
		  data:  {defId: $('#defId').val(),
			  	  nodeTag: currentNodeTag},
		  success: function(html){
			  $('#east').html(html);
			  layer.close(index);
		  },
		  dataType: 'html'
	});
	
}

// 更新人员规则页面
function toUserConditionEdit(){
	
	var selectedRow = $('#nodePerson').datagrid('getSelected');
	if(selectedRow){
		var index = layer.load(2);
		$.ajax({
			  type: 'POST',
			  url: 'bpmDefinitionController.do?toConditionEdit',
			  data:  {defId: $('#defId').val(),
				  	  nodeTag: currentNodeTag,
				  	  conditionId: selectedRow.id},
			  success: function(html){
				  $('#east').html(html);
				  layer.close(index);
			  },
			  error: function(){
				  layer.close(index);
			  },
			  dataType: 'html'
		});
	}else{
		top.layer.msg('请选择一项');
	}
	
}




// 调整位置上下位置
function changePosition(val,row,index){
	return '<a style="margin-left:3px;" href="javascript:downCondition('+ row.id +',' + row.sn +',' + index +')"><img src="plug-in/easyui/themes/metrole/icons/down.png"/></a><a style="margin-left:10px;" href="javascript:upCondition('+ row.id +',' + row.sn +',' + index +')"><img  src="plug-in/easyui/themes/metrole/icons/up.png"/></a>';
}

// 人员位置上调
function upCondition(id,sn,index){
	
var rows = $('#nodePerson').datagrid('getRows');
	
	if(index != 0){
		var lastRow = rows[index - 1];
		updateSn(id,lastRow.sn, lastRow.id, sn);
	}
	
}

// 人员位置下调
function downCondition(id,sn,index){
	
	var rows = $('#nodePerson').datagrid('getRows');
	
	if(index != rows.length - 1){
		var nextRow = rows[index + 1];
		updateSn(id,nextRow.sn, nextRow.id, sn);
	}
	
}

// 更新sn
function updateSn(currentId, currentSn, otherId, otherSn){
	$.ajax({
		  type: 'POST',
		  url: 'bpmDefinitionController.do?updateSn',
		  data:  {currentId: currentId,
				  currentSn: currentSn,
				  otherId: otherId,
				  otherSn: otherSn},
		  success: function(data){
			  if(data.success){
				  layer.msg(data.msg);
				  reloadNodePerson();
			  }else{
				  layer.msg(data.msg);
			  }
		  },
		  dataType: 'json'
	});
}

// 刷新nodePerson
function reloadNodePerson(){
	try{
		$('#nodePerson').datagrid('reload');
	}catch(exception){
		
	}
}

// 刷新node
function reloadNode(){
	try{
		$('#node').datagrid('reload');
	}catch(exception){
		
	}
}



// 删除人员节点
function delUserCondition(){
	
	var selectedRows = $('#nodePerson').datagrid('getSelected');
	
	if(selectedRows){
		var id = selectedRows.id;
		$.ajax({
			  type: 'POST',
			  url: 'bpmDefinitionController.do?delUserCondition',
			  data:  {id: id},
			  success: function(data){
				  if(data.success){
					  layer.msg(data.msg);
					  reloadNodePerson();
				  }else{
					  layer.msg(data.msg);
				  }
			  },
			  dataType: 'json'
		});
	}else{
		top.layer.msg('请选择一项');
	}
	
	
	
}


</script>
