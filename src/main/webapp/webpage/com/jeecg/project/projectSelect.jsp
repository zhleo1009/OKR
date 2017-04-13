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
            onExpand: zTreeOnExpand,
            onClick:onClick
        }
    };
    function onClick(event, treeId, treeNode){
        var departname = treeNode.name;
        var queryParams = $('#projectList1').datagrid('options').queryParams;
        queryParams.orgIds = treeNode.id;
        $('#projectList1').datagrid('options').queryParams=queryParams;
        $("#projectList1").datagrid("reload");
    }
    //加载展开方法
    function zTreeOnExpand(event, treeId, treeNode){
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
    }

    //首次进入加载level为1的
    $(function(){
        $.post(
                'departController.do?getDepartInfo',
                function(data){
                    var d = $.parseJSON(data);
                    if (d.success) {
                        var dbDate = eval(d.msg);
                        $.fn.zTree.init($("#departSelect"), setting, dbDate);
                    }
                }
        );
    });
</script>
<div class="easyui-layout" style="width:600px;height:500px;">
    
    <div data-options="region:'center'">
    
        <t:datagrid name="projectList1" title="请选择项目" actionUrl="projectController.do?datagrid"
                    fit="true" fitColumns="true" idField="id" queryMode="group" sortOrder="desc">
   <t:dgCol title="主键"  field="id"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="项目名称"  field="projectName"    queryMode="single" query="true" width="120"></t:dgCol>
   <t:dgCol title="所属部门"  field="org"   dictionary="t_s_depart,id,departname"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="备注信息"  field="remark"    queryMode="single"  width="120"></t:dgCol>
        </t:datagrid>
    </div>
</div>

<script type="text/javascript">

</script>
