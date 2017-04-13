<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>


<div class="easyui-layout" fit="true">
	<div region="center" style="padding: 0px; border: 0px">

		<script type="text/javascript">
		 function getProjectData (da){
				
				$.ajax({
					url : "projectController.do?getCombobox",
					type : "post",
					data : {
						
					},
					dataType : "json",
					async : false,
					success : function(
							data) {
						da = data
						return data;
					}
				});
				return da;
			}
		
		var projectData =getProjectData('');
		
		
		
		
		
			$(function() {
				
				storage = $.localStorage;
				if (!storage)
					storage = $.cookieStorage;
				$('#scWorkingHoursList')
						.datagrid(
								{
									idField : 'id',
									title : '工时填报列表',
									url : 'scWorkingHoursController.do?datagridAdd',
									fit : true,
									loadMsg : '数据加载中...',
									pageSize : 10,
									pagination : true,
									pageList : [ 10, 20, 30 ],
									sortOrder : 'asc',
									sort:'id',
									rownumbers : true,
									nowrap : true,
									singleSelect : false,
									fitColumns : true,
									striped : true,
									showFooter : true,
									frozenColumns : [ [ {
										field : 'ck',
										checkbox : 'true'
									}, ] ],
									columns : [ [
											{
												field : 'id',
												title : '编号',
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
													return rec.projectName
												},
												editor: { type: 'combobox', 
												    options: {
												    data:projectData,
													valueField: "id",
													textField: "projectName",
													required:true ,   
					                                missingMessage:'项目必填!'
					                            
													     	  } 
													}
											},
											{
												field : 'userId',
												title : '员工名称',
												width : 200,
												sortable : true,
												formatter : function(value,
														rec, index) {
													return rec.realName
												},
												editor: { type: 'combobox', 
												    options: {
												    url:'userController.do?getCombobox',
													valueField: "id",
													textField: "realName",
													required:true ,   
					                                missingMessage:'默认当前用户' 
													     	  } 
													}
											}, 
											{
												field : 'note',
												title : '任务信息',
												width : 200,
												editor : { 
													type: 'validatebox', 
													options: { 
														required: true,
														missingMessage:'任务信息必填!'
														} ,
													},
												sortable : true,
											},
											{
												
												field : 'workingHours1',
												title : '周一',
												width : 100,
												editor : {type:'numberbox',options:{min:1,max:24,precision:1}},
												align : 'center',
												sortable : true
											},
											{
												field : 'workingHours2',
												title : '周二',
												width : 100,
												editor : {type:'numberbox',options:{min:1,max:24,precision:1}},
												align : 'center',
												sortable : true
											},
											{
												field : 'workingHours3',
												title : '周三',
												width : 100,
												editor : {type:'numberbox',options:{min:1,max:24, precision:1}},
												align : 'center',
												sortable : true
											},
											{
												field : 'workingHours4',
												title : '周四',
												width : 100,
												editor : {type:'numberbox',options:{min:1,max:24,precision:1}},
												align : 'center',
												sortable : true
											},
											{
												field : 'workingHours5',
												title : '周五',
												width : 100,
												editor : {type:'numberbox',options:{min:1,max:24,precision:1}},
												align : 'center',
												sortable : true
											},
											{
												field : 'workingHours6',
												title : '周六',
												width : 100,
												editor : {type:'numberbox',options:{min:1,max:24,precision:1}},
												align : 'center',
												sortable : true
											},
											{
												field : 'workingHours7',
												title : '周日',
												width : 100,
												editor : {type:'numberbox',options:{min:1,max:24,precision:1}},
												align : 'center',
												sortable : true
											}] ],
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
					columnsFields = $('#scWorkingHoursList').datagrid('getColumns');
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
					var queryParams = $('#scWorkingHoursList').datagrid('options').queryParams;
					$('#scWorkingHoursListtb').find('*').each(function() {
						queryParams[$(this).attr('name')] = $(this).val();
					});
					$('#scWorkingHoursList')
							.datagrid(
									{
										url : 'scWorkingHoursController.do?datagridAdd',
										pageNumber : 1
									});
				}
			}
			function dosearch(params) {
				var jsonparams = $.parseJSON(params);
				$('#scWorkingHoursList')
						.datagrid(
								{
									url : 'scWorkingHoursController.do?datagridAdd',
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
									url : 'scWorkingHoursController.do?datagridAdd',
									pageNumber : 1
								});
			}
		</script>
		<!--  &field=id,projectId,userId,note,workingHours1,workingHours2,workingHours3,workingHours4,workingHours5,workingHours6,workingHours7,-->
		
		<table width="100%" id="scWorkingHoursList" toolbar="#scWorkingHoursListtb"></table>
		<div id="scWorkingHoursListtb" style="padding: 3px; height: auto">
			<div name="searchColums" style="padding-top: 10px;">
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
						<span style="display: -moz-inline-box; display: inline-block;">
							<span style="vertical-align: middle; display: -moz-inline-box; display: inline-block; 
							width: 80px; text-align: right; text-overflow: ellipsis; -o-text-overflow: ellipsis; 
							overflow: hidden; white-space: nowrap;" title="项目">项目：
							</span>
								<select name="projectId" WIDTH="100" onchange="scWorkingHoursListsearch()" style="width: 104px">
									<option value="">---请选择---</option>
								<c:forEach var="p" items="${project }">
									<option value="${p.id }">${p.projectName }</option>
								</c:forEach>
								</select>
					</span>
					<span style="display: -moz-inline-box; display: inline-block;">
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
					onclick="addRow('录入','null','scWorkingHoursList',null,null)">录入</a><a
					href="#" class="easyui-linkbutton" plain="true" icon="icon-edit"
					onclick="editRow('编辑','null','scWorkingHoursList',null,null)">编辑</a><a
					href="#" class="easyui-linkbutton" plain="true" icon="icon-save"
					onclick="saveData('保存','scWorkingHoursController.do?saveRows','scWorkingHoursList',null,null)">保存</a><a
					href="#" class="easyui-linkbutton" plain="true" icon="icon-undo"
					onclick="reject('取消编辑','null','scWorkingHoursList',null,null)">取消编辑</a>
					<a href="#" class="easyui-linkbutton" plain="true" icon="icon-remove"
					onclick="deleteALLSelect('批量删除','scWorkingHoursController.do?doBatchDel','scWorkingHoursList',null,null)">批量删除</a>
					</span>
			  <!--  <span style="float: right">
						<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="scWorkingHoursListsearch()">查询</a>
						<a href="#" class="easyui-linkbutton" iconCls="icon-reload" onclick="searchReset('scWorkingHoursList')">重置</a>
					</span>
					-->
			</div>
			<script type="text/javascript">
				//添加行
				function addRow(title, addurl, gname) {
					$('#' + gname).datagrid('appendRow', {});
					var editIndex = $('#' + gname).datagrid('getRows').length - 1;
					$('#' + gname).datagrid('selectRow', editIndex).datagrid(
							'beginEdit', editIndex);
					var editors = $('#' + gname).datagrid('getEditors', editIndex);    
					editors[1].target.combobox('setValue','${user.id}');
					
					
					
				}
				//保存数据 
				function saveData(title, addurl, gname) {
					if (!endEdit(gname))
						return false;
					var rows = $('#' + gname)
							.datagrid("getChanges", "inserted");
					var uprows = $('#' + gname).datagrid("getChanges",
							"updated");
					rows = rows.concat(uprows);
					if (rows.length <= 0) {
						tip("没有需要保存的数据！")
						return false;
					}
					var result = {};
				    var firstTime=$("#begintime").val();
				    
					for (var i = 0; i < rows.length; i++) {
						for ( var d in rows[i]) {
							result["scWorkingHours[" + i + "]." + d] = rows[i][d];
							var num=0;
							if(rows[i]['workingHours1']!=null&&rows[i]['workingHours1']!=''){
								result["scWorkingHours[" + i + "]." + 'workingHours']=rows[i]['workingHours1'];
								result["scWorkingHours[" + i + "]." + 'workingDate']=firstTime;
								num=num+1;
							} 
							if(rows[i]['workingHours2']!=null&&rows[i]['workingHours2']!=''){
								result["scWorkingHours[" + i + "]." + 'workingHours']=rows[i]['workingHours2'];
								result["scWorkingHours[" + i + "]." + 'workingDate']=afterSumDay(firstTime,1);
								num=num+1;
							} 
							if(rows[i]['workingHours3']!=null&&rows[i]['workingHours3']!=''){
								result["scWorkingHours[" + i + "]." + 'workingHours']=rows[i]['workingHours3'];
								result["scWorkingHours[" + i + "]." + 'workingDate']=afterSumDay(firstTime,2);
								num=num+1;
							} 
							if(rows[i]['workingHours4']!=null&&rows[i]['workingHours4']!=''){
								result["scWorkingHours[" + i + "]." + 'workingHours']=rows[i]['workingHours4'];
								result["scWorkingHours[" + i + "]." + 'workingDate']=afterSumDay(firstTime,3);
								num=num+1;
							} 
							if(rows[i]['workingHours5']!=null&&rows[i]['workingHours5']!=''){
								result["scWorkingHours[" + i + "]." + 'workingHours']=rows[i]['workingHours5'];
								result["scWorkingHours[" + i + "]." + 'workingDate']=afterSumDay(firstTime,4);
								num=num+1;
							} 
							if(rows[i]['workingHours6']!=null&&rows[i]['workingHours6']!=''){
								result["scWorkingHours[" + i + "]." + 'workingHours']=rows[i]['workingHours6'];
								result["scWorkingHours[" + i + "]." + 'workingDate']=afterSumDay(firstTime,5);
								num=num+1;
							} 
							if(rows[i]['workingHours7']!=null&&rows[i]['workingHours7']!=''){
								result["scWorkingHours[" + i + "]." + 'workingHours']=rows[i]['workingHours7'];
								result["scWorkingHours[" + i + "]." + 'workingDate']=afterSumDay(firstTime,6);
								num=num+1;
								
							}
							if(num==0){
								layer.msg('必须填写一个工时,请点编辑继续填写');
								//alert("必须填写一个工时");
								//window.location.reload();
								return;
							}
							if(num>1){
								layer.msg('每行只能填写一个工时,请点编辑继续填写');
								//alert("每行只能填写一个工时");
								//window.location.reload();
								return;
							}
						}
					}
					
					// alert(JSON.stringify(result));
					$.ajax({
						url : "<%=basePath%>/" + addurl,
						type : "post",
						data : result,
						dataType : "json",
						success : function(data) {
							layer.msg(data.msg);
							$('#scWorkingHoursList').datagrid('reload');
							
						}
					})
					//reloadTable();
				}
				
				//获取working_date
				   function afterSumDay(day,num){
					    day = day.replace(/-/g,"/");
						var newDay = new Date(day);
						newDay.setDate(newDay.getDate() + num);
						var monthNum = (newDay.getMonth()+1);
						if(monthNum<10){
							monthNum = "0"+monthNum;
						}
						return newDay.getFullYear()+"-"+monthNum+"-"+newDay.getDate();
						
				   }
				
				
				
				
				
				
				//结束编辑
				function endEdit(gname) {
					var editIndex = $('#' + gname).datagrid('getRows').length - 1;
					for (var i = 0; i <= editIndex; i++) {
						if ($('#' + gname).datagrid('validateRow', i))
							$('#' + gname).datagrid('endEdit', i);
						else
							return false;
					}
					return true;
				}
				//编辑行
				function editRow(title, addurl, gname) {
					var rows = $('#' + gname).datagrid("getChecked");
					if (rows.length == 0) {
						tip("请选择条目");
						return false;
					}
					for (var i = 0; i < rows.length; i++) {
						var index = $('#' + gname).datagrid('getRowIndex',
								rows[i]);
						$('#' + gname).datagrid('beginEdit', index);
						var editors = $('#' + gname).datagrid('getEditors', index); 
						//人员列设置为当前用户
						editors[1].target.combobox('setValue','${user.id}');
						
						//编辑前的文本，哎。。。无法获取value只有获取text,因此下面要反向查出value
						var oldText = editors[0].oldHtml;
						//这里可以直接获取全局参数projectData
						//这里通过‘getData’方法获取combobox所有列表数据
						//有一个问题，当前开启编辑模式时，EASYUI请求后台getcommbobox方法还未执行。因此获取到的值为空。
						//所以改为data参数获取值。查看上面列表中editor属性。优点是，整个页面只请求一次后台，保存在页面中。
					    var allOptions = editors[0].target.combobox('getData'); 
						//alert(JSON.stringify(allOptions));
					    
					    for(var i=0;i<allOptions.length;i++){
					    	//注意字段值不要写错。
					    	var textP = allOptions[i].projectName;
					    	var valueP = allOptions[i].id;
					    	//用老的TEXT文本循环与所有选项比对，当出现相等时，设置VALUE。即实现默认
					    	if(oldText==textP){
					    		editors[0].target.combobox('setValue',valueP);
					    		break;
					    	}
					    }
					//   alert(editors[0].target.combobox('getValue')); 
						
					}
				}
				//update-begin--Author:张忠亮  Date:20150709 for：修正 取消编辑后再次点击录入不进入编辑状态
				//取消编辑
				function reject(title, addurl, gname) {
					$('#' + gname).datagrid('clearChecked');
					$('#' + gname).datagrid('rejectChanges');

				}
				
				
				
				
				function changeTitle(){
					var day1 =  $('#begintime').val();
					//2016-12-03
					var option1 = $('#scWorkingHoursList').datagrid("getColumnOption", "workingHours1");
					    option1.title = '周一'+day1.substring(5) +'';
					    
					    
					    
					 var day2 = after1Day(day1);   
						var option2 = $('#scWorkingHoursList').datagrid("getColumnOption", "workingHours2");
					    option2.title = '周二'+day2.substring(5)+'';    
					    
					    var day3 = after1Day(day2);   
						var option3 = $('#scWorkingHoursList').datagrid("getColumnOption", "workingHours3");
					    option3.title = '周三'+day3.substring(5)+'';   
					    
					    var day4 = after1Day(day3);   
						var option4 = $('#scWorkingHoursList').datagrid("getColumnOption", "workingHours4");
					    option4.title = '周四'+day4.substring(5)+'';   
					    var day5 = after1Day(day4);   
						var option5 = $('#scWorkingHoursList').datagrid("getColumnOption", "workingHours5");
					    option5.title = '周五'+day5.substring(5)+'';   
					    
					    var day6 = after1Day(day5);   
						var option6 = $('#scWorkingHoursList').datagrid("getColumnOption", "workingHours6");
					    option6.title = '周六'+day6.substring(5)+'';   
					    
					    
					var day7 =    $('#endtime').val(); 
					var option7 = $('#scWorkingHoursList').datagrid("getColumnOption", "workingHours7")
					    option7.title = '周日'+day7.substring(5)+'';
					
				   // $('#scWorkingHoursList').datagrid();
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
							result += '（错误信息！！！）';
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

				
				
				
			</script>