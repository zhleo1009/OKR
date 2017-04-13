<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui"></t:base>
<style>
.status_red{
	color: red;
}

.status_green{
	color: green;
}
</style>


<table id="taskOpinionItem" class="easyui-datagrid" style="width:99%;height:auto;"> 
<thead>  
        <tr>  
            <th field="name1" width="30px" >序号</th>  
            <th field="name2" width="10%">任务名称</th>  
            <th field="name3" width="120px">执行开始时间</th>  
            <th field="name4" width="120px">结束时间</th>  
            <th field="name5" width="10%">持续时间</th>  
            <th field="name6" width="10%">执行人名</th>  
            <th field="name7" width="10%">审批意见</th>  
            <th field="name8" width="10%">审批状态</th>  
        </tr>                             
    </thead>     
<tbody>                             
            
<c:forEach var="taskOpinionItem" items="${taskOpinionList}" varStatus="status">   
      <tr>
   <td> ${ status.index + 1} </td>
   <td>${taskOpinionItem.taskName } </td>
   <td>
   <fmt:formatDate pattern="yyyy-MM-dd hh:mm:ss" 
            value="${taskOpinionItem.startTime}" />
   </td>
   
   <td>
     <fmt:formatDate pattern="yyyy-MM-dd hh:mm:ss" 
            value="${taskOpinionItem.endTime}" />
   </td>
   
   <td>${taskOpinionItem.durTimeInfo }</td>
   <td>${taskOpinionItem.exeFullname }</td>
   <td>${taskOpinionItem.opinion }</td>
   <td>
<c:choose>
                <c:when test="${taskOpinionItem.checkStatus==1}"><span class="status_green">同意</span></c:when>
                <c:when test="${taskOpinionItem.checkStatus==2}"><span class="status_red">反对</span></c:when>
                <c:when test="${taskOpinionItem.checkStatus==3}"><span class="status_red">驳回</span></c:when>
                <c:when test="${taskOpinionItem.checkStatus==0}"><span class="status_red">弃权</span></c:when>
                <c:when test="${taskOpinionItem.checkStatus==4}"><span class="status_red">被追回</span></c:when>
                <c:when test="${taskOpinionItem.checkStatus==7}"><span class="status_red">知会意见</span></span></c:when>
                <c:otherwise><span class="status_red">尚未处理</span></c:otherwise>
            </c:choose>
     </td>
      </tr>   
</c:forEach>   
    </tbody>                              
</table> 


