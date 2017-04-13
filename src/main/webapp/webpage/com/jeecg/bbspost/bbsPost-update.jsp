<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
 <head>
  <title>帖子</title>
  <t:base type="jquery,easyui,tools,DatePicker"></t:base>
  <script type="text/javascript">
  //编写自定义JS代码
  </script>
 </head>
 <body>
		<t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" action="bbsPostController.do?doUpdate" tiptype="4" >
					<input id="id" name="id" type="hidden" value="${bbsPostPage.id }">
					<input id="createName" name="createName" type="hidden" value="${bbsPostPage.createName }">
					<input id="createBy" name="createBy" type="hidden" value="${bbsPostPage.createBy }">
					<input id="createDate" name="createDate" type="hidden" value="${bbsPostPage.createDate }">
					<input id="updateName" name="updateName" type="hidden" value="${bbsPostPage.updateName }">
					<input id="updateBy" name="updateBy" type="hidden" value="${bbsPostPage.updateBy }">
					<input id="updateDate" name="updateDate" type="hidden" value="${bbsPostPage.updateDate }">
					<input id="sysOrgCode" name="sysOrgCode" type="hidden" value="${bbsPostPage.sysOrgCode }">
					<input id="sysCompanyCode" name="sysCompanyCode" type="hidden" value="${bbsPostPage.sysCompanyCode }">
		<table style="width: 100%;" cellpadding="0" cellspacing="1" class="formtable">
					<tr>
						<td align="right"  width="25%"  nowrap>
							<label class="Validform_label">
								标题:
							</label>
						</td>
						<td class="value" nowrap>
						     	 <input id="title" name="title" type="text" style="width: 150px" class="inputxt"  value='${bbsPostPage.title}'>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">标题</label>
						</td>
					</tr>
					<tr>
						<td align="right"  width="25%"  nowrap>
							<label class="Validform_label">
								内容:
							</label>
						</td>
						<td class="value" nowrap>
						  	 	<textarea id="content" style="width:600px;" class="inputxt" rows="6" name="content">${bbsPostPage.content}</textarea>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">内容</label>
						</td>
					</tr>
					<tr>
						<td align="right"  width="25%"  nowrap>
							<label class="Validform_label">
								发帖人ID:
							</label>
						</td>
						<td class="value" nowrap>
						     	 <input id="postUserid" name="postUserid" type="text" style="width: 150px" class="inputxt"  value='${bbsPostPage.postUserid}'>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">发帖人ID</label>
						</td>
					</tr>
					<tr>
						<td align="right"  width="25%"  nowrap>
							<label class="Validform_label">
								版块ID:
							</label>
						</td>
						<td class="value" nowrap>
						     	 <input id="editionId" name="editionId" type="text" style="width: 150px" class="inputxt"  value='${bbsPostPage.editionId}'>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">版块ID</label>
						</td>
					</tr>
			</table>
		</t:formvalid>
 </body>
  <script src = "webpage/com/jeecg/bbspost/bbsPost.js"></script>		
