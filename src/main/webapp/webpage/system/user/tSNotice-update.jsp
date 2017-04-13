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
  var flag = false;
  var serverMsg = "";
  var noticeContent = '';
  var noticeTitle = '';
  var filePaths = [];
  
  $(function() {
	  
	  
	  if($('#filePath').val()){
		  filePaths = $('#filePath').val().split('|');
	  }  
	  
	    $('#file_upload').uploadifive({
	      buttonText: '选择附件',
	      auto: true,
	      multi: true,
	      height: 25,
	      width: 100,
	      buttonClass: 'uploadBtnCls',
	      fileType: '',
	      fileSizeLimit: '15MB',
	      uploadScript: 'noticeController.do?importArchive',
	      onQueueComplete: function(queueData) {
	    	  
	      },
	      onUploadComplete: function(file, data) {
	        var result = $.parseJSON(data);
			var fileName = result.msg;
			filePaths.push(fileName);
	        
	      },
	      onError: function(errorType, file) {
	        top.layer.msg('文件大小超出15M');
	      },
	      'onCancel': function(file) {
	    	  var lastIndex = file.name.lastIndexOf('.');
	          var fileName = file.name.substring(0,lastIndex).replace(/\%/g,"_").replace(/\&/g,"_");
	          //alert(fileName);
	          //alert(filePaths);
	          $.each(filePaths,function(i,val) {
	              if(val.indexOf(fileName) != -1){
	            	  filePaths.splice(i,1) 
	              }
	          });
	          //console.debug(filePaths);
	      }
	    });
	  });
  
  
  //编写自定义JS代码
    function setContent(){
	    if(editor.queryCommandState( 'source' ))
	    	editor.execCommand('source');//切换到编辑模式才提交，否则有bug
	            
	    if(editor.hasContents()){
	    	editor.sync();
		    $("#noticeContent").val(editor.getContent());
		}
	   
	    $('#filePath').val(filePaths.join('|'));
	    //alert($('#filePath').val());
	}
  
  //删除已选择的文件
  function removeFile(obj){
	  //alert($(obj).attr("value"));
	  $(obj).parent().remove();
	  
	  $.each(filePaths,function(i,val) {
          if($(obj).attr("value") == val){
        	  filePaths.splice(i,1); 
          }
      });
	  
	  //console.debug(filePaths);
	  
  }
  
  </script>
 </head>
 <body>
  <t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" action="noticeController.do?doUpdate" tiptype="4" beforeSubmit="setContent()">
					<input id="id" name="id" type="hidden" value="${tSNoticePage.id }">
					
		<input type="hidden" name="noticeLevel" value="1" />
		<input type="hidden" id="filePath" name="filePath" value="${filePath }"/>
		<table style="width: 600px;" cellpadding="0" cellspacing="1" class="formtable">
					<tr>
						<td align="right">
							<label class="Validform_label" >
								标题:
							</label>
						</td>
						<td class="value">
						     	 <input id="noticeTitle" name="noticeTitle" type="text" style="width: 95%" class="inputxt"    value='${tSNoticePage.noticeTitle}'>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">通知标题</label>
						</td>
					</tr>
					<%-- <tr>
						<td align="right">
							<label class="Validform_label" style="white-space:nowrap;">
								阅读期限:
							</label>
						</td>
						<td class="value">
						     <input class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"  style="width: 150px" id="noticeTerm" 
						     name="noticeTerm" ignore="ignore" value="<fmt:formatDate value='${tSNoticePage.noticeTerm}' type="date" pattern="yyyy-MM-dd"/>"> 		  
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">阅读期限</label>
						</td>
					</tr> --%>
					<tr>
						<td align="right">
							<label class="Validform_label">
								内容:
							</label>
						</td>
						<td class="value">
								<input id="noticeContent" name="noticeContent" type="hidden" value='${tSNoticePage.noticeContent}'>
								<script id="content" type="text/plain" style="width:700px;" value='${tSNoticePage.noticeContent}'></script>
						  	 	<script type="text/javascript">
						  	 	var editor = UE.getEditor('content',{
					        	    toolleipi:true,//是否显示，设计器的 toolbars
					        	    textarea: 'design_content',   
					        	    //这里可以选择自己需要的工具按钮名称,此处仅选择如下五个/*
					        	   /*  toolbars: [[
					        	    'fullscreen', 'source', '|', 'undo', 'redo', '|',
					        	    'fontfamily', 'fontsize', '|', 'indent', '|',
					        	    'justifyleft', 'justifycenter', 'justifyright', 'justifyjustify', '|', 
					        	    'inserttable', 'deletetable', 'insertparagraphbeforetable', 'insertrow', 'deleterow', '|',
					        	    ]], */
					        	    toolbars:[[
								                 'fullscreen', 'source', '|', 'undo', 'redo', '|',
								                 'bold', 'italic', 'underline', 'fontborder', 'strikethrough', 'superscript', 'subscript', 'removeformat', 'formatmatch', 'autotypeset', 'blockquote', 'pasteplain', '|', 'forecolor', 'backcolor', 'insertorderedlist', 'insertunorderedlist', 'selectall', 'cleardoc', '|',
								                 'rowspacingtop', 'rowspacingbottom', 'lineheight', '|',
								                 'customstyle', 'paragraph', 'fontfamily', 'fontsize', '|',
								                 'directionalityltr', 'directionalityrtl', 'indent', '|',
								                 'justifyleft', 'justifycenter', 'justifyright', 'justifyjustify', '|', 'touppercase', 'tolowercase', '|',
								                 'link', 'unlink', '|', 'imagenone', 'imageleft', 'imageright', 'imagecenter', '|',
								                 'simpleupload', 'insertimage',   '|',
								                 'horizontal', 'date', 'time', 'spechars', '|',
								                 'inserttable', 'deletetable', 'insertparagraphbeforetable', 'insertrow', 'deleterow', 'insertcol', 'deletecol', 'mergecells', 'mergeright', 'mergedown', 'splittocells', 'splittorows', 'splittocols', 'charts', '|',
								             ]],
					        	    wordCount:false,
					        	    elementPathEnabled:false,
					        	    initialFrameHeight:250
					        	});
						  	 	editor.ready(function() {
						  	 		editor.setContent($('#noticeContent').val());
						  	    });
							 </script>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">通知公告内容</label>
						</td>
					</tr>
					
					<tr>
						<td align="right">
							<label class="Validform_label">
								上传附件:
							</label>
						</td>
						<td class="value">
							<input type="file" id="file_upload">
							
							
							<div id="uploadifive-file_upload-queue" class="uploadifive-queue">
							
							
								<c:forEach items="${files }" var="f">
										<div class="uploadifive-queue-item complete" id="uploadifive-file_upload-file-0"> 
										    <a class="close" href="#" onclick="removeFile(this)" value="${f.fileName}">X</a> 
										    <div>
										     <span class="filename">${f.fileRealName}</span>
										    </div> 
										    <div class="progress" style="display: none;"> 
										     <div class="progress-bar" style="width: 100%;"></div> 
										    </div> 
									   </div>
								
								</c:forEach>
								
							</div>
							
						</td>
					</tr>
					
					<tr>
						<td align="right">
							<label class="Validform_label" >
								类型:
							</label>
						</td>
						<td class="value">
						     	 <input type="radio" name="noticeType" value="1" datatype="*"  <c:if test="${tSNoticePage.noticeType=='1'}">checked="checked"</c:if> 
						     	 <c:if test="${empty tSNoticePage.noticeType}">checked="checked"</c:if> />通知
         				&nbsp;&nbsp;<input type="radio" name="noticeType" value="2" <c:if test="${tSNoticePage.noticeType=='2'}">checked="checked"</c:if> />公告
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
	