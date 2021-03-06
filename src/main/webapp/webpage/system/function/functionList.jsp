<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<%--   update-start--Author:duanql  Date:20130619 for：操作按钮窗口显示控制--%>
<div id="system_function_functionList" class="easyui-layout" fit="true"><%--   update-end--Author:duanql  Date:20130619 for：操作按钮窗口显示控制--%>
<div region="center" style="padding:0px;border:0px">
    <t:datagrid name="functionList" title="menu.manage"
                actionUrl="functionController.do?functionGrid" idField="id" treegrid="true" pagination="false">
        <t:dgCol title="common.id" field="id" treefield="id" hidden="true"></t:dgCol>
        <t:dgCol title="menu.name" field="functionName" treefield="text"></t:dgCol>
        <t:dgCol title="common.icon" field="TSIcon_iconPath" treefield="code" image="true"></t:dgCol>
        <t:dgCol title="funcType" field="functionType" treefield="functionType" replace="funcType.page_0,funcType.from_1"></t:dgCol>
        <t:dgCol title="menu.url" field="functionUrl" treefield="src"></t:dgCol>
        <t:dgCol title="menu.order" field="functionOrder" treefield="order"></t:dgCol>
        <t:dgCol title="common.operation" field="opt" width="100"></t:dgCol>
        <t:dgDelOpt url="functionController.do?del&id={id}" title="common.delete"></t:dgDelOpt>
        <%--   update-start--Author:anchao  Date:20130415 for：按钮权限控制--%>
        <t:dgFunOpt funname="operationDetail(id)" title="button.setting"></t:dgFunOpt>
        <t:dgFunOpt funname="operationData(id)" title="数据规则"></t:dgFunOpt>
        <%--   update-end--Author:anchao  Date:20130415 for：按钮权限控制--%>
        <t:dgToolBar title="common.add.param" langArg="common.menu" icon="icon-add" url="functionController.do?addorupdate" funname="addFun"></t:dgToolBar>
        <t:dgToolBar title="common.edit.param" langArg="common.menu" icon="icon-edit" url="functionController.do?addorupdate" funname="update"></t:dgToolBar>
    </t:datagrid>
</div>
</div>
<%--   update-start--Author:duanql  Date:20130619 for：操作按钮窗口显示控制--%>
<div data-options="region:'east',
	title:'<t:mutiLang langKey="operate.button.list"/>',
	collapsed:true,
	split:true,
	border:true,
	onExpand : function(){
		li_east = 1;
	},
	onCollapse : function() {
	    li_east = 0;
	}"
	style="width: 400px; overflow: hidden;">
<div class="easyui-panel" style="padding:0px;border:0px" fit="true" border="false" id="operationDetailpanel"></div>
</div>
</div>

<script type="text/javascript">
$(function() {
	var li_east = 0;
});

//数据规则权数
function  operationData(fucntionId){
	if(li_east == 0){
	   $('#system_function_functionList').layout('expand','east'); 
	}
	$('#operationDetailpanel').panel("refresh", "functionController.do?dataRule&functionId=" +fucntionId);
}
//页面控件权限
function operationDetail(functionId)
{
	if(li_east == 0){
	   $('#system_function_functionList').layout('expand','east'); 
	}
	$('#operationDetailpanel').panel("refresh", "functionController.do?operation&functionId=" +functionId);
}

function addFun(title,url, id) {
	var rowData = $('#'+id).datagrid('getSelected');
	if (rowData) {
		url += '&TSFunction.id='+rowData.id;
	}
	add(title,url,'functionList');
}

</script>

