<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools"></t:base>
<html>

<head>

<script type="text/javascript">

function StringBuffer(){
	this.content = new Array;
};
StringBuffer.prototype.append = function( str ){
	this.content.push( str );
};
StringBuffer.prototype.toString = function(){
	return this.content.join("");
} ;

// 添加
function addUpLow(){
	var index = $('#tab_div_database tr').length + 1;
	$('#tab_div_database').append('<tr><td style="width: 5%;"align="center"><a name="rownumber[#rindex#]">'+index+'</a></td><td style="width: 5%;"align="center"><span><input type="checkbox"name="valueId"/></span></td><td style="width: 30%;"align="center"><select style="width: 100%;"name="demensionId"><option value="1">行政维度</option></select></td><td style="width: 30%;"align="center"><select onchange="changeUpLowType(this)"style="width: 100%;"name="upLowType"><option value="0">同级</option><option value="1">上级</option><option value="-1">下级</option></select></td><td style="width: 30%;"align="center"><select onchange="changeUpLowLevel(this)"style="width: 100%;display: none"name="upLowLevel"><option selected="selected"value="0">0</option><option value="1">1</option><option value="2">2</option><option value="3">3</option><option value="4">4</option><option value="5">5</option></select></td></tr>');
}

// 删除
function deleteUpLow(){
	
	var checkedBoxs = $('input:checkbox[name=valueId]:checked');
	if(checkedBoxs){
		checkedBoxs.each(function(){
			$(this).parents('tr')[0].remove();
		});
	}
	resetTrNum('#tab_div_database');
}


function resetTrNum(tableId) {
	$(tableId + " tbody tr").each(function(i) {
		$(':input, select,a', this).each(function() {
					var $this = $(this), name = $this.attr('name'), val = $this
							.val();
					if (name != null && name.indexOf("#index#") >= 0) {
						$this.attr("name", name.replace('#index#', i));
					}
					if (name != null && name.indexOf("rownumber") >= 0) {
						$this.html(i+1); 
					}
					
				});
	});
}

//清空
function deleteBatchUpLow(){
	$('#tab_div_database tbody').empty();
}


function changeUpLowType(obj){
	var td1=$(obj).parents("td");
	var upLowType=$(obj).val();
	var td2=$(td1).next("td");
	if(upLowType==0){
		$(td2).find("select[name='upLowLevel']").val(0);
		$(td2).find("select[name='upLowLevel']").hide();
	}else{
		$(td2).find("select[name='upLowLevel']").show();
		var upLowLevel=$(td2).find("select[name='upLowLevel']").val();
		if(upLowLevel==0)
			$(td2).find("select[name='upLowLevel']").val(1);
	}
};

function changeUpLowLevel(obj){
	var upLowLevel=$(obj).val();
	if(upLowLevel==0){
		var td2=$(obj).parents("td");
		var td1=$(td2).prev("td");
		$(td1).find("select[name='upLowType']").val(0);
		$(obj).hide();
	}else{
		var td2=$(obj).parents("td");
		var td1=$(td2).prev("td");
		var upLowType=$(td1).find("select[name='upLowType']").val();
		if(upLowType==0)$(obj).val(0);
		
	}
};



// 返回选择的json
function selectUplow(){
	//if(!validDuplicate())return;
	//if(!validateVal())return;
	var json=getUplowJson();
	var show=getUplowShow();
	return {json:json,show:show};
};

function getUplowShow(){
	var $demensionIds=$("select[name='demensionId'] option:selected");
	var $upLowTypes=$("select[name='upLowType'] option:selected");
	var $upLowLevels=$("select[name='upLowLevel'] option:selected");
	var sb=new StringBuffer("");
	if($demensionIds.length>0){
		for(i=0;i<$demensionIds.length;i++){
			var demensionName=$($demensionIds[i]).text();

			var upLowType=$($upLowTypes[i]).val();
			var upLowLevel=$($upLowLevels[i]).val();
			var type="同";
			if(upLowType==1) type="上";
			else if(upLowType==-1)type="下";
			else  type="同";	
			
			
			sb.append(demensionName);
			sb.append(type);
			sb.append(upLowLevel);
			sb.append("级");
			
			

			sb.append(",");
		}
		sb=sb.toString();
		if(sb.length>0)sb=sb.substring(0,(sb.length-1));
	}
	return sb;
};

function getUplowJson(){
	var $demensionIds=$("select[name='demensionId'] option:selected");
	var $upLowTypes=$("select[name='upLowType'] option:selected");
	var $upLowLevels=$("select[name='upLowLevel'] option:selected");
	var sb=new StringBuffer();
	sb.append("[");
	
	if($demensionIds.length>0){
		
		for(i=0;i<$demensionIds.length;i++){
			var demensionId=$($demensionIds[i]).val();
			var demensionName=$($demensionIds[i]).text();
			var upLowType=$($upLowTypes[i]).val();
			var upLowLevel=$($upLowLevels[i]).val();

			sb.append("{");
			
			sb.append("demensionId");
			sb.append(":");
			sb.append(demensionId);
			sb.append(",");

			sb.append("demensionName");
			sb.append(":");
			sb.append("\"");
			sb.append(demensionName);
			sb.append("\"");
			
			sb.append(",");

			sb.append("upLowType");
			sb.append(":");
			sb.append(upLowType);
			sb.append(",");

			sb.append("upLowLevel");
			sb.append(":");
			sb.append(upLowLevel);

			sb.append("}");

			sb.append(",");
			
		}
		sb=sb.toString();
		if(sb.length>0)sb=sb.substring(0,(sb.length-1));
		
		
	}
	sb+="]";
	return sb;
};

</script>
</head>
<body>
<div class="datagrid-toolbar" style="height: 25px;">
  <a href="#" onclick="addUpLow();" data-options="iconCls:'icon-add'" class="easyui-linkbutton l-btn l-btn-small" id="addColumnBtn" group="">添加<span class="l-btn-icon icon-add">&nbsp;</span></a>
  <a href="#" onclick="deleteUpLow();" data-options="iconCls:'icon-remove'" class="easyui-linkbutton l-btn l-btn-small" id="delColumnBtn" group="">删除</span><span class="l-btn-icon icon-remove">&nbsp;</span></a>
  <a href="#" onclick="deleteBatchUpLow();" data-options="iconCls:'icon-remove'" class="easyui-linkbutton l-btn l-btn-small" id="delColumnBtn" group="">清空<span class="l-btn-icon icon-remove">&nbsp;</span></a>
</div>

<table style="height: 25px;width: 100%" id="tab_div_database_title">
    <tbody>
     <tr bgcolor="#E6E6E6">
		<th bgcolor="#EEEEEE" align="center" style="width: 5%;">序号</th>
		<th bgcolor="#EEEEEE" align="center" style="width: 5%;">操作</th>
		<th bgcolor="#EEEEEE" align="center" style="width: 30%;">维度</th>
		<th bgcolor="#EEEEEE" align="center" style="width: 30%;">上下级关系</th>
		<th bgcolor="#EEEEEE" align="center" style="width: 30%;">级数</th>
	 </tr>
	</tbody>
</table>

<div id="t_table_database" class="t_table" >
   <table class="table-list" id="tab_div_database" style="width: 100%">
     <tbody class="ui-sortable">
     <tr>
	        <td style="width: 5%;" align="center">
		      	<a name="rownumber[#rindex#]">1</a>
	      	</td>
	      	<td style="width: 5%;"  align="center">
		      	<span><input type="checkbox" name="valueId"/></span>
	      	</td>
	      	<td style="width: 30%;"  align="center">
		      	<select style="width: 100%;" name="demensionId">
		      		<option value="1">行政维度</option>
		      	</select>
	      	</td>
	      	<td style="width: 30%;"  align="center">
		      	<select onchange="changeUpLowType(this)" style="width: 100%;" name="upLowType">
				  <option value="0">同级</option>
				  <option value="1">上级</option>
				  <option value="-1">下级</option>
				</select>
	      	</td>
	      	<td style="width: 30%;"  align="center">
		      	<select onchange="changeUpLowLevel(this)" style="width: 100%;display: none" name="upLowLevel">
				  <option selected="selected" value="0">0</option>
				  <option value="1">1</option>
				  <option value="2">2</option>
				  <option value="3">3</option>
				  <option value="4">4</option>
				  <option value="5">5</option>
				</select>
	      	</td>
     </tr>
 	 </tbody>
   </table>
 <br><br><br>
</div>
</body>
</html>
