<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<%@taglib prefix="f" uri="http://www.pe.cn/functions" %>
<t:base type="jquery,easyui,tools"></t:base>
<!DOCTYPE html>
<html>
<head>
<title>任务到期提醒</title>
<style type="text/css">
.formtable .inputxt {
    border: 1px solid #d7d7d7;
    border-radius: 3px;
    display: inline-block;
    font-size: 12px;
    line-height: 14px;
    padding: 4px 0 4px 5px;
    width: 150px;
}

.choose-assigner{
	display: none;
}

.send-msg-tr{
	display: none;
}

</style>

<script type="text/javascript" charset="utf-8" src="plug-in/Formdesign/js/ueditor/ueditor.config.js?2023"></script>
<script type="text/javascript" charset="utf-8" src="plug-in/Formdesign/js/ueditor/ueditor.all.js?2023"> </script>
<script type="text/javascript" charset="utf-8" src="plug-in/Formdesign/js/ueditor/customizedpe/customizePeButton.js?2023"> </script>

<script type="text/javascript">

var curTime = '${taskReminder.times}';

$(function(){
	
	$('#taskRemainderList').datagrid({
        url:'bpmDefinitionController.do?taskReminders&actDefId=${actDefId}&nodeId=${nodeId}&field=taskDueId,name',
        idField:'taskDueId',
        striped:true,
        border:false,
        singleSelect:true,
        fit:true,
        fitColumns:true,
        columns:[[
            {field:'taskDueId',title:'taskDueId',hidden:true},
            {field:'name',title:'名称',width:'100'},
            {field:'oper',title:'操作',formatter:operFormatter,width:'150'}
        ]]
    });
	
	// fieldSet
	$("#condition").lqfieldset({  
        title:'到期条件设置',  
        collapsible:true,  
        collapsed:false,  
        checkboxToggle:false  
    });  
	
	$("#timeAction").lqfieldset({  
        title:'到期动作设置',  
        collapsible:true,  
        collapsed:false,  
        checkboxToggle:false  
    });  
	
	$("#sendMessage").lqfieldset({  
        title:'发送催办消息设置',  
        collapsible:true,  
        collapsed:false,  
        checkboxToggle:false  
    });  
	
	//是否发送催办信息的checkbox
	$("#needSendMsg").change(function(){
		var me = $(this),
			sendMsg = me.attr("checked");
		if(sendMsg){
			$(".send-msg-tr").show();
		}else{
			$("select[name='times']").val(0);
			$(".send-msg-tr").hide();
		}
	});
	
	if(curTime>0){
		$("#needSendMsg").attr("checked","checked").trigger("change");
	}else{
		$("#needSendMsg").removeAttr("checked");
	}
	
	//到期动作
	change();
	
	
});

// 操作
function operFormatter(val,row,index){
	
	return "[<a style='margin-left:3px;' href='javascript:showTaskRemainder("+ row.taskDueId + ")'>编辑</a>]" + 
		   "[<a style='margin-left:3px;' href='javascript:deleteTaskRemainder("+ row.taskDueId + ")'>删除</a>]";
	
}


// 编辑任务到期提醒
function showTaskRemainder(taskDueId){
	var actDefId = $('input[name=actDefId]').val();
	var nodeId = $('input[name=nodeId]').val();
	var url = "bpmDefinitionController.do?editTaskReminder&actDefId="
		+ actDefId + "&nodeId=" + nodeId + "&id=" + taskDueId;
	
	// 直接跳转
	window.location.href=url;
	
}


// 删除任务提醒
function deleteTaskRemainder(taskDueId){
	
	top.layer.confirm('确认删除吗？',{zIndex: top.layer.zIndex}, function(index){
		
		$.ajax({
			  type: 'POST',
			  url: 'bpmDefinitionController.do?delTaskReminder',
			  data: {taskDueId: taskDueId},
			  success: function(data){
				  if(data.success){
					  $('#taskRemainderList').datagrid('reload');
					  top.layer.close(index);
				  }
			  } ,
			  dataType: 'json'
		});
		
	});
	
}

// 保存
function save(){
	
	$("#btn_sub").click();
	
}

// 保存表单回调函数
function callback(data){
	layer.msg(data.msg);
	if(data.success){
		$('#taskRemainderList').datagrid('reload');
	}
}

// 到期动作设置
function change(){
	var s = $("#action").val();
	//$(".sub").hide();
	$(".choose-assigner").hide();
	if(s==5){//选择交办切换
		$(".choose-assigner").show();
	}
}
	
	
//获取分钟数
function getTotalMinute(e){
	var t=0;
	$(e).find(".dayInput").each(function(){
		t+= parseInt(3600* this.value);
	});
	$(e).find(".hourInput").each(function(){
		t+=parseInt(60* this.value);
	});			
	$(e).find(".minuteInput").each(function(){
		t+=parseInt(this.value);
	});
	return t;
}

// 表单validForm验证通过后，调用该方法
function validForm(data){
	
	var ctime=getTotalMinute($("#completeTr"));//相对时间
	var stime=getTotalMinute($("#startTr"));//开始发送时间
	//每次时间间隔*催办次数。
	var etime=getTotalMinute($("#endTr")) * ( parseInt($("#times").val())-1);
	//alert(ctime + ',' + stime + ',' + etime);
	if(ctime<stime+etime){				
		layer.msg('办结时间不能比催办时间短！');
		return false;// return false 表单不会提交
	}
	
}

// 开展模板列表
function showTaskRemainderTemplate(ueditorType){
	
	top.layer.open({
		id : 'changePasswordLayer',
		type : 2,
		title : '模板选择',
		content : [ 'bpmDefinitionController.do?toTaskRemainderTemplates', 'no' ],
		area : [ '600px', '300px' ],
		btn : [ '确定', '取消' ],
		zIndex : top.layer.zIndex,
		yes : function(index, layero) {
			var tmp = layero.find('iframe').contents().find('#selectedTmp').val();
			var editor = UE.getEditor(ueditorType);
			if(tmp != ''){
				editor.setContent(tmp);
			}
			top.layer.close(index);
		}
	});
	
	
}

// 新建任务到期提醒
function add(){
	
	window.location.href = 'bpmDefinitionController.do?editTaskReminder&actDefId=${actDefId}&nodeId=${nodeId}';
	
}

</script>

</head>

<body style="margin: 2px;">
<div style="height: 25px;" class="datagrid-toolbar">
  <a group="" id="addColumnBtn" class="easyui-linkbutton l-btn l-btn-small" data-options="iconCls:'icon-add'" onclick="add()" href="#">
      <span>新建</span>
  </a>
  <a group="" id="addColumnBtn" class="easyui-linkbutton l-btn l-btn-small" data-options="iconCls:'icon-save'" onclick="save()" href="#">
      <span>保存</span>
  </a>
</div>
<div class="easyui-layout" fit="true">

	<div region="center" style="padding:0px; border:0px;width: 100%" id="center">
		<jsp:include page="taskRemainderSetF.jsp"></jsp:include>
	</div>
	
	
	<div region="west" style="width: 210px;" title="催办设置列表" split="true" collapsed="false">
		<table id="taskRemainderList"></table>
	</div> 

</div>



</body>
</html>