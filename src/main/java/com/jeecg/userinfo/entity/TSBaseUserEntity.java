package com.jeecg.userinfo.entity;

import java.math.BigDecimal;
import java.util.Date;
import java.lang.String;
import java.lang.Double;
import java.lang.Integer;
import java.math.BigDecimal;
import javax.xml.soap.Text;
import java.sql.Blob;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import org.hibernate.annotations.GenericGenerator;
import javax.persistence.SequenceGenerator;
import org.jeecgframework.poi.excel.annotation.Excel;

/**   
 * @Title: Entity
 * @Description: 员工基本信息
 * @author onlineGenerator
 * @date 2016-10-25 16:13:00
 * @version V1.0   
 *
 */
@Entity
@Table(name = "t_s_base_user", schema = "")
@SuppressWarnings("serial")
public class TSBaseUserEntity implements java.io.Serializable {
	/**id*/
	private java.lang.String id;
	/**activitisync*/
	@Excel(name="activitisync")
	private java.lang.Integer activitisync;
	/**browser*/
	@Excel(name="browser")
	private java.lang.String browser;
	/**password*/
	@Excel(name="password")
	private java.lang.String password;
	/**realname*/
	@Excel(name="realname")
	private java.lang.String realname;
	/**signature*/
	@Excel(name="signature")
	private java.lang.String signature;
	/**status*/
	@Excel(name="status")
	private java.lang.Integer status;
	/**userkey*/
	@Excel(name="userkey")
	private java.lang.String userkey;
	/**username*/
	@Excel(name="username")
	private java.lang.String username;
	/**departid*/
	@Excel(name="departid")
	private java.lang.String departid;
	
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  id
	 */
	@Id
	@GeneratedValue(generator = "paymentableGenerator")
	@GenericGenerator(name = "paymentableGenerator", strategy = "uuid")
	@Column(name ="ID",nullable=false,length=32)
	public java.lang.String getId(){
		return this.id;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  id
	 */
	public void setId(java.lang.String id){
		this.id = id;
	}
	/**
	 *方法: 取得java.lang.Integer
	 *@return: java.lang.Integer  activitisync
	 */
	@Column(name ="ACTIVITISYNC",nullable=true,length=5)
	public java.lang.Integer getActivitisync(){
		return this.activitisync;
	}

	/**
	 *方法: 设置java.lang.Integer
	 *@param: java.lang.Integer  activitisync
	 */
	public void setActivitisync(java.lang.Integer activitisync){
		this.activitisync = activitisync;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  browser
	 */
	@Column(name ="BROWSER",nullable=true,length=20)
	public java.lang.String getBrowser(){
		return this.browser;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  browser
	 */
	public void setBrowser(java.lang.String browser){
		this.browser = browser;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  password
	 */
	@Column(name ="PASSWORD",nullable=true,length=100)
	public java.lang.String getPassword(){
		return this.password;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  password
	 */
	public void setPassword(java.lang.String password){
		this.password = password;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  realname
	 */
	@Column(name ="REALNAME",nullable=true,length=50)
	public java.lang.String getRealname(){
		return this.realname;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  realname
	 */
	public void setRealname(java.lang.String realname){
		this.realname = realname;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  signature
	 */
	@Column(name ="SIGNATURE",nullable=true,length=65535)
	public java.lang.String getSignature(){
		return this.signature;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  signature
	 */
	public void setSignature(java.lang.String signature){
		this.signature = signature;
	}
	/**
	 *方法: 取得java.lang.Integer
	 *@return: java.lang.Integer  status
	 */
	@Column(name ="STATUS",nullable=true,length=5)
	public java.lang.Integer getStatus(){
		return this.status;
	}

	/**
	 *方法: 设置java.lang.Integer
	 *@param: java.lang.Integer  status
	 */
	public void setStatus(java.lang.Integer status){
		this.status = status;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  userkey
	 */
	@Column(name ="USERKEY",nullable=true,length=200)
	public java.lang.String getUserkey(){
		return this.userkey;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  userkey
	 */
	public void setUserkey(java.lang.String userkey){
		this.userkey = userkey;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  username
	 */
	@Column(name ="USERNAME",nullable=false,length=32)
	public java.lang.String getUsername(){
		return this.username;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  username
	 */
	public void setUsername(java.lang.String username){
		this.username = username;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  departid
	 */
	@Column(name ="DEPARTID",nullable=true,length=32)
	public java.lang.String getDepartid(){
		return this.departid;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  departid
	 */
	public void setDepartid(java.lang.String departid){
		this.departid = departid;
	}
}
