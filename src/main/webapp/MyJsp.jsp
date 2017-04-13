<script type="text/javascript" src="plug-in/jquery/jquery-1.8.3.js"></script>
<script type="text/javascript" src="plug-in/tools/dataformat.js"></script>
<link rel="stylesheet" type="text/css"
	href="plug-in/accordion/css/accordion.css">
<link id="easyuiTheme" rel="stylesheet"
	href="plug-in/easyui_1.4.4/themes/bootstrap/easyui.css" type="text/css"></link>
<link id="easyuiTheme" rel="stylesheet"
	href="plug-in/easyui/themes/metrole/icon.css" type="text/css"></link>
<link rel="stylesheet" type="text/css"
	href="plug-in/accordion/css/icons.css">
<script type="text/javascript"
	src="plug-in/easyui/jquery.easyui.min.1.3.2.js"></script>
<script type="text/javascript" src="plug-in/easyui/locale/zh-cn.js"></script>
<script type="text/javascript" src="plug-in/tools/syUtil.js"></script>
<script type="text/javascript"
	src="plug-in/My97DatePicker/WdatePicker.js"></script>
<link rel="stylesheet" href="plug-in/tools/css/common.css"
	type="text/css"></link>
<script type="text/javascript"
	src="plug-in/lhgDialog/lhgdialog.min.js?skin=idialog"></script>
<script type="text/javascript" src="plug-in/tools/curdtools_zh-cn.js"></script>
<script type="text/javascript" src="plug-in/tools/easyuiextend.js"></script>

<script type="text/javascript" src="plug-in/layer/layer.js"></script>

<!--update-start--Author:luobaoli  Date:20150703 for：将本文档中所有href="#"修改为href="javascript:void(0)",避免rest风格下新增/删除等操作跳转到主页问题-->
<script type="text/javascript">
/**
*表单的高度,表单的宽度
**/
var personFw = 700,personFh = 400;

$(function(){
	$.get("cgFormHeadController.do?checkIsExit&checkIsTableCreate&name=person",
	function(data){
		data = $.parseJSON(data);
		if(data.success){
			createDataGridperson();
		}else{
			alertTip('表:<span style="color:red;">person</span>还没有生成,请到表单配置生成表');
		}
	});
});

function createDataGridperson(){
	var initUrl = 'cgAutoListController.do?datagrid&configId=person&field=id,create_name,create_by,create_date,update_name,update_by,update_date,sys_org_code,sys_company_code,bpm_status,name,';
	initUrl = encodeURI(initUrl);
	$('#personList').datagrid(
	{
	
	url:initUrl,
	idField: 'id', 
	title: '人员',
	fit:true,
	fitColumns:false,
	striped:true,
	autoRowHeight: true,
	pageSize: 10,
	pagination:true,
	singleSelect:true,
		sortName:'create_date',
	pageList:[10,30,50,100],
	sortOrder:'desc',
	rownumbers:true,
	showFooter:true,
	frozenColumns:[[]],
	columns:[
		[	
					
						 {	field:'id',
						 	title:'主键',
						 	hidden:true,
						 	sortable:true,
						 	width:120
						 	},
						 {	field:'create_name',
						 	title:'创建人名称',
						 	hidden:true,
						 	sortable:true,
						 	width:120
						 	},
						 {	field:'create_by',
						 	title:'创建人登录名称',
						 	hidden:true,
						 	sortable:true,
						 	width:120
						 	},
						 {	field:'create_date',
						 	title:'创建日期',
						 	hidden:true,
						 	sortable:true,
						 	width:120
						 	},
						 {	field:'update_name',
						 	title:'更新人名称',
						 	hidden:true,
						 	sortable:true,
						 	width:120
						 	},
						 {	field:'update_by',
						 	title:'更新人登录名称',
						 	hidden:true,
						 	sortable:true,
						 	width:120
						 	},
						 {	field:'update_date',
						 	title:'更新日期',
						 	hidden:true,
						 	sortable:true,
						 	width:120
						 	},
						 {	field:'sys_org_code',
						 	title:'所属部门',
						 	hidden:true,
						 	sortable:true,
						 	width:120
						 	},
						 {	field:'sys_company_code',
						 	title:'所属公司',
						 	hidden:true,
						 	sortable:true,
						 	width:120
						 	},
						 {	field:'bpm_status',
						 	title:'流程状态',
						 	hidden:true,
						 	sortable:true,
						 	width:120
						 	},
						 {	field:'name',
						 	title:'名称',
						 							 	sortable:true,
						 	width:120
						 	},
			{field:'opt',title:'操作',width:200,formatter:function(value,rec,index){
						if(!rec.id){return '';}
						var href='';
						href+="[<a href='javascript:void(0)' onclick=delObj('cgAutoListController.do?del&configId=person&id="+rec.id+"','personList')>";
						href+="删除</a>]";
						return href;
						}
			}
		]
	],
	onLoadSuccess:function(data){
		$("#personList").datagrid("clearSelections");
	},
	onClickRow:function(rowIndex,rowData)
		{rowid=rowData.id;gridname='personList';}
	});
	$('#personList').datagrid('getPager').pagination({beforePageText:'',afterPageText:'/{pages}',displayMsg:'{from}-{to}共{total}条',showPageList:true,showRefresh:true});
	$('#personList').datagrid('getPager').pagination({onBeforeRefresh:function(pageNumber, pageSize){ $(this).pagination('loading');$(this).pagination('loaded'); }});
	//将没有权限的按钮屏蔽掉
	}
	//列表刷新
	function reloadTable(){	
		try{
			$('#'+gridname).datagrid('reload');
		}catch(ex){
			//donothing
		}
	}
	//列表刷新-推荐使用
	function reloadpersonList(){
		$('#personList').datagrid('reload');
	}
	/**
	 * 获取列表中选中行的数据-推荐使用
	 * @param field 数据中字段名
	 * @return 选中行的给定字段值
	 */
	function getpersonListSelected(field){
		var row = $('#personList').datagrid('getSelected');
		if(row!=null){value= row[field];
		}else{
			value='';
		}
		return value;
	}
	/**
	 * 获取列表中选中行的数据
	 * @param field 数据中字段名
	 * @return 选中行的给定字段值
	 */
	function getSelected(field){
		var row = $('#'+gridname).datagrid('getSelected');
		if(row!=null){value= row[field];
		}else{
			value='';
		}
		return value;
	}
	
	/**
	 * 获取表格对象
	 * @return 表格对象
	 */
	function getDataGrid(){
		var datagrid = $('#'+gridname);
		return datagrid;
	}
	/**
	 * 获取列表中选中行的数据（多行）
	 * @param field 数据中字段名-不传此参数则获取全部数据
	 * @return 选中行的给定字段值，以逗号分隔
	 */
	function getpersonListSelections(field){
		var ids = '';
		var rows = $('#personList').datagrid('getSelections');
		for(var i=0;i<rows.length;i++){
			ids+=rows[i][field];
			ids+=',';
		}
		ids = ids.substring(0,ids.length-1);
		return ids;
	}
	/**
	 * 列表查询
	 */
	function personListsearch(){
		var queryParams=$('#personList').datagrid('options').queryParams;
		$('#personListtb').find('*').each(
			function(){
			queryParams[$(this).attr('name')]=$(this).val();});
			$('#personList').datagrid({url:'cgAutoListController.do?datagrid&configId=person&field=id,create_name,create_by,create_date,update_name,update_by,update_date,sys_org_code,sys_company_code,bpm_status,name,',pageNumber:1});
	}
	function dosearch(params){
		var jsonparams=$.parseJSON(params);
		$('#personList').datagrid({url:'cgAutoListController.do?datagrid&configId=person&field=id,create_name,create_by,create_date,update_name,update_by,update_date,sys_org_code,sys_company_code,bpm_status,name,,',queryParams:jsonparams});
	}
	function personListsearchbox(value,name){
		var queryParams=$('#personList').datagrid('options').queryParams;
		queryParams[name]=value;
		queryParams.searchfield=name;
		$('#personList').datagrid('reload');
	}
	$('#personListsearchbox').searchbox({
		searcher:function(value,name){
			personListsearchbox(value,name);
		},
		menu:'#personListmm',
		prompt:'请输入查询关键字'
	});
	//查询重置
	function personsearchReset(name){ 
		$("#"+name+"tb").find("input[type!='hidden']").val("");
		personListsearch();
	}
	//将字段href中的变量替换掉
	function applyHref(tabname,href,value,rec,index){
		//addOneTab(tabname,href);
		var hrefnew = href;
		var re = "";
		var p1 = /\#\{(\w+)\}/g;
		try{
			var vars =hrefnew.match(p1); 
			for(var i=0;i<vars.length;i++){
				var keyt = vars[i];
				var p2 = /\#\{(\w+)\}/g;
				var key = p2.exec(keyt);
				 hrefnew =  hrefnew.replace(keyt,rec[key[1]]);
			}
		}catch(ex){
		}
		re += "<a href = '#' onclick=\"addOneTab('"+tabname+"','"+ hrefnew+"')\" ><u>"+value+"</u></a>";
		return re;
	}
	//SQL增强入口-按钮
	function doBusButton(url,content,gridname){
		var rowData = $('#'+gridname).datagrid('getSelected');
		if (!rowData) {
			tip('请选择一条信息');
			return;
		}	
		url = url + '&id='+rowData.id;
		createdialog('确认 ', '确定'+content+'吗 ?', url,gridname);
	}
	//SQL增强入口-操作列里的链接
	function doBusButtonForLink(url,content,gridname,rowData){
		if (!rowData) {
			tip('请选择一条信息');
			return;
		}	
		url = url + '&id='+rowData;
		createdialog('确认 ', '确定'+content+'吗 ?', url,gridname);
	}
    //----author:jg_xugj---start----date:20151219-------- for：#813 【online表单】扩展出三个请求：独立的添加、查看、编辑请求，原来的保留
	//新增
	function personadd(){
		//update-begin--Author:luobaoli  Date:20150705 for：请求URL修改为REST风格
		//add('人员录入','rest/cgform/form/person','personList',personFw,personFh);
		//update-end--Author:luobaoli  Date:20150705 for：请求URL修改为REST风格
		
		add('人员录入','cgFormBuildController.do?goAddFtlForm&tableName=person&olstylecode=','personList',personFw,personFh);
	}
	//修改
	function personupdate(){
		//update-begin--Author:luobaoli  Date:20150705 for：请求URL修改为REST风格
		//update('人员编辑','rest/cgform/form/person','personList',personFw,personFh,true);
		//update-end--Author:luobaoli  Date:20150705 for：请求URL修改为REST风格
		
		update('人员编辑','cgFormBuildController.do?goUpdateFtlForm&tableName=person&olstylecode=','personList',personFw,personFh);
	}
	//查看
	function personview(){
		detail('查看','cgFormBuildController.do?goDatilFtlForm&tableName=person&mode=read&olstylecode=','personList',personFw,personFh);
	}
    //----author:jg_xugj---end----date:20151219-------- for：#813 【online表单】扩展出三个请求：独立的添加、查看、编辑请求，原来的保留
	
	
	//批量删除
	function persondelBatch(){
		//获取选中的ID串
		var ids = getpersonListSelections('id');
		if(ids.length<=0){
			tip('请选择至少一条信息');
			return;
		}
		$.dialog.confirm('确定删除吗?', function(r) {
			if(!r){return;}
			$.ajax({
			    url:"cgAutoListController.do?delBatch",
			    data:{'ids':ids,'configId':'person'},
				type:"Post",
			    dataType:"json",
			    success:function(data){
					tip(data.msg);
					reloadpersonList();
			    },
				error:function(data){
					$.messager.alert('错误',data.msg);
				}
			});
			}
		);
	}

	function personExportExcel(){
		var queryParams = $('#personList').datagrid('options').queryParams;
		$('#personListtb').find('*').each(function() {
		    queryParams[$(this).attr('name')] = $(this).val();
		});
		var params = '&';
		$.each(queryParams, function(key, val){
			params+='&'+key+'='+val;
		}); 
		var fields = '&field=';
		$.each($('#personList').datagrid('options').columns[0], function(i, val){
			if(val.field != 'opt'&&val.field != 'ck'){
				fields+=val.field+',';
			}
		}); 
		window.location.href = "excelTempletController.do?exportXls&tableName=person"+encodeURI(params+fields)
	}
	
	
	//JS增强
	
</script>
<table width="100%"   id="personList" toolbar="#personListtb"></table>
<div id="personListtb" style="padding:3px; height: auto">
<div name="searchColums">
	</div>
	<div style="height:30px;" class="datagrid-toolbar">
	<span style="float:left;" >
	
	<a id="add" href="javascript:void(0)"  class="easyui-linkbutton" plain="true"  icon="icon-add" onclick="personadd()">录入</a>
	<a id="update" href="javascript:void(0)"  class="easyui-linkbutton" plain="true"  icon="icon-edit" onclick="personupdate()">编辑</a>
	<a id="delete" href="javascript:void(0)" class="easyui-linkbutton" plain="true"  icon="icon-remove" onclick="persondelBatch()">批量删除</a>
	<a id="detail" href="javascript:void(0)" class="easyui-linkbutton" plain="true"  icon="icon-search" onclick="personview()">查看</a>
	<a id="import" href="javascript:void(0)"  class="easyui-linkbutton" plain="true"  icon="icon-put" onclick="add('人员Excel数据导入','excelTempletController.do?goImplXls&tableName=person','personList')">Excel数据导入</a>
	<a id="excel" href="javascript:void(0)" class="easyui-linkbutton" plain="true" onclick="personExportExcel()"  icon="icon-putout">Excel导出</a>
	
	</span>
	
	</div>
</div>
<!--update-end--Author:luobaoli  Date:20150703 for：将本文档中所有href="#"修改为href="javascript:void(0)",避免rest风格下新增/删除等操作跳转到主页问题-->