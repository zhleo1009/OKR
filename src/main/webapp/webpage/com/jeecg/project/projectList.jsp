<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="projectList" sortName="createTime" sortOrder="desc" checkbox="true" fitColumns="false" title="项目管理" actionUrl="projectController.do?datagrid" idField="id" fit="true" queryMode="group">
   <t:dgCol title="主键"  field="id"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="项目名称"  field="projectName"  query="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="开始时间"  field="startDate" formatter="yyyy-MM-dd hh:mm:ss"   queryMode="single"  width="130"></t:dgCol>
   <t:dgCol title="结束时间"  field="endDate"  formatter="yyyy-MM-dd hh:mm:ss"   queryMode="single"  width="130"></t:dgCol>
   <t:dgCol title="所属部门"  field="org"  dictionary="t_s_depart,id,departname"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="创建时间"  field="createTime"  formatter="yyyy-MM-dd hh:mm:ss"   queryMode="single"  width="130"></t:dgCol>
   <t:dgCol title="备注信息"  field="remark"    queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="操作" field="opt" width="100"></t:dgCol>
   <t:dgDelOpt title="删除" url="projectController.do?doDel&id={id}" />
   <t:dgToolBar title="录入" icon="icon-add" url="projectController.do?goAdd" funname="add"></t:dgToolBar>
   <t:dgToolBar title="编辑" icon="icon-edit" url="projectController.do?goUpdate" funname="update"></t:dgToolBar>
   <t:dgToolBar title="查看" icon="icon-search" url="projectController.do?goDetail" funname="detail"></t:dgToolBar>
   <t:dgToolBar title="批量删除"  icon="icon-remove" url="projectController.do?doBatchDel" funname="deleteALLSelect"></t:dgToolBar>
  	<t:dgToolBar title="导入" icon="icon-put" funname="ImportXls"></t:dgToolBar>
  	 <t:dgToolBar title="导出" icon="icon-putout" funname="ExportXls"></t:dgToolBar>
	<t:dgToolBar title="查询" icon="icon-search" funname="projectListsearch"></t:dgToolBar>
  
  </t:datagrid>
  </div>
 </div>
 <script src = "webpage/com/jeecg/project/projectList.js"></script>		
 <script type="text/javascript">
 $(document).ready(function(){
 		//给时间控件加上样式
 });
 
 
 
//导入
function ImportXls() {
	openuploadwin('Excel导入', 'projectController.do?upload', "projectList");
}

//导出
function ExportXls() {
	JeecgExcelExport("projectController.do?exportXls","projectList");
}

//模板下载
function ExportXlsByT() {
	JeecgExcelExport("projectController.do?exportXlsByT","projectList");
}
 </script>