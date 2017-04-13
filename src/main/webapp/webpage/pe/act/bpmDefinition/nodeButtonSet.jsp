<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>表单设置</title>
<t:base type="jquery,easyui,tools"></t:base>

<script type="text/javascript">

$(function(){
	if('${msg}'){
		layer.msg('${msg}');
	}
});

// 初始化所有按钮
function initAllBtn(){
	
	top.layer.confirm('确认初始化所有按钮设置吗？', function(index){
		window.location.href = 'bpmDefinitionController.do?initAllNodeBtn&defId=${defId}';
		top.layer.close(index);
	});

	
}

// 清除按钮设置
function resetAllBtn(){
	
	top.layer.confirm('确认清除所有按钮设置吗？', function(index){
		window.location.href = 'bpmDefinitionController.do?resetAllNodeBtn&defId=${defId}';
		top.layer.close(index);
	});
	
}

// 提交表单
function save(){
	$('#formobj')[0].submit();
}

</script>

</head>
<body style="overflow-y: hidden;margin-top: 2px;" scroll="no">


<!-- 工具栏 -->
<div style="height: 25px;margin-bottom: 2px;" class="datagrid-toolbar">
  <a group="" id="addColumnBtn" class="easyui-linkbutton l-btn l-btn-small" data-options="iconCls:'icon-add'" onclick="initAllBtn();" href="#">
      <span>初始化全部按钮</span>
  </a>
  <a group="" id="delColumnBtn" class="easyui-linkbutton l-btn l-btn-small" data-options="iconCls:'icon-remove'" onclick="resetAllBtn();" href="#">
      <span>清除按钮配置</span>
  </a>
</div>

	
<t:formvalid formid="formobj" layout="table" dialog="false" styleClass="formvalid" >
<input type="hidden" name="defId" value="${bpmDefinition.defId}"/>
<table style="width: 100%" cellpadding="0" cellspacing="1" class="formtable">
		<tr>
			<td align="right" width="15%" nowrap>
                <label class="Validform_label">  流程启动表单: </label>
            </td>
			<td class="value" width="85%">
                <c:set var="btnList" value="${btnMap.start}"></c:set>
				<c:choose>
					<c:when test="${empty btnList }">
						启动流程,流程示意图,打印,通知方式【短信，邮件】
					</c:when>
					<c:otherwise>
						<c:forEach items="${btnList}" var="btn" varStatus="status" >
							${btn.btnname}<c:if test="${!status.last}">,</c:if>
						</c:forEach>
					</c:otherwise>
				</c:choose>
            </td>
		</tr>
	</tr>	
</table>


<table style="height: 25px;width: 100%" id="tab_div_database_title">
    <tbody>
     <tr bgcolor="#E6E6E6">
		<th bgcolor="#EEEEEE" align="center" style="width: 5%;">序号</th>
		<th bgcolor="#EEEEEE" align="center" style="width: 10%;">节点名</th>
		<th bgcolor="#EEEEEE" align="center" style="width: 10%;">类型</th>
		<th bgcolor="#EEEEEE" align="center" style="width: 75%;">操作按钮</th>
	 </tr>
	</tbody>
</table>

<div id="t_table_database" class="t_table" style="height: 300px;">
   <table class="table-list" id="tab_div_database" style="width: 100%">
    <tbody class="ui-sortable">
    <c:forEach items="${bpmNodeSetList}" var="item" varStatus="status">
     <tr>
        <td style="width: 5%;"  align="center">
	      	${status.index +1}
      	</td>
      	<td style="width: 10%;"  align="center">
	      <input type="hidden" name="nodeId" value="${item.nodeId}"/>
		  <input type="hidden" name="nodename" value="${item.nodeName}"/>${item.nodeName}
      	</td>
      	<td style="width: 10%;" align="center">
      		<c:choose>
				<c:when test="${taskMap[item.nodeId]==1 }"><span style="color: red;font-weight: bold;">会签</span> </c:when>
				<c:otherwise><span style="color: green;font-weight: bold;">普通节点</span></c:otherwise>
			</c:choose>
      	</td>
      	<td style="width: 75%;" align="center">
      		<c:set var="btnList" value="${btnMap[item.nodeId] }"></c:set>
			<c:choose>
				<c:when test="${empty btnList }">
					完成任务,交办,驳回,驳回到发起人,流程执行示意图,审批历史,打印,通知方式【短信，邮件】
				</c:when>
				<c:otherwise>
					<c:forEach items="${btnList}" var="btn" varStatus="status" >
						${btn.btnname}<c:if test="${!status.last}">,</c:if>
					</c:forEach>
				</c:otherwise>
			</c:choose>
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
