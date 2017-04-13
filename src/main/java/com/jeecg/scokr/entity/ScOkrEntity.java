package com.jeecg.scokr.entity;

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
 * @Description: 员工日程计划
 * @author onlineGenerator
 * @date 2017-01-14 12:46:18
 * @version V1.0   
 *
 */
@Entity
@Table(name = "sc_okr", schema = "")
@SuppressWarnings("serial")
public class ScOkrEntity implements java.io.Serializable {
	/**主键*/
	private java.lang.Integer id;
	/**创建人名称*/
	private java.lang.String createName;
	/**创建人登录名称*/
	private java.lang.String createBy;
	/**创建日期*/
	private java.lang.String createDate;
	/**更新人名称*/
	private java.lang.String updateName;
	/**更新人登录名称*/
	private java.lang.String updateBy;
	/**更新日期*/
	private java.util.Date updateDate;
	/**所属部门*/
	@Excel(name="所属部门")
	private java.lang.String sysOrgCode;
	/**所属公司*/
	@Excel(name="管理中心")
	private java.lang.String sysCompanyCode;
	/**流程状态*/
	private java.lang.String bpmStatus;
	/**关键目标*/
	@Excel(name="关键目标")
	private java.lang.String objective;
	/**关键结果*/
	@Excel(name="关键结果")
	private java.lang.String keyResult;
	/**任务*/
	@Excel(name="任务")
	private java.lang.String mission;
	/**人员*/
	@Excel(name="人员")
	private java.lang.String userId;
	/**计划完成时间*/
	@Excel(name="计划完成时间",format = "yyyy-MM-dd")
	private String planTime;
	/**执行难点*/
	@Excel(name="执行难点")
	private java.lang.String difficulties;
	/**OKR完成程度*/
	@Excel(name="OKR完成程度")
	private java.lang.String percent;
	/**未完成原因*/
	@Excel(name="未完成原因")
	private java.lang.String unfinishedReason;
	/**需协助部门*/
	@Excel(name="需协助部门")
	private java.lang.String needOrgCode;
	/**实际完成时间*/
	@Excel(name="实际完成时间",format = "yyyy-MM-dd")
	private java.lang.String finishTime;
	
	/**
	 *方法: 取得java.lang.Integer
	 *@return: java.lang.Integer  主键
	 */
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name ="ID",nullable=false,length=20)
	public java.lang.Integer getId(){
		return this.id;
	}

	/**
	 *方法: 设置java.lang.Integer
	 *@param: java.lang.Integer  主键
	 */
	public void setId(java.lang.Integer id){
		this.id = id;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  创建人名称
	 */
	@Column(name ="CREATE_NAME",nullable=true,length=50)
	public java.lang.String getCreateName(){
		return this.createName;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  创建人名称
	 */
	public void setCreateName(java.lang.String createName){
		this.createName = createName;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  创建人登录名称
	 */
	@Column(name ="CREATE_BY",nullable=true,length=50)
	public java.lang.String getCreateBy(){
		return this.createBy;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  创建人登录名称
	 */
	public void setCreateBy(java.lang.String createBy){
		this.createBy = createBy;
	}
	/**
	 *方法: 取得java.util.Date
	 *@return: java.util.Date  创建日期
	 */
	@Column(name ="CREATE_DATE",nullable=true,length=20)
	public java.lang.String getCreateDate(){
		return this.createDate;
	}

	/**
	 *方法: 设置java.util.Date
	 *@param: java.util.Date  创建日期
	 */
	public void setCreateDate(java.lang.String createDate){
		this.createDate = createDate;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  更新人名称
	 */
	@Column(name ="UPDATE_NAME",nullable=true,length=50)
	public java.lang.String getUpdateName(){
		return this.updateName;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  更新人名称
	 */
	public void setUpdateName(java.lang.String updateName){
		this.updateName = updateName;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  更新人登录名称
	 */
	@Column(name ="UPDATE_BY",nullable=true,length=50)
	public java.lang.String getUpdateBy(){
		return this.updateBy;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  更新人登录名称
	 */
	public void setUpdateBy(java.lang.String updateBy){
		this.updateBy = updateBy;
	}
	/**
	 *方法: 取得java.util.Date
	 *@return: java.util.Date  更新日期
	 */
	@Column(name ="UPDATE_DATE",nullable=true,length=20)
	public java.util.Date getUpdateDate(){
		return this.updateDate;
	}

	/**
	 *方法: 设置java.util.Date
	 *@param: java.util.Date  更新日期
	 */
	public void setUpdateDate(java.util.Date updateDate){
		this.updateDate = updateDate;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  所属部门
	 */
	@Column(name ="SYS_ORG_CODE",nullable=true,length=50)
	public java.lang.String getSysOrgCode(){
		return this.sysOrgCode;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  所属部门
	 */
	public void setSysOrgCode(java.lang.String sysOrgCode){
		this.sysOrgCode = sysOrgCode;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  所属公司
	 */
	@Column(name ="SYS_COMPANY_CODE",nullable=true,length=50)
	public java.lang.String getSysCompanyCode(){
		return this.sysCompanyCode;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  所属公司
	 */
	public void setSysCompanyCode(java.lang.String sysCompanyCode){
		this.sysCompanyCode = sysCompanyCode;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  流程状态
	 */
	@Column(name ="BPM_STATUS",nullable=true,length=32)
	public java.lang.String getBpmStatus(){
		return this.bpmStatus;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  流程状态
	 */
	public void setBpmStatus(java.lang.String bpmStatus){
		this.bpmStatus = bpmStatus;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  关键目标
	 */
	@Column(name ="OBJECTIVE",nullable=true,length=200)
	public java.lang.String getObjective(){
		return this.objective;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  关键目标
	 */
	public void setObjective(java.lang.String objective){
		this.objective = objective;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  关键结果
	 */
	@Column(name ="KEY_RESULT",nullable=true,length=200)
	public java.lang.String getKeyResult(){
		return this.keyResult;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  关键结果
	 */
	public void setKeyResult(java.lang.String keyResult){
		this.keyResult = keyResult;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  任务
	 */
	@Column(name ="MISSION",nullable=true,length=200)
	public java.lang.String getMission(){
		return this.mission;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  任务
	 */
	public void setMission(java.lang.String mission){
		this.mission = mission;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  人员
	 */
	@Column(name ="USER_ID",nullable=true,length=32)
	public java.lang.String getUserId(){
		return this.userId;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  人员
	 */
	public void setUserId(java.lang.String userId){
		this.userId = userId;
	}
	/**
	 *方法: 取得java.util.Date
	 *@return: java.util.Date  计划完成时间
	 */
	@Column(name ="PLAN_TIME",nullable=true,length=32)
	public String getPlanTime(){
		return this.planTime;
	}

	/**
	 *方法: 设置java.util.Date
	 *@param: java.util.Date  计划完成时间
	 */
	public void setPlanTime(String planTime){
		this.planTime = planTime;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  执行难点
	 */
	@Column(name ="DIFFICULTIES",nullable=true,length=200)
	public java.lang.String getDifficulties(){
		return this.difficulties;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  执行难点
	 */
	public void setDifficulties(java.lang.String difficulties){
		this.difficulties = difficulties;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  OKR完成程度
	 */
	@Column(name ="PERCENT",nullable=true,length=32)
	public java.lang.String getPercent(){
		return this.percent;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  OKR完成程度
	 */
	public void setPercent(java.lang.String percent){
		this.percent = percent;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  未完成原因
	 */
	@Column(name ="UNFINISHED_REASON",nullable=true,length=100)
	public java.lang.String getUnfinishedReason(){
		return this.unfinishedReason;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  未完成原因
	 */
	public void setUnfinishedReason(java.lang.String unfinishedReason){
		this.unfinishedReason = unfinishedReason;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  需协助部门
	 */
	@Column(name ="NEED_ORG_CODE",nullable=true,length=32)
	public java.lang.String getNeedOrgCode(){
		return this.needOrgCode;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  需协助部门
	 */
	public void setNeedOrgCode(java.lang.String needOrgCode){
		this.needOrgCode = needOrgCode;
	}
	/**
	 *方法: 取得java.util.Date
	 *@return: java.util.Date  实际完成时间
	 */
	@Column(name ="FINISH_TIME",nullable=true,length=32)
	public java.lang.String getFinishTime(){
		return this.finishTime;
	}

	/**
	 *方法: 设置java.util.Date
	 *@param: java.util.Date  实际完成时间
	 */
	public void setFinishTime(java.lang.String finishTime){
		this.finishTime = finishTime;
	}
}
