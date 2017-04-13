<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div >
	
	<div style="height:30px;float: left;" >	
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<c:choose>
				<c:when test="${!isClaim}">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" id="local" href="javascript:claim(${task.id});">锁定</a>
				</c:when>
				<c:otherwise>
					<c:choose>
					<c:when test="${empty mapButton }">
						<c:if test="${isSignTask && isAllowDirectExecute}">
							<div class="easyui-linkbutton l-btn l-btn-small l-btn-plain">
								特权：<input type="checkbox" value="1" id="chkDirectComplete"><label for="chkDirectComplete">直接结束</label>
							</div>
						</c:if>
					<a id="btnAgree" class="easyui-linkbutton l-btn l-btn-small l-btn-plain">完成任务</a>
					
					<c:if test="${isSignTask==true}">
					
					<!-- 
						<a id="btnNotAgree" class="easyui-linkbutton l-btn l-btn-small l-btn-plain">反对</a>
						 -->
						<a id="btnAbandon" class="easyui-linkbutton l-btn l-btn-small l-btn-plain">弃权</a>
						
						<c:if test="${isAllowRetoactive==true}">
							<a class="easyui-linkbutton l-btn l-btn-small l-btn-plain" onclick="showAddSignWindow()">补签</a>
							
						</c:if>
					</c:if>
					<a id="btnSave" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存表单</a>
					
					  <input name="selectedOne"  type="hidden" id="selectedOne" />
						    <t:choose hiddenName="selectedOne" hiddenid="id" chooseName = "转交待办"
						url="userController.do?userSelect" name="userList"
						icon="icon-reload" title="转交待办" textname="realName" inputTextname="realNameId"
						isInit="true" width="900" height="500"
						minFlag="false" maxFlag="false" resize="false" fun="delegate"  />
					
					
					
					
					
					<c:if test="${isCanBack}">
					<a id="btnReject" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" >驳回</a>
					
					<a id="btnRejectToStart" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" >驳回到发起人</a>
					
					</c:if>
					
					<a class="easyui-linkbutton " onclick="showTaskUserDlg()">流程执行示意图</a>
					
		
					<c:if test="${isExtForm}">
						<c:choose>
							<c:when test="${!empty detailUrl && !empty form}">
								
								<a  class="easyui-linkbutton"  onclick="openForm('${form}')" >编辑表单</a>
							</c:when>
						</c:choose>
					</c:if>
				</c:when>
				
				<c:otherwise>
				
					<c:if test="${not empty mapButton.button}">
					
						<c:if test="${isSignTask && isAllowDirectExecute}">
							<div >
								特权：<input type="checkbox" value="1" id="chkDirectComplete"><label for="chkDirectComplete">直接结束</label>
							</div>
						</c:if>
						
						<c:forEach items="${mapButton.button }" var="btn"  varStatus="status">
							<c:choose>
								<c:when test="${btn.operatortype==1 }">
									<!--  同意-->
									<a id="btnAgree"  class="easyui-linkbutton" data-options="iconCls:'icon-ok'" >${btn.btnname }</a>
									
								</c:when>
								<c:when test="${btn.operatortype==2 }">
									<!-- 反对-->
									<!--<a id="btnNotAgree" " class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">${btn.btnname }</a>
									-->
								</c:when>
								<c:when test="${btn.operatortype==3 }">
									<!--弃权-->
									<c:if test="${isSignTask==true}">
									<a id="btnAbandon" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">${btn.btnname }</a>
									
									</c:if>
								</c:when>
								
								<c:when test="${btn.operatortype==4 }">
									<!--驳回-->
									<a id="btnReject" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">${btn.btnname }</a>
									
								</c:when>
								<c:when test="${btn.operatortype==5 }">
									<!--驳回到发起人-->
										<a id="btnRejectToStart" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">${btn.btnname }</a>
										
								</c:when>
								<c:when test="${btn.operatortype==6 }">
									<!--转交代办-->
					 
					    <input name="selectedOne"  type="hidden" id="selectedOne" />
					    
					    <t:choose hiddenName="selectedOne" hiddenid="id" chooseName = "转交待办"
						url="userController.do?userSelect" name="userList"
						icon="icon-reload" title="转交待办" textname="realName" inputTextname="realNameId"
						isInit="true" width="900" height="500"
						minFlag="false" maxFlag="false" resize="false" fun="delegate"  />
						
						
								</c:when>
								<c:when test="${btn.operatortype==7 }">
									<c:if test="${isSignTask==true}">
									<!--补签-->
									<c:if test="${isAllowRetoactive==true}">
										<a class="easyui-linkbutton" onclick="showAddSignWindow()">${btn.btnname }</a>
										
									</c:if>
									</c:if>
								</c:when>
								<c:when test="${btn.operatortype==8 }">
									<!--保存表单-->
								<!--	<a id="btnSave" class="easyui-linkbutton" data-options="iconCls:'icon-save'" >${btn.btnname }</a>
									-->
								</c:when>
								<c:when test="${btn.operatortype==9 }">
									<!--流程示意图-->
									<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="showTaskUserDlg()">${btn.btnname }</a>
								</c:when>
								<c:when test="${btn.operatortype==10 }">
									<!--打印-->
									<!--<a class="easyui-linkbutton" data-options="iconCls:'icon-print'" onclick="window.print();">${btn.btnname }</a>
									-->
								</c:when>
								<c:when test="${btn.operatortype==11 }">
									<!--审批历史-->
									<!--
									<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="showTaskOpinions()">${btn.btnname }</a>
									--> 
								</c:when>
							</c:choose>
							
							
						</c:forEach>
					</c:if>
					
					
					<c:if test="${isExtForm}">
						<c:choose>
							<c:when test="${!empty detailUrl && !empty form}">
								<%-- 
								<div class="easyui-linkbutton l-btn l-btn-small l-btn-plain"><a class="link edit" onclick="openForm('${form}')" >编辑表单</a></div> --%>
							</c:when>
						</c:choose>
					</c:if>
				</c:otherwise>
				</c:choose>
				</c:otherwise>
		</c:choose>
		
		<c:if test="${fn:indexOf(bpmNodeSet.jumpType,'1')!=-1}">
			<span style="padding-top:4px"><input type="radio" checked="checked" name="jumpType" onclick="chooseJumpType(1)" value="1" />&nbsp;正常跳转</span>
		</c:if>
		<c:if test="${fn:indexOf(bpmNodeSet.jumpType,'2')!=-1}">
			<span style="padding-top:4px"><input type="radio" name="jumpType" onclick="chooseJumpType(2)" value="2" />&nbsp;选择路径跳转</span>
		</c:if>
		<c:if test="${fn:indexOf(bpmNodeSet.jumpType,'3')!=-1}">
			<span style="padding-top:4px"><input type="radio" name="jumpType" onclick="chooseJumpType(3)" value="3" />&nbsp;自由跳转</span>
		</c:if>
		<c:if test="${fn:indexOf(bpmNodeSet.jumpType,'4')!=-1}">
			<span style="padding-top:4px"><input type="radio" name="jumpType" onclick="chooseJumpType(4)" value="4" />&nbsp;动态创建任务</span>
		</c:if>
		
    </div>	
		 
		
</div>