<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/pe/commons/include/html_doctype.html" %>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools"></t:base>
<html>
<head>
    <title>流程定义明细子流程图</title>
    
    <c:set var="ctx" value="${pageContext.request.contextPath}" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
   
    <script type="text/javascript" src="${ctx}/pe/js/util/util.js"></script>
	<script type="text/javascript" src="${ctx}/pe/js/util/form.js"></script>
	<script type="text/javascript" src="${ctx}/pe/js/lg/ligerui.min.js"></script>
	
   	<link href="${ctx}/pe/styles/default/css/jquery.qtip.css" rel="stylesheet" />
   	<link href="${ctx}/pe/styles/default/css/definition.node.css" rel="stylesheet" />
   	
    <script type="text/javascript" src="${ctx}/pe/js/pe/platform/bpm/SignRuleWindow.js" ></script>
    <script type="text/javascript" src="${ctx}/pe/js/pe/platform/bpm/FlowRuleWindow.js" ></script>
    <script type="text/javascript" src="${ctx}/pe/js/pe/platform/bpm/FlowVarWindow.js" ></script>
    <script type="text/javascript" src="${ctx}/pe/js/pe/platform/bpm/ForkConditionWindow.js" ></script>
    <script type="text/javascript" src="${ctx}/pe/js/pe/platform/bpm/FlowEventWindow.js" ></script>
    <script type="text/javascript" src="${ctx}/pe/js/pe/platform/bpm/FlowForkJoinWindow.js" ></script>
    <script type="text/javascript" src="${ctx}/pe/js/pe/platform/bpm/MobileSetWindow.js" ></script>
    <script type="text/javascript" src="${ctx}/pe/js/pe/platform/bpm/FlowMessageWindow.js" ></script>
    <script type="text/javascript" src="${ctx}/pe/js/pe/platform/bpm/FlowWebServiceWindow.js" ></script>
    <script type="text/javascript" src="${ctx}/pe/js/pe/platform/bpm/FlowReminderWindow.js" ></script>
    <script type="text/javascript" src="${ctx}/pe/js/pe/platform/bpm/BpmNodeUserSetWindow.js" ></script>
    <script type="text/javascript" src="${ctx}/pe/js/pe/platform/bpm/FlowApprovalItemWindow.js" ></script>
    
    <!-- 查看流程示意图 -->
    <script type="text/javascript" src="${ctx}/pe/js/pe/platform/bpm/ViewSubFlowWindow.js" ></script>
    <script type="text/javascript" src="${ctx}/pe/js/jquery/plugins/jquery.qtip.js" ></script>
    
    <script type="text/javascript">
    
    
    
    		var defId ="${bpmDefinition.defId}";
    		var actDefId ="${bpmDefinition.actDefId}";
    		var deployId= "${bpmDefinition.actDeployId}";
            var menu;
            //判断参数是否加载
            var isOtherParamFrm=false;
            var currentObj=null;
            $(function (){
                 $("div.flowNode").each(function(){                	
                	$(this).bind({mouseenter:function(){
                		currentObj=$(this);
                	}});
                	currentObj=$(this);
                	var type=currentObj.attr("type"),title=currentObj.attr("title");
                	var items= getItems(type);
                	if(!items)return;
                	if(items.length==0)return;
                	var item,html=['<div class="edui-menu-body">'];
                	while(item=items.pop()){
                		if(item.id=='-'){
                			html.push('<div class="edui-menuitem edui-menuseparator"><div class="edui-menuseparator-inner"></div></div>');
                		}
                		else{
                			html.push('<div class="edui-menuitem edui-for-'+item.id+'" onmouseover="$(this).addClass(\'edui-state-hover\')" onmouseout="$(this).removeClass(\'edui-state-hover\')" onclick="clickHandler(this.id)" id="'+item.id+'"><div class="edui-box edui-icon"></div><div class="edui-box edui-label edui-menuitem-label">'+item.text+'</div></div>');
                		}
                	}
                	html.push('</div>');
   			      $(this).qtip({  
   			        content:{
   			        	text:html.join(''),
   			        	title:{
   			        		text:title
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
   			        	event:'click mouseleave',
   			        	leave: false,
   			        	fixed:true,
   			        	delay:300
   			        	},  
   			        style: {
   			       	  classes:'ui-tooltip-light ui-tooltip-shadow'
   			        } 			    
   			      });
   			    });  
            });
            
            
            function getItems(type) {
            	var items=[];
            	switch(type){
            		/* case "startEvent":
            			items= [{id:'flowEvent', text: '事件设置'}];
            			break; */
            		/*
            		case "subStartEvent":
            			items= [ {id:'flowEvent', text: '事件设置'}];
            			break;
            		*/
            		/* case "endEvent":
            			items= [{id:'flowEvent', text: '事件设置' }];
            			break; */
            		case "parallelGateway":
            			items= [];
            			break;
            		case "inclusiveGateway":
            		case "exclusiveGateway":
            			items= [{id:'flowCodition', text: '设置分支条件' }];
            			break;
            		case "multiUserTask":
            			items= [/* {id:'mobileSet',text:'手机访问设置'},
            			        {id:'-'}, */
            			        /* {id:'flowRule', text: '跳转规则设置' } */,
                		        {id:'flowVote', text: '会签投票规则设置' },
                		        /* {id:'-'}, */
                		        /* {id:'flowEvent', text: '事件设置' }, */
                		        {id:'flowDue', text: '任务到期设置' }/* , */
                		        /* {id:'-'}, */
                		        /* {id:'flowApproval', text: '常用语设置' }, */
                		        /* {id:'userSet', text: '人员设置' } */
                		        ];
            			break;
            		case "userTask":
            			items= [
                		        /* {id:'mobileSet',text:'手机访问设置'},
                		        {id:'-'}, */
                		        /* {id:'flowRule', text: '跳转规则设置' },
                		        {id:'flowEvent', text: '事件设置' }, */
                		        /* {id:'-'}, */
                		        {id:'flowDue', text: '任务到期设置' }/* , */
                		        /* {id:'flowForkJoin', text: '流程分发汇总' }, */
                		        /* {id:'-'}, */
                		        /* {id:'flowApproval', text: '常用语设置' }, */
                		        /* {id:'userSet', text: '人员设置' }  */
                		        ];
            			break;
            		/* case "webService":
            			items= [{id:'webServiceSet',text:'WebService设置'}];
            			break;
            		case "email":
            			items= [{id:'flowMessage', text: '消息参数' }];
            			break;
            		case "script":
            			items= [{id:'flowEvent', text: '设置脚本' }];
            			break; */
            		case "callActivity":
            			items= [{id: 'viewSubFlow',text: '查看调用子过程示意图'}];
            			break;
            		/* case "subProcess":
            			items= [{id: 'flowEvent',text: '事件设置'}];
            			break; */
            	}
            
            	return items;
            }

            var signRule;
            var flowRule;
            var forkCondition;

            function clickHandler(itemId){
            	//节点类型
            	var type=currentObj.attr("type");            	
            	//任务id
            	var activitiId=currentObj.attr("id");
            	var activityName=currentObj.attr("title");
            	
            	if(itemId=="flowVote" && type=="multiUserTask"){
            		SignRuleWindow({actDefId:actDefId,activitiId:activitiId});
            	}
            	else if(itemId=="flowRule"){
            		FlowRuleWindow({deployId:deployId,actDefId:actDefId,nodeId:activitiId,nodeName:activityName});
            	}
            	else if(itemId=="webServiceSet"){
            		//alert("webservice设置");
                	FlowWebServiceWindow({actDefId:actDefId,nodeId:activitiId,defId:defId});
            	}
            	else if(itemId=="flowCodition"){
            		ForkConditionWindow({defId:defId,deployId:deployId,nodeId:activitiId});
           		}
            	else if(itemId=="flowMessage"){
            		FlowMessageWindow({actDefId:actDefId,nodeId:activitiId});
            	}
            	else if(itemId=="flowEvent"){
            		//开始事件 后置脚本 type startEvent
            		//结束事件 前置脚本 endEvent
            		//用户任务 多实例任务 前后 userTask  multiUserTask
            		//脚本节点 脚本节点 script
            		FlowEventWindow({type:type,actDefId:actDefId,activitiId:activitiId,defId:defId});
            	}
            	else if(itemId=="userSet"){
            		UserSetWindow({defId:defId,nodeId:activitiId});
            	}
            	else if(itemId=="flowDue"){
            		FlowReminderWindow({actDefId:actDefId,nodeId:activitiId});
            	}else if(itemId=="flowForkJoin"){
            		FlowForkJoinWindow({actDefId:actDefId,nodeId:activitiId,activityName:activityName});
            	}else if(itemId=="flowApproval"){ // 常用语设置
            		FlowApprovalItemWindow({activitiId:activitiId,defId:defId,actDefId:actDefId});
            	}else if(itemId=="viewSubFlow"){// 查看子流程示意图
            		ViewSubFlowWindow({nodeId:activitiId,defId:defId,actDefId:actDefId});
            	}else if(itemId=="mobileSet"){
            		MobileSetWindow({nodeId:activitiId,defId:defId,actDefId:actDefId});
            	}
            }
            
            
     </script> 
   
   
	<style type="text/css"> 
	    body{ padding:0px; margin:0;overflow:auto;}  
	    div.flowNode{cursor:pointer;}
	</style>
</head>
<body>
	<br/>
	<div class="panel">
		<div style="position: relative;background:url('${ctx}/bpmImage?deployId=${bpmDefinition.actDeployId}')  no-repeat;width:${shapeMeta.width}px;height:${shapeMeta.height+100}px;">
				${shapeMeta.xml} 
		</div>
	</div>
</body>
</html>