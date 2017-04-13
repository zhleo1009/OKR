<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<%@taglib prefix="f" uri="http://www.pe.cn/functions" %>

<t:base type="jquery,easyui,tools,autocomplete"></t:base>

<html>
<head>

<style type="text/css">
td {
    height: 17px;
}
</style>

<script type="text/javascript">
var defId='${bpmDefinition.defId}';

$(function(){
	handFlowVars();
});

function handFlowVars(){
	var objConditionCode=$("#taskNameRule");
	$("select[name='selFlowVar']").change(function(){		
		var val=$(this).val();
		var text=$(this).find("option:selected").text();
		if(val.length==0) return;
		if(text=="发起人(长整型)")
			text=text.replace("(长整型)","");			
		var inStr=text+":"+val;
		InsertText(inStr);
	});
}


function InsertText(val){
	UE.getEditor('content').focus();
	UE.getEditor('content').execCommand('inserthtml','{'+val+'}');
}


function save(){
	
	var taskNameRule=UE.getEditor('content').getPlainTxt();
	var toFirstNode=$("#toFirstNode").attr("checked");
	var needStartForm=$("#needStartForm").attr("checked");
	var showFirstAssignee=$("#showFirstAssignee").attr("checked");
	var startFirstNode=$('#startFirstNode').val();
	var formDetailUrl=$('#formDetailUrl').val();
	var outForm=$('#isOutForm').attr("checked");
	var toFirstNodeVal=1;
	var needStartFormVal=1;
	var showFirstAssigneeVal=1;
	var isOutForm=1;
	if(toFirstNode==undefined){
		toFirstNodeVal=0;
	}
	if(outForm==undefined){
		isOutForm=0;
	}
	if(needStartForm==undefined){
		needStartFormVal=0;
	}
	if(showFirstAssignee==undefined){
		showFirstAssigneeVal=0;
	}
	var params={defId:defId,taskNameRule:taskNameRule,toFirstNode:toFirstNodeVal,needStartForm:needStartFormVal,showFirstAssignee:showFirstAssigneeVal,startFirstNode:startFirstNode,isOutForm:isOutForm,formDetailUrl:formDetailUrl};
	
	$.ajax({
		  type: 'POST',
		  url: 'bpmDefinitionController.do?saveOtherParam',
		  data: params,
		  success: function(data){
			  layer.msg(data.msg);
		  } ,
		  dataType: 'json',
	});
	
}


</script>

<script type="text/javascript" charset="utf-8" src="plug-in/Formdesign/js/ueditor/ueditor.config.js?2023"></script>
<script type="text/javascript" charset="utf-8" src="plug-in/Formdesign/js/ueditor/ueditor.all.js?2023"> </script>
<script type="text/javascript" charset="utf-8" src="plug-in/Formdesign/js/ueditor/customizedpe/customizeButtonOtherParam.js?2203"> </script>

</head>

<body style="margin: 2px;">
<div style="height: 25px;" class="datagrid-toolbar">
  <a group="" id="addColumnBtn" class="easyui-linkbutton l-btn l-btn-small" data-options="iconCls:'icon-save'" onclick="save()" href="#">
      <span>保存</span>
  </a>
</div>
<t:formvalid formid="formobj" layout="table" dialog="false" styleClass="formvalid">
<table style="width: 100%;" cellpadding="0" cellspacing="1" class="formtable">
		<tr>
			<td align="right" width="25%" nowrap>
                <label class="Validform_label">  流程标题规则定义:  </label>
            </td>
			<td class="value" width="85%">
				表单变量:<f:flowVar defId="${defId}" controlName="selFlowVar"></f:flowVar>
               <%--  <textarea id="taskNameRule" row="6" name="taskNameRule" >${bpmDefinition.taskNameRule }</textarea> --%>
                 <script id="content" type="text/plain" style="width:100%;margin-top: 4px;" >${bpmDefinition.taskNameRule }</script>
			  	 <script type="text/javascript">
			        	var editor = UE.getEditor('content',{
			        	    //toolleipi:true,//是否显示，设计器的 toolbars
			        	    textarea: 'design_content',   
			        	    //这里可以选择自己需要的工具按钮名称,此处仅选择如下五个/*
			        	    toolbars: [[
			        	    'fullscreen', 'source', '|', 'undo', 'redo', '|',
			        	    'bold', 'italic', 'underline','strikethrough','|',
			        	    'fontfamily', 'fontsize', '|', 'forecolor', 'backcolor','|'
			        	    ]],
			        	    wordCount:false,
			        	    elementPathEnabled:false,
			        	    initialFrameHeight:40
			        	});
				 </script>
                
            </td>
		</tr>
		<tr>
			<td align="right" width="25%" nowrap>
                <label class="Validform_label">  驳回到的发起人节点:  </label>
            </td>
			<td class="value" width="85%">
				<select id="startFirstNode" name="startFirstNode">
					<c:forEach items="${nodeSetList}" var="node">
					<option value="${node.nodeId}" <c:if test="${bpmDefinition.startFirstNode==node.nodeId}">selected="selected"</c:if><c:if test="${firstTaskName==node.nodeId }">selected="selected"</c:if> > ${node.nodeName}</option>
					</c:forEach>
				</select>
            </td>
		</tr>
		<tr>
			<td align="right" width="25%" nowrap>
                <label class="Validform_label">   跳过第一个任务:  </label>
            </td>
			<td class="value" width="85%">
				<%-- <input id="toFirstNode" type="checkbox" name="toFirstNode" value="1"  <c:if test="${bpmDefinition.toFirstNode==1 }">checked="checked"</c:if> /> --%>
				<input id="toFirstNode" type="checkbox" name="toFirstNode" value="1" <c:if test="${bpmDefinition.toFirstNode==1 }">checked="checked"</c:if>/>
            </td>
		</tr>
		<tr>
			<td align="right" width="25%" nowrap>
                <label class="Validform_label">   开始节点需要表单:  </label>
            </td>
			<td class="value" width="85%">
				<input id="needStartForm" type="checkbox" name="needStartForm" value="1"  <c:if test="${bpmDefinition.needStartForm==1 }">checked="checked"</c:if> />
            </td>
		</tr>
		<tr>
			<td align="right" width="25%">
                <label class="Validform_label">   流程启动选择执行人:  </label>
            </td>
			<td class="value" width="85%">
				<input id="showFirstAssignee" type="checkbox" name="showFirstAssignee" value="1"  <c:if test="${bpmDefinition.showFirstAssignee==1 }">checked="checked"</c:if> />
            </td>
		</tr>
		<tr>
			<td align="right" width="25%">
                <label class="Validform_label">   允许API调用:  </label>
            </td>
			<td class="value" width="85%">
				<input id="isOutForm" type="checkbox" name="isUseOutForm" value="1"  <c:if test="${bpmDefinition.isUseOutForm==1 }">checked="checked"</c:if> />
            </td>
		</tr>
		<tr>
			<td align="right" width="25%">
                <label class="Validform_label">   表单明细Url:  </label>
            </td>
			<td class="value" width="85%">
				<input id="formDetailUrl" type="text" style="width: 80%;" name="formDetailUrl" value="${bpmDefinition.formDetailUrl}"   />
            </td>
		</tr>
		<input type="hidden" id="defId" name="defId" value="${bpmDefinition.defId }">
		
</table>
</t:formvalid>
</body>
</html>
