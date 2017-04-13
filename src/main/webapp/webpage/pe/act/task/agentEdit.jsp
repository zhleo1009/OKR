<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<!DOCTYPE html>
<html>
<head>
	<title>编辑用户代理</title>
<%-- 	<script type="text/javascript" src="<%=basePath %>/pe/js/calendar/My97DatePicker/WdatePicker.js" ></script> --%>
	
	<script type="text/javascript">
		$(function() {
			$("[name='isall']").click(bpmAgent);
			$("#tofullname").val("${sysUserAgent.tofullname}");
			$("#touserid").val("${sysUserAgent.touserid}");
		});
		
		//待绑定事件
		//选择指定流程
		function bpmAgent(){
			var isall=$('input:radio:checked').val();
			if(isall==0){
				$("#bpmAgent").show();
			}else{
				$("#bpmAgent").hide();
			}
		};
		
		
		
		/* function dlgCallBack(defIds,subjects,defKeys){
			//删除空的记录
			$('#firstRow').remove();
			var newDefIds=defIds.split(",");
			var newSubjects=subjects.split(",");
			var newDefKeys=defKeys.split(",");
			for(var i=0,len=newDefKeys.length;i<len;i++){
				var defKey=newDefKeys[i];
				var subject=newSubjects[i];
				var row=$("#def_" + defKey);
				if(row.length>0) continue;
				var tr=getRow(newDefIds[i],defKey,subject);
				$("#bpmAgentItem").append(tr);
			}
		}; */
		
		function singleDel(obj){
			var tr=$(obj).parents('tr');
			$(tr).remove();
		};
		
		<%-- function getRow(id,defKey,subject){
			var aryRow=['<tr id="def_'+defKey+'"}">',
			'<td>',
			'<input type="hidden" name="defKey" value="'+defKey+'">',
			'<a href="<%=basePath %>/platform/bpm/bpmDefinition/get.ht?defKey='+defKey+'" target="_blank">',
			subject,
			'</a>',
			'</td>',
			'<td>',
			'	<a href="#" class="link del" onclick="singleDel(this);">删除</a>',
			'</td>',
			'</tr>',
			];
			return aryRow.join("");
		} --%>
		
		
		
	</script>
</head>
<body style="overflow-y: hidden" scroll="no">

<t:formvalid formid="formobj" layout="table" dialog="true" action="sysUserAgentController.do?save" tiptype="4">
					<input type="hidden" id="agentid" name="agentid" value="${sysUserAgent.agentid}" />
					<input type="hidden" id="agentuserid" name="agentuserid" value="${sysUserAgent.agentuserid}"  class="inputText"/>
					<table style="width: 100%" cellpadding="0" cellspacing="1" class="formtable">
					   <tr>
					        <th align="right" width="25%" nowrap><label class="Validform_label">执行代理人: </label></th>
							<td class="value" width="85%">
								<input name="touserid" id="touserid" type="hidden" value="">
								<input name="tofullname" id="tofullname" style="width: 200px" onclick="openUserSelect()" type="text" readonly="true" datatype="*">
								<span class="Validform_checktip"></span>
							</td>
						</tr>
						<tr>
							<th align="right" width="25%" nowrap><label class="Validform_label">开始时间: </label></th>
							<td class="value" width="85%"><input type="text" id="starttime" name="starttime" class="Wdate" datatype="*" onclick="WdatePicker({maxDate:'#F{$dp.$D(\'endtime\')}',dateFmt:'yyyy-MM-dd'})" 
							value="<fmt:formatDate value='${sysUserAgent.starttime}' pattern='yyyy-MM-dd'/>" /><span class="Validform_checktip"></span></td>
						</tr>
						<tr>	
							<th align="right" width="25%" nowrap><label class="Validform_label">结束时间: </label></th>
							<td class="value" width="85%"><input type="text" id="endtime" name="endtime"  class="Wdate" datatype="*" onclick="WdatePicker({minDate:'#F{$dp.$D(\'starttime\')}',dateFmt:'yyyy-MM-dd'})" 
							value="<fmt:formatDate value='${sysUserAgent.endtime}' pattern='yyyy-MM-dd'/>" /><span class="Validform_checktip"></span></td>
						</tr>
						<tr>
							<th align="right" width="25%" nowrap><label class="Validform_label">是否全权代理: </label></th>
							<td class="value" width="85%">
								<label>是<input type="radio"  name="isall" value="1" checked="checked"  <c:if test="${sysUserAgent.isall==1}"> checked="checked" </c:if> />
								否<input type="radio" name="isall" value="0"  <c:if test="${sysUserAgent.isall==0}"> checked="checked" </c:if> ></label>
							</td>
						</tr>
						<tr>
							<th align="right" width="25%" nowrap><label class="Validform_label">是否有效: </label></th>
							<td class="value" width="85%">
								<label>是<input type="radio" id="isvalid" name="isvalid" value="1" checked="checked" <c:if test="${sysUserAgent.isvalid==1}"> checked="checked" </c:if> />
								否<input type="radio" id="isvalid" name="isvalid" value="0"  <c:if test="${sysUserAgent.isvalid==0}"> checked="checked" </c:if> >	</label>
							</td>
						</tr>
					</table>
					
		<div <c:if test="${fn:length(bpmAgentList)==0}">
			style="display:none;"
			</c:if> id="bpmAgent">
		
		
					<label class="Validform_label">
					授权流程:
					</label>
					<a class="easyui-linkbutton l-btn l-btn-small l-btn-plain" plain="true" icon="icon-add"  href="#" onclick="addFlow();">添加代理流程</a>
				   	<table id="bpmAgentItem"  style="width:100%;overflow: scroll;"> 
				   		<thead>
				   			<tr bgcolor="#e6e6e6">
				    		<th>流程名称</th>
				    		<th width="150px">管理</th>
				    		</tr>
				    	</thead>
				    	<tbody id="def_tbody">
				    	<c:choose>
				    		<c:when test="${fn:length(bpmAgentList)>0}">
				    			<c:forEach items="${bpmAgentList}" var="bpmAgentItem">
						    		<tr id="def_${bpmAgentItem.defKey}" >
						    			<td style="text-align: center;">
						    				<input type="hidden" name="defKey" value="${bpmAgentItem.defKey}" />
						    				<%-- <a href="bpmDefinition.do?get&defKey=${bpmAgentItem.defKey}" target="_blank">${bpmAgentItem.subject}</a> --%>
						    				${bpmAgentItem.subject}
						    			</td>
						    			<td style="text-align: center;">
						    				<a href="#" class="link del" onclick="singleDel(this);">删除</a>
										</td>
						    		</tr>
						    	</c:forEach>
				    		</c:when>
				    		<c:otherwise>
				    			<tr id="firstRow">
				    				<td colspan="2" align="center">
				    					<font color='red'>没有选择代理的流程定义！</font>
				    				</td>
				    			</tr>
				    		</c:otherwise>
				    	</c:choose>
				    	
				    	</tbody>
				    </table>
			</div>
		
			<!-- <button type="button" id="btn_sub" onclick="saveEdit();" style="display:none;">保存</button> -->
</t:formvalid>
<script type="text/javascript">


/***保存***/
function saveEdit(pwind){
	var url="sysUserAgentController.do?save";
	$.post(url,{
			"agentid":$("#agentid").val(),
			"touserid":$("#touserid").val(),
			"tofullname":$("#realName").val(),
			"agentuserid":$("#agentuserid").val(),
			"starttime":$("#starttime").val(),
			"endtime":$("#endtime").val(),
			"isall":$('input[name="isall"]:checked').val(),
			"isvalid":$('input[name="isvalid"]:checked').val()
		},function(data){
			var dataObj = eval("(" + data + ")");
			if (dataObj.success) {
				layer.msg(dataObj.msg, {
					icon : 1
				});
				pwind.reflash();
			} else {
				layer.msg(dataObj.msg, {
					icon : 2
				});
			}
	});

};


/***人员选择器***/
function openUserSelect() {      
	$.dialog({
		content: 'url:'+'userController.do?userSelect',
		lock : true,
		zIndex: getzIndex(),
		width: '800px', 
		height: '500px', 
		title:'选择人员',
		opacity : 0.3,
		cache:false,
	    ok: function(){
	    	var iframe = this.iframe.contentWindow;
			var rowsData = iframe.$('#userList1').datagrid('getSelections');
			if (!rowsData || rowsData.length==0) {
		    	top.layer.msg('<t:mutiLang langKey="common.please.select.item"/>');
				return false;
			}
			//dialog  打开的页面返回选中的数据  rowsData
			//直接通过filed用户名[realName]
			var names=rowsData[0].realName;
			//获取回来的names存入当前页面的表单对象中
			$('#tofullname').val(names);
			$('#tofullname').blur();
			var ids=rowsData[0].peUserId;
			//获取回来的ids存入当前页面的表单对象中
			$('#touserid').val(ids); 
			return true;
	    },
	    cancelVal: '关闭',
	    cancel: true
	});
};


/*** 新增指定流程 ***/
function addFlow(){
	$.dialog({
		content: 'url:'+'bpmDefinitionController.do?selectProcess',
		lock : true,
		zIndex: getzIndex(),
		width: '800px', 
		height: '520px', 
		title:'选择流程',
		opacity : 0.3,
		cache:false,
	    ok: function(){
	    	var iframe = this.iframe.contentWindow;
	    	/* var userId = iframe.$('#selectedUsers').val();
			var rowsData = iframe.$('#userList1').datagrid('getSelections');
			if (!rowsData || rowsData.length==0) {
		    	top.layer.msg('<t:mutiLang langKey="common.please.select.item"/>');
				return false;
			}
			var names=rowsData[0].realName;
			$('#realName').val(names);
			$('#realName').blur();
			var ids=rowsData[0].peUserId;
			$('#touserid').val(ids); 
			return true; */
			
			var rowsData = iframe.$('#processDefList').datagrid('getSelections');
			//var defKeys = [];
			
			if(rowsData.length > 0 && $('#firstRow')){
				$('#def_tbody').empty();
				
			}else{
				
			}
			
			$.each(rowsData,function(i,val) {
				//defKeys.push(val.defKey);
				$('#def_tbody').append("<tr id='def_" + val.defKey + 
						"'><td style='text-align: center;'><input type='hidden' name='defKey' value='"+val.defKey+
						"' />"+val.subject+"</td><td style='text-align: center;'><a href='#' class='link del' onclick='singleDel(this);'>删除</a></td></tr>");
				
	         });
			
			//console.debug(defKeys);
			
	    },
	    cancelVal: '关闭',
	    cancel: true
	});
};


</script>


</body>
</html>
