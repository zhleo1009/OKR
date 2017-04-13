<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="userInfoList" checkbox="true" fitColumns="false" title="用户资料" actionUrl="userInfoController.do?getUserList" idField="id" fit="true" queryMode="group">
   <t:dgCol title="主键"  field="id"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="姓名"  field="realname"    queryMode="single" query="true" width="120"></t:dgCol>
   <t:dgCol title="性别"  field="sex" queryMode="single" query="true" dictionary="sex" width="120"></t:dgCol>
   <t:dgCol title="员工编号"  field="user_no"    queryMode="single" query="true" width="120"></t:dgCol>
   <t:dgCol title="部门"  field="departname"    queryMode="single" query="true" width="120"></t:dgCol>
   <t:dgCol title="职位"  field="zhiwei"    queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="在岗状态"  field="zaigang" dictionary="zaiZhiType" queryMode="single" query="true" width="120"></t:dgCol>
   <t:dgCol title="类别"  field="yonggongtype"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="民族"  field="mingzu"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="操作" field="opt" width="300"></t:dgCol>
   <t:dgFunOpt title="基本信息维护"  funname="getBaseDetail(username)" />
   <t:dgFunOpt title="人事档案维护"  funname="getRsDetail(id)" />
   <t:dgFunOpt title="质量办档案维护" funname="getZlbDetail(id)" />
  </t:datagrid>
  </div>
 </div>
 <script type="text/javascript">
 $(document).ready(function(){
 		//给时间控件加上样式
 			//$("#userInfoListtb").find("input[name='createDate']").attr("class","Wdate").click(function(){WdatePicker({dateFmt:'yyyy-MM-dd'});});
 			//$("#userInfoListtb").find("input[name='updateDate']").attr("class","Wdate").click(function(){WdatePicker({dateFmt:'yyyy-MM-dd'});});
 });
 
//导入
function ImportXls() {
	openuploadwin('Excel导入', 'userInfoController.do?upload', "userInfoList");
}

//导出
function ExportXls() {
	JeecgExcelExport("userInfoController.do?exportXls","userInfoList");
}

//模板下载
function ExportXlsByT() {
	JeecgExcelExport("userInfoController.do?exportXlsByT","userInfoList");
}

function getRsDetail(id){
	var url="url:userInfoController.do?goRsInfo&id="+id;
 	$.dialog({
		content: url,
		lock : true,
		title:"人事档案信息",
		opacity : 0.3,
		width:650,
		height:500,
		cache:false,
	    ok: function(){
	    	iframe = this.iframe.contentWindow;
	    	var obj=iframe.goForm();
	    	if(obj){
	    		if(obj.msg.indexOf("失败")!=-1){
	    			layer.msg("人事档案更新失败");
	    			return false;
	    		}else{
	    			reloadTable();
	    			layer.msg("人事档案更新成功");
	    			return true;
	    		}
	    	}
	    	return false;
	    },
	    cancelVal: '关闭',
	    cancel:function(){
	    	reloadTable();
	    	return true;	
	    } /*为true等价于function(){}*/
	});
}

function getZlbDetail(id){
 		var url="url:userInfoController.do?goZlbInfo&id="+id;
 	 	$.dialog({
 			content: url,
 			lock : true,
 			title:"质量部档案信息",
 			opacity : 0.3,
 			width:1200,
 			height:400,
 			cache:false,
 		    ok: function(){
 		    	iframe = this.iframe.contentWindow;
 		    	var obj=iframe.goForm();
 		    	if(obj){
 		    		if(obj.msg.indexOf("失败")!=-1){
 		    			layer.msg("人事档案更新失败");
 		    			return false;
 		    		}else{
 		    			layer.msg("人事档案更新成功");
 		    			return true;
 		    		}
 		    	}
 		    	return false;
 		    },
 		    cancelVal: '关闭',
 		    cancel:function(){
 		    	reloadTable();
 		    	return true;	
 		    } /*为true等价于function(){}*/
 		});
 	}

	function getBaseDetail(username){
		location.href="userInfoController.do?userinfo&username="+username;
	}
 </script>