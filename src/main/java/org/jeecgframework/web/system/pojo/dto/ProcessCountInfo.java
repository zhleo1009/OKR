package org.jeecgframework.web.system.pojo.dto;

public class ProcessCountInfo {

	private String toDoTaskCount;

	private String taskAssigneeCount;

	private String agentTaskCount;

	public ProcessCountInfo() {
		super();
	}

	public ProcessCountInfo(String toDoTaskCount, String taskAssigneeCount, String agentTaskCount) {
		super();
		this.toDoTaskCount = toDoTaskCount;
		this.taskAssigneeCount = taskAssigneeCount;
		this.agentTaskCount = agentTaskCount;
	}

	public String getToDoTaskCount() {
		return toDoTaskCount;
	}

	public void setToDoTaskCount(String toDoTaskCount) {
		this.toDoTaskCount = toDoTaskCount;
	}

	public String getTaskAssigneeCount() {
		return taskAssigneeCount;
	}

	public void setTaskAssigneeCount(String taskAssigneeCount) {
		this.taskAssigneeCount = taskAssigneeCount;
	}

	public String getAgentTaskCount() {
		return agentTaskCount;
	}

	public void setAgentTaskCount(String agentTaskCount) {
		this.agentTaskCount = agentTaskCount;
	}

}
