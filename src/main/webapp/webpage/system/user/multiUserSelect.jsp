<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>

<link rel="stylesheet" type="text/css" href="plug-in/ztree/css/zTreeStyle.css">
<script type="text/javascript" src="plug-in/ztree/js/jquery.ztree.core-3.5.min.js"></script>
<script type="text/javascript" src="plug-in/ztree/js/jquery.ztree.excheck-3.5.min.js"></script>
<%--update-start--Author:wangkun  Date:20160327 TASK #956 【UI标签】封装选择用户标签--%>
<script type="text/javascript">
    var setting = {
        check: {
            enable: false,
            chkboxType: { "Y": "", "N": "" }
        },
        data: {
            simpleData: {
                enable: true
            }
        },callback: {
            //onExpand: zTreeOnExpand,
            onClick: onClick
        },
		async: {
			enable: false,
			url: "departController.do?getDepartInfoByAsync",
			autoParam: ["id=parentid"]
		}
    };
    
    //点击节点，展现右侧列表
    function onClick(event, treeId, treeNode){
        var departname = treeNode.name;
        var queryParams = $('#multiUserList').datagrid('options').queryParams;
        queryParams.orgIds = treeNode.id;
        $('#multiUserList').datagrid('options').queryParams=queryParams;
        $("#multiUserList").datagrid("reload");
    }
    
    //异步加载树的节点
  /*   function zTreeOnExpand(event, treeId, treeNode){
        var treeNodeId = treeNode.id;
        $.post(
                'departController.do?getDepartInfo',
                {parentid:treeNodeId},
                function(data){
                    var d = $.parseJSON(data);
                    if (d.success) {
                        var dbDate = eval(d.msg);
                        var tree = $.fn.zTree.getZTreeObj("departSelect");
                        tree.addNodes(treeNode, dbDate);
                    }
                }
        );
    } */

    // 首次进入加载level为1的部门树
    $(function(){
        $.post(
                'departController.do?getAllDepartInfo',
                function(data){
                    var d = $.parseJSON(data);
                    if (d.success) {
                        var dbDate = eval(d.msg);
                        $.fn.zTree.init($("#departSelect"), setting, dbDate);
                        var departSelect = $.fn.zTree.getZTreeObj("departSelect"); 
    					departSelect.expandAll(true); 
                    }
                }
        );
        
    });
    
    // 选择人员
    function check(index,row){
    	
    	//console.debug($('#selectedUsers').find("[userId='" + row.id + "']").length);
    	if($('#selectedUsers').find("[userid='" + row.id + "']").length == 0){
    		$('#selectedUsers').append("<div class='alert-info' peuserid='" + row.peUserId + 
        			"' realname='" + row.realName + "' userid='" + row.id + "'><button class='close' type='button' onclick='removeBtn(this)'>×</button>" 
        			+ row.realName + "</div>");
    	}
    	
    }
    
    // 取消人员选择
    function unCheck(index,row){
    	
    	//console.debug($('#selectedUsers').find("[userId='" + row.id + "']"));
    	var users = $('#selectedUsers').find("[userid='" + row.id + "']");
    	if(users.length > 0){
    		users[0].remove();
    		/* users.each(function(){
    		    $(this).remove();
    		}); */
    	} 
    	
    }
    
    
    function checkAll(rows){
    	
    	$.each(rows, function(index,row) {   
            check(index,row);
         });  
   
    }
    
    
    function unCheckAll(rows){
   		$.each(rows, function(index,row) {   
       		unCheck(index,row);
         }); 
    }
    
    // 移除自身btn
    function removeBtn(obj){
    	$(obj).parent().remove();
    	
    }
    
    
    // 初始化selectedUsers
    function init(){
    	
    	var selectedUsers = eval('${selectedUsersJson}');
    	
    	if(selectedUsers){
    		$.each(selectedUsers, function(index,obj){
        		$('#selectedUsers').append("<div class='alert-info' peuserid='" + obj.peUserId + 
            			"' realname='" + obj.realName + "' userid='" + obj.id + "'><button class='close' type='button' onclick='removeBtn(this)'>×</button>" 
            			+ obj.realName + "</div>");
        		
        		//勾选已选择人员
        		$.each($('#multiUserList').datagrid('getRows'), function(index,row){
            		
            		if(row.id == obj.id){
            			$('#multiUserList').datagrid('checkRow',index);
            		}
            		
            	});
        		
        	});
    	}
    	
    	
    }
    
</script>


<style type="text/css">

.alert-info {
  border-color: #3C8DBC;
  color: #31708f;
  background-color: #3C8DBC !important;
  margin: 3px;
  border-radius: 3px;
  color: #fff !important;
  font-weight: bold;
  padding: 3px;
}

.close {
  color: inherit;
  position: relative;
  right: -160px;
  top: -2px;
  color: #000;
  opacity: 0.6;
  cursor: pointer;
  background: rgba(0, 0, 0, 0) none repeat scroll 0 0;
  border: 0 none;
  cursor: pointer;
  padding: 0;
  
}

.close:hover{
  opacity: 1;
}


</style>
<div class="easyui-layout" style="width:100%;height:500px;margin-top: 8px;">
    <div data-options="region:'west',split:true" title="<t:mutiLang langKey='common.department'/>" style="width: 220px;">
        <ul id="departSelect" class="ztree"></ul>
    </div>
    <div id="selectedUsers" data-options="region:'east',split:true" title="<t:mutiLang langKey='common.selected.user'/>" style="width: 200px;">
    
    	<%-- <c:forEach items="${selectedUsers }" var="user">
    		<div userId="${user.id }" peUserId="${user.peUserId }" userReal="${user.realName }" class="alert-info">
    			<button onclick="removeBtn(this)" type="button" class="close">×</button>${user.realName }
    		</div>
    	</c:forEach> --%>
    
    </div>
    <div data-options="region:'center'" style="padding:0px;border:0px;" >
        <t:datagrid name="multiUserList" title="common.user.select" actionUrl="userController.do?datagrid" checkbox="true" 
                    fit="true" fitColumns="true" idField="id" queryMode="group" sortName="createDate" sortOrder="desc" onLoadSuccess="init"
                     onCheck="check" onUncheck="unCheck" onCheckAll="checkAll" onUncheckAll="unCheckAll">
            <t:dgCol title="common.id" field="id" hidden="true"></t:dgCol>
            <t:dgCol title="common.username" sortable="false" field="userName" query="true"  ></t:dgCol>
            <t:dgCol title="common.department" sortable="false" field="userOrgList.tsDepart.departname" query="false"></t:dgCol>
            <t:dgCol title="common.real.name" field="realName" query="true"></t:dgCol>
            <t:dgCol title="common.role" field="userKey" ></t:dgCol>
            <t:dgCol title="common.createby" field="createBy" hidden="true"></t:dgCol>
            <t:dgCol title="common.createtime" field="createDate" formatter="yyyy-MM-dd" hidden="true"></t:dgCol>
            <t:dgCol title="common.updateby" field="updateBy" hidden="true"></t:dgCol>
            <t:dgCol title="common.updatetime" field="updateDate" formatter="yyyy-MM-dd" hidden="true"></t:dgCol>
            <%-- pe系统userId --%>
            <t:dgCol title="common.pe.id" field="peUserId" hidden="true"></t:dgCol>
            <t:dgCol title="common.status" sortable="true" field="status" replace="common.active_1,common.inactive_0,super.admin_-1" ></t:dgCol>
        </t:datagrid>
    </div>
   
   
   
</div>


