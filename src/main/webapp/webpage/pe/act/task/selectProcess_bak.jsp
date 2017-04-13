<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<link rel="stylesheet" type="text/css" href="plug-in/ztree/css/zTreeStyle.css">
<script type="text/javascript" src="plug-in/ztree/js/jquery.ztree.core-3.5.min.js"></script>
<script type="text/javascript" src="plug-in/ztree/js/jquery.ztree.excheck-3.5.min.js"></script>
<script type="text/javascript" src="plug-in/tools/curdtools_zh-cn.js"></script>
<html>
<head>
<title>流程分类列表</title>
<script type="text/javascript">
	//加载树
	var setting = {
		check : {
			enable : false,
			chkboxType : {
				"Y" : "",
				"N" : ""
			}
		},
		data : {
			simpleData : {
				enable : true
			}
		},
		callback : {
			onClick : onClick
		}
	};


	//加载数数据
	function loadTree() {
		$.post('bpmDefinitionController.do?byCatKeyForBpm', function(data) {
			$.fn.zTree.init($("#bpmProcTree"), setting, eval(data));
			var departSelect = $.fn.zTree.getZTreeObj("bpmProcTree"); 
			departSelect.expandAll(true); 
		});
	}
	
	// 首次进入加载level为1的部门树
	$(function() {
		loadTree();
		$('input[name="typeId"]').parent().css({
			"display" : "none"
		});
		$('input[name="isAllowApi"]').parent().css({
			"display" : "none"
		});
		
	});
	
	
	//点击节点，展现右侧列表
	function onClick(event, treeId, treeNode) {
		$('input[name="typeId"]').val(treeNode.id);
		if(treeNode.id=="3"){
			$('input[name="isAllowApi"]').val("1");
		}else{
			$('input[name="isAllowApi"]').val("");
		}
		
		selectorProcsearch();
	}


	//展开收起
	function treeExpandAll(type) {
		var bpmAgentTree = $.fn.zTree.getZTreeObj("bpmProcTree");
		bpmAgentTree.expandAll(type);
	};


</script>


<style type="text/css">
.alert-info {
	border-color: #3C8DBC;
	color: #31708f;
	background-color: #3C8DBC !important;
	margin: 3px;
	border-radius: 3px;
	color: #fff !important;
	font-weight: bold;
	padding: 3px;
}

.close {
	color: inherit;
	position: relative;
	right: -160px;
	top: -2px;
	color: #000;
	opacity: 0.6;
	cursor: pointer;
	background: rgba(0, 0, 0, 0) none repeat scroll 0 0;
	border: 0 none;
	cursor: pointer;
	padding: 0;
}

.close:hover {
	opacity: 1;
}

.link {
	float: left;
	margin: 0px 10px;
}
</style>

</head>
<body>

<div id='defLayout' class="easyui-layout" style="width:100%;height:500px;margin-top: 8px;">
      		<div data-options="region:'west',split:true" title="流程分类" style="width: 200px;">
				<a onclick="loadTree();"  class="l-btn l-btn-small" group="">
					<span class="l-btn-left"><span class="l-btn-text">刷新</span></span>
				</a>
				<a onclick="treeExpandAll(true);"  class="l-btn l-btn-small" group="">
					<span class="l-btn-left"><span class="l-btn-text">展开</span></span>
				</a>
				<a onclick="treeExpandAll(false);"  class="l-btn l-btn-small" group="">
					<span class="l-btn-left"><span class="l-btn-text">收起</span></span>
				</a>
				<ul id="bpmProcTree" class="ztree"></ul>
			
            </div>
      	    <div data-options="region:'center'" style="padding:0px;border:0px;" >
<!--           		<iframe id="defFrame" height="100%" width="100%" frameborder="0" src="taskController.do?forAgent"></iframe> -->
          		<t:datagrid name="selectorProc" title="流程选择" 
          					actionUrl="bpmDefinitionController.do?selector&pojo=bpmDefinition" 
          					checkbox="true"  fit="true" fitColumns="true" idField="defId" queryMode="group" 
		                    sortName="createTime" sortOrder="desc" >
		            <t:dgCol title="defId" field="defId" hidden="true"></t:dgCol>
		            <t:dgCol title="subject" field="subject" hidden="true"  ></t:dgCol>
		            <t:dgCol title="defKey" field="defKey" hidden="true"  ></t:dgCol>
		            <t:dgCol title="isAllowApi" field="isAllowApi" hidden="true"  ></t:dgCol>
		            <t:dgCol title="标题" sortable="false" field="subject"   ></t:dgCol>
		            <t:dgCol title="分类" sortable="false" field="typeName" ></t:dgCol>
		            <t:dgCol title="分类id" sortable="false" field="typeId" query="true" hidden="true" ></t:dgCol>
		            <t:dgCol title="版本" sortable="false" field="versionNo" ></t:dgCol>
		            <t:dgCol title="创建时间" sortable="false" field="createtime" formatterjs="formatterTime"  ></t:dgCol>
		        </t:datagrid>
            </div>
</div>


</body>
</html>
