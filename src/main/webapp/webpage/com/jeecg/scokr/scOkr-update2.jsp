<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
 <head>
  <title>员工日程计划</title>
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
			 $('#needOrgName').val(names);
			 $('#needOrgName').blur();		
			 $('#needOrgCode').val(ids);		
			}
		}
		
		function callbackClean(){
			$('#needOrgName').val('');
			 $('#needOrgCode').val('');	
		}
		

		
		//验证数字1-100
		function checkit(obj){
		    var reg = new RegExp("^(\\d|[1-9]\\d|100)$");
		    if(!reg.test(obj.value)){
		    	layer.tips('请输入1-100的数字', '#percent', {
		    		  tips: [2, '#3595CC'],
		    		  time: 4000
		    		});
		    }
		
		}
		
		
		function isNotNull(obj){
			if(obj != null && obj!=""){
				return true;
			}else{
				return false;
			}
		}
		
		//根据完成度批判未完成原因值
		function isUnfinish(){
			var percent = $('#percent').val();	
			//判断完成度小于100不等于空时必须填写未完成原因
			if(percent<100&&percent!=null&&percent!=""){
				var unReason = $('#unfinishedReason').val();
				if(''==unReason){
					var obj = $('#unfinishedReason');
					layer.tips('请填写未完成的原因', obj,{tips: [2, '#3595CC']});
					return false;
				}
				//判断完成度在100%时必须填写完成时间
			}else if(percent==100){
				var finishTime = $('#finishTime').val();
				if(''==finishTime){
					var obj = $('#finishTime');
					layer.tips('请填写完成时间',obj,{tips:[2, '#3595CC']});
					return false;
				}
				//判断percent>100是不允许转交下一步
			}else if(percent>100){
				checkit($('#percent').val());
				return false;
			}
			
			return true;
		}
		
		
		
		
		
		//增加 保存草稿按钮
		 function saveForm(){
		 	  $('#btn_sub').click();
		 }

		//转交下一步
		 function submitForm(){
			
			//判断percent和unfinishedReason有值 finishTime必须为空
				var percent = $('#percent').val();
				var unfinishedReason = $('#unfinishedReason').val();
				var finishTime = $('#finishTime').val();
		 	     
				//判断percent==100%时unfinishedReason 不需填写	
		 		if(percent==100 && isNotNull(unfinishedReason)){
		 			if(isNotNull(finishTime)){
						var obj = $('#unfinishedReason');
						layer.tips('任务已完成,未完成原因不用填写',obj,{tips:[2, '#3595CC']});
						return false;
						}
		 			//判断任务未完成	
		 		}else  if(isNotNull(percent) && isNotNull(unfinishedReason)){
		 			if(isNotNull(finishTime)){
						var obj = $('#finishTime');
						layer.tips('任务未完成,完成时间不用填写',obj,{tips:[2, '#3595CC']});
						return false;
						}
		 			}
				
			 var mission = $('#mission').val();
			 var percent = $('#percent').val();
			 var msg = '"'+mission+'"任务确定已完成'+percent+'%吗？';
			if(percent!=null&&percent!=""){
				if(isUnfinish()){
					 layer.confirm(msg , {
						  btn: ['确定','取消'] //按钮
						}, function(){
							  $('#doCommit').val('true');//开启流程
						 	  $('#btn_sub').click();
						});
				}
				
			}else{
				 $('#doCommit').val('true');//开启流程
			 	  $('#btn_sub').click();
			}
			
		 }
			//关闭按钮
		 function cancelForm() { 
			frameElement.api.close(); 

			 } 
			
  </script>
 </head>
 <body>
		<t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" action="scOkrController.do?doUpdate" tiptype="4" >
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
					
						<input id="doCommit" name="doCommit" type="hidden" value="false">		
					
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
						<input  type="hidden" id="mission" name="mission"  style="width: 250px;height: 30px" class="inputxt" value="${scOkrPage.mission}" />
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
						<textarea  id="difficulties" name="difficulties"  style="width: 250px;height: 30px" class="inputxt">${scOkrPage.difficulties}</textarea>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">执行难点</label>
						</td>
					</tr>
					<tr>
						<td align="right"  width="25%"  nowrap>
							<label class="Validform_label"><span style="color: red;">*</span>
								OKR完成程度:
							</label>
						</td>
						<td class="value" nowrap>
						     <input id="percent" name="percent"  style="width: 150px"
					     	  type="number"  min="0" max="100" step="10" onblur="checkit(this)"
					     	  class="inputxt" value='${scOkrPage.percent}' datatype="*" >
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
						<textarea  id="unfinishedReason" name="unfinishedReason"  style="width: 250px;height: 30px" class="inputxt">${scOkrPage.unfinishedReason}</textarea>
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
						    <textarea id="needOrgCode" name="needOrgCode" type="text" style="width: 150px" class="inputxt" ></textarea>
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
						     	 <input id="finishTime" name="finishTime"  type="text"  style="width: 150px" 
						     	 class="Wdate" 
						     	 onFocus=" WdatePicker()"   
						     	 value='${scOkrPage.finishTime}'>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">实际完成时间</label>
						</td>
					</tr>
			</table>
		</t:formvalid>
			<!-- 增加保存草稿按钮 -->
        <div style="text-align:center;margin-top: 5px;" >
			<a id="saveBtn" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="saveForm()">保存为草稿</a>
			<a id="submitBtn" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="submitForm()">转交下一步</a>
			<a id="cancelBtn" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onClick="cancelForm()">关闭</a>
		</div>
 </body>
  <script src = "webpage/com/jeecg/scokr/scOkr.js"></script>	

