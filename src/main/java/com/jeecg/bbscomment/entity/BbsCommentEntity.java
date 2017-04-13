package com.jeecg.bbscomment.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.jeecgframework.poi.excel.annotation.Excel;

/**
 * @Title: Entity
 * @Description: 论坛评论
 * @author onlineGenerator
 * @date 2016-08-31 11:26:21
 * @version V1.0
 * 
 */
@Entity
@Table(name = "bbs_comment",
    schema = "")
@SuppressWarnings("serial")
public class BbsCommentEntity implements java.io.Serializable {
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
    /** 评论内容 */
    @Excel(name = "评论内容")
    private java.lang.String comment;
    /** 评论人ID */
    @Excel(name = "评论人ID")
    private java.lang.String commentUserid;

    @Excel(name = "评论人ID")
    private java.lang.String commentUserName;
    /** 帖子ID */
    @Excel(name = "帖子ID")
    private java.lang.Long postId;
    /** 引用评论ID */
    @Excel(name = "引用评论ID")
    private java.lang.Long quotesId;

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
     * @return: java.lang.String 评论内容
     */
    @Column(name = "COMMENT",
        nullable = true,
        length = 5000)
    public java.lang.String getComment() {
        return this.comment;
    }

    /**
     * 方法: 设置java.lang.String
     * 
     * @param: java.lang.String 评论内容
     */
    public void setComment(java.lang.String comment) {
        this.comment = comment;
    }

    /**
     * 方法: 取得java.lang.String
     * 
     * @return: java.lang.String 评论人ID
     */
    @Column(name = "COMMENT_USERID",
        nullable = true,
        length = 32)
    public java.lang.String getCommentUserid() {
        return this.commentUserid;
    }

    /**
     * 方法: 设置java.lang.String
     * 
     * @param: java.lang.String 评论人ID
     */
    public void setCommentUserid(java.lang.String commentUserid) {
        this.commentUserid = commentUserid;
    }
    
    
    
    
    @Column(name = "COMMENT_USERNAME",
            nullable = true,
            length = 32)
    public java.lang.String getCommentUserName() {
        return commentUserName;
    }

    public void setCommentUserName(java.lang.String commentUserName) {
        this.commentUserName = commentUserName;
    }

    /**
     * 方法: 取得java.lang.Integer
     * 
     * @return: java.lang.Integer 帖子ID
     */
    @Column(name = "POST_ID",
        nullable = true,
        length = 32)
    public java.lang.Long getPostId() {
        return this.postId;
    }

    /**
     * 方法: 设置java.lang.Integer
     * 
     * @param: java.lang.Integer 帖子ID
     */
    public void setPostId(java.lang.Long postId) {
        this.postId = postId;
    }

    /**
     * 方法: 取得java.lang.Integer
     * 
     * @return: java.lang.Integer 引用评论ID
     */
    @Column(name = "QUOTES_ID",
        nullable = true,
        length = 32)
    public java.lang.Long getQuotesId() {
        return this.quotesId;
    }

    /**
     * 方法: 设置java.lang.Integer
     * 
     * @param: java.lang.Integer 引用评论ID
     */
    public void setQuotesId(java.lang.Long quotesId) {
        this.quotesId = quotesId;
    }
}
