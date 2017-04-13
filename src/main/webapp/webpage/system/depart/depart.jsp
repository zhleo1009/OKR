<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>部门信息</title>
<t:base type="jquery,easyui,tools"></t:base>
<script type="text/javascript">
	$(function() {
		$('#cc').combotree({
			url : 'departController.do?setPFunction&selfId=${depart.id}',
            width: 155,
            onSelect : function(node) {
                changeOrgType();
                if('${depart.id}' == node.id){
                	layer.msg('<t:mutiLang langKey="common.department.parent.node.self"/>');
                	$('#cc').combotree('reset');
                }
            }
        });
       
        // 只有字节节点才能设置父类
        if('${isLeafNode}' == 'false'){
        	 $('#cc').combotree('disable');
        }
        
        if('${empty pid}' == 'false') { // 设置新增页面时的父级
            $('#cc').combotree('setValue', '${pid}');
        }
        
        // 设置机构类型：公司 or 组织|岗位
        if($("input[class='textbox-value']").val()=='') { // 第一级，只显示公司选择项
            var orgTypeSelect = $("#orgType");
            var companyOrgType = '<option value="1" <c:if test="${orgType=='1'}">selected="selected"</c:if>><t:mutiLang langKey="common.company"/></option>';
            orgTypeSelect.empty();
            orgTypeSelect.append(companyOrgType);
        } else { // 非第一级，不显示公司选择项
            $("#orgType option:first").remove();
        }
	});
	
    function changeOrgType() { // 处理组织类型，不显示公司选择项
        var orgTypeSelect = $("#orgType");
        var optionNum = orgTypeSelect.get(0).options.length;
        if(optionNum == 1) {
            $("#orgType option:first").remove();
            var bumen = '<option value="2" <c:if test="${orgType=='2'}">selected="selected"</c:if>><t:mutiLang langKey="common.department"/></option>';
            var gangwei = '<option value="3" <c:if test="${orgType=='3'}">selected="selected"</c:if>><t:mutiLang langKey="common.position"/></option>';
            orgTypeSelect.append(bumen).append(gangwei);
        }
    }
</script>

<!-- 修改下拉框样式 -->
<style type="text/css">
.textbox .textbox-text{
	padding: 2px;
	height: 16px;
}
</style>
</head>
<body style="overflow-y: hidden" scroll="no">

<t:formvalid formid="formobj" layout="table" dialog="true" action="systemController.do?saveDepart">
	<input id="id" name="id" type="hidden" value="${depart.id }">
	<table style="width: 100%" cellpadding="0" cellspacing="1" class="formtable">
		<tr>
			<td align="right" width="25%" nowrap>
                <label class="Validform_label">  <t:mutiLang langKey="common.department.name"/>:  </label>
            </td>
			<td class="value" width="85%">
                <input name="departname" class="inputxt" type="text" value="${depart.departname }"  datatype="s1-20">
            	<span class="Validform_checktip"><t:mutiLang langKey="departmentname.rang1to20"/></span>
            </td>
		</tr>
		<tr>
			<!-- 机构描述 -->
			<td align="right" width="25%" nowrap>
                <label class="Validform_label">  <t:mutiLang langKey="position.desc"/>:  </label>
            </td>
			<td class="value" width="85%">
			     <textarea name="description" class="inputxt" style="width: 300px; height: 80px;resize: none;">${depart.description }</textarea>
                 <%-- <input name="description" class="inputxt" value="${depart.description }" style="width: 300px; height: 100px;"> --%>
            </td>
		</tr>
		<tr>
			<td align="right" width="25%" nowrap>
                <label class="Validform_label">  <t:mutiLang langKey="parent.depart"/>:  </label>
            </td>
			<td class="value" width="85%">
                <input id="cc" name="TSPDepart.id" value="${depart.TSPDepart.id}">
            </td>
		</tr>
		<tr>
			<td align="right" width="25%" nowrap>
                <label class="Validform_label">  <t:mutiLang langKey="common.org.type"/>:  </label>
            </td>
			<td class="value" width="85%">
                 <select name="orgType" id="orgType">
	                <option value="1" <c:if test="${orgType=='1'}">selected="selected"</c:if>><t:mutiLang langKey="common.company"/></option>
	                <option value="2" <c:if test="${orgType=='2'}">selected="selected"</c:if>><t:mutiLang langKey="common.department"/></option>
	                <option value="3" <c:if test="${orgType=='3'}">selected="selected"</c:if>><t:mutiLang langKey="common.position"/></option>
	            </select>
            </td>
		</tr>
		<tr>
			<td align="right" width="25%" nowrap>
                <label class="Validform_label">  <t:mutiLang langKey="common.mobile"/>:  </label>
            </td>
			<td class="value" width="85%">
                <input name="mobile" class="inputxt" value="${depart.mobile }">
            </td>
		</tr>
		<tr>
			<td align="right" width="25%" nowrap>
                <label class="Validform_label">  <t:mutiLang langKey="common.fax"/>:  </label>
            </td>
			<td class="value" width="85%">
                <input name="fax" class="inputxt" value="${depart.fax }">
            </td>
		</tr>
		<tr>
			<td align="right" width="25%" nowrap>
                <label class="Validform_label">  <t:mutiLang langKey="common.address"/>:  </label>
            </td>
			<td class="value" width="85%">
                <input name="address" class="inputxt" value="${depart.address }" datatype="s1-50" style="width: 300px;">
            	<span class="Validform_checktip"><t:mutiLang langKey="departmentaddress.rang1to50"/></span>
            </td>
		</tr>
		<%-- 主要负责人 --%>
		<tr>
			<td align="right" width="25%" nowrap>
                <label class="Validform_label">  <t:mutiLang langKey="common.owner"/>:  </label>
            </td>
			<td class="value" width="85%">
				<input name="ownerIds" id="ownerIds" type="hidden" value="${ownerIds}">
                <input name="ownerNames" class="inputxt" value="${ownerNames }" id="realNameId" readonly="readonly" style="width: 300px;"/>
                <%-- 注意传入的为peUserId --%>
                <t:choose hiddenName="ownerIds" hiddenid="peUserId"
						url="userController.do?userMultipleSelectPecg" name="multiUserList"
						icon="icon-search" title="common.user.select" textname="realName" inputTextname="realNameId"
						isclear="true" isInit="true" width="900" height="500"
						minFlag="false" maxFlag="false" resize="false" multiType="user" />
			</td>
		</tr>
	</table>
</t:formvalid>



</body>
</html>
