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
 * @Description: 员工信息
 * @author onlineGenerator
 * @date 2016-10-25 16:13:22
 * @version V1.0   
 *
 */
@Entity
@Table(name = "t_s_user", schema = "")
@SuppressWarnings("serial")
public class TSUserEntity implements java.io.Serializable {
	/**email*/
	@Excel(name="email")
	private java.lang.String email;
	@Excel(name="qq")
	private java.lang.String qq;
	/**mobilephone*/
	@Excel(name="mobilephone")
	private java.lang.String mobilephone;
	/**officephone*/
	@Excel(name="officephone")
	private java.lang.String officephone;
	/**signaturefile*/
	@Excel(name="signaturefile")
	private java.lang.String signaturefile;
	/**id*/
	private java.lang.String id;
	/**修改人*/
	@Excel(name="修改人")
	private java.lang.String updateName;
	/**修改时间*/
	@Excel(name="修改时间",format = "yyyy-MM-dd")
	private java.util.Date updateDate;
	/**修改人id*/
	@Excel(name="修改人id")
	private java.lang.String updateBy;
	/**创建人*/
	@Excel(name="创建人")
	private java.lang.String createName;
	/**创建时间*/
	@Excel(name="创建时间",format = "yyyy-MM-dd")
	private java.util.Date createDate;
	/**创建人id*/
	@Excel(name="创建人id")
	private java.lang.String createBy;
	/**peUserid*/
	@Excel(name="peUserid")
	private java.lang.String peUserid;
	/**在岗；离职*/
	@Excel(name="在岗；离职")
	private java.lang.String onDuty;
	/**人员编号*/
	@Excel(name="人员编号")
	private java.lang.String userNo;
	/**token*/
	@Excel(name="token")
	private java.lang.String appToken;
	
	@Column(name ="QQ",nullable=true,length=20)
	public java.lang.String getQq() {
		return qq;
	}

	public void setQq(java.lang.String qq) {
		this.qq = qq;
	}

	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  email
	 */
	@Column(name ="EMAIL",nullable=true,length=50)
	public java.lang.String getEmail(){
		return this.email;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  email
	 */
	public void setEmail(java.lang.String email){
		this.email = email;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  mobilephone
	 */
	@Column(name ="MOBILEPHONE",nullable=true,length=30)
	public java.lang.String getMobilephone(){
		return this.mobilephone;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  mobilephone
	 */
	public void setMobilephone(java.lang.String mobilephone){
		this.mobilephone = mobilephone;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  officephone
	 */
	@Column(name ="OFFICEPHONE",nullable=true,length=20)
	public java.lang.String getOfficephone(){
		return this.officephone;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  officephone
	 */
	public void setOfficephone(java.lang.String officephone){
		this.officephone = officephone;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  signaturefile
	 */
	@Column(name ="SIGNATUREFILE",nullable=true,length=100)
	public java.lang.String getSignaturefile(){
		return this.signaturefile;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  signaturefile
	 */
	public void setSignaturefile(java.lang.String signaturefile){
		this.signaturefile = signaturefile;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  id
	 */
	@Id
	@GeneratedValue(generator = "paymentableGenerator")
	@GenericGenerator(name = "paymentableGenerator", strategy = "uuid")
	@Column(name ="ID",nullable=false,length=50)
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
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  修改人
	 */
	@Column(name ="UPDATE_NAME",nullable=true,length=32)
	public java.lang.String getUpdateName(){
		return this.updateName;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  修改人
	 */
	public void setUpdateName(java.lang.String updateName){
		this.updateName = updateName;
	}
	/**
	 *方法: 取得java.util.Date
	 *@return: java.util.Date  修改时间
	 */
	@Column(name ="UPDATE_DATE",nullable=true)
	public java.util.Date getUpdateDate(){
		return this.updateDate;
	}

	/**
	 *方法: 设置java.util.Date
	 *@param: java.util.Date  修改时间
	 */
	public void setUpdateDate(java.util.Date updateDate){
		this.updateDate = updateDate;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  修改人id
	 */
	@Column(name ="UPDATE_BY",nullable=true,length=32)
	public java.lang.String getUpdateBy(){
		return this.updateBy;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  修改人id
	 */
	public void setUpdateBy(java.lang.String updateBy){
		this.updateBy = updateBy;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  创建人
	 */
	@Column(name ="CREATE_NAME",nullable=true,length=32)
	public java.lang.String getCreateName(){
		return this.createName;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  创建人
	 */
	public void setCreateName(java.lang.String createName){
		this.createName = createName;
	}
	/**
	 *方法: 取得java.util.Date
	 *@return: java.util.Date  创建时间
	 */
	@Column(name ="CREATE_DATE",nullable=true)
	public java.util.Date getCreateDate(){
		return this.createDate;
	}

	/**
	 *方法: 设置java.util.Date
	 *@param: java.util.Date  创建时间
	 */
	public void setCreateDate(java.util.Date createDate){
		this.createDate = createDate;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  创建人id
	 */
	@Column(name ="CREATE_BY",nullable=true,length=32)
	public java.lang.String getCreateBy(){
		return this.createBy;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  创建人id
	 */
	public void setCreateBy(java.lang.String createBy){
		this.createBy = createBy;
	}
	/**
	 *方法: 取得java.lang.Integer
	 *@return: java.lang.Integer  peUserid
	 */
	@Column(name ="PE_USERID",nullable=true,length=19)
	public java.lang.String getPeUserid(){
		return this.peUserid;
	}

	/**
	 *方法: 设置java.lang.Integer
	 *@param: java.lang.Integer  peUserid
	 */
	public void setPeUserid(java.lang.String peUserid){
		this.peUserid = peUserid;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  在岗；离职
	 */
	@Column(name ="ON_DUTY",nullable=true,length=8)
	public java.lang.String getOnDuty(){
		return this.onDuty;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  在岗；离职
	 */
	public void setOnDuty(java.lang.String onDuty){
		this.onDuty = onDuty;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  人员编号
	 */
	@Column(name ="USER_NO",nullable=true,length=32)
	public java.lang.String getUserNo(){
		return this.userNo;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  人员编号
	 */
	public void setUserNo(java.lang.String userNo){
		this.userNo = userNo;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  token
	 */
	@Column(name ="APP_TOKEN",nullable=true,length=32)
	public java.lang.String getAppToken(){
		return this.appToken;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  token
	 */
	public void setAppToken(java.lang.String appToken){
		this.appToken = appToken;
	}
}
