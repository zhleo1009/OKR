<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<%@taglib prefix="f" uri="http://www.pe.cn/functions" %>
<t:base type="jquery,easyui,tools"></t:base>
<!DOCTYPE html>
<html>
<head>
<title>会签规则</title>
<style type="text/css">
td {
    height: 17px;
}
</style>

<script type="text/javascript" src="pe/js/javacode/codemirror.js"></script>
<script type="text/javascript" src="pe/js/javacode/InitMirror.js"></script>

<script type="text/javascript">

$(function(){
	
	$("input[name=voteType]").click(function(){
		var val=$(this).val();
		if(val=="2")
			$("#voteAmoutTips").html("输入整数票数。");
		else
			$("#voteAmoutTips").html("例:输入50则表示50%。");
	});
	
});

function save(){
	$("#btn_sub").click();
}

// 回调函数
function callback(data){
	layer.msg(data.msg);
}
	
</script>

</head>

<body style="margin: 2px;">
<div style="height: 25px;" class="datagrid-toolbar">
  <a group="" id="addColumnBtn" class="easyui-linkbutton l-btn l-btn-small" data-options="iconCls:'icon-save'" onclick="save()" href="#">
      <span>保存</span>
  </a>
</div>

<t:formvalid formid="formobj" layout="table" dialog="false" styleClass="formvalid" action="bpmDefinitionController.do?saveCounterSign" callback="callback">
 <input type="hidden" class="btn_sub" id="btn_sub">
 <table style="width: 100%;" cellpadding="0" cellspacing="1" class="formtable">
		<tr>
			<td align="right" width="25%" nowrap>
                <label class="Validform_label">  决策方式:  </label>
            </td>
			<td class="value" width="85%">
				<c:choose>
					<c:when test="${bpmNodeSign.signId==0}">
						<input type="radio" value="1" name="decideType" checked="checked" />通过
						<input type="radio" value="2" name="decideType"  />拒绝
					</c:when>
					<c:otherwise>
						<input type="radio" value="1" name="decideType" <c:if test="${bpmNodeSign.decideType==1}">checked="checked"</c:if>  />通过
						<input type="radio" value="2" name="decideType" <c:if test="${bpmNodeSign.decideType==2}">checked="checked"</c:if> />拒绝
					</c:otherwise>
				</c:choose>
            </td>
         </tr>  
         <tr>
            <td align="right" width="25%" nowrap>
                <label class="Validform_label">  后续处理模式:  </label>
            </td>
			<td class="value" width="85%">
			
				<c:choose>
					<c:when test="${bpmNodeSign.signId==0}">
						<input type="radio" value="1" name="flowMode" checked="checked" />直接处理
						<input type="radio" value="2" name="flowMode"  />等待所有人投票
					</c:when>
					<c:otherwise>
						<input type="radio" value="1" name="flowMode" <c:if test="${bpmNodeSign.flowMode==1}">checked="checked"</c:if>  />直接处理
						<input type="radio" value="2" name="flowMode" <c:if test="${bpmNodeSign.flowMode==2}">checked="checked"</c:if> />等待所有人投票
					</c:otherwise>
				</c:choose>

            </td>
          </tr> 
          <tr>  
            <td align="right" width="25%" nowrap>
                <label class="Validform_label">  投票类型:  </label>
            </td>
			<td class="value" width="85%">
			
				<c:choose>
					<c:when test="${bpmNodeSign.signId==0}">
						<input type="radio" value="2" name="voteType" checked="checked" />绝对票数
						<input type="radio" value="1" name="voteType"  />百分比
						
					</c:when>
					<c:otherwise>
						<input type="radio" value="2" name="voteType" <c:if test="${bpmNodeSign.voteType==2}">checked="checked"</c:if> />绝对票数
						<input type="radio" value="1" name="voteType" <c:if test="${bpmNodeSign.voteType==1}">checked="checked"</c:if>  />百分比

					</c:otherwise>
				</c:choose>

            </td>
           </tr>
            
           <tr> 
             <td align="right" width="25%" nowrap>
                <label class="Validform_label">  票数:  </label>
            </td>
			<td class="value" width="85%">
				<input type="text" id="voteAmount" name="voteAmount" value="${bpmNodeSign.voteAmount}"  class="inputText" datatype="/(^[1-9][0-9]$)|(100)|(^[1-9]$)$/i" errormsg="请输入1到100之间的正整数！" />
				<span id="voteAmoutTips">提示：
					<c:if test="${bpmNodeSign.voteType==0||bpmNodeSign.voteType==2}">输入整数票数。</c:if>
					<c:if test="${bpmNodeSign.voteType==1}">例:输入50则表示50%。</c:if>
				</span>
            </td>
		</tr>
</table>


<%-- 暂时不提供该功能，后期添加 --%>
<div  style="display: none;">
<table>
		<thead>
		<tr>
			<th width="80" nowrap="nowrap">特权类型</th>
			<th width="98" nowrap="nowrap">用户类型</th>
			<th width="*" nowrap="nowrap">用户来自</th>
		</tr>
		</thead>
		<tbody>
				<c:forEach items="${modeList}" var="text" varStatus="i">
					<c:set var="bpmNodePrivilege" value="${bpmNodePrivilegeList[i.index]}"/>
					<tr>
						<td nowrap="nowrap" height="28">
							${text}
						</td>
						<td>
							<select name="userType" class="select" onchange="">
								<option value="1" ${bpmNodePrivilege.usertype==1 ? 'selected="selected"' : ''}>用户</option>
								<option value="3" ${bpmNodePrivilege.usertype==3 ? 'selected="selected"' : ''}>组织</option>
								<option value="4" ${bpmNodePrivilege.usertype==4 ? 'selected="selected"' : ''}>组织负责人</option>
								<option value="7" ${bpmNodePrivilege.usertype==7 ? 'selected="selected"' : ''}>用户属性</option>
								<option value="12" ${bpmNodePrivilege.usertype==12 ? 'selected="selected"' : ''}>脚本</option>												
							</select>
						</td>
						<td>
							<input type="hidden" name="cmpIds" value='${bpmNodePrivilege.cmpids}'/>
							<c:choose>
								<c:when test="${bpmNodePrivilege.usertype==0}">
									流程发起人<textarea name="cmpNames" style="width:80%;display:none;" rows="3" class="textarea">${bpmNodePrivilege.cmpnames}</textarea>
									<!-- <a class="button" onclick="selectCmp(this);" style="display:none;"><span>选择...</span></a> -->
								</c:when>
								<c:when test="${bpmNodePrivilege.usertype==9}">
									与发起人相同部门<textarea name="cmpNames" style="width:80%;display:none;" rows="3" class="textarea">${bpmNodePrivilege.cmpnames}</textarea>
									<!-- <a class="button" onclick="selectCmp(this);" style="display:none;"><span>选择...</span></a> -->
								</c:when>
								<c:when test="${bpmNodePrivilege.usertype==11}">
									发起人的直属领导(组织)<textarea name="cmpNames" style="width:80%;display:none;" rows="3" class="textarea">${bpmNodePrivilege.cmpnames}</textarea>
									<!-- <a class="button" onclick="selectCmp(this);" style="display:none;"><span>选择...</span></a> -->
								</c:when>
								<c:when test="${bpmNodePrivilege.usertype==13}">
									上个任务执行人的直属领导(组织)<textarea name="cmpNames" style="width:80%;display:none;" rows="3" class="textarea">${bpmNodePrivilege.cmpnames}</textarea>
									<!-- <a class="button" onclick="selectCmp(this);" style="display:none;"><span>选择...</span></a> -->
								</c:when>
								<c:when test="${bpmNodePrivilege.usertype==14}">
									发起人的领导<textarea name="cmpNames" style="width:80%;display:none;" rows="3" class="textarea">${bpmNodePrivilege.cmpnames}</textarea>
									<!-- <a class="button" onclick="selectCmp(this);" style="display:none;"><span>选择...</span></a> -->
								</c:when>
								<c:when test="${bpmNodePrivilege.usertype==15}">
									上个任务执行人的领导<textarea name="cmpNames" style="width:80%;display:none;" rows="3" class="textarea">${bpmNodePrivilege.cmpnames}</textarea>
									<!-- <a class="button" onclick="selectCmp(this);" style="display:none;"><span>选择...</span></a> -->
								</c:when>
								
								<c:otherwise>
									<textarea name="cmpNames" readonly="readonly" style="width:80%;visibility:visible" rows="2" class="textarea">${bpmNodePrivilege.cmpnames}</textarea>
									<!-- <a class="button" onclick="selectCmp(this);" style="visibility:visible"><span>选择...</span></a> -->
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
				</c:forEach>
		</tbody>
	</table>
</div>

<input type="hidden" name="signId" value="${bpmNodeSign.signId}" />
<input type="hidden" id="nodeId" name="nodeId" value="${bpmNodeSign.nodeId}"/>
<input type="hidden" id="actDefId" name="actDefId" value="${bpmNodeSign.actDefId}" />
</t:formvalid>
</body>
</html>