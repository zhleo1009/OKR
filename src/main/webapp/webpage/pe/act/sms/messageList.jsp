<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
 <t:base type="jquery,easyui,tools"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="noticeList" title="消息列表" checkbox="true" fitColumns="true" actionUrl="messageController.do?datagrid" idField="id" fit="true" sortName="isRead" sortOrder="asc" queryMode="single">
   <t:dgCol title="编号" field="id" hidden="true"></t:dgCol>
   <t:dgCol title="状态" field="isRead" width="40" replace="已读_1,未读_0"></t:dgCol>
   <t:dgCol title="标题" field="esTitle" width="120" query="true"></t:dgCol>
   <t:dgCol title="时间" field="esSendtime" formatter="yyyy-MM-dd hh:mm" width="80"></t:dgCol>
   <t:dgCol title="common.operation" field="opt" width="40"></t:dgCol>
   <t:dgFunOpt funname="doRead(id,isRead)" title="common.read"></t:dgFunOpt>
      <t:dgToolBar title="批量删除"  icon="icon-remove" url="messageController.do?doBatchDel" funname="deleteALLSelect"></t:dgToolBar>
   
     <t:dgToolBar title="标记已读"  icon="icon-edit" url="messageController.do?doBatchRead" funname="readALLSelect"></t:dgToolBar>
   
   
  </t:datagrid>
  </div>
 </div>
 <script type="text/javascript" charset="utf-8">
 
 
 
 /**
  * 多记录刪除請求
  * 
  * @param title
  * @param url
  * @param gname
  * @param idFile
  * @param idFileName
  * @return
  */
 function readALLSelect(title,url,gname,idFileName) {
 	gridname=gname;
     var ids = [];
     var rows = $("#" + gname).datagrid('getSelections');
     if (rows.length > 0) {
     	top.layer.confirm('你确定标记已读吗？', function(index){
     		for ( var i = 0; i < rows.length; i++) {
     			if(idFileName == null){
     				ids.push(rows[i].id);
     			}else{
     				ids.push(rows[i][idFileName]);
     			}
 			}
 			$.ajax({
 				url : url,
 				type : 'get',
 				data : {
 					ids : ids.join(',')
 				},
 				cache : false,
 				success : function(data) {
 					var d = $.parseJSON(data);
 					var msg = d.msg;
 					top.layer.msg(msg);
 					if (d.success) {
 						reloadTable();
 						$("#"+gname).datagrid('unselectAll');
 					}
 					ids='';
 				}
 			});
     		top.layer.close(index);
     	});
     	
 	} else {
 		top.layer.msg("请选择需要标记的数据");
 	}
 }
 
 
 
  $('#noticeList').datagrid({   
	    rowStyler:function(index,row){   
	        if (row.isRead!=1){
	            return 'font-weight:bold !important;';   
	        }   
	    }
	});
  
  function doRead(id,isRead){
	  if(isRead!=1){
		  var url = "messageController.do?updateMessageRead";
			$.ajax({
	    		url:url,
	    		type:"GET",
	    		dataType:"JSON",
	    		data:{
	    			messageId:id
	    		},
	    		success:function(data){
	    			if(data.success){
	    				$('#noticeList').datagrid({   
	    				    rowStyler:function(index,row){   
	    				        if (row.isRead!=1){
	    				            return 'font-weight:bold !important;';   
	    				        }else{
	    				        	return 'font-weight:normal;';
	    				        }
	    				    }   
	    				});
	    			}
	    		}
	    	});
	  }
	  var addurl = "messageController.do?goMessage&id="+id;
		
	   top.layer.open({
			title: '消息详情',
			type : 2,
			content : addurl,
			area : [ '800px', '600px' ]
		});
		
		
  }
  
 </script>