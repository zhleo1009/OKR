<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<script src="plug-in/layer/layer.js"></script>
<script src="webpage/jeecg/cgreport/core/cgreportConfigHeadList.js"></script>
<script type="text/javascript">
   
function detail(id){
	 var url="bpmRunLogController.do?get&id="+id;
	 
	top.layer.open({
	  type: 2,
	  title: '日志明细',
	  shadeClose: true,
	  shade: 0.6,
	  area: ['60%', '60%'],
	  zIndex : top.layer.zIndex,
	  content: url,
	  cancel: function(){ 
		   
		  }   
	}); 
	 
}




function historyBack(title,url,id){
	
	  var url = "processRunController.do?processRunList";
	    window.location.href=url; 
}




	</script>
	
<div id="main_role_list"  class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="mytaskList" checkbox="true" 
  fitColumns="false" title="流程日志" 
  actionUrl="bpmRunLogController.do?datagrid&runId=${runId}" idField="id" fit="true" queryMode="group">
   	<t:dgCol title="id" field="id" hidden="true"></t:dgCol>
	<t:dgCol title="流程标题" field="processSubject"   autocomplete="true"  width="200"/>
	<t:dgCol title="用户名称" field="username"   autocomplete="true"  width="200"/>
	<t:dgCol title="操作时间" field="createtime"  formatterjs="formatterTime" />
	<t:dgCol title="操作类型" field="operatortype"  replace="启动流程_0,交办_1,追回_2,删除流程实例_3,同意(投票)_4,反对(投票)_5,弃权(投票)_6,补签_7,驳回_8,驳回到发起人_9,删除任务_10,代理任务_11,锁定任务_13,任务解锁_14,添加意见_15,任务指派_16,设定所有人_17,结束任务_18"  />
	<t:dgCol title="备注" field="memo"   autocomplete="true"  />
    <t:dgCol title="操作" field="opt" ></t:dgCol>
    <t:dgFunOpt  title="明细" funname="detail(id)" ></t:dgFunOpt>
<%--     <t:dgToolBar title="返回" icon="icon-undo" width="900" height="600" url="processRunController.do?processRunList" funname="historyBack"></t:dgToolBar> --%>
    
    </t:datagrid>
  </div>
 </div>
 


