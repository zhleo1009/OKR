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
<script type="text/javascript">var param = {};
  var flag = false;
  var serverMsg = "";
  var noticeContent = '';
  var noticeTitle = '';
  
  var filePaths = [];
  
  $(function() {
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
 
  function cancel() {
    $('#file_upload').uploadifive('cancel');
  }

  //编写自定义JS代码
  function setContent(){
	    if(editor.queryCommandState( 'source' ))
	    	editor.execCommand('source');//切换到编辑模式才提交，否则有bug
	            
	    if(editor.hasContents()){
	    	editor.sync();
		    $("#noticeContent").val(editor.getContent());
		}
	    	
	    $('#filePath').val(filePaths.join('|'));
	    
	}
  </script>
 </head>
 <body>
  <t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" action="noticeController.do?doAdd" tiptype="4" 
  	beforeSubmit="setContent()">
					<input id="id" name="id" type="hidden" value="${tSNoticePage.id}">
					
		<input type="hidden" name="noticeLevel" value="1" />
		<input type="hidden" id="filePath" name="filePath"/>
		<table style="width: 600px;" cellpadding="0" cellspacing="1" class="formtable">
				<tr>
					<td align="right">
						<label class="Validform_label">
							标题:
						</label>
					</td>
					<td class="value">
					     	<input id="noticeTitle" name="noticeTitle" type="text" style="width:70%" class="inputxt" datatype="*" >
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">通知标题</label>
						</td>
				</tr>
				<!-- <tr>
					<td align="right">
						<label class="Validform_label" style="white-space:nowrap;">
							阅读期限:
						</label>
					</td>
					<td class="value">
							   <input id="noticeTerm" name="noticeTerm" type="text" style="width: 150px" 
					      						class="Wdate" onClick="WdatePicker()" >    
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">阅读期限</label>
						</td>
				</tr> -->
				<tr>
					<td align="right">
						<label class="Validform_label">
							内容:
						</label>
					</td>
					<td class="value">
						  	 <input id="noticeContent" name="noticeContent" type="hidden">
						  	 <script id="content" type="text/plain" style="width:700px;" ></script>
						  	 <script type="text/javascript">
						        	var editor = UE.getEditor('content',{
						        	    toolleipi:true,//是否显示，设计器的 toolbars
						        	    textarea: 'design_content',   
						        	    //这里可以选择自己需要的工具按钮名称,此处仅选择如下五个/*
						        	   /*  toolbars: [[
						        	    'fullscreen', 'source', '|', 'undo', 'redo', '|',
						        	    'fontfamily', 'fontsize', '|', 'indent', '|',
						        	    'justifyleft', 'justifycenter', 'justifyright', 'justifyjustify', '|', 
						        	    'inserttable', 'deletetable', 'insertparagraphbeforetable', 'insertrow', 'deleterow', '|' ,
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
					</td>
				</tr>
				
				
				<tr>
					<td align="right">
						<label class="Validform_label">
							类型:
						</label>
					</td>
					<td class="value">
					     	 <input type="radio" name="noticeType" value="1" />通知
         				&nbsp;&nbsp;<input type="radio" name="noticeType" value="2" checked="checked" />公告
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">通知公告类型</label>
						</td>
				</tr>
				<!-- <tr>
					<td align="right">
						<label class="Validform_label" style="white-space:nowrap;">
							授权级别:
						</label>
					</td>
					<td class="value">
					     	  <input type="radio" name="noticeLevel" value="1" datatype="*" checked="checked" />全员
         				&nbsp;&nbsp;<input type="radio" name="noticeLevel" value="2"  />角色授权
         				&nbsp;&nbsp;<input type="radio" name="noticeLevel" value="3" />用户授权
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">授权级别</label>
						</td>
				</tr> -->
				
			</table>
		</t:formvalid>
 </body>
		