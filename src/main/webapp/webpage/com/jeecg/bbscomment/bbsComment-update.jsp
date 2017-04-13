<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
 <head>
  <title>论坛评论</title>
  <t:base type="jquery,easyui,tools,DatePicker"></t:base>
  <script type="text/javascript">
  //编写自定义JS代码
  </script>
 </head>
 <body>
		<t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" action="bbsCommentController.do?doUpdate" tiptype="4" >
					<input id="id" name="id" type="hidden" value="${bbsCommentPage.id }">
					<input id="createName" name="createName" type="hidden" value="${bbsCommentPage.createName }">
					<input id="createBy" name="createBy" type="hidden" value="${bbsCommentPage.createBy }">
					<input id="createDate" name="createDate" type="hidden" value="${bbsCommentPage.createDate }">
					<input id="updateName" name="updateName" type="hidden" value="${bbsCommentPage.updateName }">
					<input id="updateBy" name="updateBy" type="hidden" value="${bbsCommentPage.updateBy }">
					<input id="updateDate" name="updateDate" type="hidden" value="${bbsCommentPage.updateDate }">
					<input id="sysOrgCode" name="sysOrgCode" type="hidden" value="${bbsCommentPage.sysOrgCode }">
					<input id="sysCompanyCode" name="sysCompanyCode" type="hidden" value="${bbsCommentPage.sysCompanyCode }">
		<table style="width: 100%;" cellpadding="0" cellspacing="1" class="formtable">
					<tr>
						<td align="right"  width="25%"  nowrap>
							<label class="Validform_label">
								评论内容:
							</label>
						</td>
						<td class="value" nowrap>
						     	 <input id="comment" name="comment" type="text" style="width: 150px" class="inputxt"  value='${bbsCommentPage.comment}'>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">评论内容</label>
						</td>
					</tr>
					<tr>
						<td align="right"  width="25%"  nowrap>
							<label class="Validform_label">
								评论人ID:
							</label>
						</td>
						<td class="value" nowrap>
						     	 <input id="commentUserid" name="commentUserid" type="text" style="width: 150px" class="inputxt"  value='${bbsCommentPage.commentUserid}'>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">评论人ID</label>
						</td>
					</tr>
					<tr>
						<td align="right"  width="25%"  nowrap>
							<label class="Validform_label">
								帖子ID:
							</label>
						</td>
						<td class="value" nowrap>
						     	 <input id="postId" name="postId" type="text" style="width: 150px" class="inputxt"  value='${bbsCommentPage.postId}'>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">帖子ID</label>
						</td>
					</tr>
					<tr>
						<td align="right"  width="25%"  nowrap>
							<label class="Validform_label">
								引用评论ID:
							</label>
						</td>
						<td class="value" nowrap>
						     	 <input id="quotesId" name="quotesId" type="text" style="width: 150px" class="inputxt"  value='${bbsCommentPage.quotesId}'>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">引用评论ID</label>
						</td>
					</tr>
			</table>
		</t:formvalid>
 </body>
  <script src = "webpage/com/jeecg/bbscomment/bbsComment.js"></script>		
