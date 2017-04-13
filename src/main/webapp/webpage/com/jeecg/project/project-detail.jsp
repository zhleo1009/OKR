<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
 <head>
  <title>项目管理</title>
  <t:base type="jquery,easyui,tools,DatePicker"></t:base>
  <script type="text/javascript">
  
  //编写自定义JS代码
		function openDepartmentSelect() {
			$.dialog.setting.zIndex = 9999; 
			$.dialog({content: 'url:departController.do?departSelect', zIndex: 2100, title: '组织机构列表', lock: true, width: '400px', height: '350px', opacity: 0.4, button: [
			   {name: '<t:mutiLang langKey="common.confirm"/>', callback: callbackDepartmentSelect, focus: true},
			   {name: '<t:mutiLang langKey="common.cancel"/>', callback: function (){}}
		   ]}).zindex();
		}
			
		function callbackDepartmentSelect() {
			  var iframe = this.iframe.contentWindow;
			  var treeObj = iframe.$.fn.zTree.getZTreeObj("departSelect");
			  var nodes = treeObj.getCheckedNodes(true);
			  if(nodes.length>0){
			  var ids='',names='';
			  for(i=0;i<nodes.length;i++){
			     var node = nodes[i];
			     ids += node.id+',';
			    names += node.name+',';
			 }
			  if(ids!=''){
				  ids = ids.substring(0,ids.length-1);
			  }
			  if(names!=''){
				  names = names.substring(0,names.length-1);
			  }
			 $('#departname').val(names);
			 $('#departname').blur();		
			 $('#org').val(ids);		
			}
		}
		
		function callbackClean(){
			$('#departname').val('');
			 $('#org').val('');	
		}
		
		
		
		$(function(){
			$.ajax({
				url : "departController.do?getDepartNamesByIds",
				type : "post",
				data : {
					orgIds:"${projectPage.org}"
				},
				dataType : "json",
				async : false,
				success : function(data) {
					var result =  data.msg;
					 $('#departname').html(result);
				}
			});
			
			
		});
		
  </script>
 </head>
 <body>
		<t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" action="projectController.do?doUpdate" tiptype="1" >
					<input id="id" name="id" type="hidden" value="${projectPage.id }">
		<table style="width: 600px;" cellpadding="0" cellspacing="1" class="formtable">
					<tr>
						<td align="right">
							<label class="Validform_label">
								项目名称:
							</label>
						</td>
						<td class="value">
						     	${projectPage.projectName}
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">项目名称</label>
						</td>
					</tr>
					<tr>
						<td align="right">
							<label class="Validform_label">
								开始时间:
							</label>
						</td>
						<td class="value">
						    <fmt:formatDate value='${projectPage.startDate}' type="date" pattern="yyyy-MM-dd HH:mm:ss"/>
									
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">开始时间</label>
						</td>
					</tr>
					<tr>
						<td align="right">
							<label class="Validform_label">
								结束时间:
							</label>
						</td>
						<td class="value">
						     	 <fmt:formatDate value='${projectPage.endDate}' type="date" pattern="yyyy-MM-dd HH:mm:ss"/>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">结束时间</label>
						</td>
					</tr>
					<tr>
						<td align="right">
							<label class="Validform_label">
								所属部门:
							</label>
						</td>
						<td class="value">
				<span id="departname" ></span> 
						</td>
					</tr>
					<tr>
						<td align="right">
							<label class="Validform_label">
								备注信息:
							</label>
						</td>
						<td class="value">
						     	${projectPage.remark}
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">备注信息</label>
						</td>
					</tr>
			</table>
		</t:formvalid>
 </body>
  <script src = "webpage/com/jeecg/project/project.js"></script>		
