package com.jeecg.project.entity;

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
 * @Description: 项目管理
 * @author onlineGenerator
 * @date 2016-11-23 17:42:02
 * @version V1.0   
 *
 */
@Entity
@Table(name = "project", schema = "")
@SuppressWarnings("serial")
public class ProjectEntity implements java.io.Serializable {
	/**主键*/
	private java.lang.String id;
	/**项目名称*/
	@Excel(name="项目名称")
	private java.lang.String projectName;
	/**开始时间*/
	@Excel(name="开始时间",format = "yyyy-MM-dd")
	private java.util.Date startDate;
	/**结束时间*/
	@Excel(name="结束时间",format = "yyyy-MM-dd")
	private java.util.Date endDate;
	/**所属部门*/
	@Excel(name="所属部门")
	private java.lang.String org;
	/**备注信息*/
	@Excel(name="备注信息")
	private java.lang.String remark;
	/**创建时间*/
	@Excel(name="创建时间",format = "yyyy-MM-dd")
	private java.util.Date createTime;

	
	
	
	/**删除状态*/
    private java.lang.Integer deleteStatus;
	
	
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  主键
	 */
	@Id
	@GeneratedValue(generator = "paymentableGenerator")
	@GenericGenerator(name = "paymentableGenerator", strategy = "uuid")
	@Column(name ="ID",nullable=false,length=36)
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
	 *@return: java.lang.String  项目名称
	 */
	@Column(name ="PROJECT_NAME",nullable=true,length=50)
	public java.lang.String getProjectName(){
		return this.projectName;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  项目名称
	 */
	public void setProjectName(java.lang.String projectName){
		this.projectName = projectName;
	}
	/**
	 *方法: 取得java.util.Date
	 *@return: java.util.Date  开始时间
	 */
	@Column(name ="START_DATE",nullable=true,length=32)
	public java.util.Date getStartDate(){
		return this.startDate;
	}

	/**
	 *方法: 设置java.util.Date
	 *@param: java.util.Date  开始时间
	 */
	public void setStartDate(java.util.Date startDate){
		this.startDate = startDate;
	}
	/**
	 *方法: 取得java.util.Date
	 *@return: java.util.Date  结束时间
	 */
	@Column(name ="END_DATE",nullable=true,length=32)
	public java.util.Date getEndDate(){
		return this.endDate;
	}

	/**
	 *方法: 设置java.util.Date
	 *@param: java.util.Date  结束时间
	 */
	public void setEndDate(java.util.Date endDate){
		this.endDate = endDate;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  所属部门
	 */
	@Column(name ="ORG",nullable=true,length=32)
	public java.lang.String getOrg(){
		return this.org;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  所属部门
	 */
	public void setOrg(java.lang.String org){
		this.org = org;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  备注信息
	 */
	@Column(name ="REMARK",nullable=true,length=200)
	public java.lang.String getRemark(){
		return this.remark;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  备注信息
	 */
	public void setRemark(java.lang.String remark){
		this.remark = remark;
	}

	/**
     *方法: 取得java.lang.String
     *@return: java.lang.String  创建时间
     */
    @Column(name ="CREATE_TIME",nullable=true,length=200)
    public java.util.Date getCreateTime()
    {
        return createTime;
    }

    /**
     *方法: 设置java.lang.String
     *@param: java.lang.String  创建时间
     */
    public void setCreateTime(java.util.Date createTime)
    {
        this.createTime = createTime;
    }

    
    @Column(name ="DELETE_STATUS",nullable=true,length=2)
    public java.lang.Integer getDeleteStatus()
    {
        return deleteStatus;
    }

    public void setDeleteStatus(java.lang.Integer deleteStatus)
    {
        this.deleteStatus = deleteStatus;
    }
	
	
	
}
