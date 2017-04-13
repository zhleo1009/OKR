package com.jeecg.scworkinghours.entity;

import java.io.Serializable;

/**
 * 
 * 
 * @ClassName: FullCalendarDto
 * @Description: TODO
 * @CreateDate 2016-8-20
 * @Author 赵宝坤
 * 
 */
public class FullCalendarEventDto implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -8569215286832072985L;
	private String id = "";// id
	private String title = "";
	private String start = "";
	private String end = "";// 不包含
	private String color = "";// 事件颜色

	private String content = "";// 封装信息

	public FullCalendarEventDto() {
		super();
	}

	public FullCalendarEventDto(String id, String title, String start, String color) {
		super();
		this.id = id;
		this.title = title;
		this.start = start;
		this.color = color;
	}

	public FullCalendarEventDto(String id, String title, String start, String end, String color) {
		super();
		this.id = id;
		this.title = title;
		this.start = start;
		this.end = end;
		this.color = color;
	}

	public FullCalendarEventDto(String id, String title, String start, String end, String color, String content) {
		super();
		this.id = id;
		this.title = title;
		this.start = start;
		this.end = end;
		this.color = color;
		this.content = content;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getStart() {
		return start;
	}

	public void setStart(String start) {
		this.start = start;
	}

	public String getEnd() {
		return end;
	}

	public void setEnd(String end) {
		this.end = end;
	}

	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	
}
