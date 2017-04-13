package com.jeecg.bbspost.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.jeecgframework.poi.excel.annotation.Excel;

/**
 * @Title: Entity
 * @Description: 帖子
 * @author onlineGenerator
 * @date 2016-08-31 11:19:32
 * @version V1.0
 * 
 */
@Entity
@Table(name = "bbs_post",
    schema = "")
@SuppressWarnings("serial")
public class BbsPostEntity implements java.io.Serializable {
    /** 主键 */
    private java.lang.Long id;
    /** 创建人名称 */
    private java.lang.String createName;
    /** 创建人登录名称 */
    private java.lang.String createBy;
    /** 创建日期 */
    private java.util.Date createDate;
    /** 更新人名称 */
    private java.lang.String updateName;
    /** 更新人登录名称 */
    private java.lang.String updateBy;
    /** 更新日期 */
    private java.util.Date updateDate;
    /** 所属部门 */
    private java.lang.String sysOrgCode;
    /** 所属公司 */
    private java.lang.String sysCompanyCode;
    /** 标题 */
    @Excel(name = "标题")
    private java.lang.String title;
    /** 内容 */
    @Excel(name = "内容")
    private java.lang.String content;
    /** 发帖人ID */
    @Excel(name = "发帖人ID")
    private java.lang.String postUserid;

    @Excel(name = "发帖人ID")
    private java.lang.String postUserName;
    /** 版块ID */
    @Excel(name = "版块ID")
    private java.lang.Long editionId;

    /**
     * 方法: 取得java.lang.Integer
     * 
     * @return: java.lang.Integer 主键
     */
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "ID",
        nullable = false,
        length = 20)
    public java.lang.Long getId() {
        return this.id;
    }

    /**
     * 方法: 设置java.lang.Integer
     * 
     * @param: java.lang.Integer 主键
     */
    public void setId(java.lang.Long id) {
        this.id = id;
    }

    /**
     * 方法: 取得java.lang.String
     * 
     * @return: java.lang.String 创建人名称
     */
    @Column(name = "CREATE_NAME",
        nullable = true,
        length = 50)
    public java.lang.String getCreateName() {
        return this.createName;
    }

    /**
     * 方法: 设置java.lang.String
     * 
     * @param: java.lang.String 创建人名称
     */
    public void setCreateName(java.lang.String createName) {
        this.createName = createName;
    }

    /**
     * 方法: 取得java.lang.String
     * 
     * @return: java.lang.String 创建人登录名称
     */
    @Column(name = "CREATE_BY",
        nullable = true,
        length = 50)
    public java.lang.String getCreateBy() {
        return this.createBy;
    }

    /**
     * 方法: 设置java.lang.String
     * 
     * @param: java.lang.String 创建人登录名称
     */
    public void setCreateBy(java.lang.String createBy) {
        this.createBy = createBy;
    }

    /**
     * 方法: 取得java.util.Date
     * 
     * @return: java.util.Date 创建日期
     */
    @Column(name = "CREATE_DATE",
        nullable = true,
        length = 20)
    public java.util.Date getCreateDate() {
        return this.createDate;
    }

    /**
     * 方法: 设置java.util.Date
     * 
     * @param: java.util.Date 创建日期
     */
    public void setCreateDate(java.util.Date createDate) {
        this.createDate = createDate;
    }

    /**
     * 方法: 取得java.lang.String
     * 
     * @return: java.lang.String 更新人名称
     */
    @Column(name = "UPDATE_NAME",
        nullable = true,
        length = 50)
    public java.lang.String getUpdateName() {
        return this.updateName;
    }

    /**
     * 方法: 设置java.lang.String
     * 
     * @param: java.lang.String 更新人名称
     */
    public void setUpdateName(java.lang.String updateName) {
        this.updateName = updateName;
    }

    /**
     * 方法: 取得java.lang.String
     * 
     * @return: java.lang.String 更新人登录名称
     */
    @Column(name = "UPDATE_BY",
        nullable = true,
        length = 50)
    public java.lang.String getUpdateBy() {
        return this.updateBy;
    }

    /**
     * 方法: 设置java.lang.String
     * 
     * @param: java.lang.String 更新人登录名称
     */
    public void setUpdateBy(java.lang.String updateBy) {
        this.updateBy = updateBy;
    }

    /**
     * 方法: 取得java.util.Date
     * 
     * @return: java.util.Date 更新日期
     */
    @Column(name = "UPDATE_DATE",
        nullable = true,
        length = 20)
    public java.util.Date getUpdateDate() {
        return this.updateDate;
    }

    /**
     * 方法: 设置java.util.Date
     * 
     * @param: java.util.Date 更新日期
     */
    public void setUpdateDate(java.util.Date updateDate) {
        this.updateDate = updateDate;
    }

    /**
     * 方法: 取得java.lang.String
     * 
     * @return: java.lang.String 所属部门
     */
    @Column(name = "SYS_ORG_CODE",
        nullable = true,
        length = 50)
    public java.lang.String getSysOrgCode() {
        return this.sysOrgCode;
    }

    /**
     * 方法: 设置java.lang.String
     * 
     * @param: java.lang.String 所属部门
     */
    public void setSysOrgCode(java.lang.String sysOrgCode) {
        this.sysOrgCode = sysOrgCode;
    }

    /**
     * 方法: 取得java.lang.String
     * 
     * @return: java.lang.String 所属公司
     */
    @Column(name = "SYS_COMPANY_CODE",
        nullable = true,
        length = 50)
    public java.lang.String getSysCompanyCode() {
        return this.sysCompanyCode;
    }

    /**
     * 方法: 设置java.lang.String
     * 
     * @param: java.lang.String 所属公司
     */
    public void setSysCompanyCode(java.lang.String sysCompanyCode) {
        this.sysCompanyCode = sysCompanyCode;
    }

    /**
     * 方法: 取得java.lang.String
     * 
     * @return: java.lang.String 标题
     */
    @Column(name = "TITLE",
        nullable = true,
        length = 100)
    public java.lang.String getTitle() {
        return this.title;
    }

    /**
     * 方法: 设置java.lang.String
     * 
     * @param: java.lang.String 标题
     */
    public void setTitle(java.lang.String title) {
        this.title = title;
    }

    /**
     * 方法: 取得java.lang.String
     * 
     * @return: java.lang.String 内容
     */
    @Column(name = "CONTENT",
        nullable = true,
        length = 5000)
    public java.lang.String getContent() {
        return this.content;
    }

    /**
     * 方法: 设置java.lang.String
     * 
     * @param: java.lang.String 内容
     */
    public void setContent(java.lang.String content) {
        this.content = content;
    }

    /**
     * 方法: 取得java.lang.String
     * 
     * @return: java.lang.String 发帖人ID
     */
    @Column(name = "POST_USERID",
        nullable = true,
        length = 32)
    public java.lang.String getPostUserid() {
        return this.postUserid;
    }

    /**
     * 方法: 设置java.lang.String
     * 
     * @param: java.lang.String 发帖人ID
     */
    public void setPostUserid(java.lang.String postUserid) {
        this.postUserid = postUserid;
    }
    
    
    
    @Column(name = "POST_USERNAME",
            nullable = true,
            length = 32)
    public java.lang.String getPostUserName() {
        return postUserName;
    }

    public void setPostUserName(java.lang.String postUserName) {
        this.postUserName = postUserName;
    }

    /**
     * 方法: 取得java.lang.Integer
     * 
     * @return: java.lang.Integer 版块ID
     */
    @Column(name = "EDITION_ID",
        nullable = true,
        length = 32)
    public java.lang.Long getEditionId() {
        return this.editionId;
    }

    /**
     * 方法: 设置java.lang.Integer
     * 
     * @param: java.lang.Integer 版块ID
     */
    public void setEditionId(java.lang.Long editionId) {
        this.editionId = editionId;
    }
}
