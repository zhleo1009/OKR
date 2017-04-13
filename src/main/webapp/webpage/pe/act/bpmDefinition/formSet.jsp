<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>表单设置</title>
<t:base type="jquery,easyui,tools"></t:base>

<script type="text/javascript">

/* $(function(){
	if('${msg}'){
		layer.msg('${msg}');
	}
}); */

// 全局设置change
function changeGlobalSelect(obj){
	
	var val = $(obj).find("option:selected").val();
	
	if(val == -1){
		$(obj).parent('td').next('td').find('div').hide();
	}else if(val == 1){
		$(obj).parent('td').next('td').find('div').show();
	}
	
}

// 提交表单
function save(){
	//$('#formobj')[0].submit();
	$('#btn_sub').click();
}

function callback(data){
	layer.msg(data.msg);
}

</script>

</head>
<body style="overflow-y: hidden;margin-top: 8px;" scroll="no">
	
<t:formvalid formid="formobj" layout="table" dialog="false" styleClass="formvalid" action="bpmDefinitionController.do?saveNodeSet" callback="callback">
<input type="hidden" class="btn_sub" id="btn_sub">
<input type="hidden" name="defId" value="${bpmDefinition.defId}"/>
<table style="width: 100%" cellpadding="0" cellspacing="1" class="formtable">
		<tr>
			<td align="right" width="15%" nowrap>
                <label class="Validform_label">  全局表单: </label>
            </td>
			<td class="value" width="15%" align="center">
                <select name="globalFormType" class="selectForm" style="width: 100px;" onchange="changeGlobalSelect(this)">
					<c:choose >
						<c:when test="${globalForm==null }">
							<option value="-1" selected="selected">请选择...</option>
							<option value="1" >URL表单</option>
						</c:when>
						<c:otherwise>
							<option value="-1" <c:if test="${globalForm.formType==-1 }">selected="selected"</c:if>>请选择...</option>
							<option value="1"  <c:if test="${globalForm.formType==1 }">selected="selected"</c:if>>URL表单</option>
						</c:otherwise>
					</c:choose>
				</select>
            </td>
            <td class="value" width="70%">
            
            	<div <c:if test="${globalForm==null}">style="display: none" </c:if>>
            		<input id="defaultFormKey" class="formKey"  type="hidden" name="defaultFormKey" value="${globalForm.formKey }" >
					<input id="defaultFormName" class="formDefName"  type="hidden" name="defaultFormName" value="${globalForm.formDefName }">
            		<div name="globalFormUrl" <c:if test="${globalForm!=null && globalForm.formType!=1 }">style="display: none" </c:if>>
						表单URL: <input type="text" name="formUrlGlobal" value="${globalForm.formUrl }" style="width: 80%;"/>
						<br/>
						明细URL: <input type="text" name="detailUrlGlobal" value="${globalForm.detailUrl }" style="width: 80%"/>
					</div>
					<input type="hidden" name="beforeHandlerGlobal" value="${globalForm.beforeHandler }"/>
					<input type="hidden" name="afterHandlerGlobal" value="${globalForm.afterHandler }"/>
            	</div>
            
            </td>
		</tr>
	</tr>	
</table>



<!-- 局部表单节点设置 -->

<table style="height: 25px;width: 100%" id="tab_div_database_title">
    <tbody>
     <tr bgcolor="#E6E6E6">
		<th bgcolor="#EEEEEE" align="center" style="width: 15%;">节点名</th>
		<th bgcolor="#EEEEEE" align="center" style="width: 15%;">表单类型</th>
		<th bgcolor="#EEEEEE" align="center" style="width: 70%;">表单URL</th>
	 </tr>
	</tbody>
</table>

<div id="t_table_database" class="t_table" style="height: 300px;">
   <table class="table-list" id="tab_div_database" style="width: 100%">
    <tbody class="ui-sortable">
    <c:forEach items="${bpmNodeSetList}" var="item">
     <tr>
        <td style="width: 15%;"  align="center">
	      	<input type="hidden" name="nodeId" value="${item.nodeId}"/>
			<input type="hidden" name="nodename" value="${item.nodeName}"/>
			<span>${item.nodeName}</span>
      	</td>
      	<td style="width: 15%;"  align="center">
	      	<select name="formType" class="selectForm"  style="width: 100px;" onchange="changeGlobalSelect(this)">
				<option value="-1" <c:if test="${item.formType==-1}">selected</c:if>>请选择..</option>
				<option value="1" <c:if test="${item.formType==1}">selected</c:if>>URL表单</option>
			</select>
      	</td>
      	<td style="width: 70%;">
      		<div <c:if test="${item.formType==-1}">style="display:none"</c:if>>
      			<div <c:if test="${item!=null && item.formType!=1 }">style="display: none" </c:if>>
					表单URL: <input type="text" name="formUrl" value="${item.formUrl }" class="inputText" style="width: 80%"/>
					<br/>
					明细URL: <input type="text" name="detailUrl" value="${item.detailUrl }" class="inputText" style="width: 80%"/>
				</div>
	      		<input type="hidden" name="formKey" value="${item.formKey}">
				<input type="hidden" name="formDefName" value="${item.formDefName}">
				<input type="hidden" name="tableId" value="${item.mainTableId }">
		      	<input type="hidden" name="beforeHandler" value="${item.beforeHandler}"/>
				<input type="hidden" name="afterHandler" value="${item.afterHandler}"/>
      		</div>
      	</td>
    </tr>
    </c:forEach>
	</tbody>
   </table>
 <br><br><br>
</div>

</t:formvalid>

</body>
</html>
