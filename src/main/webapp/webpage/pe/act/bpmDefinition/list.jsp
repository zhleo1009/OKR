<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>

    <div id="bpmDefinition" class="easyui-panel" title="流程定义" 
            style="width:100%;height:100%;">
            <table id="processDefList"></table>
    </div>

<%-- <t:datagrid name="processDefList" title="流程定义" 
            fitColumns="false" actionUrl="bpmDefinitionController.do?datagrid" idField="defId" fit="true" 
            checkbox="true" onLoadSuccess="loadSelectedBpm" >
            
	<t:dgCol title="id" field="defId" hidden="true"  />
	<t:dgCol title="标题" field="subject" sortable="false" />
	<t:dgCol title="流程定义key" field="defKey" sortable="false" hidden="true"/>
	<t:dgCol title="分类" field="typeName" sortable="false"/>
	<t:dgCol title="版本" field="versionNo" sortable="false"/>
	<t:dgCol title="状态" field="status" sortable="false" replace="未发布_0,已发布_1,禁用_2" style="color:green;_0,color:red;_2"/>
	<t:dgCol title="创建时间" field="createtime" sortable="false" formatterjs="formatterTime"/>

</t:datagrid> --%>

<script type="text/javascript">

function saveRoleBpm(){
	
}


$(function(){
	
	$('#bpmDefinition').panel({
	    tools:[{
	        iconCls:'icon-save',
	        handler:saveRoleBpm
	    }]
	}); 
	
	
	 $('#processDefList').datagrid({
	        url:'bpmDefinitionController.do?datagrid&field=defId,subject,defKey,typeName,versionNo,status',
	        idField:'defId',
	        striped:true,
	        rownumbers:true,
	        border:false,
	        fit:true,
	        fitColumns:true,
	        pagination:true,
	        pageSize:50,
	        columns:[[
	            {field:'defId',title:'defId',hidden:true},
	            {field:'ck',checkbox:'true'},
	            {field:'subject',title:'标题'},
	            {field:'defKey',title:'流程定义key'},
	            {field:'typeName',title:'分类'},
	            {field:'versionNo',title:'版本'},
	            {field:'status',title:'状态'}
	        ]],
	        onLoadSuccess : function(data){//获取用户所有具有权限的bpm定义
	        	$.ajax({
	      		  type: 'POST',
	      		  url: 'bpmDefinitionController.do?getUserBpmDefintions',
	      		  data :{roleId: '${roleId}'},
	      		  success: function(data){
	      			  if(data.success){
	      				 $.each( data.obj, function(i, n){ 
	      					 $('#processDefList').datagrid('selectRecord',n);
	      				});
	      				  
	      			  }
	      		  } ,
	      		  dataType: 'json'
	      	});
	        }
	    });
	
});


function saveRoleBpm(){

	var rowsData = $('#processDefList').datagrid('getSelections');
	var ids = [];
	for ( var i = 0; i < rowsData.length; i++) {
		ids.push(rowsData[i].defId);
	}
	$.ajax({
		  type: 'POST',
		  url: 'bpmDefinitionController.do?saveUserBpmDefintions',
		  data: {defIds: ids.join(','), roleId:'${roleId}'},
		  success: function(data){
			  top.layer.msg(data.msg);
			  $('#processDefList').datagrid('reload');
		  } ,
		  dataType: 'json'
	});
	
}


</script>
