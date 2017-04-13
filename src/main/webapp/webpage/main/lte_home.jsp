<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>SpeedChina|速度中国</title>
  <!-- Tell the browser to be responsive to screen width -->
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
  <!-- Date Picker -->
  <link rel="stylesheet" href="plug-in/lte/plugins/datepicker/datepicker3.css">

  <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  <!--[if lt IE 9]>
  
  <script src="plug-in/lte/bootstrap/js/html5shiv.min.js"></script>
  <script src="plug-in/lte/bootstrap/js/respond.min.js"></script>
  <![endif]-->
  
  <style type="text/css">
      ul.marquee {display: block;line-height: 1;position: relative;overflow: hidden;width: 400px;  height: 22px; }  
    ul.marquee li {position: absolute; top: -999em;left: 0;display: block;  white-space: nowrap; padding: 3px 5px; text-indent:0.8em;}
  
  
  </style>
  

<style type="text/css">
.nav-tabs {
	padding-top: 4px;
	padding-left: 4px;
}

.tab-pane {
	padding-top: 5px;
}

.notification{
	list-style: outside none none;
	padding-left: 10px;
	font-size: 14px;
}

.notification li{
	padding: 9px 10px;
}

.notification span{
	padding-left: 10px;
}

.notification-footer {
	border-top: 1px solid #f4f4f4;
	text-align: right;
	bottom:0px;
	position: absolute;
	width: 100%;
	height: 40px;
}

.notification-footer a{
	color: black;
	margin-right: 10px;
	position: relative;
}

.notification-footer a:hover{
	color: #999;
}

.text-muted:hover{
	color: #888;
}

</style>

</head>
<body class="hold-transition skin-blue sidebar-mini" >

    <section class="content">
    
      <!-- 状态栏 -->
      <div class="row">
        <div class="col-lg-3 col-xs-6">
          <div class="small-box bg-aqua">
            <div class="inner">
              <h3>${toDoTaskCount}</h3>
              <p>我的待办事项</p>
            </div>
            <div class="icon">
              <i class="fa fa-tasks"></i>
            </div>
            <a href="javascript:parent.addTabs({id:'40284ac754a7c6810154a7cc48880007',title:'我的待办事项',close: true,url:'taskController.do?taskForMeList&clickFunctionId=40284ac754a7c6810154a7cc48880007'})" class="small-box-footer">查看更多 <i class="fa fa-arrow-circle-right"></i></a>
          </div>
        </div>
        
        <div class="col-lg-3 col-xs-6">
          <div class="small-box bg-green">
            <div class="inner">
              <h3>${myStartProcessCount }</h3>
              <p>我发起的流程</p>
            </div>
            <div class="icon">
              <i class="fa fa-download"></i>
            </div>
            <a href="javascript:parent.addTabs({id:'402881e4550c7b3f01550c8073be0005',title:'我发起的流程',close: true,url:'processRunController.do?myStartPage&clickFunctionId=402881e4550c7b3f01550c8073be0005'})" class="small-box-footer">查看更多 <i class="fa fa-arrow-circle-right"></i></a>
          </div>
        </div>
        
        <div class="col-lg-3 col-xs-6">
          <div class="small-box bg-yellow">
            <div class="inner">
              <h3>${myApprovedCount}</h3>
              <p>我审批的流程</p>
            </div>
            <div class="icon">
              <i class="fa fa-check-square"></i>
            </div>
            <a href="javascript:parent.addTabs({id:'402881e554bee11c0154bee64c5c0002',title:'我审批的流程',close: true,url:'processRunController.do?myAttendPage&clickFunctionId=402881e554bee11c0154bee64c5c0002'})" class="small-box-footer">查看更多 <i class="fa fa-arrow-circle-right"></i></a>
          </div>
        </div>
        
        <div class="col-lg-3 col-xs-6">
          <div class="small-box bg-red">
            <div class="inner">
              <h3>${agentTaskCount }</h3>
              <p>我的代理任务</p>
            </div>
            <div class="icon">
              <i class="fa fa-thumb-tack"></i>
            </div>
            <a href="javascript:parent.addTabs({id:'402881e4550c7b3f01550c7f3afd0001',title:'我的代理任务',close: true,url:'sysUserAgentController.do?agentManage&clickFunctionId=402881e4550c7b3f01550c7f3afd0001'})" class="small-box-footer">查看更多 <i class="fa fa-arrow-circle-right"></i></a>
          </div>
        </div>
        
      </div>
      
      
      
      <div class="row">
        <section class="col-lg-7 connectedSortable">
          <div class="nav-tabs-custom">
            <ul class="nav nav-tabs pull-right">
            
              <li class="active"><a href="#notice-info" data-toggle="tab">公告</a></li>
              <li><a href="#message-info" data-toggle="tab">消息</a></li>
              
              <li class="pull-left header" style="font-size:15px;"><i class="fa fa-bullhorn"></i> 通知中心</li>
            </ul>
            <div class="tab-content no-padding">
            
              <!-- 公告 -->
              <div class="chart tab-pane active" id="notice-info" style="position: relative; height: 240px;">
              
               <ul class="notification" id="userNotifications">
               
               <c:if test="${empty noticeList }">
               	暂无未读公告信息！
               </c:if>
               
               <c:if test="${!empty noticeList }">
               		<c:forEach items="${noticeList}" var="notice" varStatus="stat">
	               	 <li>
	                    <a href="javascript:getNotificationDetail('${notice.id }')">
	                      <c:if test="${stat.index == '0'}">
	                      	<i class="fa fa-square text-aqua"></i>
	                      </c:if>
	                      <c:if test="${stat.index == '1'}">
	                      	<i class="fa fa-square text-yellow"></i>
	                      </c:if>
	                      <c:if test="${stat.index == '2'}">
	                      	<i class="fa fa-square text-red"></i>
	                      </c:if>
	                      <c:if test="${stat.index == '3'}">
	                      	<i class="fa fa-square text-green"></i>
	                      </c:if>
	                      <c:if test="${stat.index == '4'}">
	                      	<i class="fa fa-square text-aqua"></i>
	                      </c:if>
	                       <span>${notice.title}</span>
	                      <span class="text-muted pull-right"><i class="fa fa-clock-o"></i> ${notice.createTime}</span>
	                    </a>
	                  </li>
	               	</c:forEach>
               </c:if>
               
               
                </ul>
                <div class="notification-footer">
                	<div style="margin-top: 10px;"><a href="javascript:getUserNotice()" >查看全部</a></div>
                </div>
              </div>
              
              <!-- 消息提醒 -->
              <div class="chart tab-pane" id="message-info" style="position: relative; height: 240px;">
              	
                  <ul class="notification" id="innerMessage">
               
               <c:if test="${empty messageList }">
               	暂无未读消息信息！
               </c:if>
               
               <c:if test="${!empty messageList }">
               		<c:forEach items="${messageList}" var="message" varStatus="stat">
	               	 <li>
	                    <a href="javascript:getMessageDetail('${message.id }')">
	                      <c:if test="${stat.index == '0'}">
	                      	<i class="fa fa-square text-aqua"></i>
	                      </c:if>
	                      <c:if test="${stat.index == '1'}">
	                      	<i class="fa fa-square text-yellow"></i>
	                      </c:if>
	                      <c:if test="${stat.index == '2'}">
	                      	<i class="fa fa-square text-red"></i>
	                      </c:if>
	                      <c:if test="${stat.index == '3'}">
	                      	<i class="fa fa-square text-green"></i>
	                      </c:if>
	                      <c:if test="${stat.index == '4'}">
	                      	<i class="fa fa-square text-aqua"></i>
	                      </c:if>
	                       <span>${message.esTitle}</span>
	                      <span class="text-muted pull-right"><i class="fa fa-clock-o"></i> ${message.esSendtime}</span>
	                    </a>
	                  </li>
	               	</c:forEach>
               </c:if>
                </ul>
              
                <div class="notification-footer">
                	<div style="margin-top: 10px;"><a href="javascript:getUserMessage()" >查看全部</a></div>
                </div>
              
              </div>
              
              
            </div>
            
          </div>
        </section>
        
        <section class="col-lg-5 connectedSortable">

          <!-- 日历控件 -->
          <div class="box box-solid bg-green-gradient">
            <div class="box-header" >
              <i class="fa fa-calendar" style="font-size:15px;"></i>
              <span class="box-title" style="font-size:15px;">日历</span>
              
              <!-- 工具 -->
              <div class="pull-right box-tools">
                <button type="button" class="btn btn-success btn-sm" data-widget="collapse"><i class="fa fa-minus"></i>
                </button>
                <button type="button" class="btn btn-success btn-sm" data-widget="remove"><i class="fa fa-times"></i>
                </button>
              </div>
            </div>
            
            <div class="box-body no-padding">
              <div id="calendar" style="width: 100%"></div>
            </div>
          </div>

        </section>
        
        
      </div>
      
      <!-- 滚动字幕 -->
      <section>
      	
      	<div id="marquee">
      	
      		<c:forEach var="attendance" items="${attendances}">
      			<span style="margin-right: 15px;">
	      			<i class="fa fa-circle" 
	      				style="color: #F39C12"></i>
	      			<a href="#">【滚动播出】我来也</a>
	      		</span>
      		</c:forEach>
      		
      	</div>
      	
      </section>
      
    </section>
  

<!-- jQuery 2.2.0 -->
<script src="plug-in/lte/plugins/jQuery/jQuery-2.2.0.min.js"></script>
<!-- jQuery UI 1.11.4 -->
<script src="plug-in/lte/plugins/jQueryUI/jquery-ui.min.js"></script>
<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
<script>
  $.widget.bridge('uibutton', $.ui.button);
</script>
<!-- Bootstrap 3.3.5 -->
<script src="plug-in/lte/bootstrap/js/bootstrap.min.js"></script>
<!-- jvectormap -->
<script src="plug-in/lte/plugins/jvectormap/jquery-jvectormap-1.2.2.min.js"></script>
<script src="plug-in/lte/plugins/jvectormap/jquery-jvectormap-world-mill-en.js"></script>
<!-- datepicker -->
<script src="plug-in/lte/plugins/datepicker/bootstrap-datepicker.js"></script>
<!-- AdminLTE App -->
<script src="plug-in/lte/dist/js/app.min.js"></script>
<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
<script src="plug-in/lte/dist/js/pages/dashboard.js"></script>
<!-- layer -->
<script src="plug-in/layer/layer.js"></script>

<script src="plug-in/lte/bootstrap/js/bootstrap-tab.js"></script>

<script src="plug-in/jquery-plugs/marquee/jquery.marquee.min.js"></script>

<script type="text/javascript">


$(function () {
	$("#marquee").marquee({duration: 15000,pauseOnHover: true});  
	
})


// 查看全部
function getUserNotice() {
	top.layer.open({
		title: '通知公告',
		type : 2,
		content : 'noticeController.do?noticeList',
		area : [ '800px', '600px' ]
	});
}

//查看全部
function getUserMessage() {
	top.layer.open({
		title: '系统消息',
		type : 2,
		content : 'messageController.do?messageList',
		area : [ '800px', '600px' ]
	});
}


function getMessageDetail(id){
	
	
	var addurl = "messageController.do?goAndReadMessage&id="+id;
		top.layer.open({
		type : 2,
		content :addurl,
		area : [ '500px', '300px' ],
		cancel: function(index){ 
			
			/* //刷新当前首页消息列表
			$.ajax({
				url : "messageController.do?getUnReadMessageList",
				type : "GET",
				dataType : "JSON",
				async : false,
				success : function(data) {
					if (data.success) {
						var noticeList = data.attributes.messageList;

						var noticeContent = "";
						if (noticeList.length > 0) {
							for ( var i = 0; i < noticeList.length; i++) {
								if(i >= 5){
									break;
								}
								
								noticeContent += "<li><a href='javascript:getMessageDetail(&quot;"
									+ noticeList[i].id
									+ "&quot;)'> "
								
								switch(i%5)
								{
								case 0:
									noticeContent += "<i class='fa fa-square text-aqua'></i>";
								  break;
								case 1:
									noticeContent += "<i class='fa fa-square text-yellow'></i>";
								  break;
								case 2:
									noticeContent += "<i class='fa fa-square text-red'></i>";
								  break;
								case 3:
									noticeContent += "<i class='fa fa-square text-yellow-green'></i>";
								  break;
								case 4:
									noticeContent += "<i class='fa fa-square text-aqua'></i>";
								  break;
								default:
									 break;
								}
								
								noticeContent += " <span>"
										+ noticeList[i].messageTitle
										+ "</span><span class='text-muted pull-right'><i class='fa fa-clock-o'></i> " + noticeList[i].createTime + "</span></a></li>";
										
										
							}
							
						}else{
							noticeContent += "暂无未读消息信息！";
						}
						
						$("#innerMessage").html(
								noticeContent);

					};
					
					//刷新parent iframe中通知
					parent.readInnerMessage();
					
				}
			}); */
			
			parent.readInnerMessage();
			
		} 
	});
	
}


// 查看通知公告明细
function getNotificationDetail(id){
	
   top.layer.open({
		title: '通知公告详情',
		type : 2,
		content : "noticeController.do?goDetail&id="+id,
		area : [ '800px', '600px' ]
	});
   
   //parent.readNotification();
   
/* 	var addurl = "noticeController.do?goDetial&id="+id;
		top.layer.open({
		type : 2,
		content :addurl,
		area : [ '800px', '600px' ],
		cancel: function(index){ 
			
			//刷新当前首页通知列表
			$.ajax({
				url : "noticeController.do?getNoticeList",
				type : "GET",
				dataType : "JSON",
				async : false,
				success : function(data) {
					if (data.success) {
						var noticeList = data.attributes.noticeList;

						//加载公告条目
						var noticeContent = "";
						if (noticeList.length > 0) {
							for ( var i = 0; i < noticeList.length; i++) {
								if(i >= 5){
									break;
								}
								
								noticeContent += "<li><a href='javascript:getNotificationDetail(&quot;"
									+ noticeList[i].id
									+ "&quot;)'> "
							
								switch(i%5)
								{
								case 0:
									noticeContent += "<i class='fa fa-square text-aqua'></i>";
								  break;
								case 1:
									noticeContent += "<i class='fa fa-square text-yellow'></i>";
								  break;
								case 2:
									noticeContent += "<i class='fa fa-square text-red'></i>";
								  break;
								case 3:
									noticeContent += "<i class='fa fa-square text-yellow-green'></i>";
								  break;
								case 4:
									noticeContent += "<i class='fa fa-square text-aqua'></i>";
								  break;
								default:
									 break;
								}
								
								noticeContent += " <span>"
										+ noticeList[i].noticeTitle
										+ "</span><span class='text-muted pull-right'><i class='fa fa-clock-o'></i> " + noticeList[i].createTime + "</span></a></li>";
										
										
							}
							
						}else{
							noticeContent += "暂无未读公告信息！";
						}
						
						$("#userNotifications").html(
								noticeContent);

					};
					
					//刷新parent iframe中通知
					parent.readNotification();
					
				}
			});
			
			parent.readNotification();
		} 
	}); */
}



</script>

</body>
</html>
