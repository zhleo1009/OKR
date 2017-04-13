<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<%
	String realPath=request.getContextPath();
%>
<!DOCTYPE html>
<html>
 <head>
  <title>用户资料</title>
  <t:base type="jquery,easyui,tools,DatePicker"></t:base>
  <script type="text/javascript">
  //编写自定义JS代码
  </script>
  <style type="text/css">
  	.back{
	    background-color: #ddd;
	    background-image: url(../images/tab_14.gif);
	    color: #333 !important;
	    font-family: "微软雅黑";
	    font-size: 12px;
	    padding: 2px 6px !important;
	    cursor: pointer !important;
	    border: 1px solid #D7EAFF !important;
	    margin-right: 4px !important;
	    width: auto !important;
  	}
  
  </style>
 </head>
 <body>
  <t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" action="userInfoController.do?updateUser" tiptype="4" >
	<input id="user_id" name="userId" type="hidden" value="${userinfo.user_id }">
	<input id="id" name="id" type="hidden" value="${userinfo.id }">
		<div class="easyui-panel" title="基本信息" style="padding:2px;margin: 0px;">
			<table style="width: 80%" cellpadding="0" cellspacing="1" class="formtable">
				<tr>
					<td width="10%" align="right" nowrap>姓名<span style="color:red">*</span>：</td>
					<td width="30%" class="value" nowrap>
						<input type="text" name="realname" datatype="*" class="inputxt" value="${userinfo.realname }"/>
						<span class="Validform_checktip"></span>
						 <label class="Validform_label" style="display: none;"></label>
					</td>
					<td width="10%" align="right" nowrap>部门：</td>
					<td width="30%" class="value" nowrap>${userinfo.departname }</td>
					<td width="30%" rowspan="13" class="value" style="text-align:center">
						<c:if test="${userinfo.picpath == null}">
							<img id="pic" width="90%" height="300px" src="plug-in/lte/dist/img/user2-160x160.jpg" class="img-circle" alt="User Image">
						</c:if>
						<c:if test="${userinfo.picpath != null}">
							<img id="pic" width="90%" height="300px" src="<%=realPath %>/${userinfo.picpath}" class="img-circle" alt="User Image">
						</c:if>
						<div style="padding-top:15px;">
							<input id="picTest" style="background-color: #fff;width:150px !important;border:1px solid #ddd;" name="picTest" type="file"  multiple/>
					     	<input type="hidden" id="picpath" value="${userinfo.picpath }" name="picpath" class="inputxt">
					      <!--   <input type="button" value="上传" onclick="picUpload()" class="hollowBtn"/> -->
					        <a class="easyui-linkbutton l-btn l-btn-small" onclick="picUpload()">
							<span class="l-btn-left l-btn-icon-left" style="padding:0px">
								<span class="l-btn-text">上传</span>
								<span class="l-btn-icon icon-ok"></span>
							</span>
						</a>
						</div>
					</td>
				</tr>
				<tr>
					<td width="10%" align="right" nowrap>性别<span style="color:red">*</span>：</td>
					<td width="30%" class="value" nowrap>
						<c:if test="${userinfo.sex eq '1' }">
							<input type="radio" name="sex" value="0">男
							<input type="radio" name="sex" checked="checked" value="1">女
						</c:if>
						<c:if test="${userinfo.sex eq '0' }">
							<input type="radio" name="sex" checked="checked" value="0">男
							<input type="radio" name="sex"  value="1">女
						</c:if>
						<c:if test="${userinfo.sex == null }">
							<input type="radio" name="sex" checked="checked" value="0">男
							<input type="radio" name="sex"  value="1">女
						</c:if>
					</td>
					<td width="10%" align="right" nowrap>出生日期<span style="color:red">*</span>：</td>
					<td width="30%" class="value" nowrap>
						<input class="Wdate inputxt" value="${userinfo.birthday }" datatype="*" onClick="WdatePicker()" name="birthday">
						<span class="Validform_checktip"></span>
						 <label class="Validform_label" style="display: none;"></label>
					</td>
				</tr>
				<tr>
					<td width="10%" align="right" nowrap>名族<span style="color:red">*</span>：</td>
					<td width="30%" class="value" nowrap>
						<input type="text" name="mingzu" class="inputxt" datatype="*" value="${userinfo.mingzu }"/>
						<span class="Validform_checktip"></span>
						 <label class="Validform_label" style="display: none;"></label>
					</td>
					<td width="10%" align="right" nowrap>身份证号<span style="color:red">*</span>：</td>
					<td width="30%" class="value" nowrap>
						<input type="text" name="sfz" class="inputxt" datatype="*" value="${userinfo.sfz }"/>
						<span class="Validform_checktip"></span>
						 <label class="Validform_label" style="display: none;"></label>
					</td>
				</tr>
				<tr>
					<td width="10%" align="right" nowrap>email：</td>
					<td width="30%" class="value" nowrap><input type="text" name="email" class="inputxt" value="${userinfo.email }"/></td>
					<td width="10%" align="right" nowrap>qq：</td>
					<td width="30%" class="value" nowrap><input type="text" name="qq" class="inputxt" value="${userinfo.qq }"/></td>
				</tr>
				<tr>
					<td width="10%" align="right" nowrap>婚姻状况<span style="color:red">*</span>：</td>
					<td width="30%" class="value" nowrap>
						<c:if test="${userinfo.marital_status eq 0 }">
							<input type="radio" name="maritalStatus" checked="checked" value="0"/>未婚
							<input type="radio" name="maritalStatus" value="1"/>已婚
						</c:if>
						<c:if test="${userinfo.marital_status == null }">
							<input type="radio" name="maritalStatus" checked="checked" value="0"/>未婚
							<input type="radio" name="maritalStatus" value="1"/>已婚
						</c:if>
						<c:if test="${userinfo.marital_status eq 1 }">
							<input type="radio" name="maritalStatus" value="0"/>未婚
							<input type="radio" name="maritalStatus" checked="checked" value="1"/>已婚
						</c:if>
					</td>
					<td width="10%" align="right" nowrap>政治面貌<span style="color:red">*</span>：</td>
					<td width="30%" class="value" nowrap>
						<input type="text" name="zzmm" class="inputxt" datatype="*" value="${userinfo.zzmm }"/>
						<span class="Validform_checktip"></span>
						 <label class="Validform_label" style="display: none;"></label>
					</td>
				</tr>
				<tr>
					<td width="10%" align="right" nowrap>入党时间&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>(如:2016-10)：</td>
					<td width="30%" class="value" nowrap><input type="text" name="rudangshijian" class="inputxt" value="${userinfo.rudangshijian }"/></td>
					<td width="10%" align="right" nowrap>籍贯<span style="color:red">*</span>：</td>
					<td width="30%" class="value" nowrap>
						<input type="text" name="origin" class="inputxt" datatype="*" value="${userinfo.origin }"/>
						<span class="Validform_checktip"></span>
						 <label class="Validform_label" style="display: none;"></label>
					</td>
				</tr>
				<tr>
					<td width="10%" align="right" nowrap>户口性质<span style="color:red">*</span>：</td>
					<td width="30%" class="value" nowrap>
						<c:if test="${userinfo.hukou eq 0 }">
							<input type="radio" name="hukou" checked="checked" value="0"/>城镇
							<input type="radio" name="hukou" value="1"/>农村
						</c:if>
						<c:if test="${userinfo.hukou == null }">
							<input type="radio" name="hukou" checked="checked" value="0"/>城镇
							<input type="radio" name="hukou" value="1"/>农村
						</c:if>
						<c:if test="${userinfo.hukou eq 1 }">
							<input type="radio" name="hukou" value="0"/>城镇
							<input type="radio" name="hukou" value="1" checked="checked" />农村
						</c:if>
					</td>
					<td width="10%" align="right" nowrap>户籍所在地<span style="color:red">*</span>：</td>
					<td width="30%" class="value" nowrap>
						<input type="text" name="hujisuozaidi" class="inputxt" datatype="*" value="${userinfo.hujisuozaidi }"/>
						<span class="Validform_checktip"></span>
						 <label class="Validform_label" style="display: none;"></label>
					</td>
				</tr>
				<tr>
					<td width="10%" align="right" nowrap>学历<span style="color:red">*</span>：</td>
					<td width="30%" class="value">
						<select name="education" class="inputxt" style="height:25px">
							<c:if test="${userinfo.education eq 1}">
								<option value="1" selected="selected">本科</option>
								<option value="2">大专</option>
								<option value="3">高中</option>
								<option value="5">硕士</option>
								<option value="6">博士</option>
							</c:if>
							<c:if test="${userinfo.education == null}">
								<option value="1" selected="selected">本科</option>
								<option value="2">大专</option>
								<option value="3">高中</option>
								<option value="5">硕士</option>
								<option value="6">博士</option>
							</c:if>
							<c:if test="${userinfo.education eq '2'}">
								<option value="1" >本科</option>
								<option value="2" selected="selected">大专</option>
								<option value="3">高中</option>
								<option value="5">硕士</option>
								<option value="6">博士</option>
							</c:if>
							<c:if test="${userinfo.education eq '3'}">
								<option value="1">本科</option>
								<option value="2">大专</option>
								<option value="3" selected="selected">高中</option>
								<option value="5">硕士</option>
								<option value="6">博士</option>
							</c:if>
							<c:if test="${userinfo.education eq '5'}">
								<option value="1">本科</option>
								<option value="2">大专</option>
								<option value="3">高中</option>
								<option value="5" selected="selected">硕士</option>
								<option value="6">博士</option>
							</c:if>
							<c:if test="${userinfo.education eq '6'}">
								<option value="1">本科</option>
								<option value="2">大专</option>
								<option value="3">高中</option>
								<option value="5">硕士</option>
								<option value="6" selected="selected">博士</option>
							</c:if>
						</select>
					</td>
					<td width="10%" align="right" nowrap>专业（工种）<span style="color:red">*</span>：</td>
					<td width="30%" class="value" nowrap>
						<input type="text" name="zhuanye" class="inputxt" datatype="*" value="${userinfo.zhuanye }"/>
						<span class="Validform_checktip"></span>
						 <label class="Validform_label" style="display: none;"></label>
					</td>
				</tr>
				<tr>
					<td width="10%" align="right" nowrap>手机号<span style="color:red">*</span>：</td>
					<td width="30%" class="value" nowrap>
						<input type="text" name="mobilephone" class="inputxt" datatype="*" value="${userinfo.mobilephone }"/>
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;"></label>
					</td>
					<td width="10%" align="right" nowrap>家庭联系电话<span style="color:red">*</span>：</td>
					<td width="30%" class="value" nowrap>
						<input type="text" name="homephone" class="inputxt" datatype="*" value="${userinfo.homephone }"/>
						<span class="Validform_checktip"></span>
						 <label class="Validform_label" style="display: none;"></label>
					</td>
				</tr>
				<tr>
					<td width="10%" align="right" nowrap>参加工作时间&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>(如:2016-10)：<span style="color:red">*</span>：</td>
					<td width="30%" class="value" nowrap>
						<input type="text" name="worktime" datatype="*" class="inputxt" value="${userinfo.worktime }"/>
						<span class="Validform_checktip"></span>
						 <label class="Validform_label" style="display: none;"></label>
					</td>
					<td width="10%" align="right" nowrap>进院前已在南京质检<br>系统工作年限(年)<span style="color:red">*</span>：</td>
					<td width="30%" class="value" nowrap>
						<input type="text" name="workyear" class="inputxt" datatype="*" value="${userinfo.workyear }"/>
						<span class="Validform_checktip"></span>
						 <label class="Validform_label" style="display: none;"></label>
					</td>
				</tr>
				<tr>
					<td width="10%" align="right" nowrap>原工作单位：</td>
					<td width="30%" class="value" nowrap><input type="text" name="oldcompany" class="inputxt" value="${userinfo.oldcompany }"/></td>
					<td width="10%" align="right" nowrap>原单位联系电话：</td>
					<td width="30%" class="value" nowrap><input type="text" name="oldcompanyphone" class="inputxt" value="${userinfo.oldcompanyphone }"/></td>
				</tr>
				<tr>
					<td width="10%" align="right" nowrap>原工作单位岗位：</td>
					<td width="30%" class="value" nowrap><input type="text" name="oldcompanyjob" class="inputxt" value="${userinfo.oldcompanyjob }"/></td>
					<td width="10%" align="right" nowrap>原单位证明人：</td>
					<td width="30%" class="value" nowrap><input type="text" name="oldcompanyperson" class="inputxt" value="${userinfo.oldcompanyperson }"/></td>
				</tr>
				<tr>
					<td width="10%" align="right" nowrap>家庭住址：</td>
					<td width="30%" class="value">
						<textarea style="height:50px" class="inputxt" rows="5" name="address">${userinfo.address }</textarea>
					<td width="10%" align="right" nowrap>备注：</td>
					<td width="30%" class="value">
						<textarea rows="5" style="height:50px" class="inputxt" name="baseinforemark">${userinfo.baseinforemark }</textarea>
					</td>
				</tr>
				<tr>
					<td width="10%" align="right" nowrap>附件：</td>
					<td width="85%" class="value" colspan="3">
						<input id="fileTest" style="display:none" onchange="changeVal()" name="fileTest" type="file"  multiple/>
				     	<input type="hidden" style="width:150px" id="basefilepath" name="basefilepath" class="inputxt" value="${userinfo.basefilepath }">
				     	<input onclick="fileClick()" value="${userinfo.basefilename }" readonly="readonly" style="width:150px" id="basefilename" name="basefilename" class="inputxt">
				    <!--  	<input type="button" value="上传" onclick="fileUpload()" class="hollowBtn"/> -->
				     	&nbsp;&nbsp;
				     	<a class="easyui-linkbutton l-btn l-btn-small" onclick="fileUpload()">
							<span class="l-btn-left l-btn-icon-left" style="padding:0px">
								<span class="l-btn-text">上传</span>
								<span class="l-btn-icon icon-ok"></span>
							</span>
						</a>
				     	&nbsp;&nbsp;
				     	<label id="base_filename">
				     		<a href="<%=realPath %>/claimMoneyFinanceController.do?downloadFile&fileName=${userinfo.basefilename }&filePath=${userinfo.basefilepath }">${userinfo.basefilename }</a>
						</label>
					</td>
				</tr>
			</table>
		</div>
			
		<div class="easyui-panel" title="配偶信息" style="padding:2px;margin: 0px;">
			<table style="width: 64%;" cellpadding="0" cellspacing="1" class="formtable">
				<tr>
					<td width="10%" align="right" nowrap>姓名：</td>
					<td width="30%" class="value" nowrap>
						<input type="text" name="lovename" class="inputxt" value="${userinfo.lovename }"/>
					</td>
					<td width="10%" align="right" nowrap>出生日期：</td>
					<td width="30%" class="value" nowrap>
						<input class="Wdate inputxt"  value="${userinfo.lovebirthday }" onClick="WdatePicker()" name="lovebirthday">
					</td>
				</tr>
				<tr>
					<td width="10%" align="right" nowrap>名族：</td>
					<td width="30%" class="value" nowrap><input type="text" name="lovemingzu" class="inputxt" value="${userinfo.lovemingzu }"/></td>
					<td width="10%" align="right" nowrap>学历：</td>
					<td width="30%" class="value" nowrap><input type="text" name="lovexueli" class="inputxt" value="${userinfo.lovexueli }"/></td>
				</tr>
				<tr>
					<td width="10%" align="right" nowrap>政治面貌：</td>
					<td width="30%" class="value" nowrap><input type="text" name="lovezzmm" class="inputxt" value="${userinfo.lovezzmm }"/></td>
					<td width="10%" align="right" nowrap>专业：</td>
					<td width="30%" class="value" nowrap><input type="text" name="lovezhuanye" class="inputxt" value="${userinfo.lovezhuanye }"/></td>
				</tr>
				<tr>
					<td width="10%" align="right" nowrap>联系电话：</td>
					<td width="30%" class="value" nowrap><input type="text" name="lovephone" class="inputxt" value="${userinfo.lovephone }"/></td>
					<td width="10%" align="right" nowrap>工作单位及职务：</td>
					<td width="30%" class="value" nowrap><input type="text" name="lovecompany" class="inputxt" value="${userinfo.lovecompany }"/></td>
				</tr>	
			</table>
		</div>
		
		<div class="easyui-panel" title="家庭主要成员" style="padding:2px;margin: 0px;">
			<table style="width: 64%;" cellpadding="0" cellspacing="1" class="formtable">
				<tr>
					<td width="10%" align="right" nowrap>关系<span style="color:red">*</span>：</td>
					<td width="30%" class="value" nowrap>
						<input type="text" name="familyrelation1" class="inputxt" datatype="*" value="${userinfo.familyrelation1 }"/>
						<span class="Validform_checktip"></span>
						 <label class="Validform_label" style="display: none;"></label>
					</td>
					<td width="10%" align="right" nowrap>姓名<span style="color:red">*</span>：</td>
					<td width="30%" class="value" nowrap>
						<input type="text" name="familyname1" datatype="*" class="inputxt" value="${userinfo.familyname1 }"/>
						<span class="Validform_checktip"></span>
						 <label class="Validform_label" style="display: none;"></label>
					</td>
				</tr>
				<tr>
					<td width="10%" align="right" nowrap>出生年月&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>(如:2016-10)：</td>
					<td width="30%" class="value" nowrap><input type="text" name="familybirth1" class="inputxt" value="${userinfo.familybirth1 }"/></td>
					<td width="10%" align="right" nowrap>政治面貌：</td>
					<td width="30%" class="value" nowrap><input type="text" name="familyzzmm1" class="inputxt" value="${userinfo.familyzzmm1 }"/></td>
				</tr>
				<tr>
					<td width="10%" align="right" nowrap>工作单位及职务<span style="color:red">*</span>：</td>
					<td width="30%" class="value" nowrap colspan="3">
						<input type="text" name="familycompany1" datatype="*" class="inputxt" value="${userinfo.familycompany1 }"/>
						<span class="Validform_checktip"></span>
						 <label class="Validform_label" style="display: none;"></label>
					</td>
				</tr>
				<tr>
					<td colspan="4" style="height:25px" class="value"></td>
				</tr>
				<tr>
					<td width="10%" align="right" nowrap>关系：</td>
					<td width="30%" class="value" nowrap><input type="text" name="familyrelation2" class="inputxt" value="${userinfo.familyrelation2 }"/></td>
					<td width="10%" align="right" nowrap>姓名：</td>
					<td width="30%" class="value" nowrap><input type="text" name="familyname2" class="inputxt" value="${userinfo.familyname2 }"/></td>
				</tr>
				<tr>
					<td width="10%" align="right" nowrap>出生年月&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>(如:2016-10)：</td>
					<td width="30%" class="value" nowrap><input type="text" name="familybirth2" class="inputxt" value="${userinfo.familybirth2 }"/></td>
					<td width="10%" align="right" nowrap>政治面貌：</td>
					<td width="30%" class="value" nowrap><input type="text" name="familyzzmm2" class="inputxt" value="${userinfo.familyzzmm2 }"/></td>
				</tr>
				<tr>
					<td width="10%" align="right" nowrap>工作单位及职务：</td>
					<td width="30%" class="value" nowrap colspan="3"><input type="text" name="familycompany2" class="inputxt" value="${userinfo.familycompany2 }"/></td>
				</tr>
				<tr>
					<td colspan="4" style="height:25px" class="value"></td>
				</tr>
				<tr>
					<td width="10%" align="right" nowrap>关系：</td>
					<td width="30%" class="value" nowrap><input type="text" name="familyrelation3" class="inputxt" value="${userinfo.familyrelation3 }"/></td>
					<td width="10%" align="right" nowrap>姓名：</td>
					<td width="30%" class="value" nowrap><input type="text" name="familyname3" class="inputxt" value="${userinfo.familyname3 }"/></td>
				</tr>
				<tr>
					<td width="10%" align="right" nowrap>出生年月&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>(如:2016-10)：</td>
					<td width="30%" class="value" nowrap><input type="text" name="familybirth3" class="inputxt" value="${userinfo.familybirth3 }"/></td>
					<td width="10%" align="right" nowrap>政治面貌：</td>
					<td width="30%" class="value" nowrap><input type="text" name="familyzzmm3" class="inputxt" value="${userinfo.familyzzmm3 }"/></td>
				</tr>
				<tr>
					<td width="10%" align="right" nowrap>工作单位及职务：</td>
					<td width="30%" class="value" nowrap colspan="3"><input type="text" name="familycompany3" class="inputxt" value="${userinfo.familycompany3 }"/></td>
				</tr>
			</table>	
		</div>
		
		<div class="easyui-panel" title="学历(学位)及专业技术职称" style="padding:2px;margin: 0px;">
			<table style="width: 64%;" cellpadding="0" cellspacing="1" class="formtable">
				<tr>
					<td width="10%" align="right" nowrap>全日制学历(学位)1<span style="color:red">*</span>：</td>
					<td width="30%" class="value" nowrap>
						<input type="text" name="xueli1" class="inputxt" datatype="*" value="${userinfo.xueli1 }"/>
						<span class="Validform_checktip"></span>
						 <label class="Validform_label" style="display: none;"></label>
					</td>
					<td width="10%" align="right" nowrap>毕业时间&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>(如:2016-10)<span style="color:red">*</span>：</td>
					<td width="30%" class="value" nowrap>
						<input type="text" name="biyetime1" datatype="*" class="inputxt" value="${userinfo.biyetime1 }"/>
						<span class="Validform_checktip"></span>
						 <label class="Validform_label" style="display: none;"></label>
					</td>
				</tr>
				<tr>
					<td width="10%" align="right" nowrap>毕业院校<span style="color:red">*</span>：</td>
					<td width="30%" class="value" nowrap>
						<input type="text" name="biyeschool1" class="inputxt" datatype="*" value="${userinfo.biyeschool1 }"/>
						<span class="Validform_checktip"></span>
						 <label class="Validform_label" style="display: none;"></label>
					</td>
					<td width="10%" align="right" nowrap>专业<span style="color:red">*</span>：</td>
					<td width="30%" class="value" nowrap>
						<input type="text" name="zhuanye1" class="inputxt" datatype="*" value="${userinfo.zhuanye1 }"/>
						<span class="Validform_checktip"></span>
						 <label class="Validform_label" style="display: none;"></label>
					</td>
				</tr>
				<tr>
					<td colspan="4" style="height:25px" class="value"></td>
				</tr>
				<tr>
					<td width="10%" align="right" nowrap>全日制学历(学位)2：</td>
					<td width="30%" class="value" nowrap><input type="text" name="xueli2" class="inputxt" value="${userinfo.xueli2 }"/></td>
					<td width="10%" align="right" nowrap>毕业时间&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>(如:2016-10)：</td>
					<td width="30%" class="value" nowrap><input type="text" name="biyetime2" class="inputxt" value="${userinfo.biyetime2 }"/></td>
				</tr>
				<tr>
					<td width="10%" align="right" nowrap>毕业院校：</td>
					<td width="30%" class="value" nowrap><input type="text" name="biyeschool2" class="inputxt" value="${userinfo.biyeschool2 }"/></td>
					<td width="10%" align="right" nowrap>专业：</td>
					<td width="30%" class="value" nowrap><input type="text" name="zhuanye2" class="inputxt" value="${userinfo.zhuanye2 }"/></td>
				</tr> 
				<tr>
					<td colspan="4" style="height:25px" class="value"></td>
				</tr>
				<tr>
					<td width="10%" align="right" nowrap>全日制学历(学位)3：</td>
					<td width="30%" class="value" nowrap><input type="text" name="xueli3" class="inputxt" value="${userinfo.xueli3 }"/></td>
					<td width="10%" align="right" nowrap>毕业时间&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>(如:2016-10)：</td>
					<td width="30%" class="value" nowrap><input type="text" name="biyetime3" class="inputxt" value="${userinfo.biyetime3 }"/></td>
				</tr>
				<tr>
					<td width="10%" align="right" nowrap>毕业院校：</td>
					<td width="30%" class="value" nowrap><input type="text" name="biyeschool3" class="inputxt" value="${userinfo.biyeschool3 }"/></td>
					<td width="10%" align="right" nowrap>专业：</td>
					<td width="30%" class="value" nowrap><input type="text" name="zhuanye3" class="inputxt" value="${userinfo.zhuanye3 }"/></td>
				</tr>
				<tr>
					<td colspan="4" style="height:25px" class="value"></td>
				</tr>
				<tr>
					<td width="10%" align="right" nowrap>非全日制学历(学位)：</td>
					<td width="30%" class="value" nowrap><input type="text" name="xueli4" class="inputxt" value="${userinfo.xueli4 }"/></td>
					<td width="10%" align="right" nowrap>毕业时间&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>(如:2016-10)：</td>
					<td width="30%" class="value" nowrap><input type="text" name="biyetime4" class="inputxt" value="${userinfo.biyetime4 }"/></td>
				</tr>
				<tr>
					<td width="10%" align="right" nowrap>毕业院校：</td>
					<td width="30%" class="value" nowrap><input type="text" name="biyeschool4" class="inputxt" value="${userinfo.biyeschool4 }"/></td>
					<td width="10%" align="right" nowrap>专业：</td>
					<td width="30%" class="value" nowrap><input type="text" name="zhuanye4" class="inputxt" value="${userinfo.zhuanye4 }"/></td>
				</tr>
				<tr>
					<td colspan="4" style="height:25px" class="value"></td>
				</tr>
				<tr>
					<td width="10%" align="right" nowrap>专业技术职称类别：</td>
					<td width="30%" class="value" nowrap><input type="text" name="zyjszctype" class="inputxt" value="${userinfo.zyjszctype }"/></td>
					<td width="10%" align="right" nowrap>资格取得时间&nbsp;&nbsp;&nbsp;<br>(如:2016-10)：</td>
					<td width="30%" class="value" nowrap><input type="text" name="zggettime" class="inputxt" value="${userinfo.zggettime }"/></td>
				</tr>
			</table>
		</div>
		
		<div class="easyui-panel" title="人事信息" style="padding:2px;margin: 0px;">
			<table style="width: 100%;" cellpadding="0" cellspacing="1" class="formtable">
				<tr>
					<td height="27px" width="10%" align="right" nowrap>劳动合同性质：</td>
					<td width="15%" class="value" nowrap>
						<c:if test="${userinfo.laodonghetongtype eq '1'}">
							固定期限
						</c:if>
						<c:if test="${userinfo.laodonghetongtype eq '2'}">
							无固定期限
						</c:if>
						<c:if test="${userinfo.laodonghetongtype eq '3'}">
							完成一定工作
						</c:if>
					</td>
					<td width="10%" align="right" nowrap>劳务公司：</td>
					<td width="15%" class="value" nowrap>${userinfo.laowugongsi }</td>
					<td width="10%" align="right" nowrap>劳务公司联系人：</td>
					<td width="15%" class="value" nowrap>${userinfo.laowugongsiperson }</td>
					<td width="10%" align="right" nowrap>用工性质：</td>
					<td width="15%" class="value" nowrap>
						<c:if test="${userinfo.yonggongtype eq '1' }">
							在编
						</c:if>
						<c:if test="${userinfo.yonggongtype eq '2' }">
							人事代理
						</c:if>
						<c:if test="${userinfo.yonggongtype eq '3' }">
							劳务派遣
						</c:if>
						<c:if test="${userinfo.yonggongtype eq '4' }">
							单位自聘
						</c:if>
						<c:if test="${userinfo.yonggongtype eq '5' }">
							劳务协议
						</c:if>
						<c:if test="${userinfo.yonggongtype eq '6' }">
							劳务外包
						</c:if>
						<c:if test="${userinfo.yonggongtype eq '7' }">
							其他
						</c:if>
					</td>
				</tr>
				<tr>
					<td height="27px" width="10%" align="right" nowrap>是否在职：</td>
					<td width="15%" class="value" nowrap>${userinfo.zaigang==1?'在职':'离职' }</td>
					<td width="10%" align="right" nowrap>何时进入本单位：</td>
					<td width="15%" class="value" nowrap>${userinfo.rzsj }</td>
					<td width="10%" align="right" nowrap>职务：</td>
					<td width="15%" class="value" nowrap>${userinfo.zhiwei }</td>
					<td width="10%" align="right" nowrap>合同到期时间：</td>
					<td width="15%" class="value" nowrap>${userinfo.hetongendtime }</td>
				</tr>
				<tr>
					<td height="27px" width="10%" align="right" nowrap>身份证件：</td>
					<td class="value" colspan="7" nowrap><a href="<%=realPath %>/claimMoneyFinanceController.do?downloadFile&fileName=${userinfo.sfzfilename }&filePath=${userinfo.sfzfilepath }">${userinfo.sfzfilename }</a></td>
				</tr>
				<tr>
					<td height="27px" width="10%" align="right" nowrap>职称证书：</td>
					<td class="value" colspan="7" nowrap>
						<a href="<%=realPath %>/claimMoneyFinanceController.do?downloadFile&fileName=${userinfo.zcfilename }&filePath=${userinfo.zcfilepath }">${userinfo.zcfilename }</a>
					</td>
				</tr>
				<tr>
					<td height="27px" width="10%" align="right" nowrap>学历证件：</td>
					<td class="value" colspan="7" nowrap>
						<a href="<%=realPath %>/claimMoneyFinanceController.do?downloadFile&fileName=${userinfo.xlfilename }&filePath=${userinfo.xlfilepath }">${userinfo.xlfilename }</a>
					</td>
				</tr>
			</table>
		</div>
		
		<div class="easyui-panel" title="质量办信息" style="padding:2px;margin: 0px;">
			<table style="width: 100%;" cellpadding="0" cellspacing="1" class="formtable">
				<tr>
					<td height="27px" width="10%" align="right" nowrap>职称：</td>
					<td width="15%" class="value" nowrap>${userinfo.zhicheng }</td>
					<td width="10%" align="right" nowrap>技术职称：</td>
					<td width="15%" class="value" nowrap>${userinfo.jishuzhicheng }</td>
					<td width="10%" align="right" nowrap></td>
					<td width="15%" class="value" nowrap></td>
					<td width="10%" align="right" nowrap></td>
					<td width="15%" class="value"></td>
				</tr>
				<tr>
					<td height="27px" width="10%" align="right" nowrap>第一后学历：</td>
					<td width="15%" class="value" nowrap>${userinfo.hxl1_xl }</td>
					<td width="10%" align="right" nowrap>毕业院校：</td>
					<td width="15%" class="value" nowrap>${userinfo.hxl1_xx }</td>
					<td width="10%" align="right" nowrap>所学专业：</td>
					<td width="15%" class="value" nowrap>${userinfo.hxl1_zy }</td>
					<td width="10%" align="right" nowrap>毕业时间：</td>
					<td width="15%" class="value" nowrap>${userinfo.hxl1_sj }</td>
				</tr>
				<tr>
					<td height="27px" width="10%" align="right" nowrap>第二后学历：</td>
					<td width="15%" class="value" nowrap>${userinfo.hxl2_xl }</td>
					<td width="10%" align="right" nowrap>毕业院校：</td>
					<td width="15%" class="value" nowrap>${userinfo.hxl2_xx }</td>
					<td width="10%" align="right" nowrap>所学专业：</td>
					<td width="15%" class="value" nowrap>${userinfo.hxl2_zy }</td>
					<td width="10%" align="right" nowrap>毕业时间：</td>
					<td width="15%" class="value" nowrap>${userinfo.hxl2_sj }</td>
				</tr>
				<tr>
					<td height="27px" width="10%" align="right" nowrap>第三后学历：</td>
					<td width="15%" class="value" nowrap>${userinfo.hxl3_xl }</td>
					<td width="10%" align="right" nowrap>毕业院校：</td>
					<td width="15%" class="value" nowrap>${userinfo.hxl3_xx }</td>
					<td width="10%" align="right" nowrap>所学专业：</td>
					<td width="15%" class="value" nowrap>${userinfo.hxl3_zy }</td>
					<td width="10%" align="right" nowrap>毕业时间：</td>
					<td width="15%" class="value" nowrap>${userinfo.hxl3_sj }</td>
				</tr>
			</table>
		</div>
		<div style="text-align: center;padding-top:10px;font-size:14px">
			<input type="submit" value="提交">
			<input type="button" value="返回" class="back" onclick="goback()">
		</div>
	</t:formvalid>
	 <script src = "webpage/com/jeecg/money/ajaxfileupload.js"></script>	
  <script type="text/javascript">
	function fileClick(){
  		$("#fileTest").click();
  	}
  	
  	function changeVal(){
  		var filename=document.getElementById("fileTest").value;
  		$("#basefilename").val(filename);
  	}
  	
  	function fileUpload(){
	    if($("#fileTest").val()==""){
	    	layer.msg("请选择文件！");
	        return;
	    }else{
	        $.ajaxFileUpload({
	            url: 'claimMoneyFinanceController.do?fileUpload',           //需要链接到服务器地址
	            secureuri: false,
	            fileElementId: ['fileTest'],                        //文件选择框的id属性
	            dataType: 'json',                                      //服务器返回的格式，可以是json
	            contentType: 'application/x-www-form-urlencoded; charset=utf-8',
	            data: {
	                id: 'fileTest',
	                uploadPath:'userbaseinfo'
	            },
	            success: function (data, status) { 
					//相当于java中try语句块的用法
				    data = $.parseJSON(data);
					var file=data[0];
					console.log(file);
					$("#basefilename").val(file.oldName);
                    $("#basefilepath").val(file.filePath);
                    $("#base_filename").html(file.oldName);
	            },
	          //相当于java中catch语句块的用法
	            error: function (data, status, e) { 
	            	layer.msg("上传失败");   
	                flag=false;
	            }
	        });
	    }
  	}
  	
  	function picUpload(){
	    if($("#picTest").val()==""){
	    	layer.msg("请选择图片！");
	        return;
	    }else{
	    	var value=$("#picTest").val();
	        var type=value.substr(value.lastIndexOf(".")).toLowerCase();
 			var pic_type="*.gif;*.jpg;*.jpeg;*.bmp;*.png;";
	        if(pic_type.indexOf(type+";")==-1){
                errorInfo("文件格式不正确！");
                return;
            }
	        $.ajaxFileUpload({
	            url: 'claimMoneyFinanceController.do?fileUpload',           //需要链接到服务器地址
	            secureuri: false,
	            fileElementId: ['picTest'],                        //文件选择框的id属性
	            dataType: 'json',                                      //服务器返回的格式，可以是json
	            contentType: 'application/x-www-form-urlencoded; charset=utf-8',
	            data: {
	                id: 'picTest',
	                uploadPath:'userbaseinfo'
	            },
	            success: function (data, status) { 
					//相当于java中try语句块的用法
				    data = $.parseJSON(data);
					var file=data[0];
                    $("#picpath").val(file.filePath);
                    $("#pic").attr("src","<%=realPath%>"+"/"+file.filePath);
	            },
	          //相当于java中catch语句块的用法
	            error: function (data, status, e) { 
	            	layer.msg("上传失败");   
	                flag=false;
	            }
	        });
	    }
  	}
  </script>	
	
	<script type="text/javascript">
		function goback(){
			history.go(-1);			
		}
	</script>
 </body>
