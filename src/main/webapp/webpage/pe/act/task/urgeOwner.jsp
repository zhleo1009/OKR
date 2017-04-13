<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools"></t:base>
<%@taglib prefix="f" uri="http://www.pe.cn/functions" %>
<!DOCTYPE html>
<html>
<head>
<title>新建催办单</title>
<%--
<script type="text/javascript" src="pe/js/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="pe/js/ckeditor/ckeditor_sysTemp.js"></script>
 --%>
<script type="text/javascript" src="pe/js/jquery/jquery.form.js"></script>
<script type="text/javascript" charset="utf-8" src="plug-in/Formdesign/js/ueditor/ueditor.config.js?2023"></script>
<script type="text/javascript" charset="utf-8" src="plug-in/Formdesign/js/ueditor/ueditor.all.js?2023"> </script>
<script type="text/javascript" charset="utf-8" src="plug-in/Formdesign/js/ueditor/customizedpe/customizePeButton.js?2023"> </script>


<style type="text/css">
	label{
		cursor:pointer;
	}
</style>
<script type="text/javascript">
	$(function(){
		
		//var editor1=ckeditor('inner_msg');
		//var editor2=ckeditor('mail_msg');
		var options={};
		
		$("#userProcessSubject").click(function(){
			var val=$("#userProcessSubject").attr("checked"), input=$("#subject");
			if(val){
				input.attr("disabled","disabled");
				input.val("");
			}
			else{
				input.removeAttr("disabled");
			}
		});
		
		/*
		$("a.urge").click(function() {
			$(".ckeditor").each(function(){
				$(this).val(CKEDITOR.instances[$(this).attr('name')].getData());
			});
		});
		*/

		function type_change(e){
			var id=$(e).attr("id"),	val=$(e).attr("checked"),tr;		
			switch(id){
				case "short":
					tr=$("#short_msg").closest("tr");
					break;
				case "mail":
					tr=$("#mail_msg").closest("tr");
					break;
			}
			if(tr){
				if(val)
					tr.show();
				else
					tr.hide();
			}
		};
		
	});

</script>
</head>
<body style="overflow-y: hidden" scroll="no">
<t:formvalid formid="formobj" layout="table" dialog="true" action="processRunController.do?urgeSubmit">
				<input type="hidden" id="btn_sub" class="btn_sub" onclick="saves()" />
				<input type="hidden" id="actInstId" value="${actInstId}" />
				<input type="hidden" id="processSubject" value="${processSubject}">
				<table style="width: 100%" cellpadding="0" cellspacing="1" class="formtable">
					<tr>
					<td align="right" width="25%" nowrap><label class="Validform_label">催办方式:</label></td>
					<td class="value" width="85%"><label><input type="checkbox" disabled="disabled" checked="checked" />站内消息</label>
					<!-- <label><input type="checkbox" id="short" name="short" value="1" onclick="type_change(this)"/>手机短信</label>
							<label><input type="checkbox" id="mail" name="mail" value="2" onclick="type_change(this)"/>邮件</label> -->
					</td>
					</tr>
					<tr>
						<td align="right" width="25%" nowrap><label class="Validform_label">站内消息和邮件标题:</label></td>
						<td class="value" width="85%">
							<label><input type="checkbox" checked="checked" id="userProcessSubject" name="userProcessSubject" value="true"/>使用流程标题</label>&nbsp;&nbsp;
							<input style="width:210px;height:21px;" type="text" id="subject" name="subject" disabled="disabled" />
						</td>
					</tr>
					<tr>
						<td align="right" width="25%" nowrap><label class="Validform_label">站内消息内容:</label></td>
						<td class="value" width="85%">
							
							<!-- <textarea cols="50" rows="3" id="inner_msg" name="inner_msg">${inner}</textarea>	-->						
							<script id="innerContentEditor" type="text/plain" style="width:100%;margin-top: 4px;" >${inner}</script>
						  	<script type="text/javascript">
						        	var innerEditor = UE.getEditor('innerContentEditor',{
						        	    textarea: 'inner_msg', //提交时参数名
						        	    toolbars: [[
						        	    'fullscreen', 'source', '|', 'undo', 'redo', '|',
						        	    'bold', 'italic', 'underline','strikethrough','|',
						        	    'fontfamily', 'fontsize', '|', 'forecolor', 'backcolor','|'
						        	    ]],
						        	    wordCount:false,
						        	    elementPathEnabled:false,
						        	    initialFrameHeight:320 //初始化iframe高度
						        	});
							 </script>
							 
						</td>
					</tr>
					<tr style="display:none;">
						<td align="right" width="25%" nowrap><label class="Validform_label">手机短信内容:</label></td>
						<td class="value" width="85%">
							<%--   <textarea cols="50" rows="3" id="short_msg" name="short_msg">${shortMsg}</textarea> --%>
							<script id="shortMsgContentEditor" type="text/plain" style="width:100%;margin-top: 4px;" >${shortMsg}</script>
						  	<script type="text/javascript">
						        	var shortMsgEditor = UE.getEditor('shortMsgContentEditor',{
						        	    textarea: 'short_msg', //提交时参数名
						        	    toolbars: [[
						        	    'fullscreen', 'source', '|', 'undo', 'redo', '|',
						        	    'bold', 'italic', 'underline','strikethrough','|',
						        	    'fontfamily', 'fontsize', '|', 'forecolor', 'backcolor','|'
						        	    ]],
						        	    wordCount:false,
						        	    elementPathEnabled:false,
						        	    initialFrameHeight:320 //初始化iframe高度
						        	});
							 </script>
						</td>
					</tr>
					<tr style="display:none;">
						<td align="right" width="25%" nowrap><label class="Validform_label">邮件内容:</label></td>
						<td class="value" width="85%">
							<%--   <textarea cols="50" rows="3" id="mail_msg" name="mail_msg">${mail}</textarea> --%>
							<script id="mailContentEditor" type="text/plain" style="width:100%;margin-top: 4px;" >${mail}</script>
						  	<script type="text/javascript">
						        	var mailEditor = UE.getEditor('mailContentEditor',{
						        	    textarea: 'mail_msg', //提交时参数名
						        	    toolbars: [[
						        	    'fullscreen', 'source', '|', 'undo', 'redo', '|',
						        	    'bold', 'italic', 'underline','strikethrough','|',
						        	    'fontfamily', 'fontsize', '|', 'forecolor', 'backcolor','|'
						        	    ]],
						        	    wordCount:false,
						        	    elementPathEnabled:false,
						        	    initialFrameHeight:320 //初始化iframe高度
						        	});
							 </script>
						</td>
					</tr>
				</table>
				
				
</t:formvalid>
<script type="text/javascript">

function saves(obj){
	var url=$("#formobj").attr("action");
	$.post(url,{
		"actInstId":$("#actInstId").val(),
		"subject":$("#subject").val(),
		"processSubject":$("#processSubject").val(),
		"inner_msg":innerEditor.getContentTxt(),
		"short_msg":shortMsgEditor.getContentTxt(),
		"mail_msg":mailEditor.getContentTxt(),
		"userProcessSubject":UE.getEditor('shortMsgContentEditor').getContentTxt()
	},function(data){
		var jsonResult = eval("(" + data + ")");
		if(jsonResult.success){
			top.layer.msg(jsonResult.msg,{time:500});
			//关闭后的操作
			obj.windowapi.close();
		}else{
			top.layer.msg(jsonResult.msg, {icon: 2});
		}
	} );
}


</script>


</body>
</html>


