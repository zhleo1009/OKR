<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
 <head>
  <title>用户资料</title>
  <t:base type="jquery,easyui,tools,DatePicker"></t:base>
  <script type="text/javascript">
  //编写自定义JS代码
  </script>
 </head>
 <body>
		<t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" action="userInfoController.do?doUpdate" tiptype="lte" >
					<input id="id" name="id" type="hidden" value="${userInfoPage.id }">
					<input id="createName" name="createName" type="hidden" value="${userInfoPage.createName }">
					<input id="createBy" name="createBy" type="hidden" value="${userInfoPage.createBy }">
					<input id="createDate" name="createDate" type="hidden" value="${userInfoPage.createDate }">
					<input id="updateName" name="updateName" type="hidden" value="${userInfoPage.updateName }">
					<input id="updateBy" name="updateBy" type="hidden" value="${userInfoPage.updateBy }">
					<input id="updateDate" name="updateDate" type="hidden" value="${userInfoPage.updateDate }">
					<input id="userId" name="userId" type="hidden" value="${userInfoPage.userId }">
		<table style="width: 100%;" cellpadding="0" cellspacing="1" class="formtable">
					<tr>
						<td align="right"  width="25%"  nowrap>
							<label class="Validform_label">
								学历:
							</label>
						</td>
						<td class="value" nowrap>
									<t:dictSelect field="education" type="list"
										typeGroupCode="education" defaultVal="${userInfoPage.education}" hasLabel="false"  title="学历"></t:dictSelect>     
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">学历</label>
						</td>
					</tr>
					<tr>
						<td align="right"  width="25%"  nowrap>
							<label class="Validform_label">
								毕业院校:
							</label>
						</td>
						<td class="value" nowrap>
						     	 <input id="university" name="university" type="text" style="width: 150px" class="inputxt"  value='${userInfoPage.university}'>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">毕业院校</label>
						</td>
					</tr>
					<tr>
						<td align="right"  width="25%"  nowrap>
							<label class="Validform_label">
								住址:
							</label>
						</td>
						<td class="value" nowrap>
						     	 <input id="address" name="address" type="text" style="width: 300px" class="inputxt"  value='${userInfoPage.address}'>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">住址</label>
						</td>
					</tr>
					<tr>
						<td align="right"  width="25%"  nowrap>
							<label class="Validform_label">
								籍贯:
							</label>
						</td>
						<td class="value" nowrap>
						     	 <input id="origin" name="origin" type="text" style="width: 150px" class="inputxt"  value='${userInfoPage.origin}'>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">籍贯</label>
						</td>
					</tr>
					<tr>
						<td align="right"  width="25%"  nowrap>
							<label class="Validform_label">
								婚姻状态:
							</label>
						</td>
						<td class="value" nowrap>
									<t:dictSelect field="maritalStatus" type="list"
										typeGroupCode="marital" defaultVal="${userInfoPage.maritalStatus}" hasLabel="false"  title="婚姻状态"></t:dictSelect>     
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">婚姻状态</label>
						</td>
					</tr>
					<tr>
						<td align="right"  width="25%"  nowrap>
							<label class="Validform_label">
								性别:
							</label>
						</td>
						<td class="value" nowrap>
									<t:dictSelect field="sex" type="radio"
										typeGroupCode="sex" defaultVal="${userInfoPage.sex}" hasLabel="false"  title="性别"></t:dictSelect>     
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">性别</label>
						</td>
					</tr>
					<tr>
						<td align="right"  width="25%"  nowrap>
							<label class="Validform_label">
								身高(cm):
							</label>
						</td>
						<td class="value" nowrap>
						     	 <input id="height" name="height" type="text" style="width: 150px;line-height:24px;height:28px;"  class="input easyui-numberbox" min="0.01"  max="250" precision="2"   value='${userInfoPage.height}'>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">身高</label>
						</td>
					</tr>
					<tr>
						<td align="right"  width="25%"  nowrap>
							<label class="Validform_label">
								体重（kg）:
							</label>
						</td>
						<td class="value" nowrap>
						     	 <input id="weight" name="weight" type="text" style="width: 150px;line-height:24px;height:28px;"  class="input easyui-numberbox" min="0.01"  max="200" precision="2"   value='${userInfoPage.weight}'>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">体重</label>
						</td>
					</tr>
					<tr>
						<td align="right"  width="25%"   nowrap>
							<label class="Validform_label">
								自我介绍:
							</label>
						</td>
						<td class="value" nowrap>
						  	 	<textarea id="introduction" style="width:300px;height:50px;" class="inputxt" rows="6" name="introduction">${userInfoPage.introduction}</textarea>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">自我介绍</label>
						</td>
						
					</tr>
			</table>
			
		</t:formvalid>
 </body>
  <script src = "webpage/com/jeecg/userinfo/userInfo.js"></script>		
