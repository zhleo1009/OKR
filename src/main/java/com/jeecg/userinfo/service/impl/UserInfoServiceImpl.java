package com.jeecg.userinfo.service.impl;
import com.jeecg.userinfo.service.UserInfoServiceI;

import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import com.jeecg.userinfo.entity.UserInfoEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.io.Serializable;

@Service("userInfoService")
@Transactional
public class UserInfoServiceImpl extends CommonServiceImpl implements UserInfoServiceI {

	
 	public <T> void delete(T entity) {
 		super.delete(entity);
 		//执行删除操作配置的sql增强
		this.doDelSql((UserInfoEntity)entity);
 	}
 	
 	public <T> Serializable save(T entity) {
 		Serializable t = super.save(entity);
 		//执行新增操作配置的sql增强
 		this.doAddSql((UserInfoEntity)entity);
 		return t;
 	}
 	
 	public <T> void saveOrUpdate(T entity) {
 		super.saveOrUpdate(entity);
 		//执行更新操作配置的sql增强
 		this.doUpdateSql((UserInfoEntity)entity);
 	}
 	
 	/**
	 * 默认按钮-sql增强-新增操作
	 * @param id
	 * @return
	 */
 	public boolean doAddSql(UserInfoEntity t){
	 	return true;
 	}
 	/**
	 * 默认按钮-sql增强-更新操作
	 * @param id
	 * @return
	 */
 	public boolean doUpdateSql(UserInfoEntity t){
	 	return true;
 	}
 	/**
	 * 默认按钮-sql增强-删除操作
	 * @param id
	 * @return
	 */
 	public boolean doDelSql(UserInfoEntity t){
	 	return true;
 	}
 	
 	/**
	 * 替换sql中的变量
	 * @param sql
	 * @return
	 */
 	public String replaceVal(String sql,UserInfoEntity t){
 		sql  = sql.replace("#{id}",String.valueOf(t.getId()));
 		sql  = sql.replace("#{create_name}",String.valueOf(t.getCreateName()));
 		sql  = sql.replace("#{create_by}",String.valueOf(t.getCreateBy()));
 		sql  = sql.replace("#{create_date}",String.valueOf(t.getCreateDate()));
 		sql  = sql.replace("#{update_name}",String.valueOf(t.getUpdateName()));
 		sql  = sql.replace("#{update_by}",String.valueOf(t.getUpdateBy()));
 		sql  = sql.replace("#{update_date}",String.valueOf(t.getUpdateDate()));
 		sql  = sql.replace("#{user_id}",String.valueOf(t.getUserId()));
 		sql  = sql.replace("#{education}",String.valueOf(t.getEducation()));
 		sql  = sql.replace("#{university}",String.valueOf(t.getUniversity()));
 		sql  = sql.replace("#{address}",String.valueOf(t.getAddress()));
 		sql  = sql.replace("#{origin}",String.valueOf(t.getOrigin()));
 		sql  = sql.replace("#{marital_status}",String.valueOf(t.getMaritalStatus()));
 		sql  = sql.replace("#{sex}",String.valueOf(t.getSex()));
 		sql  = sql.replace("#{height}",String.valueOf(t.getHeight()));
 		sql  = sql.replace("#{weight}",String.valueOf(t.getWeight()));
 		sql  = sql.replace("#{introduction}",String.valueOf(t.getIntroduction()));
 		sql  = sql.replace("#{UUID}",UUID.randomUUID().toString());
 		return sql;
 	}
 	
 	@Override
 	public Map<String, Object> getUserInfo(String username){
 		String sql="select u.email,u.qq,info.picpath,info.id,info.user_id,b.status,b.realname,dep.departname,u.mobilePhone,info.education," +
 					" info.rzsj,info.basefilename,info.basefilepath,info.sfzfilename,info.zcfilename,info.xlfilename,info.sfzfilepath,info.xlfilepath,info.zcfilepath, "+
 					" info.university,info.address,info.origin,info.marital_status,info.sex,info.head_pic_path,info.zhiwei"+
					",info.zaigang,info.birthday,info.mingzu,info.sfz,info.zzmm,info.hukou,info.zhicheng,info.zhuanye,info.worktime"+
					",DATE_FORMAT(info.create_date,'%Y-%m-%d') as create_date,info.homephone,info.homeaddress,info.rudangshijian,info.hujisuozaidi"+
					",info.workyear,info.oldcompany,info.oldcompanyphone,info.oldcompanyjob,info.oldcompanyperson,info.baseinforemark"+
					",info.lovename,info.lovebirthday,info.lovemingzu,info.lovexueli,info.lovezzmm,info.lovezhuanye,info.lovephone,info.lovecompany"+
					",info.familyrelation1,info.familyname1,info.familybirth1,info.familyzzmm1,info.familycompany1,info.familyrelation2"+
					",info.familyname2,info.familybirth2,info.familyzzmm2,info.familycompany2,info.familyrelation3,info.familyname3"+
					",info.familybirth3,info.familyzzmm3,info.familycompany3,info.xueli1,info.biyetime1,info.biyeschool1,info.zhuanye1"+
					",info.xueli2,info.biyetime2,info.biyeschool2,info.zhuanye2,info.xueli3,info.biyetime3,info.biyeschool3,info.zhuanye3"+
					",info.xueli4,info.biyetime4,info.biyeschool4,info.zhuanye4,info.zyjszctype,info.zggettime,info.hxl1_xl,info.hxl1_sj " +
					",info.hxl1_xx,info.hxl1_zy,info.hxl2_xl,info.hxl2_sj,info.hxl2_xx,info.hxl2_zy,info.hxl3_xl,info.hxl3_sj,info.hxl3_xx " +
					",info.hxl3_zy,info.jishuzhicheng, DATE_FORMAT(info.hetongendtime,'%Y-%m-%d') as hetongendtime,info.yonggongtype,info.laowugongsiperson,info.laowugongsi,info.laodonghetongtype from t_s_base_user b " +
					" left join t_s_user u on u.id=b.id left join user_info info on info.user_id=b.id left join t_s_user_org org on org.user_id=b.id"+
					" left join t_s_depart dep on dep.id=org.org_id where b.username=?";
 		Map<String, Object> map=findOneForJdbc(sql, username);
 		return map;
 	}
 	
 	@Override
 	public List<Map<String, Object>> getUserList(UserInfoEntity userInfo,DataGrid dataGrid,String sqlCon){
 		String sql="select info.id,b.username, b.realname,  (case info.sex when 1 then '女' ELSE '男' end ) as sex , u.user_no," +
 				" d.departname, info.zhiwei,  (case info.zaigang when 1 then '在职' ELSE '离职' end ) as zaigang," +
 				"  (case info.yonggongtype when 1 then '在编' when 2 then '人事代理' when 3 then '劳务派遣' when 4 then '单位自聘' when 5 then '劳务协议'" +
 				" when 6 then '劳务外包' else '其他' end ) as yonggongtype, info.mingzu from  t_s_base_user b left join t_s_user u on u.id = b.id" +
 				" left join user_info info on info.user_id = b.id LEFT JOIN t_s_user_org o on o.user_id = b.id" +
 				" left join t_s_depart d on d.id = o.org_id where 1=1 "+sqlCon;
 		List<Map<String, Object>> list=findForJdbc(sql,dataGrid.getPage(),dataGrid.getRows());
 		return list;
 	}

	@Override
	public int countForuser(UserInfoEntity userInfo,String sqlCon) {
		String sql="select count(1) as c from  t_s_base_user b left join t_s_user u on u.id = b.id" +
 				" left join user_info info on info.user_id = b.id LEFT JOIN t_s_user_org o on o.user_id = b.id" +
 				" left join t_s_depart d on d.id = o.org_id where 1=1 "+sqlCon;
 		Map<String, Object> map=findOneForJdbc(sql);
 		int total=Integer.parseInt(String.valueOf(map.get("c")));
 		return total;
	}

	@Override
	public Map<String, Object> getUserDetail(String id) {
		String sql="select info.id,date_format(info.create_date,'%Y-%m-%d') as create_date,info.sex, info.sfz, info.mingzu, info.birthday, info.laowugongsi,d.departname," +
				" info.sfzfilename,info.zcfilename,info.xlfilename,info.sfzfilepath,info.xlfilepath,info.zcfilepath, "+
				" info.laodonghetongtype,info.user_id, info.laowugongsiperson, date_format(info.hetongendtime,'%Y-%m-%d') as hetongendtime, info.yonggongtype, info.zhiwei," +
				"b.status, b.realname,info.zhicheng,info.jishuzhicheng,info.hxl1_xl,info.hxl1_xx,info.hxl1_zy,info.hxl1_sj" +
				",info.hxl2_xl,info.hxl2_xx,info.hxl2_zy,info.hxl2_sj,info.hxl3_xl,info.hxl3_xx,info.hxl3_zy,info.hxl3_sj" +
				" from user_info info left join t_s_base_user b on b.id = info.user_id " +
				"left join t_s_user_org o on o.user_id=b.id  left join t_s_depart d on d.id=o.org_id where info.id=?";
		Map<String, Object> map=findOneForJdbc(sql, id);
		return map;
	}

	@Override
	public Map<String, Object> getUserEntity(String user_id) {
		String sql="select * from t_s_user where id=?";
		Map<String, Object> map=findOneForJdbc(sql, user_id);
		return map;
	}

	@Override
	public Map<String, Object> getUserInfoById(String id) {
		String sql="select b.realname,d.departname,u.mobilePhone,u.email,u.qq,i.address,(case i.sex when '0' then '男' else '女' end )as sex,i.head_pic_path,"+
					" i.birthday,i.mingzu,i.sfz,i.zzmm,i.introduction from t_s_base_user b "+
					" left join t_s_user_org o on o.user_id=b.id left join t_s_depart d on d.id=o.org_id"+
					" left join t_s_user u on u.id=b.id left join user_info i on i.user_id=b.id where b.id=?";
		Map<String, Object> map=findOneForJdbc(sql, id);
		return map;
	}
}