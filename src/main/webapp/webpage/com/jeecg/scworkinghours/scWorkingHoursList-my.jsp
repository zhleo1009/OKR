<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="scWorkingHoursList" checkbox="true" fitColumns="false" title="我的项目工时表" actionUrl="scWorkingHoursController.do?datagridForme" idField="id" fit="true" queryMode="group">
   <t:dgCol title="主键"  field="id"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="项目"  field="projectId"  query="true" dictionary="project,id,project_name"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="员工"  field="userId"  query="true" dictionary="t_s_base_user,id,realname"   queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="日期"  field="workingDate" formatterjs="getWeekDay" formatter="yyyy-MM-dd" query="true"     queryMode="group"   width="150"></t:dgCol>
   <t:dgCol title="工时"  field="workingHours"    queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="任务信息"  field="note"    queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="操作" field="opt" width="100"></t:dgCol>
   <t:dgDelOpt title="删除" url="scWorkingHoursController.do?doDel&id={id}" />
   <t:dgToolBar title="录入" icon="icon-add" url="scWorkingHoursController.do?goAdd" funname="add"></t:dgToolBar>
   <t:dgToolBar title="编辑" icon="icon-edit" url="scWorkingHoursController.do?goUpdate" funname="update"></t:dgToolBar>
   <t:dgToolBar title="批量删除"  icon="icon-remove" url="scWorkingHoursController.do?doBatchDel" funname="deleteALLSelect"></t:dgToolBar>
   <t:dgToolBar title="查看" icon="icon-search" url="scWorkingHoursController.do?goUpdate" funname="detail"></t:dgToolBar>
   <t:dgToolBar title="导入" icon="icon-put" funname="ImportXls"></t:dgToolBar>
   <t:dgToolBar title="导出" icon="icon-putout" funname="ExportXls"></t:dgToolBar>
   <t:dgToolBar title="模板下载" icon="icon-putout" funname="ExportXlsByT"></t:dgToolBar>
  </t:datagrid>
  </div>
 </div>
 <script type="text/javascript">
 
 function formatDate(date){
	 var y = date.getFullYear();
	 var m = date.getMonth() + 1;
	 m = m < 10 ? '0' + m : m;
	 var d = date.getDate();
	 d = d < 10 ? ('0' + d) : d;
	 return y + '-' + m + '-' + d;
 };
 
 function getWeekDay(value,rec,index){
	 value = value.replace(/-/g,"/");
	 var date = new Date(value);
	 // 根据格式化DATE对象,与下下面星期计算无关
	 var result = formatDate(date);
	 //计算星期并用中文展示
	 var weekDay = date.getDay();
	 if(0==weekDay){
		 result+= '(星期日)';
	 }else if(1==weekDay){
		 result+=  '（星期一）';
	 }else if(2==weekDay){
		 result+=  '（星期二）';
	 }else if(3==weekDay){
		 result+=  '（星期三）';
	 }else if(4==weekDay){
		 result+=  '（星期四）';
	 }else if(5==weekDay){
		 result+=  '（星期五）';
	 }else if(6==weekDay){
		 result+=  '（星期六）';
	 }else{
		 result+=  '（错误！！！）';
	 }
	 
	 return result;
	 
	 
 }
 
 
 
 
 $(document).ready(function(){
 		//给时间控件加上样式
 		
 		
		$("#scWorkingHoursListtb").find("input[name='workingDate_begin']").attr("class","Wdate").click(function(){WdatePicker({dateFmt:'yyyy-MM-dd'});});
		$("#scWorkingHoursListtb").find("input[name='workingDate_end']").attr("class","Wdate").click(function(){WdatePicker({dateFmt:'yyyy-MM-dd'});});

 		
 });
 
//导入
function ImportXls() {
	openuploadwin('Excel导入', 'scWorkingHoursController.do?upload', "scWorkingHoursList");
}

//导出
function ExportXls() {
	JeecgExcelExport("scWorkingHoursController.do?exportXls","scWorkingHoursList");
}

//模板下载
function ExportXlsByT() {
	JeecgExcelExport("scWorkingHoursController.do?exportXlsByT","scWorkingHoursList");
}
 </script>