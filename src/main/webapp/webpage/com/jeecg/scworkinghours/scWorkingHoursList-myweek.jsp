<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>


<div class="easyui-layout" fit="true">
	<div region="center" style="padding: 0px; border: 0px">

		<script type="text/javascript">
			$(function() {
				storage = $.localStorage;
				if (!storage)
					storage = $.cookieStorage;
				$('#scWorkingHoursList')
						.datagrid(
								{
									idField : 'id',
									title : '我的工时列表',
									url : 'scWorkingHoursController.do?datagridMyWeek',
									fit : true,
									loadMsg : '数据加载中...',
									pageSize : 10,
									pagination : true,
									pageList : [ 10, 20, 30 ],
									sortOrder : 'desc',
									sort:'id',
									rownumbers : true,
									nowrap : true,
									singleSelect : false,
									fitColumns : false,
									striped : true,
									showFooter : true,
									frozenColumns : [ [ {
										field : 'ck',
										checkbox : 'true'
									}, ] ],
									columns : [ [
											{
												field : 'id',
												title : '主键',
												width : 120,
												hidden : true,
												sortable : true
											},
											{
												field : 'deleteStatus',
												title : '删除状态',
												hidden : true,
												sortable : true
											},
											{
												field : 'projectId',
												title : '项目名称',
												width : 200,
												sortable : true,
												formatter : function(value,
														rec, index) {
													//ajax。根据easy属性的值value即projectId获取项目名称，做展示
												
													$.ajax({
																url : "projectController.do?getNameById",
																type : "post",
																data : {
																	id : value
																},
																dataType : "json",
																async : false,
																success : function(
																		data) {
																	if (data.success) {
																		value = data.msg;
																	}
																}
															});

													return value;
													
												}
											},
											{
												field : 'userId',
												title : '员工',
												width : 120,
												sortable : true,
												formatter : function(value,
														rec, index) {
													//ajax. 根据easyui属性的值value即projectId获取项目名称,做展示
													$.ajax({
														url:"userController.do?getRealNameById",
														type:"post",
														data:{
															id:value
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
											
										/**
											{
												field : 'workingDate',
												title : '日期',
												width : 150,
												sortable : true,
												formatter : function(value,
														rec, index) {
													return getWeekDay(value,
															rec, index);
												}
											},
											*/
											{
												field : 'workingHours1',
												title : '周一',
												width : 100,
												align : 'center',
												sortable : true
											},
											{
												field : 'workingHours2',
												title : '周二',
												width : 100,
												align : 'center',
												sortable : true
											},
											{
												field : 'workingHours3',
												title : '周三',
												width : 100,
												align : 'center',
												sortable : true
											},
											{
												field : 'workingHours4',
												title : '周四',
												align : 'center',
												width : 100,
												sortable : true
											},
											{
												field : 'workingHours5',
												title : '周五',
												align : 'center',
												width : 100,
												sortable : true
											},
											{
												field : 'workingHours6',
												title : '周六',
												align : 'center',
												width : 100,
												sortable : true
											},
											{
												field : 'workingHours7',
												title : '周日',
												align : 'center',
												width : 100,
												sortable : true
											},
											{
												field : 'note',
												title : '任务信息',
												width : 120,
												hidden : true,
												sortable : true
											}
											 ] ],
									onLoadSuccess : function(data) {
										$("#scWorkingHoursList").datagrid(
												"clearSelections");
									},
									onClickRow : function(rowIndex, rowData) {
										rowid = rowData.id;
										gridname = 'scWorkingHoursList';
									}
								});
				$('#scWorkingHoursList').datagrid('getPager').pagination({
					beforePageText : '',
					afterPageText : '/{pages}',
					displayMsg : '{from}-{to}共 {total}条',
					showPageList : true,
					showRefresh : true
				});
				$('#scWorkingHoursList').datagrid('getPager').pagination({
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
			function reloadscWorkingHoursList() {
				$('#scWorkingHoursList').datagrid('reload');
			}
			function getscWorkingHoursListSelected(field) {
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
			function getscWorkingHoursListSelections(field) {
				var ids = [];
				var rows = $('#scWorkingHoursList').datagrid('getSelections');
				for (var i = 0; i < rows.length; i++) {
					ids.push(rows[i][field]);
				}
				ids.join(',');
				return ids
			};
			function getSelectRows() {
				return $('#scWorkingHoursList').datagrid('getChecked');
			}
			function saveHeader() {
				var columnsFields = null;
				var easyextends = false;
				try {
					columnsFields = $('#scWorkingHoursList').datagrid(
							'getColumns');
					easyextends = true;
				} catch (e) {
					columnsFields = $('#scWorkingHoursList').datagrid(
							'getColumnFields');
				}
				var cols = storage.get('scWorkingHoursListhiddenColumns');
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
						var columsDetail = $('#scWorkingHoursList').datagrid(
								"getColumnOption", columnsFields[i]);
						if (init) {
							hiddencolumns.push({
								field : columsDetail.field,
								hidden : columsDetail.hidden,
								visible : (columsDetail.hidden == true ? false
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
				storage.set('scWorkingHoursListhiddenColumns', JSON
						.stringify(hiddencolumns));
			}
			function restoreheader() {
				var cols = storage.get('scWorkingHoursListhiddenColumns');
				if (!cols)
					return;
				for (var i = 0; i < cols.length; i++) {
					try {
						if (cols.visible != false)
							$('#scWorkingHoursList').datagrid(
									(cols[i].hidden == true ? 'hideColumn'
											: 'showColumn'), cols[i].field);
					} catch (e) {
					}
				}
			}
			function resetheader() {
				var cols = storage.get('scWorkingHoursListhiddenColumns');
				if (!cols)
					return;
				for (var i = 0; i < cols.length; i++) {
					try {
						$('#scWorkingHoursList').datagrid(
								(cols.visible == false ? 'hideColumn'
										: 'showColumn'), cols[i].field);
					} catch (e) {
					}
				}
			}
			function scWorkingHoursListsearch() {
				if ($("#scWorkingHoursListForm").Validform({
					tiptype : 3
				}).check()) {
					var queryParams = $('#scWorkingHoursList').datagrid(
							'options').queryParams;
					$('#scWorkingHoursListtb').find('*').each(function() {
						queryParams[$(this).attr('name')] = $(this).val();
					});
					$('#scWorkingHoursList')
							.datagrid(
									{
										url : 'scWorkingHoursController.do?datagridMyWeek',
										pageNumber : 1
									});
				}
			}
			function dosearch(params) {
				var jsonparams = $.parseJSON(params);
				$('#scWorkingHoursList')
						.datagrid(
								{
									url : 'scWorkingHoursController.do?datagridMyWeek',
									queryParams : jsonparams
								});
			}
			function scWorkingHoursListsearchbox(value, name) {
				var queryParams = $('#scWorkingHoursList').datagrid('options').queryParams;
				queryParams[name] = value;
				queryParams.searchfield = name;
				$('#scWorkingHoursList').datagrid('reload');
			}
			$('#scWorkingHoursListsearchbox').searchbox({
				searcher : function(value, name) {
					scWorkingHoursListsearchbox(value, name);
				},
				menu : '#scWorkingHoursListmm',
				prompt : '请输入查询关键字'
			});
			function EnterPress(e) {
				var e = e || window.event;
				if (e.keyCode == 13) {
					scWorkingHoursListsearch();
				}
			}
			function searchReset(name) {
				$("#" + name + "tb").find(":input").val("");
				var queryParams = $('#scWorkingHoursList').datagrid('options').queryParams;
				$('#scWorkingHoursListtb').find('*').each(function() {
					queryParams[$(this).attr('name')] = $(this).val();
				});
				$('#scWorkingHoursList')
						.datagrid(
								{
									url :'scWorkingHoursController.do?datagridMyWeek',
									pageNumber : 1
								});
			}
		</script>
		<table width="100%" id="scWorkingHoursList"
			toolbar="#scWorkingHoursListtb"></table>
		<div id="scWorkingHoursListtb" style="padding: 3px; height: auto">
			<div name="searchColums" style="padding-top: 10px;" class="datagrid-toolbar">
				<input id="_sqlbuilder" name="sqlbuilder" type="hidden" />
				<form id='scWorkingHoursListForm'>
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
						title="项目">项目：</span><select name="projectId" WIDTH="100" onchange="scWorkingHoursListsearch()"
						style="width: 104px">
							<option value="">---请选择---</option>
							<c:forEach var="p" items="${project }">
								<option value="${p.id }">${p.projectName }</option>
							</c:forEach>
							
					</select></span>
					<!--  
					<span style="display: -moz-inline-box; display: inline-block;"><span
						style="vertical-align: middle; display: -moz-inline-box; display: inline-block; width: 80px; text-align: right; text-overflow: ellipsis; -o-text-overflow: ellipsis; overflow: hidden; white-space: nowrap;"
						title="员工">员工：</span>
						<select name="userId" WIDTH="100"style="width: 104px" onchange="scWorkingHoursListsearch()">
							<option value="">---请选择---</option>
							<c:forEach var="u" items="${userList }">
								<option value="${u.id }">${u.realName }</option>
							</c:forEach>
						</select>
						</span>
					-->	
						<span style="display: -moz-inline-box; display: inline-block;">
						<!--  <span
						style="vertical-align: middle; display: -moz-inline-box; display: inline-block; width: 80px; text-align: right; text-overflow: ellipsis; -o-text-overflow: ellipsis; overflow: hidden; white-space: nowrap;"
						title="日期">日期：</span>
						<input type="text" name="workingDate_begin"
						style="width: 94px" class="inuptxt" /><span
						style="display: -moz-inline-box; display: inline-block; width: 8px; text-align: right;">~</span>
						<input type="text" name="workingDate_end" style="width: 94px" class="inuptxt" /></span>
						
						
						<span
					style="display: -moz-inline-box; display: inline-block;"><a href="#" class="easyui-linkbutton"
					iconCls="icon-search" onclick="scWorkingHoursListsearch()">查询</a>
					
					<a
					href="#" class="easyui-linkbutton" iconCls="icon-reload"
					onclick="searchReset('scWorkingHoursList')">重置</a></span>
					-->
					<span style="display: -moz-inline-box; display: inline-block;">
					<span style="vertical-align: middle; display: -moz-inline-box; display: inline-block; width: 80px; text-align: right; text-overflow: ellipsis; -o-text-overflow: ellipsis; overflow: hidden; white-space: nowrap;"
						title="日期">
					 日期：</span>
					<input type="text" id="begintime" name="begintime" value="" style="width: 94px" class="inuptxt" )/>
					<span style="display: -moz-inline-box; display: inline-block; width: 8px; text-align: right;">~</span>
					<input type="text" id="endtime" name="endtime" value="" style="width: 94px" class="inuptxt" />
				    </span>
				    <span style="display: -moz-inline-box; display: inline-block;">
				    <a href="#" id="onweek" class="easyui-linkbutton" iconCls="icon-undo" onclick="getdaybytype(2)">上一周</a>
				    <a href="#" id="thisweek" class="easyui-linkbutton" iconCls="icon-search" onclick="getdaybytype(1)">本周</a>
				    <a href="#" id="nextweek" class="easyui-linkbutton" iconCls="icon-redo" onclick="getdaybytype(3)">下一周</a>
					
					</span>
					
					</span>
				</form>
			</div>
			<div style="height: 30px;" class="datagrid-toolbar">
			<span style="float: left;"><a href="#"
				class="easyui-linkbutton" plain="true" icon="icon-add"
				onclick="add('录入','scWorkingHoursController.do?goAdd','scWorkingHoursList',null,null)">录入</a><a
				href="#" class="easyui-linkbutton" plain="true" icon="icon-edit"
				onclick="update('编辑','scWorkingHoursController.do?goUpdate','scWorkingHoursList',null,null)">编辑</a><a
				href="#" class="easyui-linkbutton" plain="true" icon="icon-remove"
				onclick="deleteALLSelect('批量删除','scWorkingHoursController.do?doBatchDel','scWorkingHoursList',null,null)">批量删除</a><a
				href="#" class="easyui-linkbutton" plain="true" icon="icon-search"
				onclick="detail('查看','scWorkingHoursController.do?goUpdate','scWorkingHoursList',null,null)">查看</a><a
				href="#" class="easyui-linkbutton" plain="true" icon="icon-put"
				onclick="ImportXls('导入','null','scWorkingHoursList',null,null)">导入</a><a
				href="#" class="easyui-linkbutton" plain="true" icon="icon-putout"
				onclick="ExportXls('导出','null','scWorkingHoursList',null,null)">导出</a>
				<!--  <a href="#" class="easyui-linkbutton" plain="true" icon="icon-putout"
				onclick="ExportXlsByT('模板下载','null','scWorkingHoursList',null,null)">模板下载</a>
				-->
				</span>
				<!--
				<span style="float: right"><a href="#" class="easyui-linkbutton"
				iconCls="icon-search" onclick="scWorkingHoursListsearch()">查询</a><a
				href="#" class="easyui-linkbutton" iconCls="icon-reload"
				onclick="searchReset('scWorkingHoursList')">重置</a></span>
				-->
		</div>
		</div>
	</div>
	<script type="text/javascript">
         
	function changeTitle(){
		var day1 = $('#begintime').val();
		var option1 = $('#scWorkingHoursList').datagrid("getColumnOption", "workingHours1");
			option1.title = '周一'+day1.substring(5)+'';
			
		var day2 = after1Day(day1);
		var option2 = $('#scWorkingHoursList').datagrid("getColumnOption", "workingHours2");
			option2.title = '周二'+day2.substring(5);
			
		var day3 = after1Day(day2);
		var option3 = $('#scWorkingHoursList').datagrid("getColumnOption", "workingHours3");
			option3.title = '周三'+day3.substring(5);
			
			
		var day4 = after1Day(day3);
		var option4 = $('#scWorkingHoursList').datagrid("getColumnOption", "workingHours4");
			option4.title = '周四'+day4.substring(5);
			
		var day5 = after1Day(day4);
		var option5 = $('#scWorkingHoursList').datagrid("getColumnOption", "workingHours5");
			option5.title = '周五'+day5.substring(5);
			
		var day6 = after1Day(day5);
		var option6 = $('#scWorkingHoursList').datagrid("getColumnOption", "workingHours6");
			option6.title = '周六'+day6.substring(5);
			
		var day7 = $('#endtime').val();
		var option7 = $('#scWorkingHoursList').datagrid("getColumnOption", "workingHours7");
			option7.title = '周日'+day7.substring(5);
	}
	
	
	
	
	
	   $(function () { 
		   obaganlestyle(1, 7);
		   changeTitle();
		   $('#scWorkingHoursList').datagrid();
       });
       
	   function after1Day(day){
		   day = day.replace(/-/g,"/");
			var newDay = new Date(day);
			newDay.setDate(newDay.getDate() + 1);
			return newDay.getFullYear()+"-"+(newDay.getMonth()+1)+"-"+newDay.getDate();
			
	   }
	   
	   
	   
	   
       function obaganlestyle(snum,lnum)
       {
           var myDate = new Date();
           var day = myDate.getDay();//返回0-6
           //var today = new Array('星期日', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六');
           //当天的日期
           var endday;
           var startday;
         
           endday = getthisDay(-day + lnum); //算得周日
           startday = getthisDay(-day + snum);//算的周一
           
           $("#begintime").val(startday);
           $("#endtime").val(endday);
       }
       //取得日期
       function getthisDay(day) {
           var today = new Date();
           var targetday_milliseconds = today.getTime() + 1000 * 60 * 60 * 24 * day;
           today.setTime(targetday_milliseconds); //关键
           var tyear = today.getFullYear();
           var tMonth = today.getMonth();
           var tDate = today.getDate();
           if (tDate < 10) {
               tDate = "0" + tDate;
           }
           tMonth = tMonth + 1;
           if (tMonth < 10) {
               tMonth = "0" + tMonth;
           }
           return tyear + "-" + tMonth + "-" + tDate + "";
       }

       
       
       
       //各种日期取得
       function getdaybytype(type) {
           switch (type) {
               case 1:
                   obaganlestyle(1, 7);
                   break;
          			case 2:
          				upWeek();
                   break;
               case 3:
            	   downWeek();
                   break;
                   
                
               default:
                   break;
           }
           
           changeTitle();
           
           scWorkingHoursListsearch();
       }
       
	/**
	 *上周
	*/
	function upWeek(){
	//获取当前日期框里的值	
	var begin = $('#begintime').val();	
	var end  = $('#endtime').val();	
	//都减去7天
	//begin日期字符串转化成date日期对象
	begin = begin.replace(/-/g,"/");
	var begindate = new Date(begin);
	//减去天数
	begindate = jianDay(begindate);
	//格式化日期为字符串（yyyy-MM-dd）
	var newBegin = begindate.getFullYear()+"-"+(begindate.getMonth()+1)+"-"+begindate.getDate();
	//重新赋值到日期框
	$('#begintime').val(newBegin);	
	//end日期字符串转化成date日期对象
	end = end.replace(/-/g,"/");
	var enddate = new Date(end);
	//减去天数
	enddate = jianDay(enddate);
	//格式化日期为字符串（yyyy-MM-dd）
	var newEnd = enddate.getFullYear()+"-"+(enddate.getMonth()+1)+"-"+enddate.getDate();
	//重新赋值到日期框
	$('#endtime').val(newEnd);	
		
	}
	
	function jianDay(myDate){
		 //获取今天日期
		myDate.setDate(myDate.getDate() - 7);
		return myDate;
	}
	
	function jiaDay(myDate){
		 //获取今天日期
		myDate.setDate(myDate.getDate() + 7);
		return myDate;
	}
	
	
	
	/**
	*下周
	*/
	function downWeek(){
		//获取当前日期框里的值	
		var begin = $('#begintime').val();	
		var end  = $('#endtime').val();	
		//都加7天
		//begin
		begin = begin.replace(/-/g,"/");
		var begindate = new Date(begin);
		begindate = jiaDay(begindate);
		var newBegin = begindate.getFullYear()+"-"+(begindate.getMonth()+1)+"-"+begindate.getDate();
		$('#begintime').val(newBegin);	
		//end
		end = end.replace(/-/g,"/");
		var enddate = new Date(end);
		enddate = jiaDay(enddate);
		var newEnd = enddate.getFullYear()+"-"+(enddate.getMonth()+1)+"-"+enddate.getDate();
		$('#endtime').val(newEnd);	
	
	}
	
       
       
       
       
	
		function formatDate(date) {
			var y = date.getFullYear();
			var m = date.getMonth() + 1;
			m = m < 10 ? '0' + m : m;
			var d = date.getDate();
			d = d < 10 ? ('0' + d) : d;
			return y + '-' + m + '-' + d;
		};

		function getWeekDay(value, rec, index) {
			value = value.replace(/-/g, "/");
			var date = new Date(value);

			//根据格式化 DATE对象，与下面星期计算无关
			var result = formatDate(date);

			//计算星期并用中文展示
			var weekDay = date.getDay();
			if (0 == weekDay) {
				result += '（星期日）';
			} else if (1 == weekDay) {
				result += '（星期一）';
			} else if (2 == weekDay) {
				result += '（星期二）';
			} else if (3 == weekDay) {
				result += '（星期三）';
			} else if (4 == weekDay) {
				result += '（星期四）';
			} else if (5 == weekDay) {
				result += '（星期五）';
			} else if (6 == weekDay) {
				result += '（星期六）';
			} else {
				result += '（爆炎！！！）';
			}

			return result;
		}

		$(document).ready(
				function() {
					//给时间控件加上样式
					$("#scWorkingHoursListtb").find(
							"input[name='workingDate_begin']").attr("class",
							"Wdate").click(function() {
						WdatePicker({
							dateFmt : 'yyyy-MM-dd'
						});
					});
					$("#scWorkingHoursListtb").find(
							"input[name='workingDate_end']").attr("class",
							"Wdate").click(function() {
						WdatePicker({
							dateFmt : 'yyyy-MM-dd'
						});
					});

				});

		//导入
		function ImportXls() {
			openuploadwin('Excel导入', 'scWorkingHoursController.do?upload',
					"scWorkingHoursList");
		}

		//导出
		function ExportXls() {
			JeecgExcelExport("scWorkingHoursController.do?exportXls",
					"scWorkingHoursList");
		}

		//模板下载
		function ExportXlsByT() {
			JeecgExcelExport("scWorkingHoursController.do?exportXlsByT",
					"scWorkingHoursList");
		}
	</script>