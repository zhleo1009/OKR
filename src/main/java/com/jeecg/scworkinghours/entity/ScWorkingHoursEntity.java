package com.jeecg.scworkinghours.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;
import org.jeecgframework.poi.excel.annotation.Excel;

/**   
 * @Title: Entity
 * @Description: 项目工时表
 * @author onlineGenerator
 * @date 2016-11-23 17:42:30
 * @version V1.0   
 *
 */
@Entity
@Table(name = "sc_working_hours", schema = "")
@SuppressWarnings("serial")
public class ScWorkingHoursEntity implements java.io.Serializable {
	/**主键*/
	private java.lang.String id;
	/**项目id*/
	@Excel(name="项目ID" )
	private java.lang.String projectId;
	/**项目名称*/
    @Excel(name="项目名称")
	private java.lang.String projectName;
	/**备注信息*/
	@Excel(name="任务信息")
	private java.lang.String note;
	/**工时*/
	@Excel(name="工时")
	private java.lang.String workingHours;
	
	/**员工id*/
	@Excel(name="员工名称" )
	private java.lang.String userId;
	/**日期*/
	@Excel(name="日期",format = "yyyy-MM-dd")
	private java.util.Date workingDate;
	
	/**删除状态*/
	private java.lang.Integer deleteStatus;
	

	
	
	
	
    /**员工姓名*/
    @Excel(name="员工姓名")
	private java.lang.String realName;
	
	
	
	
	
	
	
	
    @Transient	
    public java.lang.String getProjectName()
    {
        return projectName;
    }

    public void setProjectName(java.lang.String projectName)
    {
        this.projectName = projectName;
    }

    @Transient
    public java.lang.String getRealName()
    {
        return realName;
    }

    public void setRealName(java.lang.String realName)
    {
        this.realName = realName;
    }

private java.lang.String workingHours1;
    
    private java.lang.String workingHours2;
    
    private java.lang.String workingHours3;
    
    private java.lang.String workingHours4;
    
    private java.lang.String workingHours5;
    
    private java.lang.String workingHours6;
    
    private java.lang.String workingHours7;
    
    
    
    
    
    @Column(name ="DELETE_STATUS",nullable=true,length=2)
    public java.lang.Integer getDeleteStatus()
    {
        return deleteStatus;
    }

    public void setDeleteStatus(java.lang.Integer deleteStatus)
    {
        this.deleteStatus = deleteStatus;
    }

    @Transient
    public java.lang.String getWorkingHours1() {
        return workingHours1;
    }

    public void setWorkingHours1(java.lang.String workingHours1) {
        this.workingHours1 = workingHours1;
    }
    @Transient
    public java.lang.String getWorkingHours2() {
        return workingHours2;
    }

    public void setWorkingHours2(java.lang.String workingHours2) {
        this.workingHours2 = workingHours2;
    }
    @Transient
    public java.lang.String getWorkingHours3() {
        return workingHours3;
    }

    public void setWorkingHours3(java.lang.String workingHours3) {
        this.workingHours3 = workingHours3;
    }
    @Transient
    public java.lang.String getWorkingHours4() {
        return workingHours4;
    }

    public void setWorkingHours4(java.lang.String workingHours4) {
        this.workingHours4 = workingHours4;
    }
    @Transient
    public java.lang.String getWorkingHours5() {
        return workingHours5;
    }

    public void setWorkingHours5(java.lang.String workingHours5) {
        this.workingHours5 = workingHours5;
    }
    @Transient
    public java.lang.String getWorkingHours6() {
        return workingHours6;
    }

    public void setWorkingHours6(java.lang.String workingHours6) {
        this.workingHours6 = workingHours6;
    }
    @Transient
    public java.lang.String getWorkingHours7() {
        return workingHours7;
    }

    public void setWorkingHours7(java.lang.String workingHours7) {
        this.workingHours7 = workingHours7;
    }

    /**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  主键
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
	 *@param: java.lang.String  主键
	 */
	public void setId(java.lang.String id){
		this.id = id;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  项目id
	 */
	@Column(name ="PROJECT_ID",nullable=true,length=32)
	public java.lang.String getProjectId(){
		return this.projectId;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  项目id
	 */
	public void setProjectId(java.lang.String projectId){
		this.projectId = projectId;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  员工id
	 */
	@Column(name ="USER_ID",nullable=true,length=32)
	public java.lang.String getUserId(){
		return this.userId;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  员工id
	 */
	public void setUserId(java.lang.String userId){
		this.userId = userId;
	}
	/**
	 *方法: 取得java.util.Date
	 *@return: java.util.Date  日期
	 */
	@Column(name ="WORKING_DATE",nullable=true,length=32)
	public java.util.Date getWorkingDate(){
		return this.workingDate;
	}

	/**
	 *方法: 设置java.util.Date
	 *@param: java.util.Date  日期
	 */
	public void setWorkingDate(java.util.Date workingDate){
		this.workingDate = workingDate;
	}
	/**
	 *方法: 取得java.lang.Integer
	 *@return: java.lang.Integer  工时
	 */
	@Column(name ="WORKING_HOURS",nullable=true,length=32)
	public java.lang.String getWorkingHours(){
		return this.workingHours;
	}

	/**
	 *方法: 设置java.lang.Integer
	 *@param: java.lang.Integer  工时
	 */
	public void setWorkingHours(java.lang.String workingHours){
		this.workingHours = workingHours;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  备注信息
	 */
	@Column(name ="NOTE",nullable=true,length=300)
	public java.lang.String getNote(){
		return this.note;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  备注信息
	 */
	public void setNote(java.lang.String note){
		this.note = note;
	}
}
