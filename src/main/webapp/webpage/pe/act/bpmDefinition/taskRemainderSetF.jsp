<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<%@taglib prefix="f" uri="http://www.pe.cn/functions" %>
	
<t:formvalid formid="formobj" layout="table" dialog="false" styleClass="formvalid" action="bpmDefinitionController.do?saveTaskRemainder" callback="callback" beforeSubmit="validForm">

<div class="easyui-tabs" style="width: 100%">

	<div title="催办基本信息设置" style="padding:10px">
		
		<div id="condition">
		
		<table style="width: 100%;" cellpadding="0" cellspacing="1" class="formtable">
			<tr>
				<td align="right" width="10%" nowrap>
	                <label class="Validform_label">  名称:  </label>
	            </td>
				<td class="value" width="40%">
					<input id="name" name="name" value="${taskReminder.name}" type="text" datatype="*"/>
	            </td>
	            <td align="right" width="10%" nowrap>
	                <label class="Validform_label">  当前节点:  </label>
	            </td>
				<td class="value" width="40%">
					<input type="text" value="${nodeId}" disabled="disabled" />
	            </td>
	         </tr>  
	         
	         <tr>
				<td align="right" width="10%" nowrap>
	                <label class="Validform_label">  相对节点:  </label>
	            </td>
				<td class="value" width="40%">
					
					<select name="relativeNodeId">
						<c:forEach items="${nodes}" var="node">
								<option value="${node.nodeId}" <c:if test="${node.nodeId==taskReminder.relativeNodeId}">selected="selected"</c:if>>${node.nodeName}</option>
						</c:forEach>
					</select>
					
	            </td>
	            <td align="right" width="10%" nowrap>
	                <label class="Validform_label">  相对动作:  </label>
	            </td>
				<td class="value" width="40%">
					<select name="relativeNodeType" style="width: 70px;">
						<option value="0" >创建</option>
						<option value="1" <c:if test="${taskReminder.relativeNodeType==1}">selected="selected"</c:if>>完成</option>
					</select>
	            </td>
	         </tr>  
	         
	         
	         <tr id="completeTr">
				<td align="right" width="10%" nowrap>
	                <label class="Validform_label">  相对时间:  </label>
	            </td>
				<td class="value" width="40%">
					
					<input class="day-input" type="text" name="completeTimeDay" value="${completeTimeDay}" style="width: 40px;"/>
					<span>天</span>
					<select id="completeTimeHour" class="hourInput" name="completeTimeHour" style="width: 70px;">
						<c:forEach var="i" begin="0" end="23" step="1">
							<option value="${i}" <c:if test="${completeTimeHour==i}">selected="selected"</c:if>>${i}小时</option>
						</c:forEach>
					</select>
					<select id="completeTimeMinute" class="minuteInput" name="completeTimeMinute" style="width: 70px;">
						<c:forEach var="i" begin="0" end="4" step="1">
							<option value="${i}" <c:if test="${completeTimeMinute==i}">selected="selected"</c:if>>${i}分钟</option>
						</c:forEach>
						<c:forEach var="i" begin="5" end="59" step="5">
							<option value="${i}" <c:if test="${completeTimeMinute==i}">selected="selected"</c:if>>${i}分钟</option>
						</c:forEach>
					</select>		
					
	            </td>
	            <td align="right" width="10%" nowrap>
	                <label class="Validform_label">  相对时间类型:  </label>
	            </td>
				<td class="value" width="40%">
					<select name="relativeTimeType" style="width: 70px;">
						<option value="0">工作日</option>
						<option value="1" <c:if test="${taskReminder.relativeTimeType==1}">selected="selected"</c:if>>日历日</option>
					</select>
	            </td>
	         </tr>  
	         
	         <tr style="display: none;">
	          <td><textarea id="condExp" name="condExp" class="condExp-editor-input">${taskReminder.condExp}</textarea></td>
	         </tr>
	         
         </table>
         
         </div>
         
         
         <div id="timeAction">
         
         <table style="width: 100%;" cellpadding="0" cellspacing="1" class="formtable">
			<tr>
				<td align="right" width="25%" nowrap>
	                <label class="Validform_label">  到期动作设置:  </label>
	            </td>
				<td class="value" width="75%">
					<select id="action" onchange="change()" name="action">
						<option value="0" <c:if test="${taskReminder.action==0}">selected="selected"</c:if>>无动作</option>
						<option value="1" <c:if test="${taskReminder.action==1}">selected="selected"</c:if>>执行同意操作</option>
						<option value="2" <c:if test="${taskReminder.action==2}">selected="selected"</c:if>>执行反对操作</option>
						<option value="3" <c:if test="${taskReminder.action==3}">selected="selected"</c:if>>执行驳回操作</option>
						<option value="4" <c:if test="${taskReminder.action==4}">selected="selected"</c:if>>执行驳回到发起人操作</option>
						<option value="5" <c:if test="${taskReminder.action==5}">selected="selected"</c:if>>执行交办操作</option>
						<option value="6" <c:if test="${taskReminder.action==6}">selected="selected"</c:if>>结束该流程</option>
					</select>
	            </td>
	         </tr>  
	         
	         <tr class="choose-assigner">
				<td align="right" width="25%" nowrap>
	                <label class="Validform_label">  指定交办人员:  </label>
	            </td>
				<td class="value" width="75%">
					<%-- <input type="hidden" name="assignerId" value="${taskReminder.assignerId}"/>
					<input type="text" name="assignerName" readonly="readonly" value="${taskReminder.assignerName}"/>
					<a href="javascript:;" onclick="chooseAssigner()" class="button">
						<span>选择</span>
					</a> --%>
					<t:userSelect windowWidth="800px" windowHeight="500px" title="用户列表" minFlag="false" resize="false" lblName="" 
						selectedIdsHiddenInputId="peUserId" griddataUserIdFieldName="peUserId"/>
	            </td>
	         </tr>  
         </table>
         
         </div>
         
         <div id="sendMessage">
          <table style="width: 100%;" cellpadding="0" cellspacing="1" class="formtable">
         	 <tr>
				<td align="right" width="25%" nowrap>
	                <label class="Validform_label">  发送催办信息:  </label>
	            </td>
				<td class="value" width="75%">
					<label><input type="checkbox" id="needSendMsg" />发送</label>
	            </td>
	         </tr>  
	         
	         <tr class="send-msg-tr">
				<td align="right" width="25%" nowrap>
	                <label class="Validform_label">  开始发送时间:  </label>
	            </td>
				<td class="value" width="75%" id="startTr">
					<input class="day-input" type="text" name="reminderStartDay" value="${reminderStartDay}"  style="width: 40px;"/>
					<span>天</span>
					<select id="reminderStartHour" class="hourInput" name="reminderStartHour"  style="width: 70px;">
						<c:forEach var="i" begin="0" end="23" step="1">
							<option value="${i}" <c:if test="${reminderStartHour==i}">selected="selected"</c:if>>${i}小时</option>
						</c:forEach>
					</select>
					<select id="reminderStartMinute" class="minuteInput" name="reminderStartMinute"  style="width: 70px;">
						<c:forEach var="i" begin="0" end="4" step="1">
							<option value="${i}" <c:if test="${reminderStartMinute==i}">selected="selected"</c:if>>${i}分钟</option>
						</c:forEach>
						<c:forEach var="i" begin="5" end="59" step="5">
							<option value="${i}" <c:if test="${reminderStartMinute==i}">selected="selected"</c:if>>${i}分钟</option>
						</c:forEach>
					</select>		
	            </td>
	         </tr>
	         
	         <tr class="send-msg-tr">
				<td align="right" width="25%" nowrap>
	                <label class="Validform_label">  发送的间隔:  </label>
	            </td>
				<td class="value" width="75%" id="endTr">
					<input class="day-input" type="text" name="reminderEndDay" value="${reminderEndDay}"  style="width: 40px;"/>
					<span>天</span>
					<select id="reminderEndHour" class="hourInput" name="reminderEndHour"  style="width: 70px;">
						<c:forEach var="i" begin="0" end="23" step="1">
							<option value="${i}" <c:if test="${reminderEndHour==i}">selected="selected"</c:if>>${i}小时</option>
						</c:forEach>
					</select>
					<select id="reminderEndMinute" class="minuteInput" name="reminderEndMinute"  style="width: 70px;">
						<c:forEach var="i" begin="1" end="4" step="1">
							<option value="${i}" <c:if test="${reminderEndMinute==i}">selected="selected"</c:if>>${i}分钟</option>
						</c:forEach>
						<c:forEach var="i" begin="5" end="59" step="5">
							<option value="${i}" <c:if test="${reminderEndMinute==i}">selected="selected"</c:if>>${i}分钟</option>
						</c:forEach>
					</select>
	            </td>
	         </tr>    
	         
	          <tr class="send-msg-tr">
				<td align="right" width="25%" nowrap>
	                <label class="Validform_label">  发送信息次数:  </label>
	            </td>
				<td class="value" width="75%">
					<select id="times"  style="width: 70px;">
						<c:forEach var="i" begin="0" end="10" step="1">
							<option value="${i}" <c:if test="${taskReminder.times==i}">selected="selected"</c:if>>${i}</option>
						</c:forEach>
					</select>
	            </td>
	         </tr>  
         </table>
         
         </div>
         
	</div>
	
	
	<div title="邮件内容" style="padding:10px">
	
		<a href="#" onclick="javascript:showTaskRemainderTemplate('mailContentEditor');">点击选择模板</a>
		<%-- <textarea id="mailContent"  name="mailContent" class="ckeditor-editor" rows="20" cols="50">${taskReminder.mailContent}</textarea> --%>
		<script id="mailContentEditor" type="text/plain" style="width:100%;margin-top: 4px;" >${taskReminder.mailContent}</script>
	  	<script type="text/javascript">
	        	var editor = UE.getEditor('mailContentEditor',{
	        	    textarea: 'mailContent', //提交时参数名
	        	    toolbars: [[
	        	    'fullscreen', 'source', '|', 'undo', 'redo', '|',
	        	    'bold', 'italic', 'underline','strikethrough','|',
	        	    'fontfamily', 'fontsize', '|', 'forecolor', 'backcolor','|'
	        	    ]],
	        	    wordCount:false,
	        	    elementPathEnabled:false,
	        	    initialFrameHeight:320//初始化iframe高度
	        	});
		 </script>
	
	
	</div>
	<div title="站内信内容" style="padding:10px">
		<a href="#" onclick="javascript:showTaskRemainderTemplate('msgContentEditor');">点击选择模板</a>
		<%-- <textarea id="msgContent"  name="msgContent" class="ckeditor-editor" rows="12" cols="50">${taskReminder.msgContent}</textarea> --%>
		<script id="msgContentEditor" type="text/plain" style="width:100%;margin-top: 4px;" >${taskReminder.msgContent}</script>
	  	<script type="text/javascript">
	        	var editor = UE.getEditor('msgContentEditor',{
	        	    textarea: 'msgContent', //提交时参数名
	        	    toolbars: [[
	        	    'fullscreen', 'source', '|', 'undo', 'redo', '|',
	        	    'bold', 'italic', 'underline','strikethrough','|',
	        	    'fontfamily', 'fontsize', '|', 'forecolor', 'backcolor','|'
	        	    ]],
	        	    wordCount:false,
	        	    elementPathEnabled:false,
	        	    initialFrameHeight:320//初始化iframe高度
	        	});
		 </script>
	</div>
	<div title="手机短信内容" style="padding:10px">
		<a href="#" onclick="javascript:showTaskRemainderTemplate('smsContentEditor');">点击选择模板</a>
		<%-- <textarea id="smsContent" name="smsContent" rows="12" cols="50">${taskReminder.smsContent}</textarea> --%>
		<script id="smsContentEditor" type="text/plain" style="width:100%;margin-top: 4px;" >${taskReminder.smsContent}</script>
	  	<script type="text/javascript">
	        	var editor = UE.getEditor('smsContentEditor',{
	        	    textarea: 'smsContent', //提交时参数名
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
	</div>
</div>

<!-- 隐藏域 -->
<input type="hidden" class="btn_sub" id="btn_sub">
<input type="hidden" name="taskDueId" value="${taskReminder.taskDueId}" />
<input type="hidden" name="actDefId" value="${actDefId}" />
<input type="hidden" name="nodeId" value="${nodeId}" />
<input type="hidden" id="defId" name="defId" value="${defId}" />
 
</t:formvalid>


