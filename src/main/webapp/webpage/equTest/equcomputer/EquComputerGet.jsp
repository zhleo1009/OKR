<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<html>
<head>

</head>
<body style="overflow-y: hidden" scroll="no" >
<t:formvalid formid="formobj" dialog="false"  layout="table" >
		<table style="width: 100%" cellpadding="0" cellspacing="1"
			class="formtable">
			<tr>
				<th align="right" width="20%" nowrap><label
					class="Validform_label">设备名称</label></th>
				<td class="value" width="30%">${EquComputer.FName}</td>
				<th align="right" width="20%" nowrap><label
					class="Validform_label">设备类型</label></th>
				<td class="value" width="30%">${EquComputer.FType}</td>
			</tr>
			<tr>
				<th align="right" width="20%" nowrap><label
					class="Validform_label">设备型号</label></th>
				<td class="value" width="30%">${EquComputer.FModel}</td>
				<th align="right" width="20%" nowrap><label
					class="Validform_label">联网类型</label></th>
				<td class="value" width="30%">${EquComputer.FInternettype}</td>
			</tr>
			<tr>
				<th align="right" width="20%" nowrap><label
					class="Validform_label">涉密性</label></th>
				<td class="value" width="30%">${EquComputer.FSecurity}</td>
				<th align="right" width="20%" nowrap><label
					class="Validform_label">机器编号</label></th>
				<td class="value" width="30%">${EquComputer.FNum}</td>
			</tr>

			<tr>
				<th align="right" width="20%" nowrap><label
					class="Validform_label">操作系统</label></th>
				<td class="value" width="30%">${EquComputer.FOperating}</td>
				<th align="right" width="20%" nowrap><label
					class="Validform_label">使用情况</label></th>
				<td class="value" width="30%">${EquComputer.FUse}</td>
			</tr>
			<tr>
				<th align="right" width="20%" nowrap><label
					class="Validform_label">责任人</label></th>
				<td class="value" width="30%">${EquComputer.FPersonname}</td>
				<th align="right" width="20%" nowrap><label
					class="Validform_label">责任部门</label></th>
				<td class="value" width="30%">${EquComputer.FDeptname}</td>
			</tr>

			<tr>
				<th align="right" width="20%" nowrap><label
					class="Validform_label">IP</label></th>
				<td class="value" width="30%">${EquComputer.FIp}</td>
				<th align="right" width="20%" nowrap><label
					class="Validform_label">Mac地址</label></th>
				<td class="value" width="30%">${EquComputer.FMac}</td>
			</tr>
		</table>
	</t:formvalid>
</body>
</html>
