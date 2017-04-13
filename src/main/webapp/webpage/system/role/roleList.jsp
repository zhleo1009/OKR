<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>

<div id="main_role_list" class="easyui-layout" fit="true">
    <div region="center" style="padding:0px;border:0px">
	<t:datagrid name="roleList" title="common.role.list" actionUrl="roleController.do?roleGrid" 
	    idField="id" sortName="createDate" sortOrder="desc">
		<t:dgCol title="common.code" field="id" hidden="true"></t:dgCol>
		<t:dgCol title="common.role.code" field="roleCode"></t:dgCol>
		<t:dgCol title="common.role.name" field="roleName" query="true"></t:dgCol>
		<t:dgCol title="common.createby" field="createBy" hidden="true"></t:dgCol>
		<t:dgCol title="common.createtime" field="createDate" formatter="yyyy-MM-dd" hidden="true"></t:dgCol>
		<t:dgCol title="common.updateby" field="updateBy" hidden="true"></t:dgCol>
		<t:dgCol title="common.updatetime" field="updateDate" formatter="yyyy-MM-dd" hidden="true"></t:dgCol>
		<t:dgCol title="common.operation" field="opt"></t:dgCol>
		<t:dgFunOpt funname="delRole(id)" title="common.delete"></t:dgFunOpt>
		<t:dgFunOpt funname="userListbyrole(id,roleName)" title="common.user"></t:dgFunOpt><%-- 用户 --%>
		<t:dgFunOpt funname="setfunbyrole(id,roleName)" title="permission.set"></t:dgFunOpt><%-- 权限设置 --%>
		<t:dgFunOpt funname="setbpmbyrole(id,roleName)" title="流程权限设置"></t:dgFunOpt><%-- 流程权限设置 --%>
		<t:dgToolBar title="common.add.param" langArg="common.role" icon="icon-add" url="roleController.do?addorupdate" funname="addRole"></t:dgToolBar>
		<t:dgToolBar title="common.edit.param" langArg="common.role" icon="icon-edit" url="roleController.do?addorupdate" funname="updateRole"></t:dgToolBar>
		<t:dgToolBar title="excelImport" icon="icon-put" funname="ImportXls"></t:dgToolBar>
		<t:dgToolBar title="excelOutput" icon="icon-putout" funname="ExportXls"></t:dgToolBar>
		<t:dgToolBar title="templateDownload" icon="icon-putout" funname="ExportXlsByT"></t:dgToolBar>
	</t:datagrid>
	</div>
</div>


<div data-options="region:'east',
	title:'<t:mutiLang langKey="member.list"/>',
	collapsed:true,
	split:true,
	onExpand : function(){
	
	},
	onCollapse : function() {
	
	}"
	style="width: 400px; overflow: hidden;" id="eastPanel">
    <div class="easyui-panel" style="padding:0px;border:0px" fit="true" border="false" id="function-panel"></div>
</div>

<%-- <div region="east" style="width: 600px;" split="true">
	<div tools="#tt" class="easyui-panel" title='<t:mutiLang langKey="permission.set"/>' style="padding: 10px;" fit="true" border="false" id="function-panel"></div>
</div>

<div id="tt"></div> --%>

<script type="text/javascript">

// 添加
function addRole(title, url, gname) {
	add(title,url,gname, 500, 200);
}

// 更新
function updateRole(title, url, gname) {
	update(title,url,gname, 500, 200);
}


// 角色权限控制
function setfunbyrole(id,roleName) {
	
	var title = roleName+ ':' + '<t:mutiLang langKey="current.permission"/>';
    $('#main_role_list').layout('expand','east');
    $('#main_role_list').layout('panel','east').panel('setTitle', title);
    $('#main_role_list').layout('panel','east').panel('resize', {width: 650});
    $('#function-panel').panel("refresh", "roleController.do?fun&roleId=" + id);
    
	/* $("#function-panel").panel(
		{
			title :roleName+ ':' + '<t:mutiLang langKey="current.permission"/>',
			href:"roleController.do?fun&roleId=" + id
		}
	);
	$('#function-panel').panel("refresh" ); */
	
}

// 设置流程定义权限
function setbpmbyrole(id,roleName) {
	
	var title = roleName+ ':' + '<t:mutiLang langKey="current.permission"/>';
    $('#main_role_list').layout('expand','east');
    $('#main_role_list').layout('panel','east').panel('setTitle', title);
    $('#main_role_list').layout('panel','east').panel('resize', {width: 500});
    $('#function-panel').panel("refresh", "bpmDefinitionController.do?list&roleId=" + id);
	
}




// 角色用户设置
function userListbyrole(id,roleName) {
	
	var title = roleName + ':' + '<t:mutiLang langKey="common.user"/>';
    $('#main_role_list').layout('expand','east');
    $('#main_role_list').layout('panel','east').panel('setTitle', title);
    $('#main_role_list').layout('panel','east').panel('resize', {width: 500});
    $('#function-panel').panel("refresh", "roleController.do?userList&roleId=" + id);
	
}


//删除角色
function delRole(id){
	var tabName= 'roleList';
	var url= 'roleController.do?delRole&id='+id;
	/* $.dialog.confirm('<t:mutiLang langKey="confirm.delete.this.record"/>', function(){
		doSubmit(url,tabName);
		rowid = '';
		$("#function-panel").html("");//删除角色后，清空对应的权限
	}, function(){
	}); */

	top.layer.confirm('<t:mutiLang langKey="confirm.delete.this.record"/>？', function(index){
		doSubmit(url,tabName);
		rowid = '';
		$("#function-panel").html("");
			top.layer.close(index);
		});
	
}

//导入
function ImportXls() {
	openuploadwin('Excel导入', 'roleController.do?upload', "roleList");
}

//导出
function ExportXls() {
	JeecgExcelExport("roleController.do?exportXls", "roleList");
}

//模板下载
function ExportXlsByT() {
	JeecgExcelExport("roleController.do?exportXlsByT", "roleList");
}
</script>
