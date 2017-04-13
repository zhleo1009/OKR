<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<script >

</script>
	
	
	
	
	
	<!--  
	<table style="height: 25px;width: 100%"  id="tab_div_database_title">
		 <tbody>
		<tr bgcolor="#E6E6E6">
			<th  bgcolor="#EEEEEE" align="left" height="28">下一步节点</th>
			
			<c:if test="${canChoicePath}">
				<th bgcolor="#EEEEEE" height="28">选择同步条件后的执行路径</th>
			</c:if>
				
			<th  bgcolor="#EEEEEE" align="left" >下一步审批人</th>
		</tr>
		 </tbody>	
		 
		 <!--  
		<c:forEach items="${nodeTranUserList}" var="nodeTranUser" varStatus="i">
			<tr>
				<td height="28" width="18%" nowrap="nowrap">
					<c:if test="${selectPath==1 }">
						<input type="radio" name="destTask" value="${nodeTranUser.nodeId}"/>
					</c:if>
					${nodeTranUser.nodeName}
					<!-- 跳转的目标节点 -->
				</td>
			<!--  	
				<c:if test="${canChoicePath}">
				<td>
					<c:forEach items="${nodeTranUser.nextPathMap}" var="nextPath">
							<div>
								<label><input type="checkbox" name="nextPathId" value="${nextPath.key}"/>
								${nextPath.value}</label>
							</div>
						</c:forEach>
					</td>
				</c:if>
				
				<td>
					<c:forEach items="${nodeTranUser.nodeUserMapSet}" var="nodeUserMap">
						<div>
							<%-- ${nodeUserMap.nodeName} --%>
							<input type="hidden" name="lastDestTaskId" value="${nodeUserMap.nodeId}"/>
							<span name="spanSelectUser">
							<c:forEach items="${nodeUserMap.taskExecutors}" var="executor">
								
								<input type="checkbox" id="aa${executor.executeId}" name="${nodeUserMap.nodeId}_userId" checked="checked" value="${executor.type}^${executor.executeId}^${executor.executor}"/>&nbsp;<label for="aa${executor.executeId}">${executor.executor}</label>
							</c:forEach>
							</span>
							&nbsp;&nbsp;
							
							<a href="javascript:;" class="link detail" onclick="selExeUsers(this,'${nodeUserMap.nodeId}')">选择审批人</a>
						</div>
					</c:forEach>
				</td> 
			</tr>
		</c:forEach>
	</table>
	-->
	