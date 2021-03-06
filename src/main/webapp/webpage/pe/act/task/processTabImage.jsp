<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui"></t:base>
<%
	//显示流程示意图及显示每个任务节点上的执行人员
%>

<html>
<head>
<title>流程执行示意图</title>
<script type="text/javascript">
var __ctx='<%=path%>';
var __jsessionId='<%=session.getId() %>';
</script>

<script type="text/javascript" src="pe/js/jquery/plugins/jquery-powerFloat.js"></script>
<script type="text/javascript" src="pe/js/jquery/plugins/jquery.qtip.js"></script>
<script type="text/javascript" src="pe/js/util/easyTemplate.js" ></script>
<link href="pe/js/jquery/plugins/powerFloat.css" rel="stylesheet" type="text/css" />
<link href="pe/styles/default/css/jquery.qtip.css" rel="stylesheet" />

<style type="text/css">
div.header{
	background-image: url(pe/styles/default/images/tool_bg.jpg);
	height:24px;
	line-height:24px;
	font-weight: bold;
	font-size: 14px;
	padding-left: 5px;
	margin: 0;
	width: 394px;
}
ul.legendContainer{
	position: relative;
	top:10px;
	left:0px;
}
	
ul.legendContainer li{
	list-style: none;
	font-size: 14px;
	display: inline-block;
	font-weight: bold;
}
	
ul.legendContainer li .legend{
	width:14px;
	height: 14px;
	border: 1px solid black;
	margin-right:5px;
	margin-top:2px;
	float: left;
}
.table-task {
	margin: 0 auto;
	width:240px;
	border-collapse: collapse;
}

.table-task th {
	text-align: right;
	padding-right: 6px;
	color: #000;
	height: 32px;
	border: solid 1px #A8CFEB;
	font-weight: bold;
	text-align: right;
	font-size: 13px;
	font-weight: bold;
	padding-right: 5px;
	background-color: #edf6fc;
	padding-right: 5px;
	border: 1px solid #8dc2e3;
}
.table-task td {
	border: solid 1px #A8CFEB;
	padding-left: 6px;
	text-align: left;
}
</style>

<script type="text/javascript">



	var processInstanceId="${processInstanceId}";
	var isStatusLoaded=false;
	var _height=${shapeMeta.height};
	//状态数据
	var aryResult=null;
	
	function setIframeHeight(){
		//var mainIFrame = window.parent.document.getElementById("flowchart");
		//if(!mainIFrame)return;
		//mainIFrame.style.height=_height+200;
	};
	
	$(function(){
		$.each($("div.flowNode"),function(){
			if($(this).attr('type')=='userTask' || $(this).attr('type')=='multiUserTask'){
				$(this).css('cursor','pointer');
				var nodeId=$(this).attr('id');
				var url="processRunController.do?taskUser&processInstanceId="+processInstanceId+"&nodeId=" + nodeId;
				$(this).powerFloat({ eventType: "click", target:url, targetMode: "ajax"});
			}
			if($(this).attr('type')=='callActivity'){
				$(this).css('cursor','pointer');
				$(this).click(function(){
					var nodeId=$(this).attr('id');
					var conf = {nodeId:nodeId,processInstanceId:processInstanceId};
					viewSubFlow(conf);
				});
			}
		});		
		loadStatus();		
		if(self!=top){
			setIframeHeight();
		}
	});
	
	function viewSubFlow(conf){
		if(!conf) conf={};
		var url="processRunController.do?subFlowImage&processInstanceId="+conf.processInstanceId+"&nodeId=" + conf.nodeId+"&processDefinitionId="+conf.processDefinitionId;
		var winArgs="dialogWidth=800px;dialogHeight=600px;help=0;status=0;scroll=1;center=1;";
		url=url.getNewUrl();
		window.showModalDialog(url,"",winArgs);
	}
	
	//初始化qtip
	function eventHandler(){
		$("div.flowNode").each(function(){
			if(!isStatusLoaded){
				loadStatus();
				return;
			}
			var obj=$(this);
			var taskId=obj.attr("id");
			var html=getTableHtml(taskId);
			if(!html)return;
			$(this).qtip({  
					content:{
						text:html,
						title:{
							text: '任务执行情况'				
						}
					},
   			        position: {
   			        	at:'center',
   			        	target:'event',
   			        	adjust: {
   			        		x:-15,
   			        		y:-15
   		   				},  
   		   				viewport: $(window)
   			        },
   			        show:{   			        	
	   			     	effect: function(offset) {
	   						$(this).slideDown(200);
	   					}
   			        },   			     	
   			        hide: {
   			        	event:'mouseleave',
   			        	fixed:true
   			        	},  
   			        style: {
   			       	  classes:'ui-tooltip-light ui-tooltip-shadow'
   			        } 			    
 		 	});	
		});
	}
	
	//加载流程状态数据。
	function loadStatus(){
		var url="processRunController.do?getFlowStatusByInstanceId";
		var params={instanceId:processInstanceId};
		$.post(url,params,function(result){
			if(result.constructor == String){
				aryResult=eval("(" + result + ")");
			}else{
				aryResult=result;
			}
			isStatusLoaded=true;
			eventHandler();
		});
	}

	//构建显示的html
	function getTableHtml(taskId){		
		var node=getNode(taskId);
		if(node==null) return false;
		var aryOptions=node.taskOpinionList;
		if(aryOptions.length==0)return false;
		
 		var html=['<div style="height:240px;width:260px;overflow:auto;">'];
 		var tableHtml=$("#txtTaskStatus").val();
 		var str= easyTemplate(tableHtml,aryOptions);
 		html.push(str);
 		html.push('</div>');
		return html.join('');
	}
	
	//从返回的结果中返回状态数据。
	function getNode(taskId){
		if(aryResult==null) return null;
		for(var i=0;i<aryResult.length;i++){
			var node=aryResult[i];
			var taskKey=node.taskKey;
			if(taskId==taskKey){
				return node;
			}
		}
		return null;
	}
</script>
</head>
<body style="margin: 0px; padding: 0px;" >
<div class="panel"  style="width:100%; height:100%; overflow-y: auto; border: 0px;">
	<c:if test="${notShowTopBar==null}">
	<div class="panel-top" >
		<div class="tbar-title">
			<%-- <span class="tbar-label">任务明细--${processRun.subject}--${taskEntity.name}</span> --%>
		</div>
		<div class="panel-toolbar">
			<div class="toolBar">
				<!-- <div class="group"><a class="link close" href="#" onclick="window.close();" >关闭</a></div> -->
			</div>
		</div>
	</div>
	</c:if>
	<div class="panel-body" style="border: 0px;" >
		<ul class="legendContainer"  >
			<li><div style="background-color:gray; " class="legend"></div>未执行</li>
			<li><div style="background-color:#00FF00;" class="legend"></div>同意</li>
			<li><div style="background-color:orange;" class="legend"></div>弃权</li>
			<li><div style="background-color:red;" class="legend"></div>当前节点</li>
			<li><div style="background-color:blue;" class="legend"></div>反对</li>
			<li><div style="background-color:#8A0902;" class="legend"></div>驳回</li>
			<li><div style="background-color:#023B62;" class="legend"></div>追回</li>
			<li><div style="background-color:#338848;" class="legend"></div>会签通过</li>
			<li><div style="background-color:#82B7D7;" class="legend"></div>会签不通过</li>
		</ul>
		<div style="padding-top:10px;background-color: white;border: 0px;" >
			<div style="margin-bottom: 5px;">
			<span style="padding-left: 20px;"><b>说明：</b>鼠标放到任务节点可以查看节点的执行人员。</span>
				<c:if test="${superInstanceId != null}">
					<a class="link setting" onclick="ViewSuperExecutionFlowWindow({'processInstanceId':'${superInstanceId}'})">查看主流程</a>
				</c:if>
			</div>
			<div id="divTaskContainer" style="margin:0 auto;  position: relative;background:url('bpmImage?processInstanceId=${processInstanceId}&randId=<%=Math.random()%>') no-repeat;width:${shapeMeta.width}px;height:${shapeMeta.height}px;">
				${shapeMeta.xml}
			</div>
		</div>
		<textarea id="txtTaskStatus" style="display:none">
			
      		<#list data as obj>
			<table class="table-task" cellpadding="0" cellspacing="0" border="0">
			
			<tr><th width="30%">任务名: </th>
			<td>\${obj.taskName}</td></tr>
			
			<tr><th width="30%">执行人: </th>
			<td>\${obj.exeFullname}</td></tr>
			
			<tr><th width="30%">开始时间: </th>
			<td>\${obj.startTimeStr}</td></tr>
			
			<tr><th width="30%">结束时间: </th>
			<td>\${obj.endTimeStr}</td></tr>
			
			<tr><th width="30%">时长: </th>
			<td>\${obj.durTimeStr}</td></tr>
			
			<tr><th width="30%">状态: </th>
			<td>\${obj.status}</td></tr>
			
			<tr><th width="30%">意见: </th>
			<td>\${obj.opinion==null?"无":obj.opinion}</td></tr>
			</table><br>
			</#list>
		</textarea>
	</div>
</div>
</body>
</html>