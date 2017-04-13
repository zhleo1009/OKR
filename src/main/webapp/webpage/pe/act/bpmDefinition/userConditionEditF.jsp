<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<style type="text/css">

.icon-save:hover {
  opacity: 1;
  filter: alpha(opacity=100);
  background-color: #E6E6E6;
  -moz-border-radius: -2px -2px -2px -2px;
  -webkit-border-radius: -2px -2px -2px -2px;
  border-radius: -2px -2px -2px -2px;
}

</style>

<div class="datagrid-toolbar" style="height: 25px;">
  <a href="#" onclick="addCondition();" data-options="iconCls:'icon-add'" class="easyui-linkbutton l-btn l-btn-small" id="addColumnBtn" group=""><span class="l-btn-left l-btn-icon-left"><span class="l-btn-text">添加</span><span class="l-btn-icon icon-add">&nbsp;</span></span></a>
  <a href="#" onclick="deleteCondition();" data-options="iconCls:'icon-remove'" class="easyui-linkbutton l-btn l-btn-small" id="delColumnBtn" group=""><span class="l-btn-left l-btn-icon-left"><span class="l-btn-text">删除</span><span class="l-btn-icon icon-remove">&nbsp;</span></span></a>
  <a href="#" onclick="deleteBatchCondition();" data-options="iconCls:'icon-remove'" class="easyui-linkbutton l-btn l-btn-small" id="resetColumnBtn" group=""><span class="l-btn-left l-btn-icon-left"><span class="l-btn-text">清空</span><span class="l-btn-icon icon-remove">&nbsp;</span></span></a>
  <a href="#" onclick="checkAndSubmit();" data-options="iconCls:'icon-save'" class="easyui-linkbutton l-btn l-btn-small" id="saveColumnBtn" group=""><span class="l-btn-left l-btn-icon-left"><span class="l-btn-text">保存</span><span class="l-btn-icon icon-save">&nbsp;</span></span></a>
  <!-- <a href="javascript:checkAndSubmit();" class="icon-save"></a> -->
</div>

<table style="height: 25px;width: 100%" id="tab_div_database_title">
    <tbody>
     <tr bgcolor="#E6E6E6">
		<th bgcolor="#EEEEEE" align="center" style="width: 5%;">序号</th>
		<th bgcolor="#EEEEEE" align="center" style="width: 5%;">操作</th>
		<th bgcolor="#EEEEEE" align="center" style="width: 15%;">类型</th>
		<th bgcolor="#EEEEEE" align="center" style="width: 30%;">用户类型</th>
		<th bgcolor="#EEEEEE" align="center" style="width: 30%;">用户来自</th>
		<th bgcolor="#EEEEEE" align="center" style="width: 15%;">运算类型</th>
	 </tr>
	</tbody>
</table>

<form method="post" id="defUserForm">
<input type="hidden" name="defId" value="${defId}" />											
<input type="hidden" id="conditionId" name="conditionId" value="${bpmUserCondition.id}" />

<div id="t_table_database" class="t_table" style="height: 300px;">
     <table class="table-list" id="tab_div_database" style="width: 100%">
       <tbody class="ui-sortable">
      
      <%-- 添加 --%> 
      <c:if test="${empty nodeUserMap.nodeUserList}">
      
	      <tr>
	        <td style="width: 5%;"  align="center">
		      	<a name="rownumber[#rindex#]">1</a>
	      	</td>
	      	<td style="width: 5%;"  align="center">
		      	<span><input type="checkbox" name="nodeUserCk"/></span>
	      	</td>
	      	<td style="width: 15%;"  align="center">
		      	<input type="hidden" name="nodeUserId" value=""/>
				<input type="hidden" name="nodeId" value="${nodeTag}"/>
				<input type="hidden" value="0" name="assignUseType">
		      	<span>[参与流程]</span>
	      	</td>
	        <td style="width: 30%;" align="center">
	        	<select name="assignType" style="width: 100%;" onchange="assignTypeChange(this)">
	        		<option value="0">发起人</option>
	        		<option value="1" selected="selected">用户</option>
	        		<option value="2">角色</option>
	        		<option value="3">组织</option>
	        		<option value="4">组织负责人</option>
	        		<option value="6">上下级</option>
	        		<option value="9">与发起人相同部门</option>
	        		<option value="10">与其他节点相同执行人</option>
	        		<option value="11">发起人的直属领导(组织)</option>
	        		<option value="13">上个任务执行人的直属领导(组织)</option>
	        		<option value="14">发起人的领导</option>
					<option value="15">上个任务执行人的领导</option>
	        	</select>
	        </td>
	        <td style="width: 30%;" align="center">
	        	<input type="hidden" name="cmpIds" value=""/><!-- todo -->
	        	<textarea style="width: 100%;" class="inputxt" name="cmpNames" readonly="readonly" id="cmpNames1" onfocus="textAreaFocus(this)"></textarea>
	        </td>
	        <td style="width: 15%;" align="center">
	        	<select name="compType" style="width: 100%;">
					<option value="0" >或运算</option>
					<option value="1" selected="selected">与运算</option>
					<option value="2" >排除</option>
				</select>
	        </td>
	      </tr>
      
      </c:if>  
      
      <%-- 更新 --%> 
      <c:if test="${!empty nodeUserMap.nodeUserList}">
      
      	 <c:forEach items="${nodeUserMap.nodeUserList}" var="userNode" varStatus="status">
	      <tr>
	      
	      	<td style="width: 5%;"  align="center">
		      	<a name="rownumber[#rindex#]">${status.index + 1}</a>
	      	</td>
	      	<td style="width: 5%;"  align="center">
		      	<span><input type="checkbox" name="nodeUserCk"/></span>
	      	</td>
	      	<td style="width: 15%;"  align="center">
				<input type="hidden" name="nodeUserId" value="${userNode.nodeUserId}"/>
				<input type="hidden" name="nodeId" value="${userNode.nodeId}"/>
				<input type="hidden" name="assignUseType" value="${userNode.assignUseType}"/>		
		      	<span>
			      	<c:choose>
						<c:when test="${userNode.assignUseType==0}">[参与流程]</c:when>
						<c:when test="${userNode.assignUseType==1}">[接收通知]</c:when>														
					</c:choose>
		      	</span>
	      	</td>
	      
	      	<%-- <td style="width: 160px;"  align="center">
	      	<input type="checkbox" name="nodeUserCk"/>
	      	${status.index + 1}&nbsp;
	      	
	      	</td> --%>
	      	
	        <td style="width: 30%;" align="center">
	        	<input type="hidden" name="assignType" value="${userNode.assignType}"/>
	        	<span>${userSetTypes[userNode.assignType]}</span>
	        </td>
	        <td style="width: 30%;" align="center">
	        <input type="hidden" name="cmpIds" value='${userNode.cmpIds}'/>
	        <c:choose>
				<c:when test="${userNode.assignType==0 
											or userNode.assignType==9 
											or userNode.assignType==11 
											or userNode.assignType==13
											or userNode.assignType==14
											or userNode.assignType==15}">
	        		<textarea style="width: 100%;display:none;" class="inputxt" name="cmpNames" readonly="readonly" onfocus="textAreaFocus(this)">${userNode.cmpNames}</textarea>
	        	</c:when>
	        	<c:otherwise>
	        		<textarea style="width: 100%" class="inputxt" name="cmpNames"  readonly="readonly" onfocus="textAreaFocus(this)">${userNode.cmpNames}</textarea>
	        	</c:otherwise>
	        </c:choose>
	        </td>
	        <td style="width: 15%;" align="center">
	        	<select name="compType" onfocus="" onchange="" style="width: 100%">
					<option value="0" <c:if test="${userNode.compType == 0}">selected</c:if> >或运算</option>
					<option value="1" <c:if test="${userNode.compType == 1}">selected</c:if> >与运算</option>
					<option value="2" <c:if test="${userNode.compType == 2}">selected</c:if> >排除</option>
				</select>
	        </td>
	      </tr>
	      </c:forEach>
      
      </c:if>  
       
			
	</tbody>
   </table>
	 
		
 <br><br><br>
</div>
</form>

<input type="hidden" name="sn" value="${bpmUserCondition.sn}" />
<input type="hidden" name="actDefId" value="${actDefId}" />
<input type="hidden" name="outnodeId" value="${nodeTag}" />
<input type="hidden" name="setId" value="${setId}" />
<input type="hidden" name="variableids"  value="${bpmUserCondition.tableId}"/>

<!-- 添加easy ui 支持 拖拽table -->
<script type="text/javascript" src="plug-in/jquery-ui/js/jquery-ui-1.9.2.custom.min.js"/>

<script type="text/javascript">

$(function(){
	// 错误信息提示
	if('${errorMsg}'){
		layer.msg('${errorMsg}');
	}
	delConds = '';
});

//添加条件dom
function addCondition(){
	
	var index = $('#tab_div_database tr').length + 1;
	
	$('#tab_div_database').append('<tr><td style="width:5%" align="center"><a name="rownumber[#rindex#]">'+index+'</a></td><td style="width:5%" align="center"><span><input type="checkbox" name="nodeUserCk"></span></td><td style="width:15%" align="center"><input type="hidden" name="nodeUserId" value=""> <input type="hidden" name="nodeId" value="${nodeTag}"> <input type="hidden" value="0" name="assignUseType"> <span>[参与流程]</span></td><td style="width:30%" align="center"><select name="assignType" style="width:100%" onchange="assignTypeChange(this)"><option value="0">发起人</option><option value="1" selected>用户</option><option value="2">角色</option><option value="3">组织</option><option value="4">组织负责人</option><option value="6">上下级</option><option value="9">与发起人相同部门</option><option value="10">与其他节点相同执行人</option><option value="11">发起人的直属领导(组织)</option><option value="13">上个任务执行人的直属领导(组织)</option><option value="14">发起人的领导</option><option value="15">上个任务执行人的领导</option></select></td><td style="width:30%" align="center"><input type="hidden" name="cmpIds" value=""><textarea style="width:100%" class="inputxt" name="cmpNames" readonly id="cmpNames1" onfocus="textAreaFocus(this)"></textarea></td><td style="width:15%" align="center"><select name="compType" style="width:100%"><option value="0">或运算</option><option value="1" selected="selected">与运算</option><option value="2">排除</option></select></td></tr>');
	
}

// 删除的节点
var delConds;

//删除条件dom
function deleteCondition(){
	
	var checkedBoxs = $('input:checkbox[name=nodeUserCk]:checked');
	if(checkedBoxs){
		checkedBoxs.each(function(){
			var nodeUserId = $(this).parents("tr").find("input[name='nodeUserId']")[0].value;
			delConds += nodeUserId + ',';
			var tr = $(this).parents('tr')[0];
			 tr.remove();
			/* $.ajax({
				  type: 'POST',
				  url: 'bpmDefinitionController.do?delBpmNodeUser',
				  data: {nodeUserId: nodeUserId},
				  success: function(data){
					  if(data.success){
						  tr.remove();
					  }
				  } ,
				  dataType: 'json'
			}); */
			
		});
	}
	
	
	//重置编号
	resetTrNum("#tab_div_" + filedTypes[0]);
	
}

// 批量删除条件dom
function deleteBatchCondition(){
	$('#tab_div_database tbody').empty();
}

// 用户类型改变
function assignTypeChange(obj){
	
	var val = $(obj).val();
	if(val == 0 || val == 9 || val == 11 || val == 13 || val == 14 || val == 15){
		$(obj).parents('tr').find('textarea').hide();
	}else{
		$(obj).parents('tr').find('textarea').show();
	}
	
}


// 保存并提交（包含添加和更新）
function checkAndSubmit(){
	
	if($('#tab_div_database tr').length == 0){
		layer.msg('规则不能为空！');
		return;
	}
	
	if(delConds){
		 $.ajax({
			  type: 'POST',
			  url: 'bpmDefinitionController.do?delBpmNodeUser',
			  data: {nodeUserIds: delConds},
			  success: function(data){
				  if(data.success){
					  
				  }
			  } ,
			  dataType: 'json'
		}); 
		 
	 }
	
	var conditionName = '默认规则';
	
	//var tbodyList=$("#ruleList");
	var conditionId=$('input[name="conditionId"]').val();
	var actDefId=$('input[name="actDefId"]').val();
	var nodeId=$('input[name="outnodeId"]').val();
	var setId=$('input[name="setId"]').val();
	var sn=$('input[name="sn"]').val();
	
	var conditionArray="[]";
	var conditionShow="";
	var currentIndex=0;
	var variableids=$('input[name="variableids"]:first').val();
	
	$('textarea[name=cmpNames]').each(
			function(){		
				var select=$(this).parents('tr').find('select[name="assignType"]');
				if(select.length>0){//新增
					var asstypeStr=$(select).find("option:selected").text();
					if(currentIndex==0){
						conditionShow+="人员选择类型:";
					}
					if($.trim($(this).val()).length>0){
						conditionShow+=asstypeStr+":"+$(this).val()+";";
					}else{
						conditionShow+=asstypeStr+";";
					}
				}else{//更新
					var asstypeStr=$.trim($(this).parents('tr').find('td').eq(3).find('span').html());
					if(currentIndex==0){
						conditionShow+="人员选择类型:";
					}
					if($.trim($(this).val()).length>0){
						conditionShow+=asstypeStr+":"+$(this).val()+";";
					}else{
						conditionShow+=asstypeStr+";";
					}
				}			
			}
	);
	
	// 传递参数
	var postData={
			'setId':setId,
			'actDefId':actDefId,
			'nodeId':nodeId,
			'conditionShow':conditionShow,
			'condition':conditionArray,
			'conditionName':conditionName,
			'conditionId':conditionId,
			'variableids':variableids,
			'sn':sn
	};
	
	
		 $.ajax({
			  type: 'POST',
			  url: 'bpmDefinitionController.do?saveUserCondition',
			  data: postData,
			  success: function(data){
				  if(data.success){
					  
					  if(!conditionId){// 添加
						  $('input[name="conditionId"]').val(data.attributes.conditionId);
					  }
						 
					  
					  // 进一步保存节点人员设置
					  /*  $.ajax({
						  type: 'POST',
						  url: 'bpmDefinitionController?saveNodeUser.do&' + $("#defUserForm").serialize(),
						  data: postData,
						  success: function(data){
							  top.layer.msg(data.msg);
						  } ,
						  dataType: 'json'
					  });  */
					  
					  $.post('bpmDefinitionController.do?saveNodeUser', $("#defUserForm").serialize(), function(data){
						  var resultJson=eval('('+data+')');
						  if(resultJson.success){
							  reloadNodePerson();
							  $('#east').empty();
						  }
						  layer.msg(resultJson.msg);
					  });
					  
				  }else{
					  layer.msg(data.msg);
				  }
			  } ,
			  dataType: 'json'
		});  
	
		 
		 
		 
}



// 拖拽排序
var fixHelper = function(e, ui) {
    ui.children().each(function() {
        $(this).width($(this).width());
    });
    return ui;
};

var filedTypes = ['database'];

// 拖动改变序号
$("#tab_div_database tbody").sortable({
    helper: fixHelper,
    items: '> tr',
    forcePlaceholderSize: true,
    stop: function (event, ui) {
    	var textContent = ui.item.context.innerText?
    			ui.item.context.innerText.toString():
    				ui.item.context.textContent.toString();
    	var endString = textContent.indexOf("S")!=-1?textContent.indexOf("S"):textContent.length;
    	var startRownum = textContent.substring(0,endString).replace(/(^\s*)|(\s*$)/g,'');
    	var targetIndex = ui.item.context.rowIndex;
    	for (var i = 0; i < filedTypes.length; i++) {
    		if(filedTypes[i] == "database" && startRownum != (targetIndex + 1)) continue;
    		if(startRownum == (targetIndex + 1)){  //处理当前行和下一行交换位置
    			$("#tab_div_" + filedTypes[i]).find("tr").eq(startRownum).insertBefore($("#tab_div_" + filedTypes[i]).find("tr").eq(targetIndex));
    		}else if(startRownum > targetIndex){
    			$("#tab_div_" + filedTypes[i]).find("tr").eq(startRownum-1).insertBefore($("#tab_div_" + filedTypes[i]).find("tr").eq(targetIndex));
    		} else {
    			$("#tab_div_" + filedTypes[i]).find("tr").eq(startRownum-1).insertAfter($("#tab_div_" + filedTypes[i]).find("tr").eq(targetIndex));
    		}
    	}
    	
    	for (var i = 0; i < filedTypes.length; i++) {
    		resetTrNum("#tab_div_" + filedTypes[i]);
    	}
    }
});

/**
 * 重置table编号
 */
function resetTrNum(tableId) {
	$(tableId + " tbody tr").each(function(i) {
		$(':input, select,a', this).each(function() {
					var $this = $(this), name = $this.attr('name'), val = $this
							.val();
					if (name != null && name.indexOf("#index#") >= 0) {
						$this.attr("name", name.replace('#index#', i));
					}
					if (name != null && name.indexOf("rownumber") >= 0) {
						$this.html(i+1); 
					}
					
				});
	});
}

//
function textAreaFocus(obj){
	
	var input = $(obj).prev();
	var selectVal = $(obj).parent('td').prev().find('select').find("option:selected").val();
	
	if(!selectVal){
		selectVal = $(obj).parent('td').prev().find('input').val();
	}
	switch(selectVal){
	case '1':
		showMultiUserSelector(obj,input);
		break;
	case '2':
		showMultiRoleSelector(obj,input);
		break;
	case '3':
		showMultiDepartSelector(obj,input);
		break;
	case '4':
		showMultiDepartSelector(obj,input);
		break;
	case '6':
		showUserUpLow(obj,input);
		break;
	case '10':
		showTaskNodeSelector(obj,input);
		break;
	}
}

// 打开人员选择器
function showMultiUserSelector(fromElt,hiddenElt){
	var url = 'userController.do?userMultipleSelectPecg';
    var initValue = hiddenElt.val();
    url += '&ids=' + initValue;
	$.dialog({
        content: 'url:' + url,
        zIndex: layer.zIndex,
        title: '用户选择',
        lock: true,
        width: 900,
        height: 520,
        left: '50%',
        top: '50%',
        opacity: 0.4,
        button: [{
            name: '确定',
            callback: function(){
            	var iframe = this.iframe.contentWindow;
            	var realName = '';
                var id = '';
                $.each($(iframe.document.getElementById('selectedUsers')).find('[userid]'),
            	    function(index, divElt) {
            	        if (!realName) {
            	            realName += $(divElt).attr('realname');
            	        } else {
            	            realName += ',' + $(divElt).attr('realname');
            	        }
            	        if (!id) {
            	            id += $(divElt).attr('peuserid');
            	        } else {
            	            id += ',' + $(divElt).attr('peuserid');
            	        }
            	    });
                if ($(fromElt)) {
                    $(fromElt).val(realName);
                    $(fromElt).blur();
                }
                if (id !== undefined && id != "") {
                    $(hiddenElt).val(id);
                }
            	
            },
            focus: true
        },
        {
            name: '关闭',
            callback: function() {}
        }]
    });
	
}


//打开角色选择器
function showMultiRoleSelector(fromElt,hiddenElt){
	var url = 'userController.do?roles';
	var initValue = hiddenElt.val();
    url += '&ids=' + initValue;
	$.dialog({
        content: 'url:' + url,
        zIndex: top.layer.zIndex,
        title: '角色列表',
        lock: true,
        width: 400,
        height: 350,
        left: '50%',
        top: '50%',
        opacity: 0.4,
        button: [{
            name: '确定',
            callback: function(){
            	var iframe = this.iframe.contentWindow;
                var roleName = iframe.getroleListSelections('roleName');
                
                if ($(fromElt)) {
                    $(fromElt).val(roleName);
                    $(fromElt).blur();
                }
                
                var id = iframe.getroleListSelections('peId');
                if (id !== undefined && id != "") {
                    $(hiddenElt).val(id);
                }
            	
            },
            focus: true
        },
        {
            name: '关闭',
            callback: function() {}
        }]
    });
	
	
}


//打开组织选择器
function showMultiDepartSelector(fromElt, hiddenElt) {
	$.dialog({
		content : 'url:departController.do?departSelect',
		zIndex : top.layer.zIndex,
		title : '组织机构列表',
		lock : true,
		width : '400px',
		height : '350px',
		opacity : 0.4,
		min : false,
		button : [ {
			name : '确定',
			callback : function (){
				
				  var iframe = this.iframe.contentWindow;
				  var treeObj = iframe.$.fn.zTree.getZTreeObj("departSelect");
				  var nodes = treeObj.getCheckedNodes(true);
				  if(nodes.length>0){
				  var ids='',names='';
				  for(i=0;i<nodes.length;i++){
				     var node = nodes[i];
				     
				     if(!ids){
				    	 ids += node.peId;
				     }else{
				    	 ids += ',' + node.peId;
				     }
				     
				     if(!names){
				    	 names += node.name;
				     }else{
				    	 names += ',' + node.name;
				     }
				 }
				 $(fromElt).val(names);
				 $(fromElt).blur();		
				 $(hiddenElt).val(ids);		
				}
				
			},
			focus : true
		}, {
			name : '关闭',
			callback : function() {
			}
		} ]
	});

}


// 任务任务节点列表
function showTaskNodeSelector(fromElt, hiddenElt) {
	$.dialog({
		content : 'url:bpmDefinitionController.do?toTaskNodesView&actDefId=${actDefId}&nodeId=${nodeTag}',
		zIndex : top.layer.zIndex,
		title : '选择任务节点',
		lock : true,
		width : '300px',
		height : '300px',
		opacity : 0.4,
		min : false,
		button : [ {
			name : '确定',
			callback : function (){
				var iframe = this.iframe.contentWindow;
				var node = iframe.getSelectedTaskNode();
				
				if(node){
					$(fromElt).val(node[1]);
					$(fromElt).blur();		
					$(hiddenElt).val(node[0]);		
				}else{
					return false;
				}
				
			},
			focus : true
		}, {
			name : '关闭',
			callback : function() {
			}
		} ]
	});

}

// 打开人员上下级对话框
function showUserUpLow(fromElt, hiddenElt){
	
	$.dialog({
		content : 'url:bpmDefinitionController.do?toUserNodeUpLowView',
		zIndex : top.layer.zIndex,
		title : '上下级选择',
		lock : true,
		width : '600px',
		height : '300px',
		opacity : 0.4,
		min : false,
		button : [ {
			name : '确定',
			callback : function (){
				
				/* var iframe = this.iframe.contentWindow;
				var node = iframe.getSelectedTaskNode();
				
				if(node){
					$(fromElt).val(node[1]);
					$(fromElt).blur();		
					$(hiddenElt).val(node[0]);		
				}else{
					return false;
				} */
				
				var iframe = this.iframe.contentWindow;
				var result = iframe.selectUplow();
				
				$(fromElt).val(result.show);
				$(fromElt).blur();		
				$(hiddenElt).val(result.json);		
				
			},
			focus : true
		}, {
			name : '关闭',
			callback : function() {
			}
		} ]
	});
	
}




</script>
