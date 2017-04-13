<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.pe.core.web.ResultMessage"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<script src="plug-in/layer/layer.js"></script>
<!DOCTYPE html>
<html>
<head>

</head>

  
		<script type="text/javascript">
		
		var processInstanceId="${processInstanceId}";
		var isStatusLoaded=false;
		var _height=${shapeMeta.height};
		//状态数据
		var aryResult=null;
		
		
		
		
		
		
		function claim(taskId){
			
			var url = 'taskController.do?claim';
				$.ajax({
					url:"${pageContext.request.contextPath}/taskController.do?claim",
					type:"post",
					data:{taskId:taskId},
					dataType:"json",
					success:function(data){
						if(data.success){
							window.location.reload();
						}
					}
				});
				

		}
		
		
		var index = parent.layer.getFrameIndex(window.name);
		
	    //关闭layer弹出框通用方法
		function closeLayer(){
			parent.reloadMyTodoTask();
			var index = parent.layer.getFrameIndex(window.name); //获取当前窗体索引
			parent.layer.close(index); //执行关闭
			
		}
		   
	    function getUserListSelections(field) {
	        var ids = [];
	        var rows = $('#userList1').datagrid('getSelections');
	        for (var i = 0; i < rows.length; i++) {
	            ids.push(rows[i][field]);
	        }
	        ids.join(',');
	        return ids;
	    }
		
		
		
		var taskId='${task.id}';
		var isExtForm=${isExtForm};
		var isEmptyForm=${isEmptyForm};
		var isSignTask=${isSignTask};
		var isHidePath=${isHidePath};
		
		//操作类型
		//1.完成任务
		//2.保存数据
		var operatorType=1;
		
	
		//补签
		function showAddSignWindow(){
			TaskAddSignWindow({taskId:taskId,callback:function(sign){
				loadTaskSign();
			}});
		}
		
		//加载会签数据。
		function loadTaskSign(){
			$(".taskOpinion").load('${pageContext.request.contextPath}/taskController.do?toSign&taskId=${task.id}');
		}
		//显示流程图
		function showTaskUserDlg(){
			TaskImageUserDialog({taskId:taskId});
		}
		
		
		//提交表单
		function submitForm(action,button){
			
		
			
			if($(button).hasClass("disabled"))return;
			if(isEmptyForm){
				top.layer.msg("还没有设置表单!");
				return;
			}
			
			$('#frmWorkFlow').attr("action",action);
				$(button).addClass("disabled");
				//$('#frmWorkFlow').submit();
				//$('#frmWorkFlow').form('load', {}); 
				$('#frmWorkFlow').form('submit', { 
					url : action, 
				//	onSubmit : function() { 
				//	return $(this).form('validate');//对数据进行格式化 
				//}, 
			   onSubmit: function(param){   
					var str  = decodeURI($("#frameDetail").contents().find('#formobj').serialize()); 
					//alert(str);
					var arr = str.split("&");
					for(var i =0; i < arr.length;i++){
					var obj = 	arr[i].split("=");
					if(obj.length>1){
						param[""+obj[0]+""]=obj[1];
					}
					}
			        return $(this).form('validate');//对数据进行格式化        
			    },
				success : function(data1) {
					var map = $.parseJSON(data1);  
					/* if(map.success){
						top.layer.msg(map.msg);
						closeLayer();
					} */
					top.layer.msg(map.msg);
					closeLayer();
				} 
			}); 
		}


		//完成当前任务。
		function completeTask(){
			var nextPathId=$("input[name='nextPathId']");
			if(nextPathId.length>0){
				var v=$("input[name='nextPathId']:checked").val();
				if(!v){
					top.layer.msg("在同步条件后的执行路径中，您至少需要选择一条路径!");
					return;	
				}
			}
			var operatorObj=getByOperatorType();
		
			var button="#" +operatorObj.btnId;
			
			var action=	document.getElementById("frameDetail").contentWindow.document.forms['formobj'].action;
			
			//执行前置脚本
			var rtn=beforeClick(operatorType);
			if( rtn==false){
				return;
			}
		
			submitForm(action,button);
		}
		
		
		function getByOperatorType(){
			var obj={};
			switch(operatorType){
				//同意
				case 1:
					obj.btnId="btnAgree";
					obj.msg="执行任务成功!";
					break;
				//反对
				case 2:
					obj.btnId="btnNotAgree";
					obj.msg="执行任务成功!";
					break;
				//弃权
				case 3:
					obj.btnId="btnAbandon";
					obj.msg="执行任务成功!";
					break;
					//驳回
				case 4:
					obj.btnId="btnReject";
					obj.msg="驳回任务成功!";
					break;
				//驳回到发起人
				case 5:
					obj.btnId="btnRejectToStart";
					obj.msg="驳回到发起人成功!";
					break;
				//保存表单
				case 8:
					obj.btnId="btnSave";
					obj.msg="保存表单数据成功!";
					break;
				
			}
			return obj;
		}
		
		function getErrorByOperatorType(){
			var rtn="";
			switch(operatorType){
				//同意
				case 1:
				//反对
				case 2:
				//弃权
				case 3:
					rtn="执行任务失败!";
					break;
				//驳回
					//驳回
				case 4:
					rtn="驳回任务失败!";
					break;
				//驳回到发起人
				case 5:
					rtn="驳回到发起人失败!";
					break;
				//保存表单
				case 8:
					rtn="保存表单数据失败!";
					break;
			}
			return rtn;
		}
		
	
		
		
		
		
	
		
		
		function showDate(){
			var now=new Date();
			
			$("#riqi").append(now.getFullYear()+"-"+(now.getMonth()+1)+"-"+now.getDate());
		}
		
		$(function(){
			
			
			initForm();
			//显示路径
			chooseJumpType(1);
			
			resizeIframe();
			
		
		});	
		
		
		
		
		function initBtnEvent(){
			//0，弃权，1，同意，2反对。
			var objVoteAgree=$("#voteAgree");
			var objBack=$("#back");
			
			//同意
			if($("#btnAgree").length>0){
				
				$("#btnAgree").click(function(){
					
				
					
					var index = layer.load(0, {shade: false});
					if(isExtForm){//提交第三方表单时检查该表单的参数
						var frm=$('#frmWorkFlow');
				//		if(!frm.valid()) return ;
						if(frm.setData){
							frm.setData();
						}
						
					}
					
					var isDirectComlete = false;
					
					if($("#chkDirectComplete").length>0){
						if($("#chkDirectComplete").attr("checked")=="checked"){
							isDirectComlete = true;
						}
					}
					
					operatorType=1;
					var tmp = '1';
					if(isDirectComlete){//直接一票通过
						tmp = '5';
					}
					objVoteAgree.val(tmp);
					objBack.val("0");
					completeTask();
				});
			}
			//反对
			if($("#btnNotAgree").length>0){
				$("#btnNotAgree").click(function(){
					var index = layer.load(0, {shade: false});
					if(isExtForm){//提交第三方表单时检查该表单的参数
						var frm=$('#frmWorkFlow');
					//	if(!frm.valid()) return ;
						if(frm.setData)frm.setData();
					}
					
					var isDirectComlete = false;
					
					if($("#chkDirectComplete").length>0){
						if($("#chkDirectComplete").attr("checked")=="checked"){
							isDirectComlete = true;
						}
					}
					
					operatorType=2;
					var tmp = '2';
					if(isDirectComlete){//直接一票通过
						tmp = '6';
					}
					objVoteAgree.val(tmp);
					objBack.val("0");
					completeTask();
				});
			}
			//弃权
			if($("#btnAbandon").length>0){
				$("#btnAbandon").click(function(){
					var index = layer.load(0, {shade: false});
					
					if(isExtForm){//提交第三方表单时检查该表单的参数
						var frm=$('#frmWorkFlow');
						//if(!frm.valid()) return ;
						if(frm.setData)frm.setData();
					}
					
					operatorType=3;
					objVoteAgree.val(0);
					objBack.val("");
					completeTask();
				})
			}
			//驳回
			if($("#btnReject").length>0){
				$("#btnReject").click(function(){
					var index = layer.load(0, {shade: false});
					if(isExtForm){//提交第三方表单时检查该表单的参数
						var frm=$('#frmWorkFlow');
					//	if(!frm.valid()) return ;
						if(frm.setData)frm.setData();
					}
					
					operatorType=4;
					objVoteAgree.val(3);
					objBack.val(1);
					completeTask();
				})
			}
			//驳回到发起人
			if($("#btnRejectToStart").length>0){
				$("#btnRejectToStart").click(function(){
					var index = layer.load(0, {shade: false});
					if(isExtForm){//提交第三方表单时检查该表单的参数
						var frm=$('#frmWorkFlow');
						//if(!frm.valid()) return ;
						if(frm.setData)frm.setData();
					}
					
					operatorType=5;
					//驳回到发起人
					objVoteAgree.val(3);
					objBack.val(2);
					completeTask();
				})
			}
			//保存表单
			if($("#btnSave").length>0){
				$("#btnSave").click(function(){
					var index = layer.load(0, {shade: false});
					if(isExtForm){//提交第三方表单时检查该表单的参数
						var frm=$('#frmWorkFlow');
					//	if(!frm.valid()) return ;
						if(frm.setData)frm.setData();
					}
					
					operatorType=8;
					saveData();
				})
			}
		}
		
		function initForm(){
			//初始化按钮事件。
			initBtnEvent();
			
			if(isEmptyForm){
				return;
			}
			if(isExtForm){				
				var formUrl=$('#divExternalForm').attr("formUrl");
				$('#divExternalForm').load(formUrl, function() {
					hasLoadComplete=true;
					//动态执行第三方表单指定执行的js
					try{
						afterOnload();
					}catch(e){}
				});
			}else{
				$(".taskopinion").each(function(){
					$(this).removeClass("taskopinion");
					var actInstId=$(this).attr("instanceId");
					$(this).load("${pageContext.request.contextPath}/taskOpinionController.do?listform&actInstId="+actInstId);
				});
			}
		}
		
	
		
		function chooseJumpType(val){
			//debugger;
			if(isHidePath) return;
			var obj=$('#jumpDiv');
			var url="";
			if(val==1){
				url="${pageContext.request.contextPath}/taskController.do?tranTaskUserMap&taskId=${task.id}&selectPath=0";
			}
			//选择路径跳转
			else if(val==2){
				url="${pageContext.request.contextPath}/taskController.do?tranTaskUserMap&taskId=${task.id}";
			}
			//自由跳转
			else if(val==3){
				url="${pageContext.request.contextPath}/taskController.do?freeJump&taskId=${task.id}";
			}
			//动态创建节点
			else if(val==4){
				url="${pageContext.request.contextPath}/taskController.do?dynamicCreate&taskId=${task.id}";
			}
			//url=url.getNewUrl();
			
			obj.html(obj.attr("tipInfo")).show().load(url);
			
		};
		
		//为目标节点选择执行的人员列表		
		function selExeUsers(obj,nodeId){
			
			var span=$(obj).siblings("span");
			var aryChk=$(":checkbox",span);
			var selectExecutors =[];  
			aryChk.each(function(){   
				var val=$(this).val();
			    var k=val.split("^");
				var userObj={};
				userObj.type=k[0];;
				userObj.id=k[1];;
				userObj.name=k[2];;
				selectExecutors.push(userObj);    
			});    
		  	$.dialog({
				content: 'url:'+'userController.do?userMultipleSelectPecg',
				lock : true,
				zIndex: top.layer.zIndex,
				width:900,
				height:510,
				title:'选择人员',
				opacity : 0.3,
				cache:false,
			    ok: function(){
			    	var iframe = this.iframe.contentWindow;
			    	var rowsData = iframe.$('#multiUserList').datagrid('getSelections');
			    	
			    	if (!rowsData || rowsData.length==0) {
			    		top.layer.msg('<t:mutiLang langKey="common.please.select.item"/>');
			    		return;
			    	}
			    
			    	
					var aryTmp=[];
					for(var i=0;i<rowsData.length;i++){
						var check="<input type='checkbox' id='aa"+rowsData[i].peUserId+"' name='" + nodeId + "_userId' checked='checked' value='user^"+  rowsData[i].peUserId +"^"+rowsData[i].realName +"'/>&nbsp;<label for='aa"+rowsData[i].peUserId+"'>"+rowsData[i].realName+"</label>";
						aryTmp.push(check);
					}
					span.html(aryTmp.join(''));
			    },
			    cancelVal: '关闭',
			    cancel: function(){ 
					
				  }   
			});  
		
		}
		
		function selectExeUsers(obj){
			var destTask=$("#destTask");
			if(destTak){
				$("#lastDestTaskId").val(destTask.val());
			}
			selExeUsers(obj,nodeId);
		}
		//显示审批历史
		function showTaskOpinions(){
			var winArgs="dialogWidth=800px;dialogHeight=600px;help=1;status=1;scroll=1;center=1;resizable:1";				
			var url='${pageContext.request.contextPath}/taskController.do?taskOpinion&taskId='+taskId+"&isOpenDialog=1";
			url=url.getNewUrl();
			window.showModalDialog(url,"",winArgs);
		}
		//更改
		function changeDestTask(sel){
			var nodeId=sel.value;
			$('#lastDestTaskId').val(nodeId);
			if(nodeId==""){
				$('#jumpUserDiv').html("");
				return;
			}
			var url="${pageContext.request.contextPath}/taskController.do?getTaskUsers&taskId=${task.id}&nodeId="+nodeId;
			$.getJSON(url, function(dataJson){
				var data=eval(dataJson);
				//alert(dataJson);
				var aryHtml=[];
				for(var i=0;i<data.length;i++){
				  var span="<input type='checkbox' name='" + nodeId + "_userId' checked='checked' value='user^"+data[i].userId+"^"+data[i].fullname+"'/>&nbsp;"+data[i].fullname;
				  aryHtml.push(span);
				}
				$('#jumpUserDiv').html(aryHtml.join(''));
			});
			
		}
		
		
		function resizeIframe(){
				if($("#frameDetail").length==0) return;
				$("#frameDetail").load(function() { 
					var height = $(this).contents().find('html').height();
					$(this).height(height); 
					$('#detailPannel').css('height',height+'px')
				}) ;
		}
		
		// 选择常用语
		function addComment(){
			var objContent=document.getElementById("voteContent");
			var selItem = $('#selTaskAppItem').val();
			jQuery.insertText(objContent,selItem);
		}
		function openForm(formUrl){
			var winArgs="dialogWidth=500px;dialogHeight=400px;help=0;status=0;scroll=0;center=1";
			var url=formUrl.getNewUrl();
			window.open(url,"",winArgs);
		}
		
		
		
		//展示流程图
		function showTaskUserDlg(){
			var taskId = ${task.id};
			var url = 'processRunController.do?userImage&taskId='+taskId;
		top.layer.open({
		  type: 2,
		  title: '流程图展示',
		  shadeClose: true,
		  shade: 0.8,
		  area: ['90%', '90%'],
		  content: url,
		  cancel: function(){ 
			    //右上角关闭回调
			    
			  }   
		}); 
		}
	
	//转交代办
	function delegate(){
		var taskId = ${task.id};
		var userId = document.getElementById("selectedOne").value ;
		if('' != userId ){
	    	$.ajax({
				url : 'taskController.do?delegate',
				type : 'post',
				data : {
					userId : userId,
					taskId : taskId
				},
				cache : false,
				success : function(data) {
					var d = $.parseJSON(data);
					// 来源页面
					if (d.success) {
						var msg = d.msg;
						top.layer.msg(msg);
					    var index = parent.layer.getFrameIndex(window.name); //获取当前窗体索引
					    parent.layer.close(index);
						
					}
				}
			}); 
    	}else{
    		layer.msg("未选择用户！");
    	}
		
		
	
	}
		
		
		
		
		
		
		
		function beforeClick(operatorType)
		{<c:if test="${not empty mapButton.button}">
		switch(operatorType){<c:forEach items="${mapButton.button }" var="btn"  ><c:if test="${not empty btn.prevscript}">
				case ${btn.operatortype}:
				${btn.prevscript}
				break;</c:if></c:forEach>
			}</c:if>
	}
	
	function afterClick(operatorType){<c:if test="${not empty mapButton.button}">
		switch(operatorType){<c:forEach items="${mapButton.button }" var="btn" ><c:if test="${not empty btn.afterscript}">
			case ${btn.operatortype}:
				${btn.afterscript}
				break;</c:if></c:forEach>
			}</c:if>
	}
	$(function(){
		var href=$("#local").attr("href");
		if(href!=undefined){
			///platform/bpm/task/
			//window.location.href=$("#local").attr("href");
			//window.location.href="/jykkyxmgl/platform/bpm/task/toStart.ht?taskId=${task.id}";
		}
	})
		
		
		
	</script>
	
	
	
	
	
	
	

	
	
	
	
	

<body >

<div id="main_role_list"  class="easyui-layout" fit="true">
	
  <div region="center" style="padding:2px;border:0px;margin: 0px;">
  
  <div id="detailPannel" class="easyui-panel" title="<b>${task.name}</b>--<i>[${bpmDefinition.subject}-V${bpmDefinition.versionNo}]" style="padding:2px;margin: 0px;">
	        
	  <%-- 上面表单明细 --%>      
	  <iframe id="frameDetail" src="${detailUrl}" scrolling="no"  frameborder="no"  width="100%" height="100%"></iframe>
					
  </div>
	
	      <form id="frmWorkFlow"  method="post" >
	
				<!-- 填写审批意见 -->
				  
					<c:choose>
						<c:when test="${bpmNodeSet.isHidePath==0}">
						<div id="jumpDiv" class="noprint" style="display:none;" tipInfo="正在加载表单请稍候...">
						</div>
						</c:when>
					</c:choose>
					<c:choose>
						<c:when test="${bpmNodeSet.isHideOption==0}">
					  <div class="easyui-panel" title="审批及意见" style="padding:0px;">
									<%@include file="/webpage/pe/act/task/incTaskOpinion.jsp"%>
							</div>
						</c:when>
					</c:choose>
					
					<div class="panel-body" style="display: none" id="delegeteMemo">
						<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<th width="30%">备注: </th>
								<td><input type="text" id="memo" name="memo"class="inputText"/></td>
							</tr>
							<input type="hidden" id="assigneeId" value=""/> 
						</table>
					</div>
					<input type="hidden" id="taskId" name="taskId" value="${task.id}"/> 
					<input type="hidden" id="businessKey" name="businessKey" value="${processRun.businessKey}"/> 
					<input type="hidden" name="agentTask" value="${param['agentTask']}"/>
					<input type="hidden" id="voteAgree" name="voteAgree" value="1"/> 
					<input type="hidden" id="back" name="back" value=""/>
</form>

  </div>
  
  </div>


</body>