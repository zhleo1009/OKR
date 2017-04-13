package org.jeecgframework.core.common.entity;

import java.io.Serializable;

public class ValidFormJson implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 6018210853568145294L;

	private String info = "";
	
	//private String msg;
	
	private String status = "y";

//	public String getMsg() {
//		return msg;
//	}
//
//	public void setMsg(String msg) {
//		this.msg = msg;
//	}

	public String getInfo() {
		return info;
	}

	public void setInfo(String info) {
		this.info = info;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
			
			

}
