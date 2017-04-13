<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>

<script type="text/javascript" src="plug-in/mutiLang/zh-cn.js"></script>
<script type="text/javascript" src="plug-in/jquery/jquery-1.8.3.js"></script>
<script type="text/javascript" src="plug-in/jquery/jquery.cookie.js"></script>
<script type="text/javascript"
	src="plug-in/jquery-plugs/storage/jquery.storageapi.min.js"></script>
<script type="text/javascript" src="plug-in/tools/dataformat.js"></script>
<link id="easyuiTheme" rel="stylesheet"
	href="plug-in/easyui_1.4.4/themes/bootstrap/easyui.css" type="text/css"></link>
<link id="easyuiTheme" rel="stylesheet"
	href="plug-in/easyui/themes/metrole/icon.css" type="text/css"></link>
<link rel="stylesheet" type="text/css"
	href="plug-in/accordion/css/accordion.css">
<script type="text/javascript"
	src="plug-in/easyui_1.4.4/jquery.easyui.min.js"></script>
<script type="text/javascript"
	src="plug-in/easyui_1.4.4/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="plug-in/tools/syUtil.js"></script>
<script type="text/javascript"
	src="plug-in/easyui_1.4.4/extends/datagrid-scrollview.js"></script>
<link rel="stylesheet"
	href="plug-in/easyui_1.4.4/themes/bootstrap/lq.fieldset.css">
<script type="text/javascript"
	src="plug-in/easyui_1.4.4/extends/lq.fieldset.js"></script>
<script type="text/javascript"
	src="plug-in/My97DatePicker/WdatePicker.js"></script>
<link rel="stylesheet" href="plug-in/tools/css/common.css"
	type="text/css"></link>
<script type="text/javascript"
	src="plug-in/lhgDialog/lhgdialog.min.js?skin=idialog"></script>
<script type="text/javascript"
	src="plug-in/lte/bootstrap/js/bootstrap-tab.js"></script>
<script type="text/javascript" src="plug-in/tools/curdtools_zh-cn.js"></script>
<script type="text/javascript" src="plug-in/tools/easyuiextend.js"></script>
<script type="text/javascript"
	src="plug-in/jquery-plugs/hftable/jquery-hftable.js"></script>
<script type="text/javascript" src="plug-in/tools/json2.js"></script>
<script type="text/javascript" src="plug-in/layer/layer.js"></script>
<script type="text/javascript">
	function showBpmStatus(value, row, index) {
		//判断value是否是未完成。如果是可以点击  也就是A标签 最好红色展示。如果已完成则展示文字即可
		var showStr = "";
		var href = '';
		if (value == 2) {
			showStr = "<span style='color: red;'>待完成</span>";
			href += "<a  href='javascript:void(0);' onclick=edit(" + row.id
					+ ")>";
			href += showStr + "</a>";
		} else if (value == 1) {
			showStr = "已完成";
			href += showStr;
		} else if (value == 3) {
			showStr = "<span style='color: green;'>草稿</span>";
			href += "<a  href='javascript:void(0);' onclick=edit(" + row.id
					+ ")>";
			href += showStr + "</a>";

		}
		return href;
	}

	//关键目标...气泡显示
	function showDetailObjective(value, row, index) {
		var strObjective = row.objective;
		if (strObjective.length > 6) {
			strObjective = strObjective.substring(0, 6) + "...";
		}
		var show = "<a title='" + row.objective
				+ "' href='javascript:void(0);' onclick=openDetail(" + row.id
				+ ")>" + strObjective + "</a>"
		return show;
	}
	//关键结果...气泡显示
	function showDetailKeyResult(value, row, index) {
		var strKeyResult = row.keyResult;
		if (strKeyResult.length > 6) {
			strKeyResult = strKeyResult.substring(0, 6) + "...";
		}
		var show = "<a title='" + row.keyResult
				+ "' href='javascript:void(0);' onclick=openDetail(" + row.id
				+ ")>" + strKeyResult + "</a>"
		return show;
	}
	//任务...气泡显示
	function showDetailMission(value, row, index) {
		var strMission = row.mission;
		if (strMission.length > 6) {
			strMission = strMission.substring(0, 6) + "...";
		}
		var show = "<a title='" + row.mission
				+ "' href='javascript:void(0);' onclick=openDetail(" + row.id
				+ ")>" + strMission + "</a>"
		return show;
	}
	//执行难点...气泡显示
	function showDetailDifficulties(value, row, index) {
		var difficulties = row.difficulties;
		if (difficulties.length > 6) {
			difficulties = difficulties.substring(0, 6) + "...";
		}
		var show = "<a title='" + row.difficulties
				+ "' href='javascript:void(0);' onclick=openDetail(" + row.id
				+ ")>" + difficulties + "</a>"
		return show;
	}
	//未完成原因...气泡显示
	function showDetailUnfinishedReason(value, row, index) {
		var unfinishedReason = row.unfinishedReason;
		if (unfinishedReason.length > 6) {
			unfinishedReason = unfinishedReason.substring(0, 6) + "...";
		}
		var show = "<a title='" + row.unfinishedReason
				+ "' href='javascript:void(0);' onclick=openDetail(" + row.id
				+ ")>" + unfinishedReason + "</a>"
		return show;
	}

	function openDetail(id) {
		createdetailwindow("查看详情", "scOkrController.do?goDetail&id=" + id, 800,
				500);
	}

	function showProgressbar(value, row, index) {
		if (value == null || value == "") {
			return "";
		}
		var show = value + "%";

		return show;
	}

	//无确定按钮弹出框;重写add方法
	function add(title, addurl, gname, width, height) {
		openwindow(title, addurl, gname, width, height);
	}

	//无确定按钮弹出框;重写add方法
	function edit(id) {
		openwindow('更新OKR', 'scOkrController.do?goUpdate&id=' + id,
				'scOkrList', 800, 500);
	}

	function extendsOPT(value, row, index) {
		//如果 row.bpmStatus ==1 是已完
		var bpmStatus = row.bpmStatus;
		var show = "";
		//已完成状态
		if (bpmStatus == 1) {
			show += "<a title='" + row.mission
					+ "' <span style='color: #ccc'>[编辑]</span></a>&nbsp;&nbsp;";
			show += "<a title='" + row.mission
					+ "' <span style='color: #ccc'>[删除]</span></a>&nbsp;&nbsp;";
			show += "<a title='" + row.mission
					+ "' href='javascript:void(0);' onclick=openDetail("
					+ row.id + ")>[查看]</a>";
			//待完成状态
		} else if (bpmStatus == 2) {
			show += "<a title='" + row.mission
					+ "' href='javascript:void(0);' onclick='edit(" + row.id
					+ ")'>[编辑]</a>&nbsp;&nbsp;";
			show += "<a title='" + row.mission
					+ "' <span style='color: #ccc'>[删除]</span></a>&nbsp;&nbsp;";
			show += "<a title='" + row.mission
					+ "' href='javascript:void(0);' onclick=openDetail("
					+ row.id + ")>[查看]</a>";
			//草稿状态
		} else if (bpmStatus == 3) {
			show = "<a  title='" + row.mission
					+ "' href='javascript:void(0);' onclick='edit(" + row.id
					+ ")'>[编辑]</a>&nbsp;&nbsp;";
			show += "<a title='" + row.mission
					+ "' href='#' onclick=delObj('scOkrController.do?doDel&id="
					+ row.id + "','scOkrList')>[删除]</a>&nbsp;&nbsp;";
			show += "<a title='" + row.mission
					+ "' href='javascript:void(0);' onclick=openDetail("
					+ row.id + ")>[查看]</a>";

		}
		return show;
	}
	
	
</script>




<div class="easyui-layout" fit="true">
	<div region="center" style="padding: 0px; border: 0px">

		<script type="text/javascript">
			$(function() {
				storage = $.localStorage;
				if (!storage)
					storage = $.cookieStorage;
				$('#scOkrList')
						.datagrid(
								{
									idField : 'id',
									title : '员工日程计划',
									url : 'scOkrController.do?datagrideasy',
									fit : true,
									loadMsg : '数据加载中...',
									pageSize : 10,
									pagination : true,
									pageList : [10, 20, 30],
									sortName : 'createDate',
									sortOrder : 'desc',
									rownumbers : true,
									nowrap : true,
									singleSelect : true,
									fitColumns : false,
									striped : true,
									showFooter : true,
									frozenColumns : [[]],
									columns : [[
											{
												field : 'id',
												title : '主键',
												width : 120,
												hidden : true,
												sortable : true
											},
											{
												field : 'createName',
												title : '创建人名称',
												width : 120,
												hidden : true,
												sortable : true
											},
											{
												field : 'createBy',
												title : '创建人登录名称',
												width : 120,
												hidden : true,
												sortable : true
											},
											{
												field : 'createDate',
												title : '创建日期',
												width : 120,
												hidden : true,
												sortable : true,
												formatter : function(value,
														rec, index) {
													if (value == undefined)
														return '';
													return new Date()
															.format(
																	'yyyy-MM-dd',
																	value);
												}
											},
											{
												field : 'updateName',
												title : '更新人名称',
												width : 120,
												hidden : true,
												sortable : true
											},
											{
												field : 'updateBy',
												title : '更新人登录名称',
												width : 120,
												hidden : true,
												sortable : true
											},
											{
												field : 'updateDate',
												title : '更新日期',
												width : 120,
												hidden : true,
												sortable : true,
												formatter : function(value,
														rec, index) {
													if (value == undefined)
														return '';
													return new Date()
															.format(
																	'yyyy-MM-dd',
																	value);
												}
											},
											{
												field : 'opt',
												title : '操作',
												width : 150,
												align : 'center',
												formatter : function(value,
														rec, index) {
													return extendsOPT(value,
															rec, index);
												}
											},
											{
												field : 'sysOrgCode',
												title : '所属部门',
												width : 80,
												sortable : true,
												formatter : function(value,
														rec, index) {
													$.ajax({
														url:"departController.do?getDepartNameByCode",
														type:"post",
														data:{
															orgCode:value
														},
														dataType:"json",
														async:false,
														success: function(data){
															if(data.success){
																value =data.msg;
															}
														}
													});
													return value;
												}
											},
											{
												field : 'sysCompanyCode',
												title : '管理中心',
												width : 120,
												sortable : true,
												formatter : function(value,
														rec, index) {
													$.ajax({
														url:"departController.do?getDepartNameByCode",
														type:"post",
														data:{
															orgCode:value
														},
														dataType:"json",
														async:false,
														success: function(data){
															if(data.success){
																value =data.msg;
															}
														}
													});
													return value;
												}
											
											},
											{
												field : 'bpmStatus',
												title : '流程状态',
												width : 55,
												sortable : true,
												formatter : function(value,
														rec, index) {
													return showBpmStatus(value,
															rec, index);
												}
											},
											{
												field : 'objective',
												title : '关键目标',
												width : 120,
												sortable : true,
												formatter : function(value,
														rec, index) {
													return showDetailMission(
															value, rec, index);
												}
											},
											{
												field : 'keyResult',
												title : '关键结果',
												width : 120,
												sortable : true,
												formatter : function(value,
														rec, index) {
													return showDetailKeyResult(
															value, rec, index);
												}
											},
											{
												field : 'mission',
												title : '任务',
												width : 120,
												sortable : true,
												formatter : function(value,
														rec, index) {
													return showDetailObjective(
															value, rec, index);
												}
											},
											{
												field : 'userId',
												title : '人员',
												width : 65,
												sortable : true,
												formatter : function(value,
														rec, index) {
													$.ajax({
														url:"userController.do?getUsernameById",
														type:"post",
														data:{
															userId:value
														},
														dataType:"json",
														
														async:false,
														success: function(data){
															if(data.success){
																value =data.msg;
															}
														}
													});
													return value;
												}
											},
											
											{
												field : 'planTime',
												title : '计划完成时间',
												width : 90,
												sortable : true,
												formatter : function(value,
														rec, index) {
													if (value == undefined)
														return '';
													return new Date()
															.format(
																	'yyyy-MM-dd',
																	value);
												}
											},
											{
												field : 'difficulties',
												title : '执行难点',
												width : 120,
												sortable : true,
												formatter : function(value,
														rec, index) {
													return showDetailDifficulties(
															value, rec, index);
												}
											},
											{
												field : 'percent',
												title : '完成程度',
												width : 80,
												align : 'center',
												sortable : true,
												formatter : function(value,
														rec, index) {
													return showProgressbar(
															value, rec, index);
												}
											},
											{
												field : 'unfinishedReason',
												title : '未完成原因',
												width : 120,
												sortable : true,
												formatter : function(value,
														rec, index) {
													return showDetailUnfinishedReason(
															value, rec, index);
												}
											},
											{
												field : 'needOrgCode',
												title : '需协助部门',
												width : 150,
												sortable : true,
												formatter : function(value,
														rec, index) {
													$.ajax({
														url:"departController.do?getDepartNameByCode",
														type:"post",
														data:{
															orgCode:value
														},
														dataType:"json",
														async:false,
														success: function(data){
															if(data.success){
																value =data.msg;
															}
														}
													});
													return value;
												}
											},
											{
												field : 'finishTime',
												title : '实际完成时间',
												width : 90,
												sortable : true,
												formatter : function(value,
														rec, index) {
													if (value == undefined)
														return '';
													return new Date()
															.format(
																	'yyyy-MM-dd',
																	value);
												}
											}]],
			onLoadSuccess : function(data) {
				$("#scOkrList").datagrid("clearSelections");
											},
			onClickRow : function(rowIndex, rowData) {
										rowid = rowData.id;
										gridname = 'scOkrList';
									}
								});
				$('#scOkrList').datagrid('getPager').pagination({
					beforePageText : '',
					afterPageText : '/{pages}',
					displayMsg : '{from}-{to}共 {total}条',
					showPageList : true,
					showRefresh : true
				});
				$('#scOkrList').datagrid('getPager').pagination({
					onBeforeRefresh : function(pageNumber, pageSize) {
						$(this).pagination('loading');
						$(this).pagination('loaded');
					}
				});
				try {
					restoreheader();
				} catch (ex) {
				}
			});
			function reloadTable() {
				try {
					$('#' + gridname).datagrid('reload');
					$('#' + gridname).treegrid('reload');
				} catch (ex) {
				}
			}
			function reloadscOkrList() {
				$('#scOkrList').datagrid('reload');
			}
			function getscOkrListSelected(field) {
				return getSelected(field);
			}
			function getSelected(field) {
				var row = $('#' + gridname).datagrid('getSelected');
				if (row != null) {
					value = row[field];
				} else {
					value = '';
				}
				return value;
			}
			function getscOkrListSelections(field) {
				var ids = [];
				var rows = $('#scOkrList').datagrid('getSelections');
				for (var i = 0; i < rows.length; i++) {
					ids.push(rows[i][field]);
				}
				ids.join(',');
				return ids
			};
			function getSelectRows() {
				return $('#scOkrList').datagrid('getChecked');
			}
			function saveHeader() {
				var columnsFields = null;
				var easyextends = false;
				try {
					columnsFields = $('#scOkrList').datagrid('getColumns');
					easyextends = true;
				} catch (e) {
					columnsFields = $('#scOkrList').datagrid('getColumnFields');
				}
				var cols = storage.get('scOkrListhiddenColumns');
				var init = true;
				if (cols) {
					init = false;
				}
				var hiddencolumns = [];
				for (var i = 0; i < columnsFields.length; i++) {
					if (easyextends) {
						hiddencolumns.push({
							field : columnsFields[i].field,
							hidden : columnsFields[i].hidden
						});
					} else {
						var columsDetail = $('#scOkrList').datagrid(
								"getColumnOption", columnsFields[i]);
						if (init) {
							hiddencolumns.push({
								field : columsDetail.field,
								hidden : columsDetail.hidden,
								visible : (columsDetail.hidden == true
										? false
										: true)
							});
						} else {
							for (var j = 0; j < cols.length; j++) {
								if (cols[j].field == columsDetail.field) {
									hiddencolumns.push({
										field : columsDetail.field,
										hidden : columsDetail.hidden,
										visible : cols[j].visible
									});
								}
							}
						}
					}
				}
				storage.set('scOkrListhiddenColumns', JSON
						.stringify(hiddencolumns));
			}
			function restoreheader() {
				var cols = storage.get('scOkrListhiddenColumns');
				if (!cols)
					return;
				for (var i = 0; i < cols.length; i++) {
					try {
						if (cols.visible != false)
							$('#scOkrList').datagrid(
									(cols[i].hidden == true
											? 'hideColumn'
											: 'showColumn'), cols[i].field);
					} catch (e) {
					}
				}
			}
			function resetheader() {
				var cols = storage.get('scOkrListhiddenColumns');
				if (!cols)
					return;
				for (var i = 0; i < cols.length; i++) {
					try {
						$('#scOkrList').datagrid(
								(cols.visible == false
										? 'hideColumn'
										: 'showColumn'), cols[i].field);
					} catch (e) {
					}
				}
			}
			function scOkrListsearch() {
				if ($("#scOkrListForm").Validform({
					tiptype : 3
				}).check()) {
					var queryParams = $('#scOkrList').datagrid('options').queryParams;
					$('#scOkrListtb').find('*').each(function() {
						queryParams[$(this).attr('name')] = $(this).val();
					});
					$('#scOkrList')
							.datagrid(
									{
										url : 'scOkrController.do?datagrideasy',
										pageNumber : 1
									});
				}
			}
			function dosearch(params) {
				var jsonparams = $.parseJSON(params);
				$('#scOkrList')
						.datagrid(
								{
									url : 'scOkrController.do?datagrideasy',
									queryParams : jsonparams
								});
			}
			function scOkrListsearchbox(value, name) {
				var queryParams = $('#scOkrList').datagrid('options').queryParams;
				queryParams[name] = value;
				queryParams.searchfield = name;
				$('#scOkrList').datagrid('reload');
			}
			$('#scOkrListsearchbox').searchbox({
				searcher : function(value, name) {
					scOkrListsearchbox(value, name);
				},
				menu : '#scOkrListmm',
				prompt : '请输入查询关键字'
			});
			function EnterPress(e) {
				var e = e || window.event;
				if (e.keyCode == 13) {
					scOkrListsearch();
				}
			}
			function searchReset(name) {
				$("#" + name + "tb").find(":input").val("");
				var queryParams = $('#scOkrList').datagrid('options').queryParams;
				$('#scOkrListtb').find('*').each(function() {
					queryParams[$(this).attr('name')] = $(this).val();
				});
				$('#scOkrList')
						.datagrid(
								{
									url : 'scOkrController.do?datagrideasy',
									pageNumber : 1
								});
			}
		</script>
		<table width="100%" id="scOkrList" toolbar="#scOkrListtb"></table>
		<div id="scOkrListtb" style="padding: 3px; height: auto">
			<div name="searchColums" style="padding-top: 10px;">
				<input id="_sqlbuilder" name="sqlbuilder" type="hidden" />
				<form id='scOkrListForm'>
					<link rel="stylesheet" href="plug-in/Validform/css/style.css"
						type="text/css">
					<link rel="stylesheet" href="plug-in/Validform/css/tablefrom.css"
						type="text/css">
					<script type="text/javascript"
						src="plug-in/Validform/js/Validform_v5.3.1_min_zh-cn.js"></script>
					<script type="text/javascript"
						src="plug-in/Validform/js/Validform_Datatype_zh-cn.js"></script>
					<script type="text/javascript"
						src="plug-in/Validform/js/datatype_zh-cn.js"></script>
					<span style="display: -moz-inline-box; display: inline-block;"><span
						style="vertical-align: middle; display: -moz-inline-box; display: inline-block; width: 80px; text-align: right; text-overflow: ellipsis; -o-text-overflow: ellipsis; overflow: hidden; white-space: nowrap;"
						title="日期">日期：</span>
						<input type="text" name="planTime_begin" style="width: 94px" class="inuptxt" /><span
						style="display: -moz-inline-box; display: inline-block; width: 8px; text-align: right;">~</span><input
						type="text" name="planTime_end" style="width: 94px"
						class="inuptxt" /></span>
				</form>
			</div>
			<div style="height: 30px;" class="datagrid-toolbar">
				<span style="float: left;"><a href="#"
					class="easyui-linkbutton" plain="true" icon="icon-add"
					onclick="add('新建OKR','scOkrController.do?goAdd','scOkrList',800,500)">新建OKR</a><a
					href="#" class="easyui-linkbutton" plain="true" icon="icon-putout"
					onclick="ExportXls('导出','null','scOkrList',null,null)">导出</a><a
					href="#" class="easyui-linkbutton" plain="true" icon="icon-search"
					onclick="scOkrListsearch('查询','null','scOkrList',null,null)">查询</a></span><span
					style="float: right"><a href="#" class="easyui-linkbutton"
					iconCls="icon-search" onclick="scOkrListsearch()">查询</a><a href="#"
					class="easyui-linkbutton" iconCls="icon-reload"
					onclick="searchReset('scOkrList')">重置</a></span>
			</div>
		</div>
	</div>
	<script src="webpage/com/jeecg/scokr/scOkrList.js"></script>
	<script type="text/javascript">
		$(document).ready(
				function() {
					//给时间控件加上样式
					$("#scOkrListtb").find("input[name='createDate']").attr(
							"class", "Wdate").click(function() {
						WdatePicker({
							dateFmt : 'yyyy-MM-dd'
						});
					});
					$("#scOkrListtb").find("input[name='updateDate']").attr(
							"class", "Wdate").click(function() {
						WdatePicker({
							dateFmt : 'yyyy-MM-dd'
						});
					});

					$("#scOkrListtb").find("input[name='planTime_begin']")
							.attr("class", "Wdate").click(function() {
								WdatePicker({
									dateFmt : 'yyyy-MM-dd'
								});
							});
					$("#scOkrListtb").find("input[name='planTime_end']").attr(
							"class", "Wdate").click(function() {
						WdatePicker({
							dateFmt : 'yyyy-MM-dd'
						});
					});

				});

		//导入
		function ImportXls() {
			openuploadwin('Excel导入', 'scOkrController.do?upload', "scOkrList");
		}

		//导出
		function ExportXls() {
			JeecgExcelExport("scOkrController.do?exportXls", "scOkrList");
		}

		//模板下载
		function ExportXlsByT() {
			JeecgExcelExport("scOkrController.do?exportXlsByT", "scOkrList");
		}
	</script>