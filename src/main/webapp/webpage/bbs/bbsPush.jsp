<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<t:base type="jquery,easyui"></t:base>
<meta content="text/html;charset=utf-8" http-equiv="Content-Type" />
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta name="renderer" content="webkit" />
<title>发布 - Ghost中文网</title>

<link href="plug-in/lte/dist/img/user2-160x160.jpg" rel="shortcut icon"
	type="image/x-icon" />
<link rel="stylesheet" type="text/css"
	href="webpage/bbs/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="webpage/bbs/css/icon.css" />
<link href="webpage/bbs/css/common.css?v=20140930" rel="stylesheet"
	type="text/css" />
<link href="webpage/bbs/css/link.css?v=20140930" rel="stylesheet"
	type="text/css" />
<link href="webpage/bbs/css/style.css?v=20140930" rel="stylesheet"
	type="text/css" />
	
	

<!-- 编辑器 -->
<script src="webpage/bbs/js/bootstrapv3.js" type="text/javascript"></script>
  <link href="webpage/bbs/css/summernote.css" rel="stylesheet">
  <script src="webpage/bbs/js/summernote.js"></script>
    <script src="webpage/bbs/js/summernote.min.js"></script>
        <script src="webpage/bbs/js/summernote-zh-CN.js"></script>
<!-- 编辑器 -->

</head>



<script type="text/javascript">
    $(function(){
        
            $('#summernote').summernote({height: '300',lang: 'zh-CN'});
        
        
    });
    
    function bbsPostPush(){
    	 
    	 var content = $('#summernote').summernote('code');
    	 var title =  $('#title').val();
    	 if(title==''){
    		 alert('请填写标题！');
    		 return;
    	 }
    	var editionId =  $('#editionId').val();
    	 if(editionId=='0'){
    		 alert('选择版块！');
    		 return;
    	 }
    	 
    	 
    	 if(content!=''){
    	 	 
        	 $('#content').val(content);
        	
        	$('#question_form').form('submit', { 
        		url : 'bbsController.do?saveBbsPost', 
        	
        	success : function(data) {
        		var map = $.parseJSON(data);  
        		var url = '${pageContext.request.contextPath}/bbsController.do?bbsList&editionId='+map.obj;
        		 window.location.href=url;
        		 
        		} 
        		}); 
    	 }else{
    		 alert('请填写内容！');
    		 return;
    	 }
   
     }
</script>



<noscript unselectable="on" id="noscript">
    <div class="aw-404 aw-404-wrap container">
        <img src="http://wenda.ghostchina.com/static/common/no-js.jpg">
        <p>你的浏览器禁用了JavaScript, 请开启后刷新浏览器获得更好的体验!</p>
    </div>
</noscript>
<body>
	<div class="aw-top-menu-wrap">
		<div class="container">
			<!-- logo -->
			<div class="aw-logo hidden-xs">
				<a href="http://wenda.ghostchina.com"></a>
			</div>
			<!-- end logo -->
			
				<!-- 搜索框 -->
			<div class="aw-search-box  hidden-xs hidden-sm">
			
				<div class="aw-publish-btn">
					<a 
					href="bbsController.do?bbs"
					class="btn-primary">论坛首页</a>
				
				</div>
			
			
			</div>
			<!-- end 搜索框 -->
		
			
			<!-- 用户栏 -->
			<div class="aw-user-nav">
				<!-- 登陆&注册栏 -->
								<a href="bbsController.do?bbs" class="aw-user-nav-dropdown"> <img alt="user"
					src="${pageContext.request.contextPath}/userInfoController.do?tofindPic"
					onerror="this.src='plug-in/lte/dist/img/user2-160x160.jpg'" />
				</a>
				
				<div class="aw-dropdown dropdown-list pull-right">
						<ul class="aw-dropdown-list">
							<li><a href="#">
							<i class="icon icon-setting"></i>
							设置</a></li>
							<li class="hidden-xs"><a href="#">
							<i class="icon icon-logout"></i> 退出</a>
							</li>
											
						</ul>
					</div>
				
				
				
				
				
				
				
				
								<!-- end 登陆&注册栏 -->
			</div>
			<!-- end 用户栏 -->
					<!-- 发起 -->
			<div class="aw-publish-btn">
				<a id="header_publish"
					href="bbsController.do?bbsPush"
					class="btn-primary"><i class="icon icon-ask"></i>发帖</a>
					
				<div class="dropdown-list pull-right">
					<ul>
					
						<c:forEach var="bbsEditionItem" items="${bbsEditionList}"
									varStatus="status">
						<li><a href="bbsController.do?bbsPush&editionId=${bbsEditionItem.id }">${bbsEditionItem.name }</a></li>
							
							</c:forEach>	
					</ul>
				</div>
					
					
					
					
				
			</div>
			<!-- end 发起 -->
		</div>
	</div>
		
			
<div class="aw-container-wrap">
	<div class="container aw-publish">
		<div class="row">
			<div class="aw-content-wrap clearfix">
				<div class="col-sm-12 col-md-9 aw-main-content">
					<!-- tab 切换 -->
					<ul class="nav nav-tabs aw-nav-tabs active">
			<li class="active"><a href="http://wenda.ghostchina.com/publish/">问题</a></li>
						<h2 class="hidden-xs"><i class="icon icon-ask"></i> 发贴</h2>
					</ul>
					<!-- end tab 切换 -->
					<form action="bbsController.do?saveBbsPost" method="post" id="question_form" onsubmit="return false;">
					<input type="hidden" name="content" id ="content" value="" /> 
			
                      <div class="aw-mod aw-mod-publish">
							<div class="mod-body">
								<h3>标题:</h3>
								<!-- 问题标题 -->
								<div class="aw-publish-title">
									<div>
										<input type="text" placeholder="标题..." name="title" id="title" value="" class="form-control" />
										<div class="aw-publish-suggest-question hide">
										</div>
									</div>
																		<div class="dropdown">
										<div class="dropdown-toggle" data-toggle="dropdown">
										
											<span id="aw-topic-tags-select" class="aw-hide-txt">
											<select name="editionId" id="editionId">
							<option value="0">- 请选择版块-</option>
							
								<c:forEach var="bbsEditionItem" items="${bbsEditionList}"
									varStatus="status">
							<option value="${bbsEditionItem.id } ">${bbsEditionItem.name } </option>
					
							
							</c:forEach>			
									</select></span>
											
										</div>
									</div>
																	</div>
								<!-- end 问题标题 -->

								<h3>内容 :</h3>
								<div class="aw-mod aw-editor-box">
									<div class="mod-head">
										<div class="wmd-panel" id="summernote">
								       </div>
									</div>
									<div class="mod-body">
										<span class="pull-right text-color-999" >&nbsp;</span>
																			</div>
									
								</div>
								
								
								
								
							
																															</div>
							<div class="mod-footer clearfix">
								<span class="aw-anonymity">
																		
								</span>
								<a class="btn btn-large btn-success btn-publish-submit" id="publish_submit" onclick="bbsPostPush();">确认发起</a>
							</div>
						</div>
					</form>
				</div>
				
				
				
				
				
				
				
				
				
				<!-- 侧边栏 -->
					<div class="col-md-3 aw-side-bar hidden-xs hidden-sm">
						<!-- 发起人 -->
						<div class="aw-mod">
							<div class="mod-head">
								<h3>发贴人</h3>
							</div>
							<div class="mod-body">
								<dl>
									<dt class="pull-left aw-border-radius-5">
										<a href="#"> <img alt="user"
											src="${pageContext.request.contextPath}/userInfoController.do?tofindPic&userId=${bbsPost.postUserid }"
											onerror="this.src='plug-in/lte/dist/img/user2-160x160.jpg'" />

										</a>
									</dt>
									<dd class="pull-left">
										<a class="aw-user-name" href="#" data-id="2">${userName}</a>
										<p></p>
									</dd>
								</dl>
							</div>
						</div>





						<div class="mod-head">
							<h3>最新帖子</h3>
						</div>
						<div class="mod-body">
							<dl>
								<dt class="pull-left">
									<!-- 话题图片 -->
									<a data-id="" class="img aw-border-radius-5" href="#"> <img
										src="http://wenda.ghostchina.com/static/common/topic-mid-img.png"
										alt="" />
									</a>
									<!-- end 话题图片 -->
								</dt>
								<dd class="pull-left"></dd>
							</dl>
							<!-- 话题描述 -->
							<p>
								<span></span>...<a href="#">进入该贴 »</a>
							</p>
							<!-- end 话题描述 -->
						</div>












						<!-- end 问题状态 -->
					</div>
					<!-- end 侧边栏 -->
				
				
				
				
				
			</div>
		</div>
	</div>
</div>



<div class="aw-footer-wrap">
	<div class="aw-footer">
		Copyright © 2016<span class="hidden-xs"> - 京ICP备11008151号, All Rights Reserved</span>
		<span class="hide">Powered By <a href="http://www.wecenter.com/?copyright" target="blank">WeCenter 3.0 Beta 2</a></span>
			</div>
</div>

</body>
</html>