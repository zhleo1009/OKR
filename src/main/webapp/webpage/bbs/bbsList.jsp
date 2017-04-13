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
<link
	href="webpage/bbs/css/common.css?v=20140930"
	rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="webpage/bbs/css/link.css" />
<link rel="stylesheet" type="text/css" href="webpage/bbs/css/style.css" />



<!-- 分页所需from -->
<link rel="stylesheet" href="webpage/bbs/css/qunit-1.11.0.css">
<script src="webpage/bbs/js/bootstrapv3.js" type="text/javascript"></script>
<script src="webpage/bbs/js/bootstrap-paginator.js"></script>
<script src="webpage/bbs/js/qunit-1.11.0.js"></script>
<!-- 分页所需to -->





</head>
<noscript unselectable="on" id="noscript">
	<div class="aw-404 aw-404-wrap container">
		<img src="http://wenda.ghostchina.com/static/common/no-js.jpg">
		<p>你的浏览器禁用了JavaScript, 请开启后刷新浏览器获得更好的体验!</p>
	</div>
</noscript>





<script type="text/javascript">

    $(function(){
        test("Test bootstrap v3 rendering", function(){

            var element = $('#bp-3-element');

            var options = {
                bootstrapMajorVersion:3,
                currentPage: ${currentPage},
                numberOfPages: 5,
                totalPages:${totalPage}, 
                pageUrl:function(type,page){
                    return "bbsController.do?bbsList&editionId=${editionId}&str_currentPage="+page;
                }
                
            }

            element.bootstrapPaginator(options);

            var element = $('#bp-3-element');

            var list = element.children();

            for(var i=0;i < list.length;i++)
            {
                var item = $(list[i]);
//   </li> <a href="bbsController.do?bbsList&editionId=${ editionId }&str_currentPage=1">1</a></li>
                ok(item.is("li"),"Element "+i+" should be li");
            }

        })
    });

</script>










<body>
	<div class="aw-top-menu-wrap">
		<div class="container">
			<!-- logo -->

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
		
		</div>

		<div class="container">
			<div class="row">
				<div class="aw-content-wrap clearfix">
					<div class="col-sm-12 col-md-9 aw-main-content">
						<div class="aw-mod aw-topic-detail-title">
							<div class="mod-body">
								<img src="${bbsEdition.logo}" alt="username" width="50px;"
									height="50px;" />
								<h2 class="pull-left">${bbsEdition.name}</h2>

							</div>
						</div>

						<div class="aw-mod aw-topic-list-mod">
							<div class="mod-head">
								<div class="tabbable">
									<!-- tab 切换 -->
									<ul class="nav nav-tabs aw-nav-tabs hidden-xs">
										<li class="active"><a href="#all" data-toggle="tab">全部内容</a></li>

									</ul>
									<!-- end tab 切换 -->
								</div>
							</div>

							<div class="mod-body">
								<!-- tab 切换内容 -->
								<div class="tab-content">
									<div class="tab-pane active" id="all">
										<!-- 推荐问题 -->

										<!-- end 推荐问题 -->
										<div class="aw-mod">
											<div class="mod-body">
												<div class="aw-common-list" id="c_all_list">



													<c:forEach var="bbsPostListItem" items="${bbsPostList}"
														varStatus="status">


														<div class="aw-item " data-topic-id="50,">
															<a class="aw-user-name hidden-xs" data-id="2"
																href="http://wenda.ghostchina.com/people/wangsai"
																rel="nofollow"> <img
																src="${pageContext.request.contextPath}/userInfoController.do?tofindPic&userId=${bbsPostListItem.postUserid}"
																alt=""
																onerror="this.src='plug-in/lte/dist/img/user2-160x160.jpg'" />
																<i class="icon icon-v"></i></a>
															<div class="aw-question-content">
																<h4>
																	<a
																		href="bbsController.do?bbsInfo&bbsPostId=${bbsPostListItem.id }">${bbsPostListItem.title
																		}</a>
																</h4>
																<p>
																	<span class="text-color-999">${bbsPostListItem.createDate
																		} </span>
																</p>
															</div>
														</div>
													</c:forEach>








												</div>
											</div>

										</div>
									</div>










									<div class="mod-footer clearfix">




										<div class="page-control">

											<ul id='bp-3-element'></ul>

											<ul class="pagination pull-right" id='bp-3-element-test'>
											
											</ul>



										</div>





									</div>


								</div>
								<!-- end tab 切换内容 -->
							</div>

						</div>
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



	




</body>
</html>