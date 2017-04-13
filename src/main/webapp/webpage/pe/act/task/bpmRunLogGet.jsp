<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<t:base type="jquery,easyui,tools"></t:base>

<style type="text/css">

.formvalid{
	padding: 0px 5px;
}

td{
	height: 17px;
}

</style>
</head>
<body>
<t:formvalid formid="formobj" layout="table" dialog="false" styleClass="formvalid">
<table style="width: 100%" cellpadding="0" cellspacing="1" class="formtable">
		<tr>
			<td align="right" width="25%" nowrap>
                <label class="Validform_label"> 
                
                
流程运行ID:  </label>
            </td>
			<td class="value" width="85%">
            ${bpmRunLog.runid}
            </td>
		</tr>
		<tr>
			<td align="right" width="25%" nowrap>
                <label class="Validform_label">
                
            流程标题: </label>
            </td>
			<td class="value" width="85%">
             ${bpmRunLog.processSubject}
            </td>
		</tr>
		
		<tr>
			<td align="right" width="25%" nowrap>
                <label class="Validform_label">   用户名称: </label>
            </td>
			<td class="value" width="85%">
              ${bpmRunLog.username}
            </td>
		</tr>
		
			<tr>
			<td align="right" width="25%">
                <label class="Validform_label"> 操作时间: </label>
            </td>	
			<td class="value" width="85%">
              
               <fmt:formatDate value="${bpmRunLog.createtime}" pattern="yyyy-MM-dd HH:mm:ss"/> 
            </td>
		</tr>
		
		
			<tr>
			<td align="right" width="25%">
                <label class="Validform_label">   操作类型: </label>
            </td>	
			<td class="value" width="85%">
            	<c:choose>
								<c:when test="${bpmRunLog.operatortype eq 0}"><span class="green">启动流程</span></c:when>
								<c:when test="${bpmRunLog.operatortype eq 1}"><span class="green">交办</span></c:when>
								<c:when test="${bpmRunLog.operatortype eq 2}"><span class="red">追回</span></c:when>
								<c:when test="${bpmRunLog.operatortype eq 3}"><span class="red">删除流程实例</span></c:when>
								<c:when test="${bpmRunLog.operatortype eq 4}"><span class="green">同意(投票)</span></c:when>
								<c:when test="${bpmRunLog.operatortype eq 5}"><span class="red">反对(投票)</span></c:when>
								<c:when test="${bpmRunLog.operatortype eq 6}"><span class="green">弃权(投票)</span></c:when>
								<c:when test="${bpmRunLog.operatortype eq 7}"><span class="green">补签</span></c:when>
								<c:when test="${bpmRunLog.operatortype eq 8}"><span class="red">驳回</span></c:when>
								<c:when test="${bpmRunLog.operatortype eq 9}"><span class="red">驳回到发起人</span></c:when>
								<c:when test="${bpmRunLog.operatortype eq 10}"><span class="red">删除任务</span></c:when>
								<c:when test="${bpmRunLog.operatortype eq 11}"><span class="green">代理任务</span></c:when>
								<c:when test="${bpmRunLog.operatortype eq 13}"><span class="green">锁定任务</span></c:when>
								<c:when test="${bpmRunLog.operatortype eq 14}"><span class="green">任务解锁</span></c:when>
								<c:when test="${bpmRunLog.operatortype eq 15}"><span class="green">添加意见</span></c:when>
								<c:when test="${bpmRunLog.operatortype eq 16}"><span class="green">任务指派</span></c:when>
								<c:when test="${bpmRunLog.operatortype eq 17}"><span class="green">设定所有人</span></c:when>
								<c:when test="${bpmRunLog.operatortype eq 18}"><span class="green">结束任务</span></c:when>
								<c:otherwise><span class="red">其他</span></c:otherwise>
							</c:choose>
            </td>
		</tr>
		
		
			<tr>
			<td align="right" width="25%">
                <label class="Validform_label"> 备注: </label>
            </td>	
			<td class="value" width="85%">
          		${bpmRunLog.memo}
            </td>
		</tr>
</table>
</t:formvalid>

</body>
</html>















