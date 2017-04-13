package org.jeecgframework.web.system.pojo.dto;

import java.io.Serializable;

/**
 * 
 * 
 * @ClassName: UnderUser
 * @Description: TODO
 * @CreateDate 2016-5-25
 * @Author 赵宝坤
 * 
 */
public class UnderUserDto implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -5716835760966848518L;
	private String userName;// 用户名
	private String realName;// 真实姓名
	private Short status;
	private Long id;// pe系统下属表id
	private String userId;// cg系统userId
	
	

	public UnderUserDto(String userName, String realName, Short status, Long id, String userId) {
		super();
		this.userName = userName;
		this.realName = realName;
		this.status = status;
		this.id = id;
		this.userId = userId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getRealName() {
		return realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
	}

	public Short getStatus() {
		return status;
	}

	public void setStatus(Short status) {
		this.status = status;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

}
