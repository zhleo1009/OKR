<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
 <head>
  <title>员工日程计划</title>
  <t:base type="jquery,easyui,tools,DatePicker"></t:base>
  <script type="text/javascript">
  //编写自定义JS代码
  	//关闭按钮
		 function cancelForm() { 
			frameElement.api.close(); 

			 } 
		
		
	
  </script>
 </head>
 <body>
		<t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" action="scOkrController.do?goDetail" tiptype="4" >
					<input id="id" name="id" type="hidden" value="${scOkrPage.id }">
					<input id="createName" name="createName" type="hidden" value="${scOkrPage.createName }">
					<input id="createBy" name="createBy" type="hidden" value="${scOkrPage.createBy }">
					<input id="createDate" name="createDate" type="hidden" value="${scOkrPage.createDate }">
					<input id="updateName" name="updateName" type="hidden" value="${scOkrPage.updateName }">
					<input id="updateBy" name="updateBy" type="hidden" value="${scOkrPage.updateBy }">
					<input id="sysOrgCode" name="sysOrgCode" type="hidden" value="${scOkrPage.sysOrgCode }">
					<input id="sysCompanyCode" name="sysCompanyCode" type="hidden" value="${scOkrPage.sysCompanyCode }">
					<input id="bpmStatus" name="bpmStatus" type="hidden" value="${scOkrPage.bpmStatus }">
					<input id="userId" name="userId" type="hidden" value="${scOkrPage.userId }">
					
					
		<table style="width: 100%;" cellpadding="0" cellspacing="1" class="formtable">
					<tr>
						<td align="right"  width="25%"  nowrap>
							<label class="Validform_label">
								关键目标:
							</label>
						</td>
						<td class="value" nowrap>
						${scOkrPage.objective}
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">关键目标</label>
						</td>
					</tr>
					<tr>
						<td align="right"  width="25%"  nowrap>
							<label class="Validform_label">
								关键结果:
							</label>
						</td>
						<td class="value" nowrap>
						${scOkrPage.keyResult}
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">关键结果</label>
						</td>
					</tr>
					<tr>
						<td align="right"  width="25%"  nowrap>
							<label class="Validform_label">
								任务:
							</label>
						</td>
						<td class="value" nowrap>
					${scOkrPage.mission}
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">任务</label>
						</td>
					</tr>
					<tr>
						<td align="right"  width="25%"  nowrap>
							<label class="Validform_label">
								计划完成时间:
							</label>
						</td>
						<td class="value" nowrap>
					${scOkrPage.planTime}
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">计划完成时间</label>
						</td>
					</tr>
					<tr>
						<td align="right"  width="25%"  nowrap>
							<label class="Validform_label">
								执行难点:
							</label>
						</td>
						<td class="value" nowrap>
						${scOkrPage.difficulties}
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">执行难点</label>
						</td>
					</tr>
					<tr>
						<td align="right"  width="25%"  nowrap>
							<label class="Validform_label">
								OKR完成程度:
							</label>
						</td>
						<td class="value" nowrap>
						  ${scOkrPage.percent}
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">OKR完成程度</label>
						</td>
					</tr>
					<tr>
						<td align="right"  width="25%"  nowrap>
							<label class="Validform_label">
								未完成原因:
							</label>
						</td>
						<td class="value" nowrap>
						${scOkrPage.unfinishedReason}
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">未完成原因</label>
						</td>
					</tr>
					<tr>
						<td align="right"  width="25%"  nowrap>
							<label class="Validform_label">
								需协助部门:
							</label>
						</td>
						<td class="value" nowrap>
						     ${scOkrPage.needOrgCode}
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">需协助部门</label>
						</td>
					</tr>
					<tr>
						<td align="right"  width="25%"  nowrap>
							<label class="Validform_label">
								实际完成时间:
							</label>
						</td>
						<td class="value" nowrap>
						     	${scOkrPage.finishTime}
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">实际完成时间</label>
						</td>
					</tr>
			</table>
		</t:formvalid>
			<!-- 增加保存草稿按钮 -->
        <div style="text-align:center;margin-top: 5px;" >
			<a id="cancelBtn" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onClick="cancelForm()">关闭</a>
		</div>
 </body>
  <script src = "webpage/com/jeecg/scokr/scOkr.js"></script>	

