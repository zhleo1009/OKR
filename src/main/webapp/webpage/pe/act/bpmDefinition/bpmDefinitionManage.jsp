<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,autocomplete"></t:base>

<div class="easyui-layout" fit="true">

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
	            fitColumns="false" actionUrl="bpmDefinitionController.do?datagrid" idField="defId" fit="true" 
	            queryMode="group" checkbox="true">
	            
		<t:dgCol title="id" field="defId" hidden="true"  />
		<t:dgCol title="标题" field="subject" query="true" sortable="false" />
		
		<t:dgCol title="流程定义key" field="defKey" query="true" sortable="false" hidden="true" queryStyle="padding-left:40px"/>
		
		<t:dgCol title="分类" field="typeName" sortable="false"/>
		<t:dgCol title="版本" field="versionNo" sortable="false"/>
		<t:dgCol title="状态" field="status" sortable="false" replace="未发布_0,已发布_1,禁用_2" style="color:green;_0,color:red;_2" query="true"/>
		<t:dgCol title="创建时间" field="createtime" sortable="false" formatterjs="formatterTime"/>
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
		<t:dgFunOpt exp="status#eq#1" title="其他参数" funname="otherParamSet(defId)" />
		
		<t:dgToolBar title="添加流程定义" icon="icon-add" url="bpmDefinitionController.do?design" funname="showDesign"></t:dgToolBar>
   		<t:dgToolBar title="批量删除"  icon="icon-remove" url="bpmDefinitionController.do?delProcessDefinition" funname="deleteALLSelectPD"></t:dgToolBar>
   		
	
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
			},
		    onContextMenu: function(e,node){
                e.preventDefault();
                $(this).tree('select',node.target);
                if(node.id == 3){// root
                	 $('#menuRoot').menu('show',{
                         left: e.pageX,
                         top: e.pageY
                     });
                }else{
                	 $('#menu').menu('show',{
                         left: e.pageX,
                         top: e.pageY
                     });
                }
               
            }
			
		});
		
		
	});
	
	// 添加流程分类节点
	function typeAdd(){
		var node = $("#processTypeTree").tree("getSelected");
	    var isRoot = node.id == 3?'1':'0';
		  $.dialog({
			content: 'url:bpmDefinitionController.do?getProcessTypeView&parentId=' + node.id + '&isRoot=' + isRoot,
			lock : true,
			zIndex: getzIndex(),
			width: 500,
			height: 150,
			title:'流程定义添加',
			opacity : 0.3,
			cache:false,
		    ok: function(){
		    	iframe = this.iframe.contentWindow;
				saveObj();
				return false;
		    },
		    cancelVal: '关闭',
		    cancel: true
		}); 
		 
	}
	
	
	// 编辑流程分类节点
	function typeUpdate(){
		
		var node = $("#processTypeTree").tree("getSelected");
	    var isRoot = node.id == 3?'1':'0';
		  $.dialog({
			content: 'url:bpmDefinitionController.do?getProcessTypeView&parentId=' + node.id + '&isRoot=' + isRoot + '&typeId=' + node.id,
			lock : true,
			zIndex: getzIndex(),
			width: 500,
			height: 150,
			title:'流程定义编辑',
			opacity : 0.3,
			cache:false,
		    ok: function(){
		    	iframe = this.iframe.contentWindow;
				saveObj();
				return false;
		    },
		    cancelVal: '关闭',
		    cancel: true
		}); 
		 
		
	}
	
	function typeDelete(){
		
		top.layer.confirm('确认删除吗？', function(index){
			var node = $("#processTypeTree").tree("getSelected");
			
			$.ajax({
				  type: 'POST',
				  url: 'bpmDefinitionController.do?delProcessType',
				  data: {typeId: node.id},
				  success: function(data){
					  if(data.success){
						  $('#processTypeTree').tree('remove', node.target);
						  top.layer.msg(data.msg);
					  }else{
						  top.layer.msg(data.msg);
					  }
				  } ,
				  dataType: 'json'
			});
			
			top.layer.close(index);
			  
		});
		
	}
	
	
	// 成功添加或更新后回调函数
	function processTypeCB(data){
		if(data.success){
			var node = $("#processTypeTree").tree("getSelected");
			if(node.id != data.attributes.id){//新增
				$('#processTypeTree').tree('append', {
					parent: node.target,
					data: [{
						id: data.attributes.id,
						text: data.attributes.text
					}]
			 	});
			}else{// 更新
				if (node){
					$('#processTypeTree').tree('update', {
						target: node.target,
						text: data.attributes.text
					});
				}
			}
			 
		}
		
	}
	
	// 工具栏批量删除 
	function deleteALLSelectPD(){
		
		deleteALLSelect('批量删除','bpmDefinitionController.do?delProcessDefinition','processDefList','defId');
		
	}
	
	// 新建流程设计图
	function showDesign(title,url,id){
		   /* $.dialog({
				content: 'url:' + url,
				lock : true,
				zIndex: getzIndex(),
				width: 1000,
				height: 700,
				title:title,
				opacity : 0.3,
				cache:false,
				min: false
			}).max();   */
		   
		   window.open(url);
	}
	
	// 编辑流程设计
	function showEditDesign(defId){
		
		/* var index = top.layer.open({
			  type: 2,
			  content: 'bpmDefinitionController.do?design&defId=' + defId,
			  area: ['300px', '195px'],
			  maxmin: true
			});
			top.layer.full(index); */
		
		/* $.dialog({
			content: 'url:bpmDefinitionController.do?design&defId=' + defId,
			lock : true,
			zIndex: getzIndex(),
			width: 1000,
			height: 700,
			title: '编辑流程定义',
			opacity : 0.3,
			cache:false,
			min: false
		}).max();  */
		
		window.open('bpmDefinitionController.do?design&defId=' + defId);
	}
	
	
	// 流程设计器关闭后回调页面，刷新datagrid列表页面
	function reloadPDTable(){
		$('#processDefList').datagrid('reload');
	}
	
	// 发布流程定义
	function deployProcess(defId){
		
		top.layer.confirm('确认发布该流程？', function(index){
			$.ajax({
				  type: 'POST',
				  url: 'bpmDefinitionController.do?deploy',
				  data: {defId: defId},
				  success: function(data){
					  if(data.success){
						  reloadPDTable();
						  top.layer.msg(data.msg);
					  }else{
						  top.layer.msg(data.msg);
					  }
					  top.layer.close(index);
				  },
				  dataType: 'json'
			});
			
		});
		
	}
	
	// 流程定义明细
	function processDetail(defId){
		top.layer.open({
			type : 2,
			title: '流程明细',
			content : 'bpmDefinitionController.do?getProcessDetail&defId=' + defId,
			area : [ '600px', '470px' ]
		});
		
	}
	
	// 人员设置
	function personSet(defId){
		/* var index = top.layer.open({
			  type: 2,
			  content: 'bpmDefinitionController.do?toPersonSetView&defId=' + defId,
			  area: ['1300px', '500px'],
			  maxmin: true,
			  zIndex: top.layer.zIndex
			});
		 */
		
		$.dialog({
			content: 'url:bpmDefinitionController.do?toPersonSetView&defId=' + defId,
			lock : true,
			/* zIndex: 1000, */
			width: 1300,
			height: 500,
			title: '人员设置',
			cache:false,
			min: false,
			cancel: true
		}); 
		
		
	}
	
	// 表单设置
	function formSet(defId){
		
		$.dialog({
			content: 'url:bpmDefinitionController.do?toNodeSetlist&defId=' + defId,
			lock : true,
			zIndex: getzIndex(),
			width: 800,
			height: 400,
			title: '表单设置',
			cache:false,
			min: false,
			ok: function(){
		    	var iframe = this.iframe.contentWindow;
		    	iframe.save();
				return false;
		    },
			cancelVal: '关闭',
			cancel: true
		}); 
		
	}
	
	
	// 按钮设置
	function buttonSet(defId){
		
		/* $.dialog({
			content: 'url:bpmDefinitionController.do?nodeButtonList&defId=' + defId,
			lock : true,
			zIndex: getzIndex(),
			width: 800,
			height: 400,
			title: '按钮设置',
			opacity : 0.3,
			cache:false,
			min: false,
			ok: function(){
		    	var iframe = this.iframe.contentWindow;
		    	iframe.save();
				return false;
		    },
			cancelVal: '关闭',
			cancel: true
		});  */
		
		top.layer.open({
			type : 2,
			title: '按钮设置',
			content : 'bpmDefinitionController.do?nodeButtonList&defId=' + defId,
			area : [ '800px', '400px' ]
		});
		
	}
	
	
//历史版本
function historyVersion(defId){
	top.layer.open({
		type : 2,
		title: '历史版本',
		content : 'bpmDefinitionController.do?historyList&defId=' + defId,
		area : [ '1000px', '500px' ]
	});
	
}


//变量设置
function variableSet(defId){
	top.layer.open({
		type : 2,
		title: '变量设置',
		content : 'bpmDefinitionController.do?toDefVarView&defId=' + defId,
		area : [ '1000px', '400px' ]
	});
	
}


// 其他参数设置
function otherParamSet(defId){
	
	top.layer.open({
		type : 2,
		title: '其他参数',
		content : 'bpmDefinitionController.do?toOtherParamView&defId=' + defId,
		area : [ '800px', '450px' ],
		zIndex : getzIndex()
	});
	
}

// 节点设置
function nodeSet(defId){
	
	top.layer.open({
		type : 2,
		title: '节点设置',
		content : 'bpmDefinitionController.do?nodeSet&defId=' + defId,
		area : [ '1000px', '500px' ],
		maxmin: true,
		zIndex : getzIndex()
	});
	
}


</script>
