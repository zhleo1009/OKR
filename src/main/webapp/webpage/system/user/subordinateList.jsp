<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:datagrid name="subordinateList" title="common.operation" checkbox="true"
            actionUrl="userController.do?subordinateDatagrid&userid=${userid}" fit="true" fitColumns="true" idField="id" queryMode="group">
	<t:dgCol title="用户id" field="userId" hidden="true"></t:dgCol>
	<t:dgCol title="下属关系id" field="id" hidden="true"></t:dgCol>
	<t:dgCol title="common.username" sortable="false" field="userName" query="false"></t:dgCol>
	<t:dgCol title="common.real.name" field="realName" query="true" sortable="false"></t:dgCol>
	<t:dgCol title="common.status" sortable="false" field="status" replace="common.active_1,common.inactive_0,super.admin_-1"></t:dgCol>
	<t:dgCol title="common.operation" field="opt"></t:dgCol>
	<t:dgDelOpt title="common.remove" url="userController.do?delSubordinate&ids={id}" />
	
	<t:dgToolBar title="subordinate.input" langArg="common.user" icon="icon-add" url="userController.do?userMultipleSelectPecg" funname="chooseSubordinate"></t:dgToolBar>
	<t:dgToolBar title="common.remove" langArg="common.user" icon="icon-remove" url="userController.do?delSubordinate" funname="deleteALLSelect"></t:dgToolBar>
</t:datagrid>

<script type="text/javascript">

// 下属录入
function chooseSubordinate(title, addurl, gname) {
	
	$.dialog({
		content: 'url:'+addurl,
		lock : true,
		zIndex: getzIndex(),
		width:900,
		height:510,
		title:title,
		opacity : 0.3,
		cache:false,
	    ok: function(){
	    	var iframe = this.iframe.contentWindow;
			var ids = '';
			var realNames = '';
			$.each($(iframe.document.getElementById('selectedUsers')).find(
					'[userid]'), function(index, divElt) {
				if (!realNames) {
					realNames += $(divElt).attr('realname');
				} else {
					realNames += ',' + $(divElt).attr('realname');
				}
				if (!ids) {
					ids += $(divElt).attr('peuserid');
				} else {
					ids += ',' + $(divElt).attr('peuserid');
				}
			});
	    	
	    	$.ajax({
				url : 'userController.do?saveSubordinate',
				type : 'post',
				data : {
					ids : ids,
					realNames : realNames,
					userid : '${userid}'//上级用户id
				},
				cache : false,
				success : function(data) {
					var d = $.parseJSON(data);
					// 来源页面
					if (d.success) {
						var msg = d.msg;
						top.layer.msg(msg);
						$('#subordinateList').datagrid('unselectAll');
						$('#subordinateList').datagrid('reload');
						ids='';
					}
				}
			});  
			this.close();//关闭
	    	
			return false;
	    },
	    cancelVal: '关闭',
	    cancel: true
	});
	
}

</script>
