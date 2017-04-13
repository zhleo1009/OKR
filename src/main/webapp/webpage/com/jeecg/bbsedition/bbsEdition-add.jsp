<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
 <head>
  <title>论坛板块</title>
  <t:base type="jquery,easyui,tools,DatePicker"></t:base>
  <script type="text/javascript">
  //编写自定义JS代码
  </script>
 </head>
 <body>
  <t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" action="bbsEditionController.do?doAdd" tiptype="4" >
					<input id="id" name="id" type="hidden" value="${bbsEditionPage.id }">
					<input id="createName" name="createName" type="hidden" value="${bbsEditionPage.createName }">
					<input id="createBy" name="createBy" type="hidden" value="${bbsEditionPage.createBy }">
					<input id="createDate" name="createDate" type="hidden" value="${bbsEditionPage.createDate }">
					<input id="updateName" name="updateName" type="hidden" value="${bbsEditionPage.updateName }">
					<input id="updateBy" name="updateBy" type="hidden" value="${bbsEditionPage.updateBy }">
					<input id="updateDate" name="updateDate" type="hidden" value="${bbsEditionPage.updateDate }">
					<input id="sysOrgCode" name="sysOrgCode" type="hidden" value="${bbsEditionPage.sysOrgCode }">
					<input id="sysCompanyCode" name="sysCompanyCode" type="hidden" value="${bbsEditionPage.sysCompanyCode }">
		<table style="width: 100%;" cellpadding="0" cellspacing="1" class="formtable">
				<tr>
					<td align="right"  width="25%"  nowrap>
						<label class="Validform_label">
							版块名称:
						</label>
					</td>
					<td class="value" nowrap>
					     	 <input id="name" name="name" type="text" style="width: 150px" class="inputxt"  datatype="*">
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">版块名称</label>
						</td>
						
				</tr>
				<tr>
					<td align="right"  width="25%"  nowrap>
						<label class="Validform_label">
							版块介绍:
						</label>
					</td>
					<td class="value" nowrap>
						  	 <textarea style="width:600px;" class="inputxt" rows="6" id="intro" name="intro"></textarea>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">版块介绍</label>
						</td>
						
				</tr>
				<tr>
					<td align="right"  width="25%"  nowrap>
						<label class="Validform_label">
							版块图标地址:
						</label>
					</td>
					<td class="value" nowrap>
					     	 <input id="logo" name="logo" type="text" style="width: 150px" class="inputxt" >
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">版块图标地址</label>
						</td>
						
				</tr>
				<tr>
					<td align="right"  width="25%"  nowrap>
						<label class="Validform_label">
							版块类型:
						</label>
					</td>
					<td class="value" nowrap>
							  <t:dictSelect field="type" type="list"
									typeGroupCode="" defaultVal="${bbsEditionPage.type}" hasLabel="false"  title="版块类型"></t:dictSelect>     
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">版块类型</label>
						</td>
						
				</tr>
			</table>
		</t:formvalid>
 </body>
  <script src = "webpage/com/jeecg/bbsedition/bbsEdition.js"></script>		
