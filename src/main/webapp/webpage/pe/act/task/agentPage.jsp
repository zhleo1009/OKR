<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  
  <t:datagrid name="agentPage" checkbox="true"  fitColumns="false" title="流程代理授权" 
  actionUrl="sysUserAgentController.do?list&pojo=sysUserAgent" idField="agentid" fit="true" queryMode="group">
   	<t:dgCol title="agentid" field="id" hidden="true" />
   	<t:dgCol title="agentid" field="agentid" hidden="true" />
	<t:dgCol title="授权人id" field="agentuserid" autocomplete="true" hidden="true"  width="200"/>
	<t:dgCol title="代理人id" field="touserid"  autocomplete="true" hidden="true" width="200"/>
	<t:dgCol title="代理人" field="tofullname" query="true" queryStyle="padding-left:20px;" autocomplete="true"  width="200"/>
    <t:dgCol title="开始时间" field="starttime" formatterjs="formatterTime"  width="150"/>
    <t:dgCol title="结束时间" field="endtime" formatterjs="formatterTime"   width="150"/>
    <t:dgCol title="全权代理" field="isall" query="true" replace="是_1,否_0"   autocomplete="true"  />
    <t:dgCol title="是否有效" field="isvalid" query="true" replace="是_1,否_0" autocomplete="true"  />
    <t:dgCol title="管理" field="opt"  width="120"/>
    <t:dgFunOpt  title="删除" funname="delAgent(agentid)" />
   	<t:dgToolBar title="批量删除"  icon="icon-remove" url="sysUserAgentController.do?del"  funname="delAgents"></t:dgToolBar>
    <t:dgToolBar title="common.add.param" langArg="代理"  icon="icon-add" url="sysUserAgentController.do?edit" funname="add" width="800" height="500"></t:dgToolBar>
	<t:dgToolBar title="common.edit.param" langArg="代理"  icon="icon-edit" url="sysUserAgentController.do?edit" funname="updAgent" ></t:dgToolBar>
    </t:datagrid>
  </div>
 </div>
<!-- <script src="jeecg/cgreport/core/cgreportConfigHeadList.js"></script> -->
<script type="text/javascript" src="plug-in/tools/curdtools_zh-cn.js"></script>
 <script type="text/javascript">
		$(document).ready(function() {
			//给时间控件加上样式
		});

		//添加
		/* function addAgent(title, url, gname) {
			add(title, url, gname, 800, 500);
		} */

		//更新
		function updAgent(title, url, gname) {
			update2(title, url, gname, 800, 500);
		}
	
		function update2(title,url, id,width,height,isRestful) {
			gridname=id;
			var rowsData = $('#'+id).datagrid('getSelections');
			if (!rowsData || rowsData.length==0) {
				layer.msg('请选择编辑项目');
				return;
			}
			if (rowsData.length>1) {
				layer.msg('请选择一条记录再编辑');
				return;
			}delObj
			if(isRestful!='undefined'&&isRestful){
				url += '/'+rowsData[0].agentid;
			}else{
				url += '&id='+rowsData[0].agentid;
			}
			
			createwindow(title,url,width,height);
		}

		//删除
		function delAgent(id, content) {
			var tabName = 'agentPage';
			var url = 'sysUserAgentController.do?del';
			top.layer.confirm( '<t:mutiLang langKey="confirm.delete.this.record"/>',
					function(index) {
						$.post(url, { "agentid" : id }, function(data) {
								var jsonResult = eval("(" + data + ")");
								if (jsonResult.success) {
									top.layer.msg(jsonResult.msg);
									agentPagesearch();
								} else {
									layer.msg(jsonResult.msg, {
										icon : 2
									});
								}
								top.layer.close(index);
							});
					});
		};
		
		function delAgents(title,urls,id){
			var rowsData = $('#'+id).datagrid('getSelections');
			if (!rowsData || rowsData.length==0) {
				top.layer.msg('<t:mutiLang langKey="common.please.select.item"/>');
				return;
			}
			top.layer.confirm('<t:mutiLang langKey="confirm.remove.record"/>？', function(index){
					var ids=new Array();
					for(var i=0;i<rowsData.length;i++){
						ids.push(rowsData[i].agentid);
					}
					$.ajax({
						url : urls,
						type : 'post',
						data : {
							agentid : ids.join(',')
						},
						cache : false,
						success : function(data) {
							var d = $.parseJSON(data);
							// 来源页面
							if (d.success) {
								var msg = d.msg;
								top.layer.msg(msg);
								agentPagesearch();
							}
						}
					}); 
			});
		    }

		
		
		
		/*
		curdtools_zh-cn.js
		重写saveObj()
		*/
		/* function saveObj() {
			iframe.saveEdit(window);
		} */
		
		//页面数据重载
		/* function reflash(){
			iframe.windowapi.close();
			agentPagesearch();
		} */
		

	</script>
