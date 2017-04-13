<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>

<style type="text/css">
td {
    height: 17px;
}
</style>
<script type="text/javascript">

$(function() {
	changeScope();
});


// 清空
function resetForm(){
	$('#formobj')[0].reset();
}

// 改变作用域
function changeScope(){
	var s = $("#varScope").val();
		if(s == 'task'){
			$("#sub").show();
		}else{
			$("#sub").hide();
		}
}

// 保存
function save(){
	$('#btn_sub').click();
}

function callbackForm(data){
	
	
	layer.msg(data.msg);
	
	if(data.success){
		reloadDefVar();
		$('#east').empty();
	}
	
}

</script>

<div style="height: 25px;" class="datagrid-toolbar">
  <a group="" id="addColumnBtn" class="easyui-linkbutton l-btn l-btn-small" data-options="iconCls:'icon-save'" onclick="save();" href="#">
      <span>保存</span>
  </a>
 <!--  <a group="" id="delColumnBtn" class="easyui-linkbutton l-btn l-btn-small" data-options="iconCls:'icon-remove'" onclick="resetForm();" href="#">
      <span>清空</span>
  </a> -->
</div>
<t:formvalid formid="formobj" layout="table" dialog="false" styleClass="formvalid" callback="callbackForm" action="bpmDefinitionController.do?saveDefVar">
<table style="width: 100%;" cellpadding="0" cellspacing="1" class="formtable">
		<tr>
			<td align="right" width="25%" nowrap>
                <label class="Validform_label">  变量名称:  </label>
            </td>
			<td class="value" width="85%">
                <input type="text" id="varName" name="varName" value="${bpmDefVar.varName}"  class="inputxt" datatype="*"/>
            </td>
		</tr>
		<tr>
			<td align="right" width="25%" nowrap>
                <label class="Validform_label">  变量Key:  </label>
            </td>
			<td class="value" width="85%">
				<input type="text" id="varKey" name="varKey" value="${bpmDefVar.varKey}"  class="inputxt" datatype="*"/>
            </td>
		</tr>
		<tr>
			<td align="right" width="25%" nowrap>
                <label class="Validform_label">   数据类型:  </label>
            </td>
			<td class="value" width="85%">
				<select name="varDataType"  >
					<option value="string" <c:if test="${bpmDefVar.varDataType eq 'string'}">selected='selected'</c:if>>字符串(string)</option>
					<option value="short" <c:if test="${bpmDefVar.varDataType eq 'short'}">selected='selected'</c:if>>短整形(short)</option>
					<option value="int" <c:if test="${bpmDefVar.varDataType eq 'int'}">selected='selected'</c:if>>整形(integer)</option>
					<option value="long" <c:if test="${bpmDefVar.varDataType eq 'long'}">selected='selected'</c:if>>长整型(long)</option>
					<option value="double" <c:if test="${bpmDefVar.varDataType eq 'double'}">selected='selected'</c:if>>浮点数(double)</option>
					<option value="date" <c:if test="${bpmDefVar.varDataType eq 'date'}">selected='selected'</c:if>>日期(date)</option>
				</select>
            </td>
		</tr>
		<tr>
			<td align="right" width="25%" nowrap>
                <label class="Validform_label">   作用域:  </label>
            </td>
			<td class="value" width="85%">
				<select name="varScope" id="varScope"  onchange="changeScope()" style="width:40%;">
					<option value="global" <c:if test="${bpmDefVar.varScope eq 'global'}">selected='selected'</c:if>>全局</option>
					<option value="task" <c:if test="${bpmDefVar.varScope eq 'task'}">selected='selected'</c:if>>局部</option>
				</select>
            </td>
		</tr>
		<tr id="sub">
			<td align="right" width="25%">
                <label class="Validform_label">   节点名称:  </label>
            </td>
			<td class="value" width="85%">
				<select id="nodeId" name="nodeId" style="width:40%;">
					<c:forEach items="${nodeMap}" var="node">
					<option value="${node.key},${node.value}"  <c:if test="${node.value==bpmDefVar.nodeName}">selected='selected'</c:if>>${node.value}</option>
					</c:forEach>
				</select>
            </td>
		</tr>
		<input type="hidden" name="varId"  id="varId" value="${bpmDefVar.varId}" />
		<input type="hidden" id="actDeployId" name="actDeployId" value="${actDeployId}"/>
		<input type="hidden" id="defId" name="defId" value="${defId}"  />
		<input type="hidden" class="btn_sub" id="btn_sub">
		
</table>
</t:formvalid>

<t:base type="easyui"></t:base>
