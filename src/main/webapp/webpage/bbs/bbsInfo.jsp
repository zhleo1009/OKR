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
<link href="webpage/bbs/css/link.css?v=20140930" rel="stylesheet"
	type="text/css" />
<link href="webpage/bbs/css/style.css?v=20140930" rel="stylesheet"
	type="text/css" />
	
	
<!-- 分页所需from -->
<link  href="webpage/bbs/css/qunit-1.11.0.css" rel="stylesheet">
<script src="webpage/bbs/js/bootstrapv3.js" type="text/javascript"></script>
<script src="webpage/bbs/js/bootstrap-paginator.js"></script>
<script src="webpage/bbs/js/qunit-1.11.0.js"></script>
<!-- 分页所需to -->
<!-- 编辑器 -->
  <link href="webpage/bbs/css/summernote.css" rel="stylesheet">
  <script src="webpage/bbs/js/summernote.js"></script>
    <script src="webpage/bbs/js/summernote.min.js"></script>
          <script src="webpage/bbs/js/summernote-zh-CN.js"></script>
<!-- 编辑器 -->

</head>




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
                    return "bbsController.do?bbsInfo&bbsPostId=${postId}&str_currentPage="+page;
                }
            }

            element.bootstrapPaginator(options);
            var element = $('#bp-3-element');
            var list = element.children();
            for(var i=0;i < list.length;i++)
            {
                var item = $(list[i]);
                ok(item.is("li"),"Element "+i+" should be li");
            }

        })
        
        
            $('#summernote').summernote({height: '300',lang: 'zh-CN'});
        
        
    });
    
    
    
    
    
    
    function comment(){
    	 
    	 var comment = $('#summernote').summernote('code');
    	 
    	 if(comment!=''){
    	 	 
        	 $('#comment').val(comment);
        	
        	$('#answer_form').form('submit', { 
        		url : 'bbsController.do?saveComment', 
        	
        	success : function(data) {
        		 location.reload() ;
        		} 
        		}); 
    	 }
   
     }
    

    
    
    
    
    
    
    
    
    
    

</script>


<noscript unselectable="on" id="noscript">
	<div class="aw-404 aw-404-wrap container">
		<img src="webpage/bbs/js/img/no-js.jpg">
		<p>你的浏览器禁用了JavaScript, 请开启后刷新浏览器获得更好的体验!</p>
	</div>
</noscript>
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
		<div class="container">
			<div class="row">
				<div class="aw-content-wrap clearfix">
					<div class="col-sm-12 col-md-9 aw-main-content">
						<div class="aw-mod aw-topic-bar" id="question_topic_editor"
							data-type="question" data-id="429">
							<div class="tag-bar clearfix">
								<span class="topic-tag"> <a href="bbsController.do?bbsList&editionId=${bbsEdition.id }" class="text"
									data-id="50">${bbsEdition.name }</a>
								</span>

							</div>
						</div>
						<!-- end 话题bar -->
						<div class="aw-mod aw-question-detail aw-item">
							<div class="mod-head">
								<h1>${bbsPost.title }</h1>
							</div>
							<div class="mod-body">
								<div class="content markitup-box">${bbsPost.content }</div>
							</div>
							<div class="mod-footer">
								<div class="meta">
									<span class="text-color-999">${bbsPost.createDate }</span>
									
									



								</div>


							</div>

							<div class="aw-mod aw-question-comment">
								<div class="mod-head">
									<ul class="nav nav-tabs aw-nav-tabs active">
										<li class="active"><a href="#">时间 <i
												class="icon icon-up"></i>
										</a></li>

										<h2 class="hidden-xs">${totalRow}个回复</h2>
									</ul>
								</div>
								<div class="mod-body aw-feed-list">




									<c:forEach var="bbsCommentListItem" items="${bbsCommentList}"
										varStatus="status">
										<div class="aw-item" uninterested_count="0" force_fold="0"
											id="answer_list_${bbsCommentListItem.id}">
											<div class="mod-head">
												<a class="anchor" name="answer_${bbsCommentListItem.id}"></a>
												<!-- 用户头像 -->
												<a class="aw-user-img aw-border-radius-5 pull-right"
													href="#" data-id="${bbsCommentListItem.id}"> <img alt="user"
													src="${pageContext.request.contextPath}/userInfoController.do?tofindPic&userId=${bbsCommentListItem.commentUserid}"
													onerror="this.src='plug-in/lte/dist/img/user2-160x160.jpg'" />


												</a>
												<!-- end 用户头像 -->
												
												
													<div class="title">
											<p>
												<a class="aw-user-name"
													href="#"
													data-id="${bbsCommentListItem.commentUserid}">${bbsCommentListItem.commentUserName}</a>
													<!--   - <span class="text-color-999">${bbsCommentListItem.commentUserid}</span>-->
													
													
											<span class="topic-tag" > 
											<a href="#" class="text" ><i class="icon icon-logout"></i>引用</a>
								</span>		
												
												
													
											</p>
										</div>
												
												
												
												
												
									
											</div>
											<div class="mod-body clearfix">
												<!-- 评论内容 -->
												<div class="markitup-box">${bbsCommentListItem.comment}</div>


												<!-- end 评论内容 -->
											</div>
											<div class="mod-footer">
												
												
										<!-- 社交操作 -->
										<div class="meta clearfix">
											<span class="text-color-999 pull-right">${bbsCommentListItem.createDate}</span>
											<!-- 投票栏 -->
									
											<!-- end 投票栏 -->
										
										

										</div>
										<!-- end 社交操作 -->
												
												
											</div>
										</div>

									</c:forEach>
									
									
									
									
									
									
									
									



								</div>


							</div>
							<!-- end 问题详细模块 -->
							
							
							<!-- 分页 -->
					
									<div class="mod-footer clearfix">




										<div class="page-control">

											<ul id='bp-3-element'></ul>

											<ul class="pagination pull-right" id='bp-3-element-test'>
											
											</ul>



										</div>





									</div>
					<!-- 分页 -->
							
							

							<!-- 回复编辑器 -->
							<div class="aw-mod aw-replay-box question">
								<a name="answer_form"></a>
								<form
									action="bbsController.do?savaComment"
									onsubmit="return false;" method="post" id="answer_form"
									class="question_answer_form">
									<input type="hidden" name="id" value="${bbsPost.id }" />
									<input type="hidden" name="quotesId" id ="quotesId" value="" /> 
									<input type="hidden" name="comment" id ="comment" value="" /> 
									
									<div class="mod-head">
									<a href="#" class="aw-user-name"> 
									<img alt="user" src="${pageContext.request.contextPath}/userInfoController.do?tofindPic" onerror="this.src='plug-in/lte/dist/img/user2-160x160.jpg'" />
								    </a>
								    <p>${userName}</p>
								    							
									</div>



									<div class="mod-body">
										<div class="aw-mod aw-editor-box">
											<div class="mod-head"   >
												<div class="wmd-panel"  id="summernote">
										
												</div>
												
											</div>
											<div class="mod-body clearfix">
												<a href="javascript:;"
													onclick="comment();"
													class="btn btn-normal btn-success pull-right btn-reply">回复</a>
												<span class="pull-right text-color-999"
													id="answer_content_message">&nbsp;</span>
											</div>
										
										</div>

									</div>
								</form>
							</div>
							<!-- end 回复编辑器 -->





						</div>
						
						
						
						

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
										<a class="aw-user-name" href="#" data-id="2">${bbsPost.postUserName}</a>
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
			Copyright © 2016<span class="hidden-xs"> - 京ICP备11008151号, All
				Rights Reserved</span> <span class="hide">Powered By <a
				href="http://www.wecenter.com/?copyright" target="blank">WeCenter
					3.0 Beta 2</a></span>

		</div>
	</div>





</body>
</html>