<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="org.jeecgframework.core.util.SysThemesUtil,org.jeecgframework.core.enums.SysThemesEnum"%>
<%@include file="/context/mytags.jsp"%>
<%
  session.setAttribute("lang","zh-cn");
  SysThemesEnum sysTheme = SysThemesUtil.getSysTheme(request);
  String lhgdialogTheme = SysThemesUtil.getLhgdialogTheme(sysTheme);
%>
<!DOCTYPE html>
<html lang="en">
<head>
  
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <!-- <title>南京锅检院OA</title> -->
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
  <!-- iCheck -->
  <link rel="stylesheet" href="plug-in/lte/plugins/iCheck/square/blue.css">
  <link rel="stylesheet" href="plug-in/lte/bootstrap/css/main.css">
  <link rel="stylesheet" href="plug-in/lte/dist/css/slide.css">

  <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  <!--[if lt IE 9]>
  <script src="plug-in/lte/bootstrap/js/html5shiv.min.js"></script>
  <script src="plug-in/lte/bootstrap/js/respond.min.js"></script>
  <![endif]-->
  
  <!-- loadding -->
  <link rel="stylesheet" href="plug-in/laddaui/ladda-themeless.min.css">

<style type="text/css">
.login-page {
	background-image: url(plug-in/ace/css/images/meteorshower2.jpg);
}
#overlay {
    background:#E0FFFF;
    filter: alpha(opacity=50); /* IE的透明度 */
    opacity: 0;  /* 透明度 */
    display: none;
    position: absolute;
    top: 0px;
    left: 0px;
    width: 100%;
    height: 100%;
    z-index: 200; /* 此处的图层要大于页面 */
    display:none;
}
</style>
</head>
<body class="hold-transition login-page">
<div style="text-align: center;margin-top: 7%">
 <div class="login-logo1" style="padding-bottom: 1%;font-size: 25px">
  	<span >
  		<img alt="" src="webpage/login/img/speedchina.png" style="width:400px;height: 120px">
  	</span>
  </div>
  <div class="login-logo1" style="padding-bottom: 2%;font-size: 25px">
    <span style="color: white;"><b>OKR管理系统</b></span>
  </div>
  
  <!-- /.login-logo -->
  <div class="login-box-body" style="width: 360px;margin: 0% auto;">
    <p class="login-box-msg">用户登录</p>
              
     <form id="loinForm" check="loginController.do?checkuser" role="form" action="loginController.do?login"  method="post">
        <div class="widget-main">
          <div class="alert alert-warning" role="alert" style="padding: 8px;" id="errMsgContiner">
		  <div id="showErrMsg"></div>
		</div>
    </div>
    
      <div class="form-group has-feedback">
        <input type="text"  name="userName" class="form-control" placeholder="请输入用户名"  id="userName"/>
        <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
      </div>
      <div class="form-group has-feedback">
        <input type="password" name="password" class="form-control" placeholder="请输入密码" id="password" />
        <span class="glyphicon glyphicon-lock form-control-feedback"></span>
      </div>
      <!-- 
      <div class="input-group has-feedback" style="margin-bottom: 15px;">
        <input type="text" style="width:150px" name="randCode" class="form-control" placeholder="请输入验证码"  id="randCode"/>
        <span class="input-group-addon" style="padding: 0px; border-left: 1px solid #D2D6DE;"><img id="randCodeImage" src="randCodeImage" /></span>
      </div>
       -->
      <div class="row">
        <div class="col-xs-7">
          <!-- <div class="checkbox icheck">
            <label>
              <input type="checkbox" id="on_off"  name="remember" value="yes"/>
              	<span class="lbl">记住用户名</span>
            </label>
          </div> -->
          <div class="checkbox icheck">
	          <label>
	              <input type="checkbox" id="rememberPwd" value="yes"/>
	              	<span class="lbl">记住密码</span>
	            </label>
           </div>
        </div>
        <!-- /.col -->
        <div class="col-xs-5">
          <!-- <button type="button"  onclick="checkUser()" class="btn btn-primary btn-block btn-flat">
         	<i class="fa fa-fw fa-key"></i> 登录
          </button> -->
          
          <button class="btn btn-primary  btn-block ladda-button" data-style="zoom-in" onclick="checkUser()" type="button" id="submitBtn" style="margin-left: 10px;width: 106px;">
          	<span class="ladda-label"><i class="fa fa-fw fa-key"></i> 登录</span>
          </button>
          
        </div>
        <!-- /.col -->
      </div>
      
    </form>
    <!-- /.social-auth-links -->
  </div>
  <!-- /.login-box-body -->
   <div style="text-align: center;padding-top: 4%">
        <span style="font-size: 0.75em;color: white;font-family:微软雅黑">Copyright © <span id="myDate">2014</span> SpeedChina. All right reserved. </span>
   </div>
</div>
<!-- /.login-box   background: url(webpage/login/img/slide1.jpg) no-repeat; -->
<div id="overlay" style="display: none;">       
   <div class="slides">
			<div class="slideInner"  style="margin-top: 10%">
				<a href="#" style="width: 100%;height: 100%" onclick="hide();">
					<div class="moveElem img1" rel="0,easeInOutExpo">
						<img src="./webpage/login/img/s01.jpg" />
					</div>
				</a>
				<a href="#" style="width: 100%;height: 100%" onclick="hide();">
					<div class="moveElem img1" rel="0,easeInOutExpo">
						<img src="./webpage/login/img/s02.jpg" />
					</div>
				</a>
				<a href="#" style="width: 100%;height: 100%" onclick="hide();">
					<div class="moveElem img1" rel="0,easeInOutExpo">
						<img src="./webpage/login/img/s03.jpg" />
					</div>
				</a>
				<a href="#" style="width: 100%;height: 100%" onclick="hide();" id="last">
					<div class="moveElem img1" rel="0,easeInOutExpo">
						<img src="./webpage/login/img/s04.jpg" />
					</div>
				</a>
			</div>
		</div>  
		</div>           
 
<!-- jQuery 2.2.0 -->
<script src="plug-in/lte/plugins/jQuery/jQuery-2.2.0.min.js"></script>
<script src="plug-in/lte/dist/js/slide.js"></script>
<!-- Bootstrap 3.3.5 -->
<script src="plug-in/lte/bootstrap/js/bootstrap.min.js"></script>
<!-- iCheck -->
<script src="plug-in/lte/plugins/iCheck/icheck.min.js"></script>

<script type="text/javascript" src="plug-in/login/js/login_lte.js"></script>
<script type="text/javascript" src="plug-in/jquery/jquery.cookie.js"></script>

<!-- loadding -->
<script src="plug-in/laddaui/spin.min.js"></script>
<script src="plug-in/laddaui/ladda.min.js"></script>   

<script type="text/javascript">
	$(function(){
		
		//给版权获取当前年份
		var showYear = new Date().getFullYear();
		$('#myDate').html(showYear);
		
		$(".slideInner").slide({
			slideContainer: $('.slideInner a'),
			effect: 'easeInOutQuad',
			autoRunTime:1000,
			slideSpeed: 1000,
			imgSlideSpeed:500,
			autoRun: true,
			nav:false
		});
		//showOverlay();
		//读取cookie
		$('#userName').val($.cookie('username'));
		if($.cookie('njgjyloginpwd')) {
			$('#password').val($.cookie('njgjyloginpwd'));
			$('#rememberPwd').prop('checked',true);
		}
		
		//Ladda.bind( 'button[type=button]', { timeout: 3000 } );
		$('input').iCheck({
		      checkboxClass: 'icheckbox_square-blue',
		      radioClass: 'iradio_square-blue',
		      increaseArea: '20%' // optional
		    });
		optErrMsg();
		
		//禁止输入空格
		$("#password").keydown(function(e){
			if(e.keyCode == 32) {
				return false;
			}
		});
		
	});
	function hide(){
		$("#overlay").hide();
	}
	function showOverlay() {
	    $("#overlay").height($(document).height());
	    $("#overlay").width($(document).width());

	    // fadeTo第一个参数为速度，第二个为透明度
	    // 多重方式控制透明度，保证兼容性，但也带来修改麻烦的问题
	    $("#overlay").fadeTo(100, 1);
	}
	/* 隐藏覆盖层 */
	function hideOverlay() {
	    $("#overlay").fadeOut(200);
	}
	$("#errMsgContiner").hide();
	function optErrMsg(){
		$("#showErrMsg").html('');
		$("#errMsgContiner").hide();
	}
	
	
	
	
	
	
	
	// 点击登陆
	 $(document).keydown(function(e){
		if(e.keyCode == 13) {
			checkUser();
		}
	});
	
  
  // loadding条
  var loaddingBar = Ladda.create( document.querySelector( 'button[type=button]' ) );
  //验证用户信息
  function checkUser(){
    if(!validForm()){
      return false;
    }
    loaddingBar.start();
    Login();
   
  }
  //表单验证
  function validForm(){
    if($.trim($("#userName").val()).length==0){
      showErrorMsg("请输入用户名");
      return false;
    }

    if($.trim($("#password").val()).length==0){
      showErrorMsg("请输入密码");
      return false;
    }

    
    /*
    if($.trim($("#randCode").val()).length==0){
      showErrorMsg("请输入验证码");
      return false;
    }
    
    */
    return true;
  }

  //登录处理函数
  function Login(orgId) {
	
	//设置username
	$.cookie('username', $('#userName').val(), { expires: 14 }); 
    setCookie();
    var actionurl=$('form').attr('action');//提交路径
    var checkurl=$('form').attr('check');//验证路径
    var formData = new Object();
    $(":input").each(function() {
      formData[this.name] =$("#"+this.name ).val();
    });
    formData['orgId'] = orgId ? orgId : "";
    //formData['langCode']=$("#langCode").val();
    //formData['langCode'] = $("#langCode option:selected").val();
    $.ajax({
      async : false,
      cache : false,
      type : 'POST',
      url : checkurl,// 请求的action路径
      data : formData,
      error : function() {// 请求失败处理函数
      },
      success : function(data) {
        var d = $.parseJSON(data);
        if (d.success) {
        	
          loginsuccess();
          if($('#rememberPwd').prop('checked')) {//记住密码
        	  $.cookie('njgjyloginpwd', $('#password').val(), { expires: 14 }); 
          }else {
        	  $.cookie('njgjyloginpwd', '', { expires: 1 }); 
          }
          
          var title, okButton;
          if($("#langCode").val() == 'en') {
            title = "Please select Org";
            okButton = "Ok";
          } else {
            title = "请选择组织机构";
            okButton = "确定";
          }
          //如果存在两个组织，选择其中一个登陆
          if (d.attributes.orgNum > 1) {
            $.dialog({
              id: 'LHG1976D',
              title: title,
              max: false,
              min: false,
              drag: false,
              resize: false,
              content: 'url:userController.do?userOrgSelect&userId=' + d.attributes.user.id,
              lock:true,
              button : [ {
                name : okButton,
                focus : true,
                callback : function() {
                  iframe = this.iframe.contentWindow;
                  var orgId = $('#orgId', iframe.document).val();
                  Login(orgId);
                  this.close();
                  return false;
                }
              }],
              close: function(){
                window.location.href = actionurl;
              }
            });
          } else {
            setTimeout("window.location.href='"+actionurl+"'", 1000);
          }
       } else {
          if(d.msg == "a"){
            $.dialog.confirm("数据库无数据,是否初始化数据?", function(){
              window.location = "init.jsp";
            }, function(){
            });
          } else{
        	  showErrorMsg(d.msg);
          } 
        }
      }
    });
  } 
  
  //显示错误提示信息
  function showErrorMsg(msg){
	loaddingBar.stop();
    $("#errMsgContiner").show();
    $("#showErrMsg").html(msg);
    window.setTimeout(optErrMsg,3000); 
  }

</script>
<%=lhgdialogTheme %>
</body>
</html>