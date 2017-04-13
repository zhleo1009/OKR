<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<script type="text/javascript">





$(function(){
	
	//var item = $("select[@name=userId]option[@selected]").text();

	
	var item = $("select[name=userId]").change(function(){
				//alert('s');
				//var userId = $("select[name=userId]").find("option:selected").val();
				//alert(userId);
		scOkrListsearch();

	});

	
	
	
});
     function showBpmStatus(value,row,index){
    	//判断value是否是未完成。如果是可以点击  也就是A标签 最好红色展示。如果已完成则展示文字即可
    	 var showStr = "";
    	 var href = '';
    	 if(value==2){
    		 showStr = "<span style='color: red;'>待完成</span>";
    			href += "<a  href='javascript:void(0);' onclick=edit2("
					+ row.id
					+ ")>";
			href += showStr+"</a>";
    	 }else if(value==1){
    		 showStr = "已提交";
			href += showStr;
    	 }else if(value==3){
    		 showStr = "<span style='color: green;'>草稿</span>";
 			href += "<a  href='javascript:void(0);' onclick=edit("
					+ row.id
					+ ")>";
			href += showStr+"</a>";
    		 
    	 }
		return href;
     }
     

   
     
     //关键目标...气泡显示
     function showDetailObjective(value,row,index){
    	 var strObjective  = row.objective; 
    	 if(strObjective.length>6){
    		 strObjective = strObjective.substring(0,6)+"...";
    	 }
    	 var show ="<a title='"+row.objective+"' href='javascript:void(0);' onclick=openDetail(" +row.id + ")>"+strObjective+"</a>"
     	 return show;
     }
     //关键结果...气泡显示
      function showDetailKeyResult(value,row,index){
    	 var strKeyResult  = row.keyResult; 
    	 if(strKeyResult.length>6){
    		strKeyResult = strKeyResult.substring(0,6)+"...";
    	 }
    	 var show ="<a title='"+row.keyResult+"' href='javascript:void(0);' onclick=openDetail(" +row.id + ")>"+strKeyResult+"</a>"
     	 return show;
     }
     //任务...气泡显示
     function showDetailMission(value,row,index){
    	 var strMission = row.mission;
    	 if(strMission.length>6){
    		 strMission = strMission.substring(0,6)+"..." ; 
    	 }
     	 var show ="<a title='"+row.mission+"' href='javascript:void(0);' onclick=openDetail(" +row.id + ")>"+strMission+"</a>"
     	 return show;
      }
     //执行难点...气泡显示
       function showDetailDifficulties(value,row,index){
    	 var difficulties = row.difficulties;
    	 if(difficulties.length>6){
    		 difficulties = difficulties.substring(0,6)+"..." ; 
    	 }
     	 var show ="<a title='"+row.difficulties+"' href='javascript:void(0);' onclick=openDetail(" +row.id + ")>"+difficulties+"</a>"
     	 return show;
      }
     //未完成原因...气泡显示
      function showDetailUnfinishedReason(value,row,index){
    	 var unfinishedReason = row.unfinishedReason;
    	 if(unfinishedReason.length>6){
    		 unfinishedReason = unfinishedReason.substring(0,6)+"..." ; 
    	 }
     	 var show ="<a title='"+row.unfinishedReason+"' href='javascript:void(0);' onclick=openDetail(" +row.id + ")>"+unfinishedReason+"</a>"
     	 return show;
      }
     
      function showProgressbar(value,row,index){
    	  if(value==null||value==""){
    		  return "";
    	  }
     	 var show =value + "%";
     	
     	 return show;
      }
     
      //无确定按钮弹出框;重写Detail方法
      function openDetail(id){
    	  openwindow("查看详情","scOkrController.do?goDetail&id="+id,800,500); 
      }
      
      
      
      //无确定按钮弹出框;重写add方法
      function   add(title,addurl,gname,width,height){
    	  openwindow(title, addurl,gname, width, height) ;
      }
      
      //无确定按钮弹出框;重写add方法
      function   edit(id){
    	  openwindow('更新OKR', 'scOkrController.do?goUpdate&id='+id,'scOkrList', 800, 500) ;
      }

      function   edit2(id){
    	  openwindow('更新OKR', 'scOkrController.do?goUpdate2&id='+id,'scOkrList', 800, 500) ;
      }

      
      function extendsOPT(value,row,index){
    	 //如果 row.bpmStatus ==1 是已完
    	 var bpmStatus = row.bpmStatus;
    	 var show = "";
    	 //已完成状态
    	 if(bpmStatus==1){
    		 show +="<a title='"+row.mission+"' <span style='color: #ccc'>[编辑]</span></a>&nbsp;&nbsp;";
    		 show +="<a title='"+row.mission+"' <span style='color: #ccc'>[删除]</span></a>&nbsp;&nbsp;";
    		 show +="<a title='"+row.mission+"' href='javascript:void(0);' onclick=openDetail(" +row.id + ")>[查看]</a>";
    	 //待完成状态
    	 }else if(bpmStatus==2){
    		 show +="<a title='"+row.mission+"' href='javascript:void(0);' onclick='edit2(" +row.id + ")'>[编辑]</a>&nbsp;&nbsp;";
    		 show +="<a title='"+row.mission+"' <span style='color: #ccc'>[删除]</span></a>&nbsp;&nbsp;";
    		 show +="<a title='"+row.mission+"' href='javascript:void(0);' onclick=openDetail(" +row.id + ")>[查看]</a>";
    	//草稿状态
    	 }else if(bpmStatus==3){
    		show ="<a  title='"+row.mission+"' href='javascript:void(0);' onclick='edit(" +row.id + ")'>[编辑]</a>&nbsp;&nbsp;";
    		show +="<a title='"+row.mission+"' href='#' onclick=delObj('scOkrController.do?doDel&id="+ row.id+ "','scOkrList')>[删除]</a>&nbsp;&nbsp;";
    		show +="<a title='"+row.mission+"' href='javascript:void(0);' onclick=openDetail(" +row.id + ")>[查看]</a>";
    	 
    	 }
  	return show;
      }
      
  	//获取周一
		function getMonday(){
			var now = new Date(); 
			var nowTime = now.getTime() ; 
			var day = now.getDay();
			var oneDayLong = 24*60*60*1000 ; 
			var MondayTime = nowTime - (day-1)*oneDayLong  ; 
			var monday = new Date(MondayTime);
			return monday.getFullYear()+"-"+(monday.getMonth()+1)+"-"+monday.getDate();

		}
		//获取周日
	  	function getSunday(){
	  		var now = new Date(); 
			var nowTime = now.getTime() ; 
			var day = now.getDay();
			var oneDayLong = 24*60*60*1000 ; 
			var SundayTime =  nowTime + (7-day)*oneDayLong ; 
			var sunday = new Date(SundayTime);
			return sunday.getFullYear()+"-"+(sunday.getMonth()+1)+"-"+sunday.getDate();
	  	}
		
      

</script>




<div class="easyui-layout" fit="true" >
  <div region="center" style="padding:0px;border:0px"  >
  <t:datagrid name="scOkrList" checkbox="false" sortName="createDate" sortOrder="desc" fitColumns="false" title=" " actionUrl="scOkrController.do?datagrid" idField="id" fit="true" queryMode="group">
   <t:dgCol title="主键"  field="id"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="创建人名称"  field="createName"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="创建人登录名称"  field="createBy"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="更新人名称"  field="updateName"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="更新人登录名称"  field="updateBy"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="更新日期"  field="updateDate" formatter="yyyy-MM-dd" hidden="true"   queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="操作" formatterjs="extendsOPT" align="center" field="opt" width="150"></t:dgCol>
   <t:dgCol title="创建日期"  field="createDate" formatter="yyyy-MM-dd" queryMode="group"  query="true"  width="90"></t:dgCol>
   <t:dgCol title="所属部门"  field="sysOrgCode"  dictionary="t_s_depart,org_code,departname"  queryMode="single"  width="80"></t:dgCol>
   <t:dgCol title="管理中心"  field="sysCompanyCode" dictionary="t_s_depart,org_code,departname"   queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="流程状态"  formatterjs="showBpmStatus" field="bpmStatus"   queryMode="single"  width="55"></t:dgCol>
   <t:dgCol title="关键目标"  formatterjs="showDetailObjective" field="objective"    queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="关键结果"  formatterjs="showDetailKeyResult" field="keyResult"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="任务" formatterjs="showDetailMission" field="mission"    queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="人员"  field="userId"  dictionary="t_s_base_user,id,realname" query="true" queryMode="single"  width="65"></t:dgCol>
   <t:dgCol title="计划完成时间"  field="planTime"    formatter="yyyy-MM-dd"  width="90"></t:dgCol>
   <t:dgCol title="执行难点"  field="difficulties" formatterjs="showDetailDifficulties"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="完成程度"  field="percent" formatterjs="showProgressbar" queryMode="single"  width="80" align="center"></t:dgCol>
   <t:dgCol title="未完成原因"  field="unfinishedReason" formatterjs="showDetailUnfinishedReason"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="需协助部门"  field="needOrgCode"  dictionary="t_s_depart,id,departname" queryMode="single"  width="150"></t:dgCol>
   <t:dgCol title="实际完成时间"  field="finishTime"   formatter="yyyy-MM-dd" queryMode="single"  width="90"></t:dgCol>
   <t:dgToolBar title="新建OKR" icon="icon-add" url="scOkrController.do?goAdd" width="800" height="500" funname="add"></t:dgToolBar>
   <t:dgToolBar title="导出" icon="icon-putout" funname="ExportXls"></t:dgToolBar>
   <t:dgToolBar title="查询" icon="icon-search" funname="scOkrListsearch"></t:dgToolBar>
  </t:datagrid>
  </div>
 </div>
 <script src = "webpage/com/jeecg/scokr/scOkrList.js"></script>		
 <script type="text/javascript">
 $(document).ready(function(){
	 
 		//给时间控件加上样式
 		 $("#scOkrListtb").find("input[name='createDate']").attr("class","Wdate").click(function(){WdatePicker({dateFmt:'yyyy-MM-dd'});});
 		 $("#scOkrListtb").find("input[name='updateDate']").attr("class","Wdate").click(function(){WdatePicker({dateFmt:'yyyy-MM-dd'});});

		
		$("#scOkrListtb").find("input[name='createDate_begin']").attr("class","Wdate").click(function(){WdatePicker({dateFmt:'yyyy-MM-dd'});});
		$("#scOkrListtb").find("input[name='createDate_end']").attr("class","Wdate").click(function(){WdatePicker({dateFmt:'yyyy-MM-dd'});});
		var monday = getMonday();
		var sunday = getSunday();
		$("#scOkrListtb").find("input[name='createDate_begin']").val(monday);
		$("#scOkrListtb").find("input[name='createDate_end']").val(sunday);
 		
 });
 
//导入
function ImportXls() {
	openuploadwin('Excel导入', 'scOkrController.do?upload', "scOkrList");
}

//导出
function ExportXls() {
	JeecgExcelExport("scOkrController.do?exportXls","scOkrList");
}

//模板下载
function ExportXlsByT() {
	JeecgExcelExport("scOkrController.do?exportXlsByT","scOkrList");
}
 </script>