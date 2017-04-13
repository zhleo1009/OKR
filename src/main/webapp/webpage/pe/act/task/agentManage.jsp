<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<link rel="stylesheet" type="text/css" href="plug-in/ztree/css/zTreeStyle.css">
<script type="text/javascript" src="plug-in/ztree/js/jquery.ztree.core-3.5.min.js"></script>
<script type="text/javascript" src="plug-in/ztree/js/jquery.ztree.excheck-3.5.min.js"></script>
<script type="text/javascript" src="plug-in/tools/curdtools_zh-cn.js"></script>
<html>
<head>
<title>代理任务列表</title>
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
		},
		async : {
			enable : true,
			url : "sysUserAgentController.do?treeSyn",
			autoParam : [ "id=parentid" ]
		}
	};

	// 首次进入加载level为1的部门树
	$(function() {
		loadTree();
		$('input[name="userId"]').parent().css({
			"display" : "none"
		});
		
	});

	function expandAll() {
		var zTree = $.fn.zTree.getZTreeObj("bpmAgentTree");
		var nodes = zTree.getNodes();
		for (var i=0, l=nodes.length; i<l; i++) {
			zTree.reAsyncChildNodes(nodes[i], "refresh", true);
		}
	}
	
	//点击节点，展现右侧列表
	function onClick(event, treeId, treeNode) {
		if (treeNode.id == "2") {
			$('input[name="userId"]').val("");
		} else {
			$('input[name="userId"]').val(treeNode.id);
		}
		userAgnetssearch();
	}

	//加载数数据
	function loadTree() {
		$.post('sysUserAgentController.do?tree', function(data) {
			var d = $.parseJSON(data);
			if (d.success) {
				var dbDate = eval(d.msg);
				$.fn.zTree.init($("#bpmAgentTree"), setting, dbDate);
				expandAll();
			}
		});
	}

	//展开收起
	function treeExpandAll(type) {
		var bpmAgentTree = $.fn.zTree.getZTreeObj("bpmAgentTree");
		bpmAgentTree.expandAll(type);
	};

	


	//执行任务
	function executeTask(taskId) {
		//加上代理参数
		var url = "/bpm/task/toStart.ht?taskId=" + taskId + "&agentTask=true";
		jQuery.openFullWindow(url);
	}

	//明细
	function findAttend(id,subject, content) {
		var url = "processRunController.do?procTabs&taskId=" + id;
		//var url = "processRunController.do?procTabs&runId=" + id;
		var index = top.layer.open({
			type : 2,
			title : "明细" + subject,
			shadeClose : true,
			shade : 0.8,
			maxmin : true, //开启最大化最小化按钮
			area : [ '800px', '500px' ],
			content : url, //iframe的url
			zIndex : top.layer.zIndex
		});
	}

	//执行
	function toStart(taskId) {
		var taskId = taskId;
		var url = 'taskController.do?toStart&taskId=' + taskId +"&agentTask=true";
		var index = top.layer.open({
			type : 2,
			title : '办理',
			shadeClose : true,
			shade : 0.8,
			area : [ '80%', '80%' ],
			content : url,
			zIndex : top.layer.zIndex,
			cancel : function() {
				//右上角关闭回调
				userAgnetssearch();
			}
		});
	}
	
	
	//锁定
	function claim(taskId){
		var urls = 'taskController.do?claim';
			$.ajax({
				url:urls,
				type:"post",
				data:{taskId:taskId,isAgent:"1"},
				dataType:"json",
				success:function(data){
					if(data.success){
						userAgnetssearch();
					}
				}
			});
	}

	//解锁
	function unlock(taskId){
		var urls = 'taskController.do?unlock';
			$.ajax({
				url:urls,
				type:"post",
				data:{taskId:taskId},
				dataType:"json",
				success:function(data){
					if(data.success){
						userAgnetssearch();
					}
				}
			});
	}
	
	
	
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

<div id='defLayout' class="easyui-layout" style="width:100%;height:100%;margin-top: 0px;">
      		<div data-options="region:'west',split:true" title="代理授权人" style="width: 200px;">
            	<!--  <div class="tree-toolbar" >
					<span class="toolBar">
						<a class="link reload" id="treeFresh" href="javascript:loadTree();">刷新</a>
						<a class="link expand" id="treeExpandAll" href="javascript:treeExpandAll(true)">展开</a>
						<a class="link collapse" id="treeCollapseAll" href="javascript:treeExpandAll(false)">收起</a>
					</span>
				</div>-->
				<a onclick="loadTree();"  class="l-btn l-btn-small" group="">
					<span class="l-btn-left"><span class="l-btn-text">刷新</span></span>
				</a>
				<a onclick="treeExpandAll(true);"  class="l-btn l-btn-small" group="">
					<span class="l-btn-left"><span class="l-btn-text">展开</span></span>
				</a>
				<a onclick="treeExpandAll(false);"  class="l-btn l-btn-small" group="">
					<span class="l-btn-left"><span class="l-btn-text">收起</span></span>
				</a>
				<ul id="bpmAgentTree" class="ztree"></ul>
			
            </div>
      	    <div data-options="region:'center'" style="padding:0px;border:0px;" >
<!--           		<iframe id="defFrame" height="100%" width="100%" frameborder="0" src="taskController.do?forAgent"></iframe> -->
          		<t:datagrid name="userAgnets" title="common.user.select" actionUrl="taskController.do?forAgent&pojo=taskEntity" checkbox="true" 
		                    fit="true" fitColumns="true" idField="id" queryMode="group" 
		                    sortName="createTime" sortOrder="desc" 
		                    onLoadSuccess="init"  onCheck="check" onUncheck="unCheck" 
		                     onCheckAll="checkAll" onUncheckAll="unCheckAll">
		            <t:dgCol title="id" field="id" hidden="true"></t:dgCol>
		            <t:dgCol title="userId" field="userId" hidden="true"  query="true"></t:dgCol>
		            <t:dgCol title="事项名称" sortable="false" field="subject" query="true" width="200" ></t:dgCol>
		            <t:dgCol title="流程名称" sortable="false" field="processName" query="true" width="200"></t:dgCol>
		            <t:dgCol title="任务名称" sortable="false" field="name" query="true" width="200"></t:dgCol>
		            <t:dgCol title="执行人"  sortable="false" field="assignee"  dictionary="sys_user,userId,fullname"  width="200" ></t:dgCol>
		            <t:dgCol title="创建时间" field="createTime" formatterjs="formatterTime"  width="200"></t:dgCol>
		            <%-- pe系统userId --%>
		            <t:dgCol title="管理" field="opt"  >
				    	<t:dgFunOpt title="明细" funname="findAttend(id,subject,assignee)" />
				    	<t:dgFunOpt exp="assignee#empty#true" title="锁定" funname="claim(id,assignee)" />
				    	<t:dgFunOpt exp="assignee#empty#false"  title="执行" funname="toStart(id,assignee)" />
				    </t:dgCol>
		        </t:datagrid>
            </div>
</div>


</body>

<script type="text/javascript">

function reloadMyAgentTask(){
	
	$("#userAgnets").datagrid('reload',{});
}

</script>
</html>
