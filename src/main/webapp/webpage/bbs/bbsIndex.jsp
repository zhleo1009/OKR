<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<t:base type="jquery,easyui"></t:base>
<meta content="text/html;charset=utf-8" http-equiv="Content-Type" />
<meta
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta name="renderer" content="webkit" />
<title>锅检院论坛</title>
<link href="plug-in/lte/dist/img/user2-160x160.jpg" rel="shortcut icon"
	type="image/x-icon" />
<link rel="stylesheet" type="text/css"
	href="webpage/bbs/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="webpage/bbs/css/icon.css" />
<link href="webpage/bbs/css/common.css?v=20140930" rel="stylesheet"
	type="text/css" />
<link rel="stylesheet" type="text/css" href="webpage/bbs/css/link.css" />
<link rel="stylesheet" type="text/css" href="webpage/bbs/css/style.css" />

<script src="webpage/bbs/js/jquery.2.js" type="text/javascript"></script>
<script src="webpage/bbs/js/jquery.form.js" type="text/javascript"></script>
</head>

<body>
	<div class="aw-top-menu-wrap">
		<div class="container">
			<!-- logo -->
			<div class="aw-logo hidden-xs">
				<a href="#"></a>
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
			<!-- 导航 -->
			<div class="aw-top-nav navbar">
				<div class="navbar-header">
					<button class="navbar-toggle pull-left">
						<span class="icon-bar"></span> <span class="icon-bar"></span> <span
							class="icon-bar"></span>
					</button>
				</div>
				<nav role="navigation"
					class="collapse navbar-collapse bs-navbar-collapse"></nav>
			</div>
			<!-- end 导航 -->
			<!-- 用户栏 -->
			<div class="aw-user-nav">
				<!-- 登陆&注册栏 -->
				<a href="bbsController.do?bbs"
					class="aw-user-nav-dropdown"> <img alt="user"
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
		<div class="container">
			<div class="row">
				<div class="aw-content-wrap clearfix">
					<div class="col-sm-12 col-md-9 aw-main-content">
						<!-- tab切换 -->
						<ul class="nav nav-tabs aw-nav-tabs active hidden-xs">

							<li class="active"><a
								href="bbsController.do?bbs">全部</a></li>
							<h2 class="hidden-xs">
								<i class="icon icon-topic"></i> 锅检院论坛
							</h2>
						</ul>
						<!-- end tab切换 -->

						<!-- 话题分类 -->
						<!-- end 话题分类 -->

						<!-- 我关注的话题 -->
						<div class="aw-mod aw-topic-list">
							<div class="mod-body clearfix">

								<c:forEach var="bbsEditionItem" items="${bbsEditionList}"
									varStatus="status">

									<div class="aw-item">
										<!-- 话题图片 -->
										<a class="img aw-border-radius-5"
											href="bbsController.do?bbsList&editionId=${ bbsEditionItem.id }" data-id="11">
											<img src="${bbsEditionItem.logo }" alt="" width="50px;"
											height="50px;" />
										</a>
										<!-- end 话题图片 -->
										<p class="clearfix">
											<!-- 话题内容 -->
											<span class="topic-tag"> <a class="text"
												href="bbsController.do?bbsList&editionId=${ bbsEditionItem.id }"
												data-id="11">${bbsEditionItem.name } </a>
											</span>
											<!-- end 话题内容 -->
										</p>

										<p class="text-color-999">${bbsEditionItem.intro }</p>
									</div>
								</c:forEach>
							</div>

						</div>
						<!-- end 我关注的话题 -->
					</div>
					<!-- 侧边栏 -->











					<div class="col-sm-3 col-md-3 aw-side-bar hidden-sm hidden-xs">
						<!-- 今日话题 -->
						<div class="aw-mod topic-daily hidden-xs">
							<div class="mod-head">
								<h3>最新帖子</h3>
							</div>
							<div class="mod-body">
								<dl>
									<dt class="pull-left">
										<!-- 话题图片 -->
										<a data-id="" class="img aw-border-radius-5"
											href="http://wenda.ghostchina.com/topic/"> <img
											src="http://wenda.ghostchina.com/static/common/topic-mid-img.png"
											alt="" />
										</a>
										<!-- end 话题图片 -->
									</dt>
									<dd class="pull-left"></dd>
								</dl>
								<!-- 话题描述 -->
								<p>
									<span></span>...<a href="http://wenda.ghostchina.com/topic/">进入该贴
										»</a>
								</p>
								<!-- end 话题描述 -->
							</div>
						</div>
						<!-- end 今日话题 -->


					</div>
					<!-- end 侧边栏 -->
				</div>
			</div>
		</div>
	</div>

	<div class="aw-footer-wrap">
		<div class="aw-footer">
			Copyright © 2016<span class="hidden-xs"> - 京ICP备11008151号, All
				Rights Reserved</span> <span class="hide">Powered By <a
				href="http://www.wecenter.com/?copyright" target="blank">WeCenter
					3.0 Beta 2</a></span>

		</div>
	</div>



	<a class="aw-back-top hidden-xs" href="javascript:;"
		onclick="$.scrollTo(1, 600, {queue:true});"><i
		class="icon icon-up"></i></a>




</body>
</html>















