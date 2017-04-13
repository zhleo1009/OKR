<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<%@taglib prefix="f" uri="http://www.pe.cn/functions" %>
<t:base type="jquery,easyui,tools"></t:base>

<html>
<head>

<style type="text/css">
td {
    height: 17px;
}
</style>

<script type="text/javascript" src="pe/js/javacode/codemirror.js"></script>
<script type="text/javascript" src="pe/js/javacode/InitMirror.js"></script>

<script type="text/javascript">

	var nodeId = "${nodeId}", deployId = "${deployId}", defId = "${defId}", selectNodeId = "${selectCanChoicePathNodeId}";
	
	$(function() {
		//$("a[name='btnVars']").click(selectVar);
		//$("#btnScript").click(selectScript);
		$("#canChoicePath").click(function() {
			var targ = $("#canChoicePathNodeId");
			if ($(this).attr("checked")) {
				targ.removeClass("hidden");
				InitMirror.each(function(e) {
					e.setCode('NextPathId.contains("' + e.targetId + '")');
				});
			} else {
				targ.addClass("hidden");
				InitMirror.each(function(e) {
					e.setCode('');
				});
			}
		});
		if (selectNodeId) {
			$("#canChoicePathNodeId").val(selectNodeId);
		}
		$("a[name='signResult']").click(function() {
			addToTextarea($(this).attr("result"));
		});
		//$("a.save").click(saveCondition);
	});
	
	var flowVarWindow;
	//选择变量
	function selectVar() {
		FlowVarWindow({
			deployId : deployId,
			nodeId : nodeId,
			callback : function(vars) {
				addToTextarea(vars);
			}
		});
	};
	//将条件表达式追加到脚本输入框内
	function addToTextarea(str) {
		InitMirror.editor.insertCode(str);
	};

	function selectScript() {
		ScriptDialog({
			callback : function(script) {
				addToTextarea(script);
			}
		});
	};
	function handFlowVars(obj) {
		addToTextarea($(obj).val());
	};
	
	// 保存条件
	function saveCondition() {
		InitMirror.save();
		var tasks = [];
		var conditions = [];		
		$("tr.taskTr > td").each(function(){
			var condition=$("[name='condition']", $(this)).val();
			var task=$("[name='task']", $(this)).val(); 
			tasks.push(task);
			conditions.push(condition);
		});
		
		var canChoicePathNodeId=$("#canChoicePathNodeId:visible").val();
		
		var url = "bpmDefinitionController.do?saveGatewayCondition";
		
		var paras = {
			"defId" : defId,
			"nodeId" : nodeId,
			"tasks" : tasks.join('#split#'),
			"conditions" : conditions.join('#split#'),
			"canChoicePathNodeId":canChoicePathNodeId
		};

		$.ajax({
			  type: 'POST',
			  url: url,
			  data: paras,
			  success: function(data){
				  if(data.success){
					  layer.msg(data.msg);
				  }
			  } ,
			  dataType: 'json'
		});
		
	};
	
</script>

</head>

<body style="margin: 2px;">
<div style="height: 25px;" class="datagrid-toolbar">
  <a group="" id="addColumnBtn" class="easyui-linkbutton l-btn l-btn-small" data-options="iconCls:'icon-save'" onclick="saveCondition()" href="#">
      <span>保存</span>
  </a>
</div>
<t:formvalid formid="formobj" layout="table" dialog="false" styleClass="formvalid">
 <table style="width: 100%;" cellpadding="0" cellspacing="1" class="formtable">
		<tr>
			<td align="right" width="25%" nowrap>
                <label class="Validform_label">  条件表达式:  </label>
            </td>
			<td class="value" width="85%">
				
               	表单变量:
				<f:flowVar defId="${defId}" change="handFlowVars(this)"></f:flowVar>
				<c:if test="${ifInclusiveGateway}">
					&nbsp;&nbsp;&nbsp;&nbsp;<label><input type="checkbox" id="canChoicePath" <c:if test="${selectCanChoicePathNodeId!=null}">checked="checked"</c:if> />可以选择条件同步路径</label>&nbsp;
					<select  <c:if test="${selectCanChoicePathNodeId==null}">class="hidden"</c:if> id="canChoicePathNodeId">
						<c:forEach items="${incomeNodes}" var="incomeNode">
							<option value="${incomeNode.nodeId}">${incomeNode.nodeName}</option>
						</c:forEach>
					</select>
				</c:if>
				
				<c:forEach items="${incomeNodes}" var="inNode">
					<div style="padding: 4px;">
						<c:choose>
							<c:when test="${inNode.isMultiple==true}">
								<a href="#" name="signResult"
									result='signResult_${inNode.nodeId}=="pass"'>[${inNode.nodeName}]投票通过</a>
											&nbsp;
											<a href="#" name="signResult"
									result='signResult_${inNode.nodeId}=="refuse"'>[${inNode.nodeName}]投票不通过</a>
							</c:when>
							<c:otherwise>
								<a href="#" name="signResult"
									result="approvalStatus_${inNode.nodeId}==1">[${inNode.nodeName}]-通过</a>
											&nbsp;
											<a href="#" name="signResult"
									result="approvalStatus_${inNode.nodeId}==2">[${inNode.nodeName}]-反对</a>
							</c:otherwise>
						</c:choose>
						<ul style="list-style:none;margin: 5px;padding: 0px;">
							<li>1.先选中下方的脚本输入框，然后再插入条件表达式。</li>
							<li>2.表达式中不能有分号或return语句。</li>
						</ul>
													
					</div>
				</c:forEach>				
				
            </td>
		</tr>
		
		<c:forEach items="${outcomeNodes}" var="outNode">
			<tr class="taskTr">
				<th width="20%">
					 ${outNode.nodeName }
				</th>
				<td style="background-color: #ffffff;">
					<input type="hidden" name="task" value="${outNode.nodeId}" />
					<textarea id="${outNode.nodeId}" codemirror="true" mirrorheight="110px" name="condition" rows="6" style="width:100%;" class="inputText">${outNode.condition}</textarea>
				</td>
			</tr>
		</c:forEach>
		
</table>
</body>
</t:formvalid>
</html>
