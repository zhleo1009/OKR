<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script >

$(function(){
	
	var now=new Date();
	
	$("#riqi").append(now.getFullYear()+"-"+(now.getMonth()+1)+"-"+now.getDate());

});

</script>

<c:choose>
	<c:when test="${not isSignTask}">
			
			<table style="width: 100%;" cellpadding="0" cellspacing="1"  class="formtable">
		<tr>
			<th align="right"  width="80px"  height="40px;" nowrap> <label class="Validform_label">审 批 人:</label></th>
			<td class="value" style="padding-left: 15px">${sessionUser.fullname }</td>
		</tr>
		<tr>
			<th align="right"  width="80px" height="40px;" nowrap> <label class="Validform_label">审批日期:</label></th>
			<td class="value" id="riqi" style="padding-left: 15px"></td>
		</tr>
		
			<tr>
			<th align="right"  width="80px" height="40px;" nowrap> <label class="Validform_label">审批意见:</label></th>
			<td class="value" style="padding-left: 15px">
			
				<c:if test="${!empty taskAppItems}">
							常用语选择:
							<select  id="selTaskAppItem" onchange="addComment()" >
								<option value="" style="text-align:center;">-- 请选择 --</option>
								<c:forEach var="item" items="${taskAppItems}">
									<option value="${item}">${item}</option>
								</c:forEach>
							</select>
							<br>
						</c:if>
						<c:if test="${isClaim==true}">
							<textarea rows="2" cols="78" id="voteContent" name="voteContent" maxlength="512" style="height: 60px;"></textarea>
						</c:if>
						<c:if test="${isClaim==false}">
							<textarea rows="2" cols="78" id="voteContent" name="voteContent" maxlength="512" readonly="readonly" style="height: 60px;"></textarea>
						</c:if>
			
			</td>
		</tr>
		
		 	 <tr>
					    <td colspan="3" align="right" height="50px;">
					    <!-- 审批按钮 -->
					    	<c:choose>
				            	<c:when test="${(empty task.executionId) && task.description=='通知任务' }">
				            	</c:when>
				            	<c:otherwise>
				            	<%@include file="/webpage/pe/act/task/incToolBarNode.jsp"%>
				            	</c:otherwise>
				            </c:choose>
			            </td>
				    </tr>
	</table>
	</c:when>
	
	
	<c:otherwise>
		<div id="taskOpinion">
			<table class="table-detail">
				<tr>
					<th nowrap="nowrap" width="120">会签人</th>
					<td>${curUser.fullname}</td>
				</tr>
				<tr>
					<th nowrap="nowrap">会签意见</th>
					<td>
						
						<textarea rows="3" cols="78" id="voteContent" name="voteContent" maxlength="512"></textarea>
						<input type="hidden" id="isSignTask" name="isSignTask" value="true"/>
					</td>
				</tr>
				
			</table>
			<br>
		
		
		
		</div>
		 <!-- 审批按钮 -->
					    	<c:choose>
				            	<c:when test="${(empty task.executionId) && task.description=='通知任务' }">
				            			
				            	</c:when>
				            	<c:otherwise>
				            			<%@include file="/webpage/pe/act/task/incToolBarNode.jsp"%>
				            	</c:otherwise>
				            </c:choose>
	</c:otherwise>
</c:choose>


