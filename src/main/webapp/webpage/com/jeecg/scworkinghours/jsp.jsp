
<link rel="stylesheet" href="plug-in/Validform/css/metrole/style.css"
	type="text/css" />
<link rel="stylesheet"
	href="plug-in/Validform/css/metrole/tablefrom.css" type="text/css" />
<script type="text/javascript"
	src="plug-in/Validform/js/Validform_v5.3.1_min_zh-cn.js"></script>
<script type="text/javascript"
	src="plug-in/Validform/js/Validform_Datatype_zh-cn.js"></script>
<script type="text/javascript"
	src="plug-in/Validform/js/datatype_zh-cn.js"></script>
<SCRIPT type="text/javascript"
	src="plug-in/Validform/plugin/passwordStrength/passwordStrength-min.js"></SCRIPT>
<script type="text/javascript">
	$(function() {
		$("#formobj").Validform(
				{
					tiptype : 4,
					btnSubmit : "#btn_sub",
					btnReset : "#btn_reset",
					ajaxPost : true,
					usePlugin : {
						passwordstrength : {
							minLen : 6,
							maxLen : 18,
							trigger : function(obj, error) {
								if (error) {
									obj.parent().next().find(
											".Validform_checktip").show();
									obj.find(".passwordStrength").hide();
								} else {
									$(".passwordStrength").show();
									obj.parent().next().find(
											".Validform_checktip").hide();
								}
							}
						}
					},
					callback : function(data) {
						var win = frameElement.api.opener;
						if (data.success == true) {
							frameElement.api.close();
							win.tip(data.msg);
						} else {
							if (data.responseText == ''
									|| data.responseText == undefined) {
								$.messager.alert('错误', data.msg);
								$.Hidemsg();
							} else {
								try {
									var emsg = data.responseText.substring(
											data.responseText.indexOf('错误描述'),
											data.responseText.indexOf('错误信息'));
									$.messager.alert('错误', emsg);
									$.Hidemsg();
								} catch (ex) {
									$.messager.alert('错误', data.responseText
											+ "");
									$.Hidemsg();
								}
							}
							return false;
						}
						win.reloadTable();
					}
				});
	});
</script>
</form>