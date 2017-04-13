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
 </head>
 <body>
		<t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" action="userInfoController.do?doUpdateRs" tiptype="lte" >
			<input id="id" name="id" type="hidden" value="${userinfo.id }">
			<input id="user_id" name="user_id" type="hidden" value="${userinfo.user_id }">
			<table style="width: 100%;" cellpadding="0" cellspacing="1" class="formtable">
				<tr>
					<td width="25%" align="right" nowrap>姓名：</td>
					<td width="25%" class="value" nowrap>${userinfo.realname }</td>
					<td width="25%" align="right" nowrap>部门：</td>
					<td width="25%" class="value" nowrap>${userinfo.departname }</td>
				</tr>
				<tr>
					<td width="25%" height="25px" align="right" nowrap>名族：</td>
					<td width="25%" class="value" nowrap>${userinfo.mingzu }</td>
					<td width="25%" align="right" nowrap>身份证号：</td>
					<td width="25%" class="value" nowrap>${userinfo.sfz }</td>	
				</tr>
				<tr>
					<td width="25%" height="25px" align="right" nowrap>性别：</td>
					<td width="25%" class="value" nowrap>
						<c:if test="${userinfo.sex eq '0'}">男</c:if>
						<c:if test="${userinfo.sex eq '1'}">女</c:if>
					</td>
					<td width="25%" align="right" nowrap>出生日期：</td>
					<td width="25%" class="value" nowrap>${userinfo.birthday }</td>	
				</tr>
				<tr>
					<td colspan="4" style="height:25px" class="value"></td>
				</tr>
				<tr>
					<td width="25%" align="right" nowrap>何时进入本单位：</td>
					<td width="25%" class="value" nowrap>
						<input class="Wdate inputxt" id="create_date" value="${userinfo.create_date }" onClick="WdatePicker()" name="create_date">
					</td>
					<td width="25%" align="right" nowrap>劳务公司：</td>
					<td width="25%" class="value" nowrap>
						<input type="text" value="${userinfo.laowugongsi }" id="laowugongsi" name="laowugongsi" class="inputxt">
					</td>	
				</tr>
				<tr>
					<td width="25%" align="right" nowrap>劳动合同性质：</td>
					<td width="25%" class="value" nowrap>
						<select name="laodonghetongtype" id="laodonghetongtype" style="height:25px" class="inputxt">
							<c:if test="${userinfo.laodonghetongtype eq '1'}">
								<option value="1" selected="selected">固定期限</option>
								<option value="2">无固定期限</option>
								<option value="3">完成一定工作</option>
							</c:if>
							<c:if test="${userinfo.laodonghetongtype == null}">
								<option value="1" selected="selected">固定期限</option>
								<option value="2">无固定期限</option>
								<option value="3">完成一定工作</option>
							</c:if>
							<c:if test="${userinfo.laodonghetongtype eq '2'}">
								<option value="1">固定期限</option>
								<option value="2" selected="selected">无固定期限</option>
								<option value="3">完成一定工作</option>
							</c:if>
							<c:if test="${userinfo.laodonghetongtype eq '3'}">
								<option value="1">固定期限</option>
								<option value="2">无固定期限</option>
								<option value="3" selected="selected">完成一定工作</option>
							</c:if>
						</select>
					</td>
					<td width="25%" align="right" nowrap>劳务公司联系人：</td>
					<td width="25%" class="value" nowrap>
						<input type="text" value="${userinfo.laowugongsiperson }" id="laowugongsiperson" name="laowugongsiperson" class="inputxt">
					</td>	
				</tr>
				<tr>
					<td width="25%" align="right" nowrap>合同到期时间：</td>
					<td width="25%" class="value" nowrap>
						<input class="Wdate inputxt" id="hetongendtime" value="${userinfo.hetongendtime }" onClick="WdatePicker()" name="hetongendtime">
					</td>
					<td width="25%" align="right" nowrap>用工性质：</td>
					<td width="25%" class="value" nowrap>
						<select name="yonggongtype" id="yonggongtype" style="height:25px" class="inputxt" >
							<c:if test="${userinfo.yonggongtype eq '1' }">
								<option value="1" selected="selected">在编</option>
								<option value="2">人事代理</option>
								<option value="3">劳务派遣</option>
								<option value="4">单位自聘</option>
								<option value="5">劳务协议</option>
								<option value="6">劳务外包</option>
								<option value="7">其他</option>
							</c:if>
							<c:if test="${userinfo.yonggongtype == null }">
								<option value="1" selected="selected">在编</option>
								<option value="2">人事代理</option>
								<option value="3">劳务派遣</option>
								<option value="4">单位自聘</option>
								<option value="5">劳务协议</option>
								<option value="6">劳务外包</option>
								<option value="7">其他</option>
							</c:if>
							<c:if test="${userinfo.yonggongtype eq '2' }">
								<option value="1">在编</option>
								<option value="2" selected="selected">人事代理</option>
								<option value="3">劳务派遣</option>
								<option value="4">单位自聘</option>
								<option value="5">劳务协议</option>
								<option value="6">劳务外包</option>
								<option value="7">其他</option>
							</c:if>
							<c:if test="${userinfo.yonggongtype eq '3' }">
								<option value="1">在编</option>
								<option value="2">人事代理</option>
								<option value="3" selected="selected">劳务派遣</option>
								<option value="4">单位自聘</option>
								<option value="5">劳务协议</option>
								<option value="6">劳务外包</option>
								<option value="7">其他</option>
							</c:if>
							<c:if test="${userinfo.yonggongtype eq '4' }">
								<option value="1">在编</option>
								<option value="2">人事代理</option>
								<option value="3">劳务派遣</option>
								<option value="4" selected="selected">单位自聘</option>
								<option value="5">劳务协议</option>
								<option value="6">劳务外包</option>
								<option value="7">其他</option>
							</c:if>
							<c:if test="${userinfo.yonggongtype eq '5' }">
								<option value="1">在编</option>
								<option value="2">人事代理</option>
								<option value="3">劳务派遣</option>
								<option value="4">单位自聘</option>
								<option value="5" selected="selected">劳务协议</option>
								<option value="6">劳务外包</option>
								<option value="7">其他</option>
							</c:if>
							<c:if test="${userinfo.yonggongtype eq '6' }">
								<option value="1">在编</option>
								<option value="2">人事代理</option>
								<option value="3">劳务派遣</option>
								<option value="4">单位自聘</option>
								<option value="5">劳务协议</option>
								<option value="6" selected="selected">劳务外包</option>
								<option value="7">其他</option>
							</c:if>
							<c:if test="${userinfo.yonggongtype eq '7' }">
								<option value="1">在编</option>
								<option value="2">人事代理</option>
								<option value="3">劳务派遣</option>
								<option value="4">单位自聘</option>
								<option value="5">劳务协议</option>
								<option value="6">劳务外包</option>
								<option value="7" selected="selected">其他</option>
							</c:if>
						</select>
					</td>	
				</tr>
				<tr>
					<td width="25%" align="right" nowrap>职位：</td>
					<td width="25%" class="value" nowrap><input type="text" class="inputxt" name="zhiwei" id="zhiwei" value="${userinfo.zhiwei }"></td>
					<td width="25%" align="right" nowrap>是否在职：</td>
					<td width="25%" class="value" id="status" nowrap>
						<c:if test="${userinfo.status eq '1' }">
							<input type="radio" name="status" checked="checked" value="1">在岗
							<input type="radio" name="status" value="0">离职
						</c:if>
						<c:if test="${userinfo.status eq '0' }">
							<input type="radio" name="status" value="1">在岗
							<input type="radio" name="status" checked="checked" value="0">离职
						</c:if>
					</td>	
				</tr>
				<tr>
					<td colspan="4" style="height:25px" class="value"></td>
				</tr>
				<tr>
					<td width="25%" align="right" nowrap>身份证件：</td>
					<td width="25%" align="left" nowrap  class="value">
						<label id="sfz_filename">
							<a href="<%=realPath %>/claimMoneyFinanceController.do?downloadFile&fileName=${userinfo.sfzfilename }&filePath=${userinfo.sfzfilepath }">${userinfo.sfzfilename }</a>
						</label>
					</td>
					<td width="50%" align="left" colspan="2"  class="value" nowrap>
						<input id="sfzTest" style="background-color: #fff;width:200px !important;border:1px solid #ddd;" name="sfzTest" type="file"  multiple/>
				     	<input type="hidden" id="sfzfilepath" name="sfzfilepath" class="inputxt">
				     	<input type="hidden" id="sfzfilename" name="sfzfilename" class="inputxt">
				        <!-- <input type="button" value="上传" onclick="sfzUpload()" class="hollowBtn"/> -->
				        &nbsp;&nbsp;
				        <a class="easyui-linkbutton l-btn l-btn-small" onclick="sfzUpload()">
							<span class="l-btn-left l-btn-icon-left" style="padding:0px">
								<span class="l-btn-text">上传</span>
								<span class="l-btn-icon icon-ok"></span>
							</span>
						</a>
					</td>
				</tr>
				<tr>
					<td colspan="4" style="height:25px" class="value"></td>
				</tr>
				<tr>
					<td width="25%" align="right" nowrap>职称证书：</td>
					<td width="25%" align="left" nowrap  class="value">
						<label id="zc_filename">
							<a href="<%=realPath %>/claimMoneyFinanceController.do?downloadFile&fileName=${userinfo.zcfilename }&filePath=${userinfo.zcfilepath }">${userinfo.zcfilename }</a>
						</label>
					</td>
					<td width="50%" align="left" colspan="2" class="value" nowrap>
						<input id="zcTest" style="background-color: #fff;width:200px !important;border:1px solid #ddd;" name="zcTest" type="file"  multiple/>
				     	<input type="hidden" id="zcfilepath" name="zcfilepath" class="inputxt">
				     	<input type="hidden" id="zcfilename" name="zcfilename" class="inputxt">
				        <!-- <input type="button" value="上传" onclick="zcUpload()" class="hollowBtn"/> -->
				        &nbsp;&nbsp;
				        <a class="easyui-linkbutton l-btn l-btn-small" onclick="zcUpload()">
							<span class="l-btn-left l-btn-icon-left" style="padding:0px">
								<span class="l-btn-text">上传</span>
								<span class="l-btn-icon icon-ok"></span>
							</span>
						</a>
					</td>
				</tr>
				<tr>
					<td colspan="4" style="height:25px" class="value"></td>
				</tr>
				<tr>
					<td width="25%" align="right" nowrap>学历证书：</td>
					<td width="25%" align="left" nowrap  class="value">
						<label id="xl_filename">
							<a href="<%=realPath %>/claimMoneyFinanceController.do?downloadFile&fileName=${userinfo.xlfilename }&filePath=${userinfo.xlfilepath }">${userinfo.xlfilename }</a>
						</label>
					</td>
					<td width="50%" align="left" colspan="2"  class="value" nowrap>
						<input id="xlTest" style="background-color: #fff;width:200px !important;border:1px solid #ddd;" name="xlTest" type="file"  multiple/>
				     	<input type="hidden" id="xlfilepath" name="xlfilepath" class="inputxt">
				     	<input type="hidden" id="xlfilename" name="xlfilename" class="inputxt">
				     	&nbsp;&nbsp;
				        <a class="easyui-linkbutton l-btn l-btn-small" onclick="xlUpload()">
							<span class="l-btn-left l-btn-icon-left" style="padding:0px">
								<span class="l-btn-text">上传</span>
								<span class="l-btn-icon icon-ok"></span>
							</span>
						</a>
				     <!--    <input type="button" value="上传" onclick="xlUpload()" class="hollowBtn"/> -->
					</td>
				</tr>
			</table>
			
		</t:formvalid>
		<script src = "webpage/com/jeecg/money/ajaxfileupload.js"></script>	
		<script type="text/javascript">
			function goForm(){
				var create_date=$("#create_date").val();
				var laowugongsi=$("#laowugongsi").val();
				var laodonghetongtype=$("#laodonghetongtype").val();
				var laowugongsiperson=$("#laowugongsiperson").val();
				var hetongendtime=$("#hetongendtime").val();
				var yonggongtype=$("#yonggongtype").val();
				var zhiwei=$("#zhiwei").val();
				var status=$("input[name='status']:checked").val();
				var user_id=$("#user_id").val();
				var id=$("#id").val();
				var sfzfilename=$("#sfzfilename").val();
				var sfzfilepath=$("#sfzfilepath").val();
				var zcfilename=$("#zcfilename").val();
				var zcfilepath=$("#zcfilepath").val();
				var xlfilepath=$("#xlfilepath").val();
				var xlfilename=$("#xlfilename").val();
				var returnData;
				$.ajax({
			        type: 'POST',
			        url: 'userInfoController.do?doUpdateRs&r=' + Math.random(),
			        async: false,
			        data:
			        {	
			        	id:id,
			        	create_date:create_date,
						laowugongsi:laowugongsi,
						laodonghetongtype:laodonghetongtype,
						laowugongsiperson:laowugongsiperson,
						hetongendtime:hetongendtime,
						yonggongtype:yonggongtype,
						zhiwei:zhiwei,
						status:status,
						sfzfilename:sfzfilename,
						sfzfilepath:sfzfilepath,
						zcfilename:zcfilename,
						zcfilepath:zcfilepath,
						xlfilepath:xlfilepath,
						xlfilename:xlfilename,
						user_id:user_id
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
		
			
			function sfzUpload(){
			    if($("#sfzTest").val()==""){
			    	layer.msg("请选择图片！");
			        return;
			    }else{
			    	var value=$("#sfzTest").val();
			        var type=value.substr(value.lastIndexOf(".")).toLowerCase();
		 			var pic_type="*.gif;*.jpg;*.jpeg;*.bmp;*.png;";
			        if(pic_type.indexOf(type+";")==-1){
		                errorInfo("文件格式不正确！");
		                return;
		            }
			        $.ajaxFileUpload({
			            url: 'claimMoneyFinanceController.do?fileUpload',           //需要链接到服务器地址
			            secureuri: false,
			            fileElementId: ['sfzTest'],                        //文件选择框的id属性
			            dataType: 'json',                                      //服务器返回的格式，可以是json
			            contentType: 'application/x-www-form-urlencoded; charset=utf-8',
			            data: {
			                id: 'sfzTest',
			                uploadPath:'rsinfo'
			            },
			            success: function (data, status) { 
							//相当于java中try语句块的用法
						    data = $.parseJSON(data);
							var file=data[0];
		                    $("#sfzfilepath").val(file.filePath);
		                    $("#sfz_filename").html(file.oldName);
		                    $("#sfzfilename").val(file.oldName);
			            },
			          //相当于java中catch语句块的用法
			            error: function (data, status, e) { 
			            	layer.msg("上传失败");   
			                flag=false;
			            }
			        });
			    }
		  	}
			
			
			function zcUpload(){
				if($("#zcTest").val()==""){
			    	layer.msg("请选择图片！");
			        return;
			    }else{
			    	var value=$("#zcTest").val();
			        var type=value.substr(value.lastIndexOf(".")).toLowerCase();
		 			var pic_type="*.gif;*.jpg;*.jpeg;*.bmp;*.png;";
			        if(pic_type.indexOf(type+";")==-1){
		                errorInfo("文件格式不正确！");
		                return;
		            }
			        $.ajaxFileUpload({
			            url: 'claimMoneyFinanceController.do?fileUpload',           //需要链接到服务器地址
			            secureuri: false,
			            fileElementId: ['zcTest'],                        //文件选择框的id属性
			            dataType: 'json',                                      //服务器返回的格式，可以是json
			            contentType: 'application/x-www-form-urlencoded; charset=utf-8',
			            data: {
			                id: 'zcTest',
			                uploadPath:'rsinfo'
			            },
			            success: function (data, status) { 
							//相当于java中try语句块的用法
						    data = $.parseJSON(data);
							var file=data[0];
		                    $("#zcfilepath").val(file.filePath);
		                    $("#zc_filename").html(file.oldName);
		                    $("#zcfilename").val(file.oldName);
			            },
			          //相当于java中catch语句块的用法
			            error: function (data, status, e) { 
			            	layer.msg("上传失败");   
			                flag=false;
			            }
			        });
			    }
			}
			
			function xlUpload(){
				if($("#xlTest").val()==""){
			    	layer.msg("请选择图片！");
			        return;
			    }else{
			    	var value=$("#xlTest").val();
			        var type=value.substr(value.lastIndexOf(".")).toLowerCase();
		 			var pic_type="*.gif;*.jpg;*.jpeg;*.bmp;*.png;";
			        if(pic_type.indexOf(type+";")==-1){
		                errorInfo("文件格式不正确！");
		                return;
		            }
			        $.ajaxFileUpload({
			            url: 'claimMoneyFinanceController.do?fileUpload',           //需要链接到服务器地址
			            secureuri: false,
			            fileElementId: ['xlTest'],                        //文件选择框的id属性
			            dataType: 'json',                                      //服务器返回的格式，可以是json
			            contentType: 'application/x-www-form-urlencoded; charset=utf-8',
			            data: {
			                id: 'xlTest',
			                uploadPath:'rsinfo'
			            },
			            success: function (data, status) { 
							//相当于java中try语句块的用法
						    data = $.parseJSON(data);
							var file=data[0];
		                    $("#xlfilepath").val(file.filePath);
		                    $("#xl_filename").html(file.oldName);
		                    $("#xlfilename").val(file.oldName);
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
 </body>
