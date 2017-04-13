<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,autocomplete"></t:base>

<div class="easyui-layout" fit="true" style="margin-top: 5px;">

	<!-- 流程定义分类tree -->
	<div region="west" style="width: 200px;" title="流程分类" split="true" collapsed="false">
		<div class="easyui-panel" style="padding:0px; border:0px;" fit="true" border="false">
			<a id="refreshTreeBtn" onclick="refreshTree();">刷新</a> 
			<a id="expandTreeBtn" onclick="expandTree();">展开</a>
			<a id="closeTreeBtn" onclick="closeTree();">收起</a>
			<ul id="processTypeTree"></ul>
		</div>
	</div>
	
	<!-- 右键菜单 -->
	<div id="menu" class="easyui-menu" style="width:120px;">
        <div onclick="typeAdd()" data-options="iconCls:'icon-add'">添加分类</div>
        <div onclick="typeUpdate()" data-options="iconCls:'icon-edit'">编辑分类</div>
        <div onclick="typeDelete()" data-options="iconCls:'icon-remove'">删除分类</div>
    </div>
    
    <!-- 右键菜单（root） -->
	<div id="menuRoot" class="easyui-menu" style="width:120px;">
        <div onclick="typeAdd()" data-options="iconCls:'icon-add'">添加分类</div>
    </div>
	
	<!-- 流程分类列表 -->
	<div region="center" style="padding:0px; border:0px;">
	
	<t:datagrid name="processDefList" title="流程定义" 
	            fitColumns="false" actionUrl="bpmDefinitionController.do?datagrid&status=1" idField="defId" fit="true" 
	            queryMode="group" checkbox="true">
	            
		<t:dgCol title="id" field="defId" hidden="true"  />
		<t:dgCol title="标题" field="subject" query="true" sortable="false" />
		<t:dgCol title="流程定义key" field="defKey" query="false" sortable="false" hidden="true" queryStyle="padding-left:40px"/>
		
		<t:dgCol title="分类" field="typeName" sortable="false"/>
		<t:dgCol title="版本" field="versionNo" sortable="false"/>
		<%-- <t:dgCol title="状态" field="status" sortable="false" replace="未发布_0,已发布_1,禁用_2" style="color:green;_0,color:red;_2" query="true"/> --%>
		
		<t:dgCol title="创建时间" field="createtime" sortable="false" formatterjs="formatterTime"/>
		
		<%--
		<t:dgCol title="common.operation" field="opt" width="600" ></t:dgCol>
		<t:dgFunOpt funname="showEditDesign(defId)" title="修改流程图"></t:dgFunOpt>
		<t:dgFunOpt exp="status#eq#0" title="发布" funname="deployProcess(defId)" urlStyle="color:green;"/>
		<t:dgFunOpt exp="status#eq#1" title="流程明细" funname="processDetail(defId)" />
		<t:dgFunOpt exp="status#eq#1" title="节点设置" funname="nodeSet(defId)"/>
		<t:dgFunOpt exp="status#eq#1" title="人员设置" funname="personSet(defId)"/>
		<t:dgFunOpt exp="status#eq#1" title="表单设置" funname="formSet(defId)" />
		<t:dgFunOpt exp="status#eq#1" title="变量设置" funname="variableSet(defId)" />
		<t:dgFunOpt exp="status#eq#1" title="按钮设置" funname="buttonSet(defId)" />
		<t:dgFunOpt exp="status#eq#1" title="历史版本" funname="historyVersion(defId)" />
		<t:dgFunOpt exp="status#eq#1" title="其他参数" funname="otherParamSet(defId)" /> --%>
	<%-- 	<t:dgToolBar title="添加流程定义" icon="icon-add" url="bpmDefinitionController.do?design" funname="showDesign"></t:dgToolBar>
   		<t:dgToolBar title="批量删除"  icon="icon-remove" url="bpmDefinitionController.do?delProcessDefinition" funname="deleteALLSelectPD"></t:dgToolBar> --%>
	
	</t:datagrid>
	</div>
</div>

<script type="text/javascript">

	$('#refreshTreeBtn').linkbutton({}); 
	$('#expandTreeBtn').linkbutton({});  
	$('#closeTreeBtn').linkbutton({});  

	function refreshTree(){
		$('#processTypeTree').tree('reload');
	}

	// 展开
	function expandTree(){
		$('#processTypeTree').tree('expandAll');
	}

	// 关闭
	function closeTree(){
		$('#processTypeTree').tree('collapseAll');
	}
	
	$(function() {
		//加载流程分类树
		$('#processTypeTree').tree({
			animate : true,
			url : 'bpmDefinitionController.do?getByCatKey&catType=FLOW_TYPE_ROOT',
			onClick : function(node) {
				$("#processDefList").datagrid('reload',{typeId:node.id});
			}
			
		});
		
	});
	
	

</script>
