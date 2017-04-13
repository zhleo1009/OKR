<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
 <head>
  <title>common.notice</title>
  <t:base type="jquery,easyui,tools,DatePicker"></t:base>
  <script type="text/javascript" src="plug-in/ckeditor/ckeditor.js"></script>
  <script type="text/javascript" src="plug-in/ckfinder/ckfinder.js"></script>
  <script>UEDITOR_HOME_URL='<%=path%>/plug-in/Formdesign/js/ueditor/';</script>
<script type="text/javascript" charset="utf-8" src="plug-in/Formdesign/js/ueditor/ueditor.config.js?2023"></script>
<script type="text/javascript" charset="utf-8" src="plug-in/Formdesign/js/ueditor/ueditor.all.js?2023"> </script>

 <link href="plug-in/uploadifive/1.2.2/uploadifive.css" rel="stylesheet" />
 <script type="text/javascript" src="plug-in/uploadifive/1.2.2/jquery.uploadifive.min.js"></script>
 <script type="text/javascript">
 
 // 导出文件
/*  exportArchive(id,fileName){
	 
	 window.location.href = 'noticeController.do?doUpdate';
	 
 } */
 
 
 
 
 </script>
 </head>
 <body style="margin: 10px;">
  <t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" action="noticeController.do?doUpdate" tiptype="4" beforeSubmit="setContent()">
					
		<table style="width: 100%;" cellpadding="0" cellspacing="1" class="formtable">
					<tr>
						<td align="right">
							<label class="Validform_label" >
								标题:
							</label>
						</td>
						<td class="value">
						     	 ${tSNoticePage.noticeTitle}
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">通知标题</label>
						</td>
					</tr>
					<tr>
						<td align="right">
							<label class="Validform_label">
								内容:
							</label>
						</td>
						<td class="value">
								<%-- <input id="noticeContent" name="noticeContent" type="hidden" value='${tSNoticePage.noticeContent}'>
								<script id="content" type="text/plain" style="width:700px;" value='${tSNoticePage.noticeContent}'></script>
						  	 	<script type="text/javascript">
						  	 	var editor = UE.getEditor('content',{
					        	    toolleipi:true,//是否显示，设计器的 toolbars
					        	    textarea: 'design_content',   
					        	    //这里可以选择自己需要的工具按钮名称,此处仅选择如下五个/*
					        	    toolbars: [],
					        	    wordCount:false,
					        	    elementPathEnabled:false,
					        	    initialFrameHeight:250,
					        	    readonly:true
					        	});
						  	 	editor.ready(function() {
						  	 		editor.setContent($('#noticeContent').val());
						  	    });
							 </script>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">通知公告内容</label> --%>
							
							${tSNoticePage.noticeContent}
						</td>
					</tr>
					
					<c:if test="${not empty files}">
					<tr>
						<td align="right">
							<label class="Validform_label">
								附件:
							</label>
						</td>
						<td class="value">
							
							<div id="uploadifive-file_upload-queue" class="uploadifive-queue">
							
							
								<c:forEach items="${files }" var="f">
										<div class="uploadifive-queue-item complete" id="uploadifive-file_upload-file-0"> 
										    <div>
										     <a style="cursor: pointer;" href="noticeController.do?exportArchive&id=${tSNoticePage.id}&fileName=${f.fileName}"><span class="filename" >${f.fileRealName}</span></a>
										    </div> 
										    <div class="progress" style="display: none;"> 
										     <div class="progress-bar" style="width: 100%;"></div> 
										    </div> 
									   </div>
								
								</c:forEach>
								
							</div>
							
						</td>
					</tr>
					
					</c:if>
					
					
					
					<tr>
						<td align="right">
							<label class="Validform_label" >
								类型:
							</label>
						</td>
						<td class="value">
						     	 <input type="radio" name="noticeType" value="1" disabled="disabled" <c:if test="${tSNoticePage.noticeType=='1'}">checked="checked"</c:if> 
						     	 <c:if test="${empty tSNoticePage.noticeType}">checked="checked"</c:if> />通知
         				&nbsp;&nbsp;<input type="radio" name="noticeType" value="2" disabled="disabled" <c:if test="${tSNoticePage.noticeType=='2'}">checked="checked"</c:if> />公告
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">类型</label>
						</td>
					</tr>
					<%-- <tr>
						<td align="right">
							<label class="Validform_label" style="white-space:nowrap;">
								授权级别:
							</label>
						</td>
						<td class="value">
						     	 <input type="radio" id="noticeLevel" name="noticeLevel" value="1" datatype="*"  <c:if test="${tSNoticePage.noticeLevel=='1'}">checked="checked"</c:if> 
						     	 <c:if test="${empty tSNoticePage.noticeLevel}">checked="checked"</c:if> />全员
         				&nbsp;&nbsp;<input type="radio" name="noticeLevel" value="2" <c:if test="${tSNoticePage.noticeLevel=='2'}">checked="checked"</c:if> />角色授权
         				&nbsp;&nbsp;<input type="radio" name="noticeLevel" value="3" <c:if test="${tSNoticePage.noticeLevel=='3'}">checked="checked"</c:if> />用户授权
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">授权级别</label>
						</td>
					</tr> --%>
					
			</table>
		</t:formvalid>
 </body>
	