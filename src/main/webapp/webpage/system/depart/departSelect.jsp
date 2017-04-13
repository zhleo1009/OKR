<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html >
<html>
<head>
<title>组织机构集合</title>
<t:base type="jquery,easyui"></t:base>
<!-- update--start--by:jg_renjie--at:20160318 for:#942 【组件封装】组织机构弹出模式，目前是列表，得改造成树方式 -->
<!-- update-start--Author:jg_renjie  Date:20160317 for：组织机构改为ztree -->
<link rel="stylesheet" type="text/css" href="plug-in/ztree/css/zTreeStyle.css">
<script type="text/javascript" src="plug-in/ztree/js/jquery.ztree.core-3.5.min.js"></script>
<script type="text/javascript" src="plug-in/ztree/js/jquery.ztree.excheck-3.5.min.js"></script>
<!-- update-end--Author:jg_renjie  Date:20160317 for：组织机构改为ztree -->


<script type="text/javascript">
	var setting = {
	  check: {
			<c:if test="${param.multiFlag == 'false'}">
			  	enable: true,
				chkStyle: "radio",
				radioType: "level"
	  		</c:if>
			<c:if test="${param.multiFlag == 'true' or param.multiFlag == null}">
				enable: true,
				chkboxType: { "Y": "", "N": "" }
	  		</c:if>
		},
		data: {
			simpleData: {
				enable: true
			}
		},callback: {
			//onExpand: zTreeOnExpand
		},
		async: {
			enable: false,
			url: "departController.do?getDepartInfoByAsync",
			autoParam: ["id=parentid"]
		}
	};
	
	//加载展开方法
	/* function zTreeOnExpand(event, treeId, treeNode){
		 var treeNodeId = treeNode.id;
		 $.post(
			'departController.do?getDepartInfo',
			{parentid:treeNodeId},
			function(data){
				var d = $.parseJSON(data);
				if (d.success) {
					var dbDate = eval(d.msg);
					var tree = $.fn.zTree.getZTreeObj("departSelect");
					tree.removeChildNodes(treeNode);
					tree.addNodes(treeNode, dbDate);
				}
			}
		);
	} */
	
	//首次进入加载level为1的
	$(function(){
		$.post(
			'departController.do?getAllDepartInfo',
			function(data){
				var d = $.parseJSON(data);
				if (d.success) {
					var dbDate = eval(d.msg);
					$.fn.zTree.init($("#departSelect"), setting, dbDate);
					
					var departSelect = $.fn.zTree.getZTreeObj("departSelect"); 
					departSelect.expandAll(true); 
				}
			}
		);
		
	});
	
	// 刷新树
	function refreshTree(){
		var zTree = $.fn.zTree.getZTreeObj("departSelect");
        zTree.reAsyncChildNodes(null, "refresh");
	}
</script>
</head>
<body style="overflow-y: hidden" scroll="no">
<!-- <a onclick="refreshTree();"  class="l-btn l-btn-small" group="">
	<span class="l-btn-left"><span class="l-btn-text">重置</span></span>
</a> -->
<ul id="departSelect" class="ztree"></ul>
<%-- <t:datagrid name="departList" title="common.department.list" actionUrl="departController.do?departSelectDataGrid" idField="id" checkbox="true" showRefresh="false">
	<t:dgCol title="common.id" field="id" hidden="true"></t:dgCol>
	<t:dgCol title="common.department.name" field="departname" width="50"></t:dgCol>
</t:datagrid> --%>
</body>
</html>
<!-- update--end--by:jg_renjie--at:20160318 for:#942 【组件封装】组织机构弹出模式，目前是列表，得改造成树方式 -->