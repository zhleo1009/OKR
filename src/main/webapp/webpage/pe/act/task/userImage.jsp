<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>


<link href="pe/styles/default/css/jquery.qtip.css" rel="stylesheet" />

<script type="text/javascript" src="pe/js/jquery/plugins/jquery-powerFloat.js"></script>
<script type="text/javascript" src="pe/js/jquery/plugins/jquery.qtip.js" ></script>
<link type="text/css" href="pe/js/jquery/plugins/powerFloat.css" rel="stylesheet"  />
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
	width:260px;
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
	//hjx add ifram自适应高度
	$(window.parent.document).find("#flowchart").load(function(){
		var main = $(window.parent.document).find("#flowchart");
		var thisheight = $(document).height()+30;
		main.height(thisheight);
		});
	
	function setIframeHeight(){
		var mainIFrame = window.parent.document.getElementById("flowchart");
		if(!mainIFrame)return;
		mainIFrame.style.height=_height+200;
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
		var url="processRunController.do?taskUser&processInstanceId="+conf.processInstanceId+"&nodeId=" + conf.nodeId+"&processDefinitionId="+conf.processDefinitionId;
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
			aryResult=result;
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
 		var html=['<div style="height:260px;width:288px;overflow:auto;">'];
		for(var i=0;i<aryOptions.length;i++){
			var p=aryOptions[i];
			var sb=new StringBuffer();			
			var exeFullname=p.exeFullname;
			var taskName=p.taskName;
			var startTime=p.startTimeStr;
			var endTime=p.endTimeStr;
			var status=p.status;
			var opinion=p.opinion==null ?"无":p.opinion;
			var durTime=p.durTimeStr;
			var fieldName =p.fieldName;

			sb.append('<table class="table-task" cellpadding="0" cellspacing="0" border="0">');
			
			sb.append('<tr><th width="30%">任务名: </th>');
			sb.append('<td>'+taskName+'</td></tr>');
			
			sb.append('<tr><th width="30%">执行人: </th>');
			sb.append('<td>'+exeFullname+'</td></tr>');
			
			sb.append('<tr><th width="30%">开始时间: </th>');
			sb.append('<td>'+startTime+'</td></tr>');
			
			sb.append('<tr><th width="30%">结束时间: </th>');
			sb.append('<td>'+endTime+'</td></tr>');
			
			sb.append('<tr><th width="30%">时长: </th>');
			sb.append('<td>'+durTime+'</td></tr>');
			
			sb.append('<tr><th width="30%">状态: </th>');
			sb.append('<td>'+status+'</td></tr>');
			
			sb.append('<tr><th width="30%">意见: </th>');
			sb.append('<td>'+opinion+'</td></tr>');
			
			
			sb.append("</table><br>");
			html.push(sb.toString());
		}
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

<div class="panel" style="width:99%; height:99%; overflow-y: auto;">
	<div class="panel-body">
		<ul class="legendContainer">
			<li><div style="background-color:gray; " class="legend"></div>未执行</li>
			<li><div style="background-color:#00FF00;" class="legend"></div>同意</li>
			<li><div style="background-color:red;" class="legend"></div>当前节点</li>
			<li><div style="background-color:#8A0902;" class="legend"></div>驳回</li>
		</ul>
		<div style="padding-top:40px;background-color: white;">
			<div style="margin-bottom: 5px;"><b>说明：</b>点击任务节点可以查看节点的执行人员。
				<c:if test="${superInstanceId != null}">
					<a class="link setting" onclick="ViewSuperExecutionFlowWindow({'processInstanceId':'${superInstanceId}'})">查看主流程</a>
				</c:if>
			</div>
			<div id="divTaskContainer" style="margin:0 auto;  position: relative;background:url('bpmImage?processInstanceId=${processInstanceId}&randId=<%=Math.random()%>') no-repeat;width:${shapeMeta.width}px;height:${shapeMeta.height}px;">
				${shapeMeta.xml}
			</div>  
		</div>
	</div>
</div>

