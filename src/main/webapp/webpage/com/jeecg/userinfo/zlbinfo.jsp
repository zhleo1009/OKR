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
		<t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" action="userInfoController.do?doUpdateZlb" tiptype="1" >
			<input id="id" name="id" type="hidden" value="${userinfo.id }">
			<input id="user_id" name="user_id" type="hidden" value="${userinfo.user_id }">
			<table style="width: 100%;" cellpadding="0" cellspacing="1" class="formtable">
				<tr>
					<td width="10%" align="right" nowrap>姓名：</td>
					<td width="15%" class="value" nowrap>${userinfo.realname }</td>
					<td width="10%" align="right" nowrap>部门：</td>
					<td width="15%" class="value" nowrap>${userinfo.departname }</td>
					<td width="10%" align="right" nowrap>名族：</td>
					<td width="15%" class="value" nowrap>${userinfo.mingzu }</td>
					<td width="10%" align="right" nowrap>身份证号：</td>
					<td width="15%" class="value" nowrap>${userinfo.sfz }</td>	
				</tr>
				<tr>
					<td width="10%" align="right" nowrap>性别：</td>
					<td width="15%" class="value" nowrap>
						<c:if test="${userinfo.sex eq '0'}">男</c:if>
						<c:if test="${userinfo.sex eq '1'}">女</c:if>
					</td>
					<td width="10%" align="right" nowrap>出生日期：</td>
					<td width="15%" class="value" nowrap>${userinfo.birthday }</td>	
					<td width="10%" align="right" nowrap>何时进入本单位：</td>
					<td width="15%" class="value" nowrap>${userinfo.create_date }</td>
					<td width="10%" align="right" nowrap></td>
					<td width="15%" class="value" nowrap></td>
					<td width="10%" align="right" nowrap></td>
					<td width="15%" class="value"></td>
				</tr>
				<tr>
					<td colspan="8" style="height:25px" class="value"></td>
				</tr>
				<tr>
					<td height="27px" width="10%" align="right" nowrap>职称：</td>
					<td width="15%" class="value" nowrap>
						<select style="height:25px" name="zhicheng" id="zhicheng" class="inputxt">
							<c:if test="${userinfo.zhicheng eq '1'}">
								<option value="1" selected="selected">工程师</option>
								<option value="2">助理工程师</option>
							</c:if>
							<c:if test="${userinfo.zhicheng eq '2'}">
								<option value="1">工程师</option>
								<option value="2" selected="selected">助理工程师</option>
							</c:if>
							<c:if test="${userinfo.zhicheng == null}">
								<option value="1">工程师</option>
								<option value="2" selected="selected">助理工程师</option>
							</c:if>
						</select>
					</td>
					<td width="10%" align="right" nowrap>技术职称：</td>
					<td width="15%" class="value" nowrap>
						<input type="text" value="${userinfo.jishuzhicheng }"  class="inputxt" name="jishuzhicheng" id="jishuzhicheng"></td>
					<td width="10%" align="right" nowrap></td>
					<td width="15%" class="value" nowrap></td>
					<td width="10%" align="right" nowrap></td>
					<td width="15%" class="value"></td>
				</tr>
				<tr>
					<td height="27px" width="10%" align="right" nowrap>第一后学历：</td>
					<td width="15%" class="value" nowrap>
						<input type="text" name="hxl1_xl" id="hxl1_xl"  class="inputxt" value="${userinfo.hxl1_xl }">
					</td>
					<td width="10%" align="right" nowrap>毕业院校：</td>
					<td width="15%" class="value" nowrap>
						<input type="text" name="hxl1_xx" id="hxl1_xx"  class="inputxt" value="${userinfo.hxl1_xx }">
					</td>
					<td width="10%" align="right" nowrap>所学专业：</td>
					<td width="15%" class="value" nowrap>
						<input type="text" name="hxl1_zy" id="hxl1_zy"  class="inputxt" value="${userinfo.hxl1_zy }">
					</td>
					<td width="10%" align="right" nowrap>毕业时间：</td>
					<td width="15%" class="value" nowrap>
						<input type="text" name="hxl1_sj" id="hxl1_sj"  onClick="WdatePicker()"  class="Wdate inputxt" value="${userinfo.hxl1_sj }">
					</td>
				</tr>
				<tr>
					<td height="27px" width="10%" align="right" nowrap>第二后学历：</td>
					<td width="15%" class="value" nowrap>
						<input type="text" name="hxl2_xl" id="hxl2_xl"  class="inputxt" value="${userinfo.hxl2_xl }">
					</td>
					<td width="10%" align="right" nowrap>毕业院校：</td>
					<td width="15%" class="value" nowrap>
						<input type="text" name="hxl2_xx" id="hxl2_xx"  class="inputxt" value="${userinfo.hxl2_xx }">
					</td>
					<td width="10%" align="right" nowrap>所学专业：</td>
					<td width="15%" class="value" nowrap>
						<input type="text" name="hxl2_zy" id="hxl2_zy"  class="inputxt" value="${userinfo.hxl2_zy }">
					</td>
					<td width="10%" align="right" nowrap>毕业时间：</td>
					<td width="15%" class="value" nowrap>
						<input type="text" name="hxl2_sj" id="hxl2_sj" onClick="WdatePicker()"  class="Wdate inputxt" value="${userinfo.hxl2_sj }">
					</td>
				</tr>
				<tr>
					<td height="27px" width="10%" align="right" nowrap>第三后学历：</td>
					<td width="15%" class="value" nowrap>
						<input type="text" name="hxl3_xl" id="hxl3_xl"  class="inputxt" value="${userinfo.hxl3_xl }">
					</td>
					<td width="10%" align="right" nowrap>毕业院校：</td>
					<td width="15%" class="value" nowrap>
						<input type="text" name="hxl3_xx" id="hxl3_xx"  class="inputxt" value="${userinfo.hxl3_xx }">
					</td>
					<td width="10%" align="right" nowrap>所学专业：</td>
					<td width="15%" class="value" nowrap>
						<input type="text" name="hxl3_zy" id="hxl3_zy"  class="inputxt" value="${userinfo.hxl3_zy }">
					</td>
					<td width="10%" align="right" nowrap>毕业时间：</td>
					<td width="15%" class="value" nowrap>
						<input type="text" name="hxl3_sj" id="hxl3_sj" onClick="WdatePicker()"   class="Wdate inputxt" value="${userinfo.hxl3_sj }">
					</td>
				</tr>
			</table>
			
		</t:formvalid>
		
		<script type="text/javascript">
			function goForm(){
				var zhicheng=$("#zhicheng").val();
				var jishuzhicheng=$("#jishuzhicheng").val();
				var hxl3_xl=$("#hxl3_xl").val();
				var hxl3_xx=$("#hxl3_xx").val();
				var hxl3_zy=$("#hxl3_zy").val();
				var hxl3_sj=$("#hxl3_sj").val();
				var hxl2_xl=$("#hxl3_xl").val();
				var hxl2_xx=$("#hxl3_xx").val();
				var hxl2_zy=$("#hxl3_zy").val();
				var hxl2_sj=$("#hxl3_sj").val();
				var hxl1_xl=$("#hxl3_xl").val();
				var hxl1_xx=$("#hxl3_xx").val();
				var hxl1_zy=$("#hxl3_zy").val();
				var hxl1_sj=$("#hxl3_sj").val();
				var id=$("#id").val();
				var returnData;
				$.ajax({
			        type: 'POST',
			        url: 'userInfoController.do?doUpdateZlb&r=' + Math.random(),
			        async: false,
			        data:
			        {	
			        	id:id,
			        	hxl3_xl:hxl3_xl,
			        	hxl3_xx:hxl3_xx,
			        	hxl3_zy:hxl3_zy,
			        	hxl3_sj:hxl3_sj,
			        	hxl2_xl:hxl2_xl,
			        	hxl2_xx:hxl2_xx,
			        	hxl2_zy:hxl2_zy,
			        	hxl2_sj:hxl2_sj,
			        	hxl1_xl:hxl1_xl,
			        	hxl1_xx:hxl1_xx,
			        	hxl1_zy:hxl1_zy,
			        	hxl1_sj:hxl1_sj,
			        	jishuzhicheng:jishuzhicheng,
			        	zhicheng:zhicheng
			        },
			        contentType: 'application/x-www-form-urlencoded; charset=utf-8',
			        dataType: 'json',
			        error:function(XMLHttpRequest, textStatus, errorThrown){
			        	returnData=new Object();
			        	returnData.msg="保存失败！";
			        },
			        success: function (data) {
			        	returnData=data;
			        }
			    });
			 return returnData;
			}
		
		</script>
 </body>
