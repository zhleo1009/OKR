package org.jeecgframework.web.system.pojo.dto;

import java.io.Serializable;

/**
 * 通知公告dto
 * 
 * @ClassName: NoticeDto
 * @Description: TODO
 * @CreateDate 2016-6-2
 * @Author 赵宝坤
 * 
 */
public class NoticeDto implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 8993937017448687355L;

	private String id;

	private String title;

	private String createTime;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

}
