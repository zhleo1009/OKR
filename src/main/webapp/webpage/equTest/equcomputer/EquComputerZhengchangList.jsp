<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  
  <t:datagrid name="myAttend" checkbox="true"  fitColumns="false" title="设备管理" 
  actionUrl="equComputerController.do?zhengchangList&pojo=equComputer" idField="id" fit="true" queryMode="group">
   	<t:dgCol title="id" field="id" hidden="true" />
	<t:dgCol title="设备名称" field="fName"  autocomplete="true"  width="200"/>
	<t:dgCol title="设备类型" field="fType"  autocomplete="true"  width="200"/>
	<t:dgCol title="设备型号" field="fModel" autocomplete="true"  width="200"/>
    <t:dgCol title="操作系统" field="fOperating"  autocomplete="true" width="120"/>
    <t:dgCol title="责任人" field="fPersonname"  autocomplete="true"  width="120"/>
    <t:dgCol title="责任部门" field="fDeptname"  autocomplete="true"  width="120"/>
    <t:dgCol title="流程状态" field="fApprovedstate" autocomplete="true"  />
    <t:dgCol title="设备状态" field="state"  query="true" replace="正常_正常,维修_维修" autocomplete="true"  />
    <t:dgCol title="操作" field="opt"  width="120"/>
    <t:dgFunOpt  title="详情" funname="showInfo(id)" />
    <t:dgFunOpt  title="维修申请" funname="shangbao(id)" />
    </t:datagrid>
  </div>
 </div>
<script src="webpage/jeecg/cgreport/core/cgreportConfigHeadList.js"></script>
 <script type="text/javascript">
 $(document).ready(function(){
 		//给时间控件加上样式
 });

 
 function showInfo(id,ind ){
	 var url="equComputerController.do?get&id="+id;
	 //alert("功能未完成！");
	 createwindow("详细信息",url,600,200);
 }
 

function shangbao(id,ind ) {

	//登陆时需要将用户存入全局变量中，否则启动工作流无法获取当前用户信息
	//com.pe.core.util.ContextUtil
	$.post('equComputerController.do?report&id='+ id,{}, 
			function(res) {
			//var result = eval('(' + res + ')');
			//alert(ccc);
			layer.alert(res, {icon: 6});
	});
}
</script>


