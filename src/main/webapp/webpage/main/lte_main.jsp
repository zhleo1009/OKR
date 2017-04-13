<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- <title>JEECG_LTE</title> -->
<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
<!-- Bootstrap 3.3.5 -->
<link rel="stylesheet" href="plug-in/lte/bootstrap/css/bootstrap.min.css">
<!-- Font Awesome -->
<link rel="stylesheet" href="plug-in/lte/bootstrap/css/font-awesome.min.css">
<!-- Ionicons -->
<link rel="stylesheet" href="plug-in/lte/bootstrap/css/ionicons.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="plug-in/lte/dist/css/AdminLTE.min.css">

<!-- AdminLTE Skins. Choose a skin from the css/skins
       folder instead of downloading all of them to reduce the load. -->
<link rel="stylesheet" href="plug-in/lte/dist/css/skins/_all-skins.min.css">

<link rel="stylesheet" href="plug-in/csshake/csshake.min.css">



<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
  
  <script src="plug-in/lte/bootstrap/js/html5shiv.min.js"></script>
  <script src="plug-in/lte/bootstrap/js/respond.min.js"></script>
  <![endif]-->


<style type="text/css">
.nav-tabs {
	padding-top: 4px;
	padding-left: 4px;
}

.tab-pane {
	padding-top: 5px;
}

/* 菜单字体 */
.skin-blue-light .sidebar-menu > li > a {
    font-weight: 500;
}

/* 菜单样式 */
.skin-blue-light .sidebar-menu > li:hover > a, .skin-blue-light .sidebar-menu > li:active > a{
    border-left: 3px solid transparent;
    font-weight: 600;
    border-left-color: #3c8dbc;
}

  
.main-header{
	 z-index: 900;
}

.main-header .logo {
    height: 51px;
}

</style>

</head>
<body class="sidebar-mini wysihtml5-supported skin-blue-light">
	<div class="wrapper">

		<header class="main-header">
			<a href="javascript:addTabs({id:'home',title:'首页',close: false,url: 'loginController.do?ltehome'});" class="logo"> 
				<span class="logo-mini"><b>OA</b></span>
				<span class="logo-lg"><b>OKR管理系统 </b></span>
				<!-- <span class="logo-lg"><b>demo OA </b></span> -->
			</a>

			<nav class="navbar navbar-static-top" role="navigation">
				<a href="#" class="sidebar-toggle" data-toggle="offcanvas"
					role="button"> <span class="sr-only">Toggle navigation</span>
				</a>

				<div class="navbar-custom-menu">
					<ul class="nav navbar-nav">
					
						<!-- <li class="dropdown messages-menu">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown"> 
								<i class="fa fa-envelope-o"></i> 
								<span class="label label-success" >0</span>
							</a>
							<ul class="dropdown-menu">
								<li class="header" >您有0封新邮件</li>
								<li>
									<ul class="menu">
									</ul>
								</li>
								<li class="footer"><a href="#">查看全部</a></li>
							</ul>
							
						</li> -->
						
					<!-- 论坛 
					 <li class="dropdown notifications-menu" onclick="goToBBS();">
				 
			            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
			              <i class="fa fa-users" > 论坛</i>
			            </a>
			           
			          </li>	
					-->		
					
					<!-- 未读公告 
					 <li class="dropdown notifications-menu" onclick="readNotification()">
				 
			            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
			              <i class="fa fa-bullhorn" id="noticeCountFont"></i>
			              <span class="label label-warning" id="noticeCount" style="font-size: 11px">0</span>
			            </a>
			            <ul class="dropdown-menu">
			              <li class="header" id="noticeTip"></li>
			              <li>
			                <ul class="menu" id="noticeContent">      
			                </ul>
			              </li>
			              <li class="footer"><a href="javascript:getUserNotice()">查看全部</a></li>
			            </ul>
			          </li>
          			-->	
          			<!-- 消息提醒 
					<li class="dropdown tasks-menu" onclick="readInnerMessage()">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown"> 
							<i class="fa fa-bell-o" id="messageCountFont"></i> 
							<span class="label label-danger" id="messageCount" style="font-size: 11px">0</span>
						</a>
						<ul class="dropdown-menu">
							<li class="header"  id="messageTip"></li>
							<li>
								<ul class="menu" id="messageContent">
								
								</ul>
							</li>
							<li class="footer"><a href="javascript:getUserMessage()">查看所有</a></li>
						</ul>
					</li>
					-->
					
					<!-- 个人信息 -->	
					<li class="dropdown user user-menu"><a href="#"
						class="dropdown-toggle" data-toggle="dropdown"> <img id ="headimgtop" 
							src="${pageContext.request.contextPath}/userInfoController.do?tofindPic" class="user-image"  onerror="this.src='plug-in/lte/dist/img/user2-160x160.jpg'"
							alt="User Image"> <span class="user-info"> <small>${realName
									}</small>
						</span>
					</a>
					
						<ul class="dropdown-menu" style="width: 320px">
							<li class="user-header" id="crop-avatar" >
							
							
								<div class="avatar-view">
			    					<img  width="90px" height="90px;" style="cursor: pointer;" src="${pageContext.request.contextPath}/userInfoController.do?tofindPic"  onerror="this.src='plug-in/lte/dist/img/user2-160x160.jpg'" class="img-circle" alt="User Image">
			    	
								</div>
								
								 <p>${realName} - ${roleName}</p>  <%--<small>注册于：${createTime }</small>--%>
								
								
							</li>
							<li class="user-body">
								<div class="row">
									<div class="col-xs-4 text-center">
										<a href="javascript:changePassword()"> <i
											class="fa fa-key"></i> <t:mutiLang
												langKey="common.change.password" />
										</a>
									</div>
									<div class="col-xs-4 text-center">
										<a href="javascript:getUserinfo()"> <i class="fa fa-user"></i>
											<t:mutiLang langKey="common.profile" />
										</a>
									</div>
											<div class="col-xs-4 text-center">
										<a href="javascript:getUserPerfect()"> <i class="fa fa-file-text-o"></i>
											<t:mutiLang langKey="完善资料" />
										</a>
									</div>
								</div>
							</li>
							
							<li class="user-footer" style="padding: 1px;">
							</li>
						</ul>
					</li>
					
					<li><a href="javascript:logout()"><i
							class="fa fa-sign-out"></i></a></li>
					</ul>
				</div>
				
				
			</nav>
		</header>
		<aside class="main-sidebar" >
			<section class="sidebar">
				<div class="user-panel">
					<div class="pull-left image">
						<img id ="headimgleft"  src="${pageContext.request.contextPath}/userInfoController.do?tofindPic"  onerror="this.src='plug-in/lte/dist/img/user2-160x160.jpg'"
							class="img-circle">
					</div>
					<div class="pull-left info">
						<p>${userName}</p>
						<a href="#"><i class="fa fa-circle text-success"></i> 当前在线</a>
					</div>
				</div>
				<div id="menuDiv" >
					<ul class="sidebar-menu">
						 <!-- <li class="header">系统主菜单
						 </li> -->
						 <li class="treeview">
					          <a href="javascript:addTabs({id:'home',title:'首页',close: false,url: 'loginController.do?ltehome'});">
					            <i class="fa fa-dashboard"></i>
					            <span>首页</span>
					          </a>
				          </li>
	
						<t:menu style="lte" menuFun="${menuMap}"></t:menu>
					</ul>
				
				</div>
			</section>
		</aside>

		<div class="content-wrapper" >

			<div class="nav-tabs-custom" id="tabs" style="margin-bottom: 0px;">
				<ul class="nav nav-tabs">
				</ul>
				<div class="tab-content no-padding">
				</div>
			</div>

		</div>

		<div class="control-sidebar-bg"></div>
	</div>


	<!-- 右键菜单 -->
	<div id="main-context-menu">
		<ul class="dropdown-menu">
			<li><a tabindex="-1" action="refresh" style="cursor: pointer;"><i
					class="fa fa-refresh"></i>刷新页面</a></li>
			<li><a tabindex="-1" action="close" style="cursor: pointer;"><i
					class="fa fa-close"></i>关闭当前</a></li>
			<li><a tabindex="-1" action="closeAll" style="cursor: pointer;"><i
					class="fa fa-ellipsis-h"></i>全部关闭</a></li>
			<li><a tabindex="-1" action="closeOthers"
				style="cursor: pointer;"><i class="fa fa-close"></i>关闭其他</a></li>
			<li class="divider"></li>
			<li><a tabindex="-1" action="closeRight"
				style="cursor: pointer;"><i class="fa fa-chevron-right"></i>关闭右侧</a></li>
			<li><a tabindex="-1" action="closeLeft" style="cursor: pointer;"><i
					class="fa fa-chevron-left"></i>关闭左侧</a></li>
		</ul>
	</div>

	<!-- jQuery 2.2.0 -->
	<!-- jQuery UI 1.11.4 -->
	<script src="jquery-html5-upload/jquery.min.js"></script>
	<link href="jquery-html5-upload/cropper/cropper.min.css" rel="stylesheet">
	<link href="jquery-html5-upload/sitelogo/sitelogo.css" rel="stylesheet">
	<script src="jquery-html5-upload/cropper/cropper.min.js"></script>
	<script src="jquery-html5-upload/sitelogo/sitelogo.js"></script>
	<!-- Bootstrap 3.3.5 -->
	<script src="plug-in/lte/bootstrap/js/bootstrap.min.js"></script>
	<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
	<script>
		//$.widget.bridge('uibutton', $.ui.button);
	</script>
	<!-- Slimscroll -->
	<script src="plug-in/lte/plugins/slimScroll/jquery.slimscroll.min.js"></script>
	<!-- AdminLTE App -->
	<script src="plug-in/lte/dist/js/app.js"></script>
	<script src="plug-in/jquery-plugs/storage/jquery.storageapi.min.js"></script>
	<script src="plug-in/bootstrap-contextmenu/bootstrap-contextmenu.js"></script>
	<script src="plug-in/layer/layer.js"></script>

	<script src="plug-in/lte/bootstrap/js/bootstrap-tab.js"></script>

	<script type="text/javascript">
	
		$(function() {
			
			//保留点击样式
			$(".treeview li").click(function(){
            	$(".treeview li").css('background','#f5f5f5');
            	$(this).css('background','#ccc');
       		 })
		
			//$('#menuDiv').css('height',$(window).height());
		
		// 首页
		addTabs({id:'home',title:'首页',close: false,url: 'loginController.do?ltehome'});
		
		// 展现消息框
		showMessageBar();
		
		// 电子签名
		//addTabs({id:'4028a08156d6872d0156d69090830003',title:'个人签名',close: true,url:'eSignatureController.do?list&clickFunctionId=4028a08156d6872d0156d69090830003'});
		
		// 新建审批
		//addTabs({id:'4028a0815627052301562786a603000a',title:'新建工作',close: true,url:'approveProcessController.do?newTaskManage&clickFunctionId=4028a0815627052301562786a603000a'});
		
		//人员
		//addTabs({id:'8a8ab0b246dc81120146dc8180df001f',title:'用户管理',close: true,url:'userController.do?user&clickFunctionId=8a8ab0b246dc81120146dc8180df001f'});
		
		//组织结构
		//addTabs({id:'8a8ab0b246dc81120146dc8180f60028',title:'组织机构',close: true,url:'departController.do?depart&clickFunctionId=8a8ab0b246dc81120146dc8180f60028'});
		
		//角色
		//addTabs({id:'8a8ab0b246dc81120146dc8180e30021',title:'角色管理',close: true,url:'roleController.do?role&clickFunctionId=8a8ab0b246dc81120146dc8180e30021'});
	
		// 国际化
		//addTabs({id:'402881c746de1ea60146de207d770001',title:'国际化语言',close: true,url:'mutiLangController.do?mutiLang&clickFunctionId=402881c746de1ea60146de207d770001'});
	
		// 数据字典
		//addTabs({id:'8a8ab0b246dc81120146dc8180ee0025',title:'数据字典',close: true,url:'systemController.do?typeGroupList&clickFunctionId=8a8ab0b246dc81120146dc8180ee0025'});
		
		// 菜单
		//addTabs({id:'8a8ab0b246dc81120146dc8180e70023',title:'菜单管理',close: true,url:'functionController.do?function&clickFunctionId=8a8ab0b246dc81120146dc8180e70023'});
		
		// 地域选择
		//addTabs({id:'8a8ab0b246dc81120146dc8180f80029',title:'地域管理',close: true,url:'territoryController.do?territory&clickFunctionId=8a8ab0b246dc81120146dc8180f80029'});
		
		// online coding
		//addTabs({id:'8a8ab0b246dc81120146dc818106002d',title:'Online表单开发',close: true,url:'cgFormHeadController.do?cgFormHeadList&clickFunctionId=8a8ab0b246dc81120146dc818106002d'});
		
		// 图标
		//addTabs({id:'8a8ab0b246dc81120146dc8180f30027',title:'系统图标',close: true,url:'iconController.do?icon&clickFunctionId=8a8ab0b246dc81120146dc8180f30027'});
			
		// 人员
		//addTabs({id:'8a8ab0b246dc81120146dc8180df001f',title:'用户管理',close: true,url:'userController.do?user&clickFunctionId=8a8ab0b246dc81120146dc8180df001f'});

		// 组织结构
		//addTabs({id:'8a8ab0b246dc81120146dc8180f60028',title:'组织机构',close: true,url:'departController.do?depart&clickFunctionId=8a8ab0b246dc81120146dc8180f60028'});

		// 角色
		//addTabs({id:'8a8ab0b246dc81120146dc8180e30021',title:'角色管理',close: true,url:'roleController.do?role&clickFunctionId=8a8ab0b246dc81120146dc8180e30021'});

		// 系统公告
		//addTabs({id:'402880ea53303a060153304a9ad50001',title:'系统公告',close: true,url:'noticeController.do?tSNotice&clickFunctionId=402880ea53303a060153304a9ad50001'});
		
		//流程定义
		//addTabs({id:'4028a0815513f3f6015514fcba5e0006',title:'流程定义',close: true,url:'bpmDefinitionController.do?manage&clickFunctionId=4028a0815513f3f6015514fcba5e0006'});
		
		// 表单自定义
		//addTabs({id:'402881e54df73c73014df75ab670000f',title:'自定义表单列表',close: true,url:'autoFormController.do?autoForm&clickFunctionId=402881e54df73c73014df75ab670000f'});
		
		});
		
	/**	// ajax轮询
		function showMessageBar(){
			readNotification();
			setInterval("readNotification()", 30000);  
			readInnerMessage();
			setInterval("readInnerMessage()", 30000);  
			getProcessCountInfo();
			setInterval("getProcessCountInfo()", 30000);  
		}
		
		*/
		// 读取和流程相关的数量信息
		function getProcessCountInfo(){
			
			$.ajax({
				url : 'messageController.do?getProcessCountInfo',
				type : "GET",
				dataType : "JSON",
				async : false,
				success : function(data) {
					if(data.success){
						
						//赋值
						var toDoTaskCountA = $("a[url='taskController.do?taskForMeList']");
						if(toDoTaskCountA.find("span")){
							toDoTaskCountA.find("span").remove();
						}
						if(data.obj.toDoTaskCount > 0){
							toDoTaskCountA.append("<span class='label label-primary pull-right'>" + data.obj.toDoTaskCount +"</span>");
						}
						
						
						var taskAssigneeCountA = $("a[url='myTaskController.do?myTaskList']");
						if(taskAssigneeCountA.find("span")){
							taskAssigneeCountA.find("span").remove();
						}
						if(data.obj.taskAssigneeCount > 0){
							taskAssigneeCountA.append("<span class='label pull-right bg-green'>" + data.obj.taskAssigneeCount +"</span>");
						}
						
						
						var agentTaskCountA = $("a[url='sysUserAgentController.do?agentManage']");
						if(agentTaskCountA.find("span")){
							agentTaskCountA.find("span").remove();
						}
						if(data.obj.agentTaskCount > 0){
							agentTaskCountA.append("<span class='label label pull-right bg-red'>" + data.obj.agentTaskCount +"</span>");
						}
						
						
					}
				}
			});
			
		};
		
		
		
		var noticeNumber;//公告数量
		var innerMessageNumber;//站内信数量
		// 读取公告
		function readNotification(){
			//加载公告
			var url = "noticeController.do?getNoticeList";
			jQuery.ajax({
						url : url,
						type : "GET",
						dataType : "JSON",
						async : false,
						success : function(data) {
							if (data.success) {
								var noticeList = data.attributes.noticeList;
								var noticeCount = data.obj;
								if(noticeNumber != undefined && noticeCount > noticeNumber){
									$('#noticeCountFont').addClass('shake-horizontal shake-constant');
									setTimeout("$('#noticeCountFont').removeClass('shake-horizontal shake-constant')",30000)
								}
								noticeNumber = noticeCount;
								//加载公告条数
								if (noticeCount > 99) {
									$("#noticeCount").html(
											"99+");
								} else {
									$("#noticeCount").html(
											noticeCount);
								}
								//加载公告提示
								var noticeTip = "";
								noticeTip += "<i class='icon-warning-sign'></i>";
								noticeTip += noticeCount
										+ " 条未读公告";
								$("#noticeTip").html(noticeTip);

								//加载公告条目
								var noticeContent = "";
								if (noticeList.length > 0) {
									for ( var i = 0; i < noticeList.length; i++) {
										if(i >= 5){
											break;
										}
										noticeContent += "<li><a href='javascript:goNotice(&quot;"
												+ noticeList[i].id
												+ "&quot;)' ";
										noticeContent += "style='word-break:keep-all;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;'>";
										
										switch(i%5)
										{
										case 0:
											noticeContent += "<i class='fa fa-exclamation-circle text-aqua'></i>";
										  break;
										case 1:
											noticeContent += "<i class='fa fa-exclamation-circle text-yellow'></i>";
										  break;
										case 2:
											noticeContent += "<i class='fa fa-exclamation-circle text-red'></i>";
										  break;
										case 3:
											noticeContent += "<i class='fa fa-exclamation-circle text-green'></i>";
										  break;
										case 4:
											noticeContent += "<i class='fa fa-exclamation-circle text-red'></i>";
										  break;
										default:
											 break;
										}
										
										noticeContent += "&nbsp;"
												+ noticeList[i].noticeTitle
												+ "</a></li></ul></li>";
									}
								}
								
								$("#noticeContent").html(
										noticeContent);

								//加载公告底部文字
								var noticeSeeAll = data.attributes.seeAll
										+ "<i class='ace-icon fa fa-arrow-right'></i>";
								$("#noticeFooter").html(
										noticeSeeAll);
							}
						}
					});
			
			
			
			//修改首页公告
			
			
		}
		
		
		// 读取站内信
		function readInnerMessage(){
			
			//加载消息
			var url = "messageController.do?getUnReadMessageList";
			jQuery.ajax({
						url : url,
						type : "GET",
						dataType : "JSON",
						async : false,
						success : function(data) {
							if (data.success) {
								var messageList = data.attributes.messageList;
								var noticeCount = data.obj;
								if(innerMessageNumber != undefined && noticeCount > innerMessageNumber){
									$('#messageCountFont').addClass('shake-horizontal shake-constant');
									setTimeout("$('#messageCountFont').removeClass('shake-horizontal shake-constant')",30000)
								}
								innerMessageNumber = noticeCount;
								//加载公告条数
								if (noticeCount > 99) {
									$("#messageCount").html(
											"99+");
								} else {
									$("#messageCount").html(
											noticeCount);
								}
								//加载公告提示
								var messageTip = "";
								messageTip += "<i class='icon-warning-sign'></i>";
								messageTip += noticeCount
										+ " 条未读消息";
								$("#messageTip").html(messageTip);

								//加载公告条目
								var messageContent = "";
								if ( messageList.length > 0) {
									for ( var i = 0; i < messageList.length; i++) {
										messageContent += "<li><a href='javascript:goMessage(&quot;"
												+ messageList[i].id
												+ "&quot;)' ";
										messageContent += "style='word-break:keep-all;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;'>";
										
										switch(i%5)
										{
										case 0:
											messageContent += "<i class='fa fa-exclamation-circle text-aqua'></i>";
										  break;
										case 1:
											messageContent += "<i class='fa fa-exclamation-circle text-yellow'></i>";
										  break;
										case 2:
											messageContent += "<i class='fa fa-exclamation-circle text-red'></i>";
										  break;
										case 3:
											messageContent += "<i class='fa fa-exclamation-circle text-green'></i>";
										  break;
										case 4:
											messageContent += "<i class='fa fa-exclamation-circle text-red'></i>";
										  break;
										default:
											 break;
										}
										
										messageContent += "&nbsp;"
												+ messageList[i].messageTitle
												+ "</a></li></ul></li>";
									}
								}
								
								$("#messageContent").html(
										messageContent);
								
								//加载公告底部文字
								var noticeSeeAll = data.attributes.seeAll
										+ "<i class='ace-icon fa fa-arrow-right'></i>";
								$("#messageFooter").html(
										noticeSeeAll);
								
							}
						}
					});
			
			
			
		}
		
		
		
		

		//登出
		function logout() {
			layer.confirm('确定退出登录嘛？', {
				btn : [ '确定', '取消' ]
			//按钮
			}, function() {
				location.href = "loginController.do?logout";
			}, function() {

			});

		}
		function createdetailwindow(title, addurl,width,height) {
			width = width?width:550;
			height = height?height:400;
			if(width=="100%" || height=="100%"){
				width = window.top.document.body.offsetWidth;
				height =window.top.document.body.offsetHeight-100;
			}
			var name; //网页名称，可为空;
			var iWidth; //弹出窗口的宽度;
			var iHeight; //弹出窗口的高度;
			//window.screen.height获得屏幕的高，window.screen.width获得屏幕的宽
			var iTop = (window.screen.height-30-500)/2; //获得窗口的垂直位置;
			var iLeft = (window.screen.width-30-650)/2; //获得窗口的水平位置;
			window.open(addurl,name,'height='+height+',width='+width+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=auto,resizeable=no,location=no,status=no');
			
		}
		//修改密码
		function changePassword() {

			layer.open({
						id : 'changePasswordLayer',
						type : 2,
						content : [ 'userController.do?changepassword', 'no' ],
						area : [ '600px', '300px' ],
						btn : [ '确定', '取消' ],
						yes : function(index, layero) {
							layero.find('iframe').contents().find('#submitBtn')
									.click();
						}
					});
		}

		// 获取人员信息
		function getUserinfo() {
			layer.open({
				type : 2,
				content : 'userController.do?userinfo',
				area : [ '500px', '300px' ]
			});
		}
		
		
		function getUserPerfect() {
			layer.open({
				btns : 1,
			    btn : ['确定', '取消'],	
				type : 2,
				content : 'userInfoController.do?goPerfect',
				area : [ '500px', '500px' ],
				
				
				yes : function(index, layero) {
					//layero.find('iframe').contents().find('#submitBtn').click();
					//layer.close(index);
					  layero.find('iframe').contents().find('#btn_sub').trigger('click');
				}
			});
		}
		
		
		
		
		
		// 展现通知公告明细
		 function goNotice(id){
		  		var addurl = "noticeController.do?goAndReadNotice&id="+id;
		  		layer.open({
					type : 2,
					content :addurl,
					area : [ '800px', '600px' ],
					cancel: function(index){ 
						readNotification();
					} ,
					maxmin:true
				});
		    }
		 
		
		// 展现消息明细
		 function goMessage(id){
		  		layer.open({
					type : 2,
					content :"messageController.do?goAndReadMessage&id="+id,
					area : [ '500px', '300px' ],
					cancel: function(index){ 
						readInnerMessage();
					} 
				});
		    }
		 
		 
		 
		// 获取系统消息
		function getSysInfo() {
			layer.open({
				type : 2,
				content : [ 'tSSmsController.do?getSysInfos', 'no' ],//这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
				area : [ '500px', '300px' ]
			});
		}
		
		
		// 获取通知列表
		function getUserNotice() {
			top.layer.open({
				title: '通知中心',
				type : 2,
				content : 'noticeController.do?noticeList',
				area : [ '800px', '600px' ]
			});
		}
		
		
		// 获取消息列表
		function getUserMessage() {
			top.layer.open({
				title: '通知中心',
				type : 2,
				content : 'messageController.do?messageList',
				area : [ '800px', '600px' ]
			});
		}
		
		function goToBBS(){
			window.open('bbsController.do?bbs'); 
		}
		
		
		// 专门用于我的待办刷新、刷新流程任务
		function reloadMyTodoTask(){
			var iframe = $('iframe[name=tabname_40284ac754a7c6810154a7cc48880007]')[0];
			if(iframe){
				iframe.contentWindow.reloadDatagrid();
			}
			
			iframe = $('iframe[name=tabname_402881e65586a46b015586a691440003]')[0];
			if(iframe){
				iframe.contentWindow.reloadDatagrid();
			}
		}
		
		
		
	</script>
	
	

<!-- <script>(function(T,h,i,n,k,P,a,g,e){g=function(){P=h.createElement(i);a=h.getElementsByTagName(i)[0];P.src=k;P.async=1;a.parentNode.insertBefore(P,a)};T["ThinkPageWeatherWidgetObject"]=n;T[n]||(T[n]=function(){(T[n].q=T[n].q||[]).push(arguments)});T[n].l=+new Date();if(T.attachEvent){T.attachEvent("onload",g)}else{T.addEventListener("load",g,false)}}(window,document,"script","tpwidget","//widget.thinkpage.cn/widget/chameleon.js"))</script>
<script>tpwidget('init', {
    "flavor": "bubble",
    "location": "WX4FBXXFKE4F",
    "geolocation": "enabled",
    "position": "bottom-left",
    "margin": "5px 5px",
    "language": "auto",
    "unit": "c",
    "theme": "chameleon",
    "uid": "U563EB9E64",
    "hash": "2478fa0d7b67e23094abd31a491eb921"
});
tpwidget('show');</script> -->


<!-- 上传头像 -->
	
	<div class="ibox-content" >
		<div class="row">
		
		<!-- 
			<div id="crop-avatar" class="col-md-6">
				<div class="avatar-view" title="Change Logo Picture">
			    	<img src="jquery-html5-upload/logo.jpg" alt="Logo">
			    </div>
			</div>
			 -->
			
			
		</div>
	</div>

<div class="modal fade" id="avatar-modal" aria-hidden="true" aria-labelledby="avatar-modal-label" role="dialog" tabindex="-1">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<form class="avatar-form" action="userInfoController.do?doUploadPic" enctype="multipart/form-data" method="post">
				<div class="modal-header">
					<button class="close" data-dismiss="modal" type="button">&times;</button>
					<h4 class="modal-title" id="avatar-modal-label">上传头像</h4>
				</div>
				<div class="modal-body">
					<div class="avatar-body">
						<div class="avatar-upload">
							<input class="avatar-src" name="avatar_src" type="hidden">
							<input class="avatar-data" name="avatar_data" type="hidden">
							<label for="avatarInput">图片上传</label>
							<input class="avatar-input" id="avatarInput" name="avatar_file" type="file"></div>
						<div class="row">
							<div class="col-md-9">
								<div class="avatar-wrapper"></div>
							</div>
							<div class="col-md-3">
								<div class="avatar-preview preview-lg"></div>
								<!--  <div class="avatar-preview preview-md"></div>
								<div class="avatar-preview preview-sm"></div>-->
							</div>
						</div>
						<div class="row avatar-btns">
							<div class="col-md-9">
								<div class="btn-group">
									<button class="btn" data-method="rotate" data-option="-90" type="button" title="Rotate -90 degrees"><i class="fa fa-undo"></i> 向左旋转</button>
								</div>
								<div class="btn-group">
									<button class="btn" data-method="rotate" data-option="90" type="button" title="Rotate 90 degrees"><i class="fa fa-repeat"></i> 向右旋转</button>
								</div>
							</div>
							<div class="col-md-3">
								<button class="btn btn-success btn-block avatar-save" type="submit"><i class="fa fa-save"></i> 保存修改</button>
							</div>
						</div>
					</div>
				</div>
  		</form>
  	</div>
  </div>
</div>

<div class="loading" aria-label="Loading" role="img" tabindex="-1"></div>


<!-- 上传头像 -->

</body>
</html>
