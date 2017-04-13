<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>地域信息</title>
<t:base type="jquery,easyui,tools"></t:base>
<script type="text/javascript">
		
	$(function() {
		$('#cc').combotree({
			panelMaxHeight: 300,
			url : 'territoryController.do?setPTerritory',
			panelHeight:'auto',
			onClick: function(node){
				$("#territoryId").val(node.id);
			}
		});
		
		if($('#territoryLevel').val()=='1'){
			$('#pfun').show();
		}else{
			$('#pfun').hide();
		}
		
		
		$('#territoryLevel').change(function(){
			if($(this).val()=='1'){
				$('#pfun').show();
				var t = $('#cc').combotree('tree');
				var nodes = t.tree('getRoots');
				if(nodes.length>0){
					$('#cc').combotree('setValue', nodes[0].id);
					$("#territoryId").val(nodes[0].id);
				}
			}else{
				var t = $('#cc').combotree('tree');
				var node = t.tree('getSelected');
				if(node){
					$('#cc').combotree('setValue', null);
				}
				$('#pfun').hide();
			}
		});
	});
</script>

<style type="text/css">
.textbox .textbox-text{
	padding: 2px;
	height: 16px;
}
</style>

</head>
<body style="overflow-y: hidden" scroll="no">
<t:formvalid formid="formobj" layout="table" dialog="true" refresh="true" action="territoryController.do?saveTerritory">
	<input name="id" type="hidden" value="${territory.id}">
	
	<table style="width: 100%" cellpadding="0" cellspacing="1" class="formtable">
		<tr>
			<td align="right" width="25%" nowrap>
                <label class="Validform_label"> <t:mutiLang langKey="area.name"/>: </label>
            </td>
			<td class="value" width="85%">
               <input name="territoryName" class="inputxt" value="${territory.territoryName}" datatype="s2-15">
           	   <span class="Validform_checktip"><t:mutiLang langKey="areaname.rang2to15"/></span>
            </td>
		</tr>
		
		<tr>
			<td align="right" width="25%" nowrap>
                <label class="Validform_label"> <t:mutiLang langKey="area.level"/>: </label>
            </td>
			<td class="value" width="85%">
               <select name="territoryLevel" id="territoryLevel" datatype="*">
                <option value="0" <c:if test="${territory.territoryLevel eq 0}">selected="selected"</c:if>><t:mutiLang langKey="main.area"/></option>
                <option value="1" <c:if test="${territory.territoryLevel>0}"> selected="selected"</c:if>><t:mutiLang langKey="sub.area"/></option>
	           </select>
	           <span class="Validform_checktip"></span>
            </td>
		</tr>
		
		<tr id="pfun">
			<td align="right" width="25%" nowrap>
                <label class="Validform_label"> <t:mutiLang langKey="parent.area"/>: </label>
            </td>
			<td class="value" width="85%">
              <input id="cc"
                <c:if test="${territory.TSTerritory.territoryLevel eq 0}"> value="${territory.TSTerritory.id}"</c:if>
                <c:if test="${territory.TSTerritory.territoryLevel > 0}"> value="${territory.TSTerritory.territoryName}"</c:if>>
              <input id="territoryId" name="TSTerritory.id" style="display: none;" value="${territory.TSTerritory.id}">
            </td>
		</tr>
		
		<tr id="funorder">
			<td align="right" width="25%" nowrap>
                <label class="Validform_label"> <t:mutiLang langKey="area.code"/>: </label>
            </td>
			<td class="value" width="85%">
              <input name="territoryCode" class="inputxt" value="${territory.territoryCode}" datatype="*6-16">
            </td>
		</tr>
		
		<tr id="funorder">
			<td align="right" width="25%" nowrap>
               <label class="Validform_label"> <t:mutiLang langKey="display.order"/>: </label>
            </td>
			<td class="value" width="85%">
               <input name="territorySort" class="inputxt" value="${territory.territorySort}" datatype="n1-3">
            </td>
		</tr>
		
	</table>
	
	
	<%-- <fieldset class="step">
        <div class="form">
            <label class="Validform_label"> <t:mutiLang langKey="area.name"/>: </label>
            <input name="territoryName" class="inputxt" value="${territory.territoryName}" datatype="s2-15">
            <span class="Validform_checktip"><t:mutiLang langKey="areaname.rang2to15"/></span>
        </div>
        <div class="form">
            <label class="Validform_label"> <t:mutiLang langKey="area.level"/>: </label>
            <select name="territoryLevel" id="territoryLevel" datatype="*">
                <option value="0" <c:if test="${territory.territoryLevel eq 0}">selected="selected"</c:if>><t:mutiLang langKey="main.area"/></option>
                <option value="1" <c:if test="${territory.territoryLevel>0}"> selected="selected"</c:if>><t:mutiLang langKey="sub.area"/></option>
            </select>
            <span class="Validform_checktip"></span>
        </div>
        <div class="form" id="pfun">
            <label class="Validform_label"> <t:mutiLang langKey="parent.area"/>: </label>
            <input id="cc"
                <c:if test="${territory.TSTerritory.territoryLevel eq 0}"> value="${territory.TSTerritory.id}"</c:if>
                <c:if test="${territory.TSTerritory.territoryLevel > 0}"> value="${territory.TSTerritory.territoryName}"</c:if>>
            <input id="territoryId" name="TSTerritory.id" style="display: none;" value="${territory.TSTerritory.id}">
        </div>
        <div class="form" id="funorder">
            <label class="Validform_label"> <t:mutiLang langKey="area.code"/>: </label>
            <input name="territoryCode" class="inputxt" value="${territory.territoryCode}" datatype="*6-16">
        </div>
        <div class="form" id="funorder">
            <label class="Validform_label"> <t:mutiLang langKey="display.order"/>: </label>
            <input name="territorySort" class="inputxt" value="${territory.territorySort}" datatype="n1-3">
        </div>
	</fieldset> --%>
	
	
	
</t:formvalid>
</body>
</html>
