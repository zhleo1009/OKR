<!DOCTYPE html>
<html>
 <head>
  <title></title>
  <script type="text/javascript" src="plug-in/jquery/jquery-1.8.3.js"></script><script type="text/javascript" src="plug-in/tools/dataformat.js"></script><link rel="stylesheet" type="text/css" href="plug-in/accordion/css/accordion.css"><link id="easyuiTheme" rel="stylesheet" href="plug-in/easyui_1.4.4/themes/bootstrap/easyui.css" type="text/css"></link><link rel="stylesheet" href="plug-in/easyui/themes/icon.css" type="text/css"></link><link rel="stylesheet" type="text/css" href="plug-in/accordion/css/icons.css"><script type="text/javascript" src="plug-in/easyui/jquery.easyui.min.1.3.2.js"></script><script type="text/javascript" src="plug-in/easyui/locale/zh-cn.js"></script><script type="text/javascript" src="plug-in/tools/syUtil.js"></script><script type="text/javascript" src="plug-in/My97DatePicker/WdatePicker.js"></script><link rel="stylesheet" href="plug-in/tools/css/common.css" type="text/css"></link><script type="text/javascript" src="plug-in/lhgDialog/lhgdialog.min.js?skin=idialog"></script><script type="text/javascript" src="plug-in/tools/curdtools_zh-cn.js"></script><script type="text/javascript" src="plug-in/tools/easyuiextend.js"></script><link rel="stylesheet" href="plug-in/uploadify/css/uploadify.css" type="text/css"></link><script type="text/javascript" src="plug-in/uploadify/jquery.uploadify-3.1.js"></script><script type="text/javascript" src="plug-in/tools/Map.js"></script><script type="text/javascript" src="plug-in/Validform/js/Validform_v5.3.1_min_zh-cn.js"></script><script type="text/javascript" src="plug-in/Validform/js/Validform_Datatype_zh-cn.js"></script><script type="text/javascript" src="plug-in/Validform/js/datatype_zh-cn.js"></script><script type="text/javascript" src="plug-in/Validform/plugin/passwordStrength/passwordStrength-min.js"></script><link rel="stylesheet" href="plug-in/Validform/css/metrole/style.css" type="text/css"/><link rel="stylesheet" href="plug-in/Validform/css/metrole/tablefrom.css" type="text/css"/><link rel="stylesheet" href="plug-in/umeditor/themes/default/css/umeditor.css" type="text/css"></link><script type="text/javascript" src="plug-in/umeditor/umeditor.config.js"></script><script type="text/javascript" src="plug-in/umeditor/umeditor.min.js"></script><script type="text/javascript" src="plug-in/umeditor/lang/zh-cn/zh-cn.js"></script>
 </head>
 <body>
  <form id="formobj" action="cgFormBuildController.do?saveOrUpdate" name="formobj" method="post">
			<input type="hidden" id="btn_sub" class="btn_sub"/>
			<input type="hidden" name="tableName" value="person" >
			<input type="hidden" name="id" value="4028a081550485540155048554820000" >
			  <input type="hidden" id="create_name" name="create_name" value="管理员" >
			  <input type="hidden" id="create_by" name="create_by" value="admin" >
			  <input type="hidden" id="create_date" name="create_date" value="2016-05-31 00:00:00" >
			  <input type="hidden" id="update_name" name="update_name" value="管理员" >
			  <input type="hidden" id="update_by" name="update_by" value="admin" >
			  <input type="hidden" id="update_date" name="update_date" value="2016-05-31 00:00:00" >
			  <input type="hidden" id="sys_org_code" name="sys_org_code" value="A03" >
			  <input type="hidden" id="sys_company_code" name="sys_company_code" value="A0" >
			  <input type="hidden" id="bpm_status" name="bpm_status" value="1" >
			<table cellpadding="0" cellspacing="1" class="formtable">
					<tr>
					<td align="right" >
						<label class="Validform_label">
							名称:
						</label>
					</td>
					<td class="value">
						<!--update-begin--Author:钟世云  Date:20150610 for：online支持树配置-->
							<input id="name"  name="name" type="text"
							       style="width: 150px" class="inputxt" value="qe"
					               
					               
					               >
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">名称</label>
					</td>
					</tr>
			  
			  <tr id = "sub_tr" style="display: none;">
				  <td colspan="2" align="center">
				  <input type="button" value="提交" onclick="neibuClick();" class="ui_state_highlight">
				  </td>
			  </tr>
			</table>
		<script type="text/javascript">$(function(){$("#formobj").Validform({tiptype:1,btnSubmit:"#btn_sub",btnReset:"#btn_reset",ajaxPost:true,usePlugin:{passwordstrength:{minLen:6,maxLen:18,trigger:function(obj,error){if(error){obj.parent().next().find(".Validform_checktip").show();obj.find(".passwordStrength").hide();}else{$(".passwordStrength").show();obj.parent().next().find(".Validform_checktip").hide();}}}},callback:function(data){if(data.success==true){uploadFile(data);}else{if(data.responseText==''||data.responseText==undefined){$.messager.alert('错误', data.msg);$.Hidemsg();}else{try{var emsg = data.responseText.substring(data.responseText.indexOf('错误描述'),data.responseText.indexOf('错误信息')); $.messager.alert('错误',emsg);$.Hidemsg();}catch(ex){$.messager.alert('错误',data.responseText+'');}} return false;}if(!neibuClickFlag){var win = frameElement.api.opener; win.reloadTable();}}});});</script>
	</form>
<script type="text/javascript">
   $(function(){
    //查看模式情况下,删除和上传附件功能禁止使用
	if(location.href.indexOf("load=detail")!=-1){
		$(".jeecgDetail").hide();
	}
	
	if(location.href.indexOf("mode=read")!=-1){
		//查看模式控件禁用
		$("#formobj").find(":input").attr("disabled","disabled");
	}
	if(location.href.indexOf("mode=onbutton")!=-1){
		//其他模式显示提交按钮
		$("#sub_tr").show();
	}
   });
  function upload() {
  }
  var neibuClickFlag = false;
  function neibuClick() {
	  neibuClickFlag = true; 
	  $('#btn_sub').trigger('click');
  }
  function cancel() {
  }
  function uploadFile(data){
  		if(!$("input[name='id']").val()){
  			<!--update-start--Author:luobaoli  Date:20150614 for：需要判断data.obj存在，才能取id值-->
  			if(data.obj!=null && data.obj!='undefined'){
  				$("input[name='id']").val(data.obj.id);
  			}
  			<!--update-end--Author:luobaoli  Date:20150614 for：需要判断data.obj存在，才能取id值-->
  		}
  		if($(".uploadify-queue-item").length>0){
  			upload();
  		}else{
  			if (neibuClickFlag){
  				alert(data.msg);
  				neibuClickFlag = false;
  			}else {
	  			var win = frameElement.api.opener;
				win.reloadTable();
				win.tip(data.msg);
				frameElement.api.close();
  			}
  		}
  	}
	$.dialog.setting.zIndex =1990;
	function del(url,obj){
		$.dialog.confirm("确认删除该条记录?", function(){
		  	$.ajax({
				async : false,
				cache : false,
				type : 'POST',
				url : url,// 请求的action路径
				error : function() {// 请求失败处理函数
				},
				success : function(data) {
					var d = $.parseJSON(data);
					if (d.success) {
						var msg = d.msg;
						tip(msg);
						$(obj).closest("tr").hide("slow");
					}
				}
			});  
		}, function(){
	});
}

/**树形列表数据转换**/
function convertTreeData(rows, textField) {
    for(var i = 0; i < rows.length; i++) {
        var row = rows[i];
        row.text = row[textField];
        if(row.children) {
        	row.state = "open";
            convertTreeData(row.children, textField);
        }
    }
}
/**树形列表加入子元素**/
function joinTreeChildren(arr1, arr2) {
    for(var i = 0; i < arr1.length; i++) {
        var row1 = arr1[i];
        for(var j = 0; j < arr2.length; j++) {
            if(row1.id == arr2[j].id) {
                var children = arr2[j].children;
                if(children) {
                    row1.children = children;
                }
                
            }
        }
    }
}
</script>
	<script type="text/javascript"></script>		
 </body>
</html>