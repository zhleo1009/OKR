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
            onClick: onClick
        },
		async: {
			enable: true,
			url: "departController.do?getDepartInfoByAsync",
			autoParam: ["id=parentid"]
		}
    };
 
 

    
    // 选择人员
    function check(index,row){
 
    	$('#selectedUsers').val(row.id) ;
    	
    	
    }
    
    // 取消人员选择
    function unCheck(index,row){
    	
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
    
    
    function init(){
    	$('#selectedUsers').val('');
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
 
    <div data-options="region:'center'" style="padding:0px;border:0px;" >
        <t:datagrid name="C" title="common.user.select" actionUrl="userController.do?datagrid" 
          onCheck="check"       onLoadSuccess="init"    fit="true" fitColumns="true" idField="id" queryMode="group" sortName="createDate" sortOrder="desc" 
                    >
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
            <t:dgCol title="common.pe.id" field="peUserId" ></t:dgCol>
            <t:dgCol title="common.status" sortable="true" field="status" replace="common.active_1,common.inactive_0,super.admin_-1" ></t:dgCol>
        </t:datagrid>
    </div>
    	<input id = "selectedUsers" type="hidden" />
   
   
</div>


