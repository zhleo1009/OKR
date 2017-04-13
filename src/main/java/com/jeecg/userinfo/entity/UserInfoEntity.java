package com.jeecg.userinfo.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.jeecgframework.poi.excel.annotation.Excel;

/**   
 * @Title: Entity
 * @Description: 用户信息
 * @author onlineGenerator
 * @date 2016-10-25 15:49:19
 * @version V1.0   
 *
 */
@Entity
@Table(name = "user_info", schema = "")
@SuppressWarnings("serial")
public class UserInfoEntity implements java.io.Serializable {
	/**主键*/
	private java.lang.Integer id;
	/**创建人名称*/
	@Excel(name="创建人名称")
	private java.lang.String createName;
	/**创建人登录名称*/
	@Excel(name="创建人登录名称")
	private java.lang.String createBy;
	/**创建日期*/
	@Excel(name="创建日期",format = "yyyy-MM-dd")
	private java.util.Date createDate;
	/**更新人名称*/
	@Excel(name="更新人名称")
	private java.lang.String updateName;
	/**更新人登录名称*/
	@Excel(name="更新人登录名称")
	private java.lang.String updateBy;
	/**更新日期*/
	@Excel(name="更新日期",format = "yyyy-MM-dd")
	private java.util.Date updateDate;
	/**用户ID*/
	@Excel(name="用户ID")
	private java.lang.String userId;
	/**学历*/
	@Excel(name="学历")
	private java.lang.Integer education;
	/**毕业院校*/
	@Excel(name="毕业院校")
	private java.lang.String university;
	/**住址*/
	@Excel(name="住址")
	private java.lang.String address;
	/**籍贯*/
	@Excel(name="籍贯")
	private java.lang.String origin;
	/**婚姻状态*/
	@Excel(name="婚姻状态")
	private java.lang.Integer maritalStatus;
	/**性别*/
	@Excel(name="性别")
	private java.lang.Integer sex;
	/**身高*/
	@Excel(name="身高")
	private java.lang.Double height;
	/**体重*/
	@Excel(name="体重")
	private java.lang.Double weight;
	/**自我介绍*/
	@Excel(name="自我介绍")
	private java.lang.String introduction;
	/**头像地址*/
	@Excel(name="头像地址")
	private java.lang.String headPicPath;
	/**zhiwei*/
	@Excel(name="zhiwei")
	private java.lang.String zhiwei;
	/**1在岗*/
	@Excel(name="1在岗")
	private java.lang.Double zaigang;
	/**birthday*/
	@Excel(name="birthday")
	private java.lang.String birthday;
	/**mingzu*/
	@Excel(name="mingzu")
	private java.lang.String mingzu;
	/**身份证*/
	@Excel(name="身份证")
	private java.lang.String sfz;
	/**政治面貌*/
	@Excel(name="政治面貌")
	private java.lang.String zzmm;
	/**户口:0城镇1农村*/
	@Excel(name="户口:0城镇1农村")
	private java.lang.String hukou;
	/**职称*/
	@Excel(name="职称")
	private java.lang.String zhicheng;
	/**专业*/
	@Excel(name="专业")
	private java.lang.String zhuanye;
	/**参加工作时间*/
	@Excel(name="参加工作时间")
	private java.lang.String worktime;
	/**家庭电话*/
	@Excel(name="家庭电话")
	private java.lang.String homephone;
	/**家庭住址*/
	@Excel(name="家庭住址")
	private java.lang.String homeaddress;
	/**奖惩记录*/
	@Excel(name="奖惩记录")
	private java.lang.String jiangchengorder;
	/**培训记录*/
	@Excel(name="培训记录")
	private java.lang.String peixunjilu;
	/**担保记录*/
	@Excel(name="担保记录")
	private java.lang.String danbaojilu;
	/**劳动合同*/
	@Excel(name="劳动合同")
	private java.lang.String laodonghetong;
	/**社保缴纳*/
	@Excel(name="社保缴纳")
	private java.lang.String shebaojiaona;
	/**体检记录*/
	@Excel(name="体检记录")
	private java.lang.String tijianjilu;
	/**附件*/
	@Excel(name="附件")
	private java.lang.String fujian;
	/**入党时间*/
	@Excel(name="入党时间")
	private java.lang.String rudangshijian;
	/**户籍所在地*/
	@Excel(name="户籍所在地")
	private java.lang.String hujisuozaidi;
	/**workyear*/
	@Excel(name="workyear")
	private java.lang.String workyear;
	/**原工作单位*/
	@Excel(name="原工作单位")
	private java.lang.String oldcompany;
	/**oldcompanyphone*/
	@Excel(name="oldcompanyphone")
	private java.lang.String oldcompanyphone;
	/**原工作单位岗位*/
	@Excel(name="原工作单位岗位")
	private java.lang.String oldcompanyjob;
	/**原工作单位证明人*/
	@Excel(name="原工作单位证明人")
	private java.lang.String oldcompanyperson;
	/**基本信息备注*/
	@Excel(name="基本信息备注")
	private java.lang.String baseinforemark;
	/**lovename*/
	@Excel(name="lovename")
	private java.lang.String lovename;
	/**lovebirthday*/
	@Excel(name="lovebirthday")
	private java.lang.String lovebirthday;
	/**lovemingzu*/
	@Excel(name="lovemingzu")
	private java.lang.String lovemingzu;
	/**lovexueli*/
	@Excel(name="lovexueli")
	private java.lang.String lovexueli;
	/**lovezzmm*/
	@Excel(name="lovezzmm")
	private java.lang.String lovezzmm;
	/**lovezhuanye*/
	@Excel(name="lovezhuanye")
	private java.lang.String lovezhuanye;
	/**lovephone*/
	@Excel(name="lovephone")
	private java.lang.String lovephone;
	/**lovecompany*/
	@Excel(name="lovecompany")
	private java.lang.String lovecompany;
	/**familyrelation1*/
	@Excel(name="familyrelation1")
	private java.lang.String familyrelation1;
	/**familyname1*/
	@Excel(name="familyname1")
	private java.lang.String familyname1;
	/**familybirth1*/
	@Excel(name="familybirth1")
	private java.lang.String familybirth1;
	/**familyzzmm1*/
	@Excel(name="familyzzmm1")
	private java.lang.String familyzzmm1;
	/**familycompany1*/
	@Excel(name="familycompany1")
	private java.lang.String familycompany1;
	/**familyrelation2*/
	@Excel(name="familyrelation2")
	private java.lang.String familyrelation2;
	/**familyname2*/
	@Excel(name="familyname2")
	private java.lang.String familyname2;
	/**familybirth2*/
	@Excel(name="familybirth2")
	private java.lang.String familybirth2;
	/**familyzzmm2*/
	@Excel(name="familyzzmm2")
	private java.lang.String familyzzmm2;
	/**familycompany2*/
	@Excel(name="familycompany2")
	private java.lang.String familycompany2;
	/**familyrelation3*/
	@Excel(name="familyrelation3")
	private java.lang.String familyrelation3;
	/**familyname3*/
	@Excel(name="familyname3")
	private java.lang.String familyname3;
	/**familybirth3*/
	@Excel(name="familybirth3")
	private java.lang.String familybirth3;
	/**familyzzmm3*/
	@Excel(name="familyzzmm3")
	private java.lang.String familyzzmm3;
	/**familycompany3*/
	@Excel(name="familycompany3")
	private java.lang.String familycompany3;
	/**xueli1*/
	@Excel(name="xueli1")
	private java.lang.String xueli1;
	/**biyetime1*/
	@Excel(name="biyetime1")
	private java.lang.String biyetime1;
	/**biyeschool1*/
	@Excel(name="biyeschool1")
	private java.lang.String biyeschool1;
	/**zhuanye1*/
	@Excel(name="zhuanye1")
	private java.lang.String zhuanye1;
	/**xueli2*/
	@Excel(name="xueli2")
	private java.lang.String xueli2;
	/**biyetime2*/
	@Excel(name="biyetime2")
	private java.lang.String biyetime2;
	/**biyeschool2*/
	@Excel(name="biyeschool2")
	private java.lang.String biyeschool2;
	/**zhuanye2*/
	@Excel(name="zhuanye2")
	private java.lang.String zhuanye2;
	/**xueli3*/
	@Excel(name="xueli3")
	private java.lang.String xueli3;
	/**biyetime3*/
	@Excel(name="biyetime3")
	private java.lang.String biyetime3;
	/**biyeschool3*/
	@Excel(name="biyeschool3")
	private java.lang.String biyeschool3;
	/**zhuanye3*/
	@Excel(name="zhuanye3")
	private java.lang.String zhuanye3;
	/**xueli4*/
	@Excel(name="xueli4")
	private java.lang.String xueli4;
	/**biyetime4*/
	@Excel(name="biyetime4")
	private java.lang.String biyetime4;
	/**biyeschool4*/
	@Excel(name="biyeschool4")
	private java.lang.String biyeschool4;
	/**zhuanye4*/
	@Excel(name="zhuanye4")
	private java.lang.String zhuanye4;
	/**zyjszctype*/
	@Excel(name="zyjszctype")
	private java.lang.String zyjszctype;
	/**zggettime*/
	@Excel(name="zggettime")
	private java.lang.String zggettime;
	/**劳动合同性质*/
	@Excel(name="劳动合同性质")
	private java.lang.String laodonghetongtype;
	/**劳务公司*/
	@Excel(name="劳务公司")
	private java.lang.String laowugongsi;
	/**劳务公司联系人*/
	@Excel(name="劳务公司联系人")
	private java.lang.String laowugongsiperson;
	/**用工性质*/
	@Excel(name="用工性质")
	private java.lang.String yonggongtype;
	/**合同到期时间*/
	@Excel(name="合同到期时间",format = "yyyy-MM-dd")
	private java.util.Date hetongendtime;
	/**技术职称*/
	@Excel(name="技术职称")
	private java.lang.String jishuzhicheng;
	/**hxl1Xl*/
	@Excel(name="hxl1Xl")
	private java.lang.String hxl1Xl;
	/**hxl1Sj*/
	@Excel(name="hxl1Sj")
	private java.lang.String hxl1Sj;
	/**hxl1Xx*/
	@Excel(name="hxl1Xx")
	private java.lang.String hxl1Xx;
	/**hxl1Zy*/
	@Excel(name="hxl1Zy")
	private java.lang.String hxl1Zy;
	/**hxl2Xl*/
	@Excel(name="hxl2Xl")
	private java.lang.String hxl2Xl;
	/**hxl2Sj*/
	@Excel(name="hxl2Sj")
	private java.lang.String hxl2Sj;
	/**hxl2Xx*/
	@Excel(name="hxl2Xx")
	private java.lang.String hxl2Xx;
	/**hxl2Zy*/
	@Excel(name="hxl2Zy")
	private java.lang.String hxl2Zy;
	/**hxl3Xl*/
	@Excel(name="hxl3Xl")
	private java.lang.String hxl3Xl;
	/**hxl3Sj*/
	@Excel(name="hxl3Sj")
	private java.lang.String hxl3Sj;
	/**hxl3Xx*/
	@Excel(name="hxl3Xx")
	private java.lang.String hxl3Xx;
	/**hxl3Zy*/
	@Excel(name="hxl3Zy")
	private java.lang.String hxl3Zy;
	@Excel(name="入职时间")
	private java.lang.String rzsj;
	
	private java.lang.String basefilename;
	private java.lang.String basefilepath;
	private java.lang.String picpath;
	
	private java.lang.String sfzfilename;
	private java.lang.String sfzfilepath;
	
	private java.lang.String zcfilename;
	private java.lang.String zcfilepath;
	
	private java.lang.String xlfilename;
	private java.lang.String xlfilepath;
	
	/**
	 *方法: 取得java.lang.Integer
	 *@return: java.lang.Integer  主键
	 */
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name ="ID",nullable=false,length=10)
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
	@Column(name ="CREATE_DATE",nullable=true)
	public java.util.Date getCreateDate(){
		return this.createDate;
	}

	/**
	 *方法: 设置java.util.Date
	 *@param: java.util.Date  创建日期
	 */
	public void setCreateDate(java.util.Date createDate){
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
	@Column(name ="UPDATE_DATE",nullable=true)
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
	 *@return: java.lang.String  用户ID
	 */
	@Column(name ="USER_ID",nullable=false,length=32)
	public java.lang.String getUserId(){
		return this.userId;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  用户ID
	 */
	public void setUserId(java.lang.String userId){
		this.userId = userId;
	}
	/**
	 *方法: 取得java.lang.Integer
	 *@return: java.lang.Integer  学历
	 */
	@Column(name ="EDUCATION",nullable=true,length=10)
	public java.lang.Integer getEducation(){
		return this.education;
	}

	/**
	 *方法: 设置java.lang.Integer
	 *@param: java.lang.Integer  学历
	 */
	public void setEducation(java.lang.Integer education){
		this.education = education;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  毕业院校
	 */
	@Column(name ="UNIVERSITY",nullable=true,length=32)
	public java.lang.String getUniversity(){
		return this.university;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  毕业院校
	 */
	public void setUniversity(java.lang.String university){
		this.university = university;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  住址
	 */
	@Column(name ="ADDRESS",nullable=true,length=100)
	public java.lang.String getAddress(){
		return this.address;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  住址
	 */
	public void setAddress(java.lang.String address){
		this.address = address;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  籍贯
	 */
	@Column(name ="ORIGIN",nullable=true,length=32)
	public java.lang.String getOrigin(){
		return this.origin;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  籍贯
	 */
	public void setOrigin(java.lang.String origin){
		this.origin = origin;
	}
	/**
	 *方法: 取得java.lang.Integer
	 *@return: java.lang.Integer  婚姻状态
	 */
	@Column(name ="MARITAL_STATUS",nullable=true,length=10)
	public java.lang.Integer getMaritalStatus(){
		return this.maritalStatus;
	}

	/**
	 *方法: 设置java.lang.Integer
	 *@param: java.lang.Integer  婚姻状态
	 */
	public void setMaritalStatus(java.lang.Integer maritalStatus){
		this.maritalStatus = maritalStatus;
	}
	/**
	 *方法: 取得java.lang.Integer
	 *@return: java.lang.Integer  性别
	 */
	@Column(name ="SEX",nullable=true,length=10)
	public java.lang.Integer getSex(){
		return this.sex;
	}

	/**
	 *方法: 设置java.lang.Integer
	 *@param: java.lang.Integer  性别
	 */
	public void setSex(java.lang.Integer sex){
		this.sex = sex;
	}
	/**
	 *方法: 取得java.lang.Double
	 *@return: java.lang.Double  身高
	 */
	@Column(name ="HEIGHT",nullable=true,length=3)
	public java.lang.Double getHeight(){
		return this.height;
	}

	/**
	 *方法: 设置java.lang.Double
	 *@param: java.lang.Double  身高
	 */
	public void setHeight(java.lang.Double height){
		this.height = height;
	}
	/**
	 *方法: 取得java.lang.Double
	 *@return: java.lang.Double  体重
	 */
	@Column(name ="WEIGHT",nullable=true,length=5)
	public java.lang.Double getWeight(){
		return this.weight;
	}

	/**
	 *方法: 设置java.lang.Double
	 *@param: java.lang.Double  体重
	 */
	public void setWeight(java.lang.Double weight){
		this.weight = weight;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  自我介绍
	 */
	@Column(name ="INTRODUCTION",nullable=true,length=200)
	public java.lang.String getIntroduction(){
		return this.introduction;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  自我介绍
	 */
	public void setIntroduction(java.lang.String introduction){
		this.introduction = introduction;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  头像地址
	 */
	@Column(name ="HEAD_PIC_PATH",nullable=true,length=100)
	public java.lang.String getHeadPicPath(){
		return this.headPicPath;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  头像地址
	 */
	public void setHeadPicPath(java.lang.String headPicPath){
		this.headPicPath = headPicPath;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  zhiwei
	 */
	@Column(name ="ZHIWEI",nullable=true,length=50)
	public java.lang.String getZhiwei(){
		return this.zhiwei;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  zhiwei
	 */
	public void setZhiwei(java.lang.String zhiwei){
		this.zhiwei = zhiwei;
	}
	/**
	 *方法: 取得java.lang.Double
	 *@return: java.lang.Double  1在岗
	 */
	@Column(name ="ZAIGANG",nullable=true,length=10)
	public java.lang.Double getZaigang(){
		return this.zaigang;
	}

	/**
	 *方法: 设置java.lang.Double
	 *@param: java.lang.Double  1在岗
	 */
	public void setZaigang(java.lang.Double zaigang){
		this.zaigang = zaigang;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  birthday
	 */
	@Column(name ="BIRTHDAY",nullable=true,length=50)
	public java.lang.String getBirthday(){
		return this.birthday;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  birthday
	 */
	public void setBirthday(java.lang.String birthday){
		this.birthday = birthday;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  mingzu
	 */
	@Column(name ="MINGZU",nullable=true,length=50)
	public java.lang.String getMingzu(){
		return this.mingzu;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  mingzu
	 */
	public void setMingzu(java.lang.String mingzu){
		this.mingzu = mingzu;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  身份证
	 */
	@Column(name ="SFZ",nullable=true,length=50)
	public java.lang.String getSfz(){
		return this.sfz;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  身份证
	 */
	public void setSfz(java.lang.String sfz){
		this.sfz = sfz;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  政治面貌
	 */
	@Column(name ="ZZMM",nullable=true,length=50)
	public java.lang.String getZzmm(){
		return this.zzmm;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  政治面貌
	 */
	public void setZzmm(java.lang.String zzmm){
		this.zzmm = zzmm;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  户口:0城镇1农村
	 */
	@Column(name ="HUKOU",nullable=true,length=50)
	public java.lang.String getHukou(){
		return this.hukou;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  户口:0城镇1农村
	 */
	public void setHukou(java.lang.String hukou){
		this.hukou = hukou;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  职称
	 */
	@Column(name ="ZHICHENG",nullable=true,length=50)
	public java.lang.String getZhicheng(){
		return this.zhicheng;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  职称
	 */
	public void setZhicheng(java.lang.String zhicheng){
		this.zhicheng = zhicheng;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  专业
	 */
	@Column(name ="ZHUANYE",nullable=true,length=50)
	public java.lang.String getZhuanye(){
		return this.zhuanye;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  专业
	 */
	public void setZhuanye(java.lang.String zhuanye){
		this.zhuanye = zhuanye;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  参加工作时间
	 */
	@Column(name ="WORKTIME",nullable=true)
	public java.lang.String getWorktime(){
		return this.worktime;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  参加工作时间
	 */
	public void setWorktime(java.lang.String worktime){
		this.worktime = worktime;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  家庭电话
	 */
	@Column(name ="HOMEPHONE",nullable=true,length=50)
	public java.lang.String getHomephone(){
		return this.homephone;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  家庭电话
	 */
	public void setHomephone(java.lang.String homephone){
		this.homephone = homephone;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  家庭住址
	 */
	@Column(name ="HOMEADDRESS",nullable=true,length=100)
	public java.lang.String getHomeaddress(){
		return this.homeaddress;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  家庭住址
	 */
	public void setHomeaddress(java.lang.String homeaddress){
		this.homeaddress = homeaddress;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  奖惩记录
	 */
	@Column(name ="JIANGCHENGORDER",nullable=true,length=200)
	public java.lang.String getJiangchengorder(){
		return this.jiangchengorder;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  奖惩记录
	 */
	public void setJiangchengorder(java.lang.String jiangchengorder){
		this.jiangchengorder = jiangchengorder;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  培训记录
	 */
	@Column(name ="PEIXUNJILU",nullable=true,length=255)
	public java.lang.String getPeixunjilu(){
		return this.peixunjilu;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  培训记录
	 */
	public void setPeixunjilu(java.lang.String peixunjilu){
		this.peixunjilu = peixunjilu;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  担保记录
	 */
	@Column(name ="DANBAOJILU",nullable=true,length=255)
	public java.lang.String getDanbaojilu(){
		return this.danbaojilu;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  担保记录
	 */
	public void setDanbaojilu(java.lang.String danbaojilu){
		this.danbaojilu = danbaojilu;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  劳动合同
	 */
	@Column(name ="LAODONGHETONG",nullable=true,length=255)
	public java.lang.String getLaodonghetong(){
		return this.laodonghetong;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  劳动合同
	 */
	public void setLaodonghetong(java.lang.String laodonghetong){
		this.laodonghetong = laodonghetong;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  社保缴纳
	 */
	@Column(name ="SHEBAOJIAONA",nullable=true,length=255)
	public java.lang.String getShebaojiaona(){
		return this.shebaojiaona;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  社保缴纳
	 */
	public void setShebaojiaona(java.lang.String shebaojiaona){
		this.shebaojiaona = shebaojiaona;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  体检记录
	 */
	@Column(name ="TIJIANJILU",nullable=true,length=255)
	public java.lang.String getTijianjilu(){
		return this.tijianjilu;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  体检记录
	 */
	public void setTijianjilu(java.lang.String tijianjilu){
		this.tijianjilu = tijianjilu;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  附件
	 */
	@Column(name ="FUJIAN",nullable=true,length=255)
	public java.lang.String getFujian(){
		return this.fujian;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  附件
	 */
	public void setFujian(java.lang.String fujian){
		this.fujian = fujian;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  入党时间
	 */
	@Column(name ="RUDANGSHIJIAN",nullable=true,length=100)
	public java.lang.String getRudangshijian(){
		return this.rudangshijian;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  入党时间
	 */
	public void setRudangshijian(java.lang.String rudangshijian){
		this.rudangshijian = rudangshijian;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  户籍所在地
	 */
	@Column(name ="HUJISUOZAIDI",nullable=true,length=100)
	public java.lang.String getHujisuozaidi(){
		return this.hujisuozaidi;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  户籍所在地
	 */
	public void setHujisuozaidi(java.lang.String hujisuozaidi){
		this.hujisuozaidi = hujisuozaidi;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  workyear
	 */
	@Column(name ="WORKYEAR",nullable=true,length=20)
	public java.lang.String getWorkyear(){
		return this.workyear;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  workyear
	 */
	public void setWorkyear(java.lang.String workyear){
		this.workyear = workyear;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  原工作单位
	 */
	@Column(name ="OLDCOMPANY",nullable=true,length=255)
	public java.lang.String getOldcompany(){
		return this.oldcompany;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  原工作单位
	 */
	public void setOldcompany(java.lang.String oldcompany){
		this.oldcompany = oldcompany;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  oldcompanyphone
	 */
	@Column(name ="OLDCOMPANYPHONE",nullable=true,length=255)
	public java.lang.String getOldcompanyphone(){
		return this.oldcompanyphone;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  oldcompanyphone
	 */
	public void setOldcompanyphone(java.lang.String oldcompanyphone){
		this.oldcompanyphone = oldcompanyphone;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  原工作单位岗位
	 */
	@Column(name ="OLDCOMPANYJOB",nullable=true,length=255)
	public java.lang.String getOldcompanyjob(){
		return this.oldcompanyjob;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  原工作单位岗位
	 */
	public void setOldcompanyjob(java.lang.String oldcompanyjob){
		this.oldcompanyjob = oldcompanyjob;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  原工作单位证明人
	 */
	@Column(name ="OLDCOMPANYPERSON",nullable=true,length=255)
	public java.lang.String getOldcompanyperson(){
		return this.oldcompanyperson;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  原工作单位证明人
	 */
	public void setOldcompanyperson(java.lang.String oldcompanyperson){
		this.oldcompanyperson = oldcompanyperson;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  基本信息备注
	 */
	@Column(name ="BASEINFOREMARK",nullable=true,length=255)
	public java.lang.String getBaseinforemark(){
		return this.baseinforemark;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  基本信息备注
	 */
	public void setBaseinforemark(java.lang.String baseinforemark){
		this.baseinforemark = baseinforemark;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  lovename
	 */
	@Column(name ="LOVENAME",nullable=true,length=100)
	public java.lang.String getLovename(){
		return this.lovename;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  lovename
	 */
	public void setLovename(java.lang.String lovename){
		this.lovename = lovename;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  lovebirthday
	 */
	@Column(name ="LOVEBIRTHDAY",nullable=true,length=100)
	public java.lang.String getLovebirthday(){
		return this.lovebirthday;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  lovebirthday
	 */
	public void setLovebirthday(java.lang.String lovebirthday){
		this.lovebirthday = lovebirthday;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  lovemingzu
	 */
	@Column(name ="LOVEMINGZU",nullable=true,length=100)
	public java.lang.String getLovemingzu(){
		return this.lovemingzu;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  lovemingzu
	 */
	public void setLovemingzu(java.lang.String lovemingzu){
		this.lovemingzu = lovemingzu;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  lovexueli
	 */
	@Column(name ="LOVEXUELI",nullable=true,length=100)
	public java.lang.String getLovexueli(){
		return this.lovexueli;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  lovexueli
	 */
	public void setLovexueli(java.lang.String lovexueli){
		this.lovexueli = lovexueli;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  lovezzmm
	 */
	@Column(name ="LOVEZZMM",nullable=true,length=100)
	public java.lang.String getLovezzmm(){
		return this.lovezzmm;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  lovezzmm
	 */
	public void setLovezzmm(java.lang.String lovezzmm){
		this.lovezzmm = lovezzmm;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  lovezhuanye
	 */
	@Column(name ="LOVEZHUANYE",nullable=true,length=100)
	public java.lang.String getLovezhuanye(){
		return this.lovezhuanye;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  lovezhuanye
	 */
	public void setLovezhuanye(java.lang.String lovezhuanye){
		this.lovezhuanye = lovezhuanye;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  lovephone
	 */
	@Column(name ="LOVEPHONE",nullable=true,length=100)
	public java.lang.String getLovephone(){
		return this.lovephone;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  lovephone
	 */
	public void setLovephone(java.lang.String lovephone){
		this.lovephone = lovephone;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  lovecompany
	 */
	@Column(name ="LOVECOMPANY",nullable=true,length=100)
	public java.lang.String getLovecompany(){
		return this.lovecompany;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  lovecompany
	 */
	public void setLovecompany(java.lang.String lovecompany){
		this.lovecompany = lovecompany;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  familyrelation1
	 */
	@Column(name ="FAMILYRELATION1",nullable=true,length=100)
	public java.lang.String getFamilyrelation1(){
		return this.familyrelation1;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  familyrelation1
	 */
	public void setFamilyrelation1(java.lang.String familyrelation1){
		this.familyrelation1 = familyrelation1;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  familyname1
	 */
	@Column(name ="FAMILYNAME1",nullable=true,length=100)
	public java.lang.String getFamilyname1(){
		return this.familyname1;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  familyname1
	 */
	public void setFamilyname1(java.lang.String familyname1){
		this.familyname1 = familyname1;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  familybirth1
	 */
	@Column(name ="FAMILYBIRTH1",nullable=true,length=100)
	public java.lang.String getFamilybirth1(){
		return this.familybirth1;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  familybirth1
	 */
	public void setFamilybirth1(java.lang.String familybirth1){
		this.familybirth1 = familybirth1;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  familyzzmm1
	 */
	@Column(name ="FAMILYZZMM1",nullable=true,length=100)
	public java.lang.String getFamilyzzmm1(){
		return this.familyzzmm1;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  familyzzmm1
	 */
	public void setFamilyzzmm1(java.lang.String familyzzmm1){
		this.familyzzmm1 = familyzzmm1;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  familycompany1
	 */
	@Column(name ="FAMILYCOMPANY1",nullable=true,length=100)
	public java.lang.String getFamilycompany1(){
		return this.familycompany1;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  familycompany1
	 */
	public void setFamilycompany1(java.lang.String familycompany1){
		this.familycompany1 = familycompany1;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  familyrelation2
	 */
	@Column(name ="FAMILYRELATION2",nullable=true,length=100)
	public java.lang.String getFamilyrelation2(){
		return this.familyrelation2;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  familyrelation2
	 */
	public void setFamilyrelation2(java.lang.String familyrelation2){
		this.familyrelation2 = familyrelation2;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  familyname2
	 */
	@Column(name ="FAMILYNAME2",nullable=true,length=100)
	public java.lang.String getFamilyname2(){
		return this.familyname2;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  familyname2
	 */
	public void setFamilyname2(java.lang.String familyname2){
		this.familyname2 = familyname2;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  familybirth2
	 */
	@Column(name ="FAMILYBIRTH2",nullable=true,length=100)
	public java.lang.String getFamilybirth2(){
		return this.familybirth2;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  familybirth2
	 */
	public void setFamilybirth2(java.lang.String familybirth2){
		this.familybirth2 = familybirth2;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  familyzzmm2
	 */
	@Column(name ="FAMILYZZMM2",nullable=true,length=100)
	public java.lang.String getFamilyzzmm2(){
		return this.familyzzmm2;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  familyzzmm2
	 */
	public void setFamilyzzmm2(java.lang.String familyzzmm2){
		this.familyzzmm2 = familyzzmm2;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  familycompany2
	 */
	@Column(name ="FAMILYCOMPANY2",nullable=true,length=100)
	public java.lang.String getFamilycompany2(){
		return this.familycompany2;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  familycompany2
	 */
	public void setFamilycompany2(java.lang.String familycompany2){
		this.familycompany2 = familycompany2;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  familyrelation3
	 */
	@Column(name ="FAMILYRELATION3",nullable=true,length=100)
	public java.lang.String getFamilyrelation3(){
		return this.familyrelation3;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  familyrelation3
	 */
	public void setFamilyrelation3(java.lang.String familyrelation3){
		this.familyrelation3 = familyrelation3;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  familyname3
	 */
	@Column(name ="FAMILYNAME3",nullable=true,length=100)
	public java.lang.String getFamilyname3(){
		return this.familyname3;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  familyname3
	 */
	public void setFamilyname3(java.lang.String familyname3){
		this.familyname3 = familyname3;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  familybirth3
	 */
	@Column(name ="FAMILYBIRTH3",nullable=true,length=100)
	public java.lang.String getFamilybirth3(){
		return this.familybirth3;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  familybirth3
	 */
	public void setFamilybirth3(java.lang.String familybirth3){
		this.familybirth3 = familybirth3;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  familyzzmm3
	 */
	@Column(name ="FAMILYZZMM3",nullable=true,length=100)
	public java.lang.String getFamilyzzmm3(){
		return this.familyzzmm3;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  familyzzmm3
	 */
	public void setFamilyzzmm3(java.lang.String familyzzmm3){
		this.familyzzmm3 = familyzzmm3;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  familycompany3
	 */
	@Column(name ="FAMILYCOMPANY3",nullable=true,length=100)
	public java.lang.String getFamilycompany3(){
		return this.familycompany3;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  familycompany3
	 */
	public void setFamilycompany3(java.lang.String familycompany3){
		this.familycompany3 = familycompany3;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  xueli1
	 */
	@Column(name ="XUELI1",nullable=true,length=10)
	public java.lang.String getXueli1(){
		return this.xueli1;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  xueli1
	 */
	public void setXueli1(java.lang.String xueli1){
		this.xueli1 = xueli1;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  biyetime1
	 */
	@Column(name ="BIYETIME1",nullable=true,length=50)
	public java.lang.String getBiyetime1(){
		return this.biyetime1;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  biyetime1
	 */
	public void setBiyetime1(java.lang.String biyetime1){
		this.biyetime1 = biyetime1;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  biyeschool1
	 */
	@Column(name ="BIYESCHOOL1",nullable=true,length=50)
	public java.lang.String getBiyeschool1(){
		return this.biyeschool1;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  biyeschool1
	 */
	public void setBiyeschool1(java.lang.String biyeschool1){
		this.biyeschool1 = biyeschool1;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  zhuanye1
	 */
	@Column(name ="ZHUANYE1",nullable=true,length=50)
	public java.lang.String getZhuanye1(){
		return this.zhuanye1;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  zhuanye1
	 */
	public void setZhuanye1(java.lang.String zhuanye1){
		this.zhuanye1 = zhuanye1;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  xueli2
	 */
	@Column(name ="XUELI2",nullable=true,length=10)
	public java.lang.String getXueli2(){
		return this.xueli2;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  xueli2
	 */
	public void setXueli2(java.lang.String xueli2){
		this.xueli2 = xueli2;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  biyetime2
	 */
	@Column(name ="BIYETIME2",nullable=true,length=50)
	public java.lang.String getBiyetime2(){
		return this.biyetime2;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  biyetime2
	 */
	public void setBiyetime2(java.lang.String biyetime2){
		this.biyetime2 = biyetime2;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  biyeschool2
	 */
	@Column(name ="BIYESCHOOL2",nullable=true,length=50)
	public java.lang.String getBiyeschool2(){
		return this.biyeschool2;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  biyeschool2
	 */
	public void setBiyeschool2(java.lang.String biyeschool2){
		this.biyeschool2 = biyeschool2;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  zhuanye2
	 */
	@Column(name ="ZHUANYE2",nullable=true,length=50)
	public java.lang.String getZhuanye2(){
		return this.zhuanye2;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  zhuanye2
	 */
	public void setZhuanye2(java.lang.String zhuanye2){
		this.zhuanye2 = zhuanye2;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  xueli3
	 */
	@Column(name ="XUELI3",nullable=true,length=10)
	public java.lang.String getXueli3(){
		return this.xueli3;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  xueli3
	 */
	public void setXueli3(java.lang.String xueli3){
		this.xueli3 = xueli3;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  biyetime3
	 */
	@Column(name ="BIYETIME3",nullable=true,length=50)
	public java.lang.String getBiyetime3(){
		return this.biyetime3;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  biyetime3
	 */
	public void setBiyetime3(java.lang.String biyetime3){
		this.biyetime3 = biyetime3;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  biyeschool3
	 */
	@Column(name ="BIYESCHOOL3",nullable=true,length=50)
	public java.lang.String getBiyeschool3(){
		return this.biyeschool3;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  biyeschool3
	 */
	public void setBiyeschool3(java.lang.String biyeschool3){
		this.biyeschool3 = biyeschool3;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  zhuanye3
	 */
	@Column(name ="ZHUANYE3",nullable=true,length=50)
	public java.lang.String getZhuanye3(){
		return this.zhuanye3;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  zhuanye3
	 */
	public void setZhuanye3(java.lang.String zhuanye3){
		this.zhuanye3 = zhuanye3;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  xueli4
	 */
	@Column(name ="XUELI4",nullable=true,length=10)
	public java.lang.String getXueli4(){
		return this.xueli4;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  xueli4
	 */
	public void setXueli4(java.lang.String xueli4){
		this.xueli4 = xueli4;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  biyetime4
	 */
	@Column(name ="BIYETIME4",nullable=true,length=50)
	public java.lang.String getBiyetime4(){
		return this.biyetime4;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  biyetime4
	 */
	public void setBiyetime4(java.lang.String biyetime4){
		this.biyetime4 = biyetime4;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  biyeschool4
	 */
	@Column(name ="BIYESCHOOL4",nullable=true,length=50)
	public java.lang.String getBiyeschool4(){
		return this.biyeschool4;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  biyeschool4
	 */
	public void setBiyeschool4(java.lang.String biyeschool4){
		this.biyeschool4 = biyeschool4;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  zhuanye4
	 */
	@Column(name ="ZHUANYE4",nullable=true,length=50)
	public java.lang.String getZhuanye4(){
		return this.zhuanye4;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  zhuanye4
	 */
	public void setZhuanye4(java.lang.String zhuanye4){
		this.zhuanye4 = zhuanye4;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  zyjszctype
	 */
	@Column(name ="ZYJSZCTYPE",nullable=true,length=50)
	public java.lang.String getZyjszctype(){
		return this.zyjszctype;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  zyjszctype
	 */
	public void setZyjszctype(java.lang.String zyjszctype){
		this.zyjszctype = zyjszctype;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  zggettime
	 */
	@Column(name ="ZGGETTIME",nullable=true,length=50)
	public java.lang.String getZggettime(){
		return this.zggettime;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  zggettime
	 */
	public void setZggettime(java.lang.String zggettime){
		this.zggettime = zggettime;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  劳动合同性质
	 */
	@Column(name ="LAODONGHETONGTYPE",nullable=true,length=100)
	public java.lang.String getLaodonghetongtype(){
		return this.laodonghetongtype;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  劳动合同性质
	 */
	public void setLaodonghetongtype(java.lang.String laodonghetongtype){
		this.laodonghetongtype = laodonghetongtype;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  劳务公司
	 */
	@Column(name ="LAOWUGONGSI",nullable=true,length=100)
	public java.lang.String getLaowugongsi(){
		return this.laowugongsi;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  劳务公司
	 */
	public void setLaowugongsi(java.lang.String laowugongsi){
		this.laowugongsi = laowugongsi;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  劳务公司联系人
	 */
	@Column(name ="LAOWUGONGSIPERSON",nullable=true,length=100)
	public java.lang.String getLaowugongsiperson(){
		return this.laowugongsiperson;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  劳务公司联系人
	 */
	public void setLaowugongsiperson(java.lang.String laowugongsiperson){
		this.laowugongsiperson = laowugongsiperson;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  用工性质
	 */
	@Column(name ="YONGGONGTYPE",nullable=true,length=100)
	public java.lang.String getYonggongtype(){
		return this.yonggongtype;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  用工性质
	 */
	public void setYonggongtype(java.lang.String yonggongtype){
		this.yonggongtype = yonggongtype;
	}
	/**
	 *方法: 取得java.util.Date
	 *@return: java.util.Date  合同到期时间
	 */
	@Column(name ="HETONGENDTIME",nullable=true)
	public java.util.Date getHetongendtime(){
		return this.hetongendtime;
	}

	/**
	 *方法: 设置java.util.Date
	 *@param: java.util.Date  合同到期时间
	 */
	public void setHetongendtime(java.util.Date hetongendtime){
		this.hetongendtime = hetongendtime;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  技术职称
	 */
	@Column(name ="JISHUZHICHENG",nullable=true,length=100)
	public java.lang.String getJishuzhicheng(){
		return this.jishuzhicheng;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  技术职称
	 */
	public void setJishuzhicheng(java.lang.String jishuzhicheng){
		this.jishuzhicheng = jishuzhicheng;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  hxl1Xl
	 */
	@Column(name ="HXL1_XL",nullable=true,length=100)
	public java.lang.String getHxl1Xl(){
		return this.hxl1Xl;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  hxl1Xl
	 */
	public void setHxl1Xl(java.lang.String hxl1Xl){
		this.hxl1Xl = hxl1Xl;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  hxl1Sj
	 */
	@Column(name ="HXL1_SJ",nullable=true,length=100)
	public java.lang.String getHxl1Sj(){
		return this.hxl1Sj;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  hxl1Sj
	 */
	public void setHxl1Sj(java.lang.String hxl1Sj){
		this.hxl1Sj = hxl1Sj;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  hxl1Xx
	 */
	@Column(name ="HXL1_XX",nullable=true,length=100)
	public java.lang.String getHxl1Xx(){
		return this.hxl1Xx;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  hxl1Xx
	 */
	public void setHxl1Xx(java.lang.String hxl1Xx){
		this.hxl1Xx = hxl1Xx;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  hxl1Zy
	 */
	@Column(name ="HXL1_ZY",nullable=true,length=100)
	public java.lang.String getHxl1Zy(){
		return this.hxl1Zy;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  hxl1Zy
	 */
	public void setHxl1Zy(java.lang.String hxl1Zy){
		this.hxl1Zy = hxl1Zy;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  hxl2Xl
	 */
	@Column(name ="HXL2_XL",nullable=true,length=100)
	public java.lang.String getHxl2Xl(){
		return this.hxl2Xl;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  hxl2Xl
	 */
	public void setHxl2Xl(java.lang.String hxl2Xl){
		this.hxl2Xl = hxl2Xl;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  hxl2Sj
	 */
	@Column(name ="HXL2_SJ",nullable=true,length=100)
	public java.lang.String getHxl2Sj(){
		return this.hxl2Sj;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  hxl2Sj
	 */
	public void setHxl2Sj(java.lang.String hxl2Sj){
		this.hxl2Sj = hxl2Sj;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  hxl2Xx
	 */
	@Column(name ="HXL2_XX",nullable=true,length=100)
	public java.lang.String getHxl2Xx(){
		return this.hxl2Xx;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  hxl2Xx
	 */
	public void setHxl2Xx(java.lang.String hxl2Xx){
		this.hxl2Xx = hxl2Xx;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  hxl2Zy
	 */
	@Column(name ="HXL2_ZY",nullable=true,length=100)
	public java.lang.String getHxl2Zy(){
		return this.hxl2Zy;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  hxl2Zy
	 */
	public void setHxl2Zy(java.lang.String hxl2Zy){
		this.hxl2Zy = hxl2Zy;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  hxl3Xl
	 */
	@Column(name ="HXL3_XL",nullable=true,length=100)
	public java.lang.String getHxl3Xl(){
		return this.hxl3Xl;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  hxl3Xl
	 */
	public void setHxl3Xl(java.lang.String hxl3Xl){
		this.hxl3Xl = hxl3Xl;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  hxl3Sj
	 */
	@Column(name ="HXL3_SJ",nullable=true,length=100)
	public java.lang.String getHxl3Sj(){
		return this.hxl3Sj;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  hxl3Sj
	 */
	public void setHxl3Sj(java.lang.String hxl3Sj){
		this.hxl3Sj = hxl3Sj;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  hxl3Xx
	 */
	@Column(name ="HXL3_XX",nullable=true,length=100)
	public java.lang.String getHxl3Xx(){
		return this.hxl3Xx;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  hxl3Xx
	 */
	public void setHxl3Xx(java.lang.String hxl3Xx){
		this.hxl3Xx = hxl3Xx;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  hxl3Zy
	 */
	@Column(name ="HXL3_ZY",nullable=true,length=100)
	public java.lang.String getHxl3Zy(){
		return this.hxl3Zy;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  hxl3Zy
	 */
	public void setHxl3Zy(java.lang.String hxl3Zy){
		this.hxl3Zy = hxl3Zy;
	}

	@Column(name ="BASEFILENAME",nullable=true,length=100)
	public java.lang.String getBasefilename() {
		return basefilename;
	}

	public void setBasefilename(java.lang.String basefilename) {
		this.basefilename = basefilename;
	}

	@Column(name ="BASEFILEPATH",nullable=true,length=100)
	public java.lang.String getBasefilepath() {
		return basefilepath;
	}

	public void setBasefilepath(java.lang.String basefilepath) {
		this.basefilepath = basefilepath;
	}

	@Column(name ="PICPATH",nullable=true,length=100)
	public java.lang.String getPicpath() {
		return picpath;
	}

	public void setPicpath(java.lang.String picpath) {
		this.picpath = picpath;
	}

	@Column(name ="SFZFILENAME",nullable=true,length=100)
	public java.lang.String getSfzfilename() {
		return sfzfilename;
	}

	public void setSfzfilename(java.lang.String sfzfilename) {
		this.sfzfilename = sfzfilename;
	}

	@Column(name ="SFZFILEPATH",nullable=true,length=100)
	public java.lang.String getSfzfilepath() {
		return sfzfilepath;
	}

	public void setSfzfilepath(java.lang.String sfzfilepath) {
		this.sfzfilepath = sfzfilepath;
	}

	@Column(name ="ZCFILENAME",nullable=true,length=100)
	public java.lang.String getZcfilename() {
		return zcfilename;
	}

	public void setZcfilename(java.lang.String zcfilename) {
		this.zcfilename = zcfilename;
	}

	@Column(name ="ZCFILEPATH",nullable=true,length=100)
	public java.lang.String getZcfilepath() {
		return zcfilepath;
	}

	public void setZcfilepath(java.lang.String zcfilepath) {
		this.zcfilepath = zcfilepath;
	}

	@Column(name ="XLFILENAME",nullable=true,length=100)
	public java.lang.String getXlfilename() {
		return xlfilename;
	}

	public void setXlfilename(java.lang.String xlfilename) {
		this.xlfilename = xlfilename;
	}

	@Column(name ="XLFILEPATH",nullable=true,length=100)
	public java.lang.String getXlfilepath() {
		return xlfilepath;
	}

	public void setXlfilepath(java.lang.String xlfilepath) {
		this.xlfilepath = xlfilepath;
	}

	@Column(name ="RZSJ",nullable=true,length=50)
	public java.lang.String getRzsj() {
		return rzsj;
	}

	public void setRzsj(java.lang.String rzsj) {
		this.rzsj = rzsj;
	}
	
}
