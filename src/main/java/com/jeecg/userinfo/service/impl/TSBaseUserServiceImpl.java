package com.jeecg.userinfo.service.impl;
import com.jeecg.userinfo.service.TSBaseUserServiceI;
import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import com.jeecg.userinfo.entity.TSBaseUserEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.UUID;
import java.io.Serializable;

@Service("tSBaseUserService")
@Transactional
public class TSBaseUserServiceImpl extends CommonServiceImpl implements TSBaseUserServiceI {

	
 	public <T> void delete(T entity) {
 		super.delete(entity);
 		//执行删除操作配置的sql增强
		this.doDelSql((TSBaseUserEntity)entity);
 	}
 	
 	public <T> Serializable save(T entity) {
 		Serializable t = super.save(entity);
 		//执行新增操作配置的sql增强
 		this.doAddSql((TSBaseUserEntity)entity);
 		return t;
 	}
 	
 	public <T> void saveOrUpdate(T entity) {
 		super.saveOrUpdate(entity);
 		//执行更新操作配置的sql增强
 		this.doUpdateSql((TSBaseUserEntity)entity);
 	}
 	
 	/**
	 * 默认按钮-sql增强-新增操作
	 * @param id
	 * @return
	 */
 	public boolean doAddSql(TSBaseUserEntity t){
	 	return true;
 	}
 	/**
	 * 默认按钮-sql增强-更新操作
	 * @param id
	 * @return
	 */
 	public boolean doUpdateSql(TSBaseUserEntity t){
	 	return true;
 	}
 	/**
	 * 默认按钮-sql增强-删除操作
	 * @param id
	 * @return
	 */
 	public boolean doDelSql(TSBaseUserEntity t){
	 	return true;
 	}
 	
 	/**
	 * 替换sql中的变量
	 * @param sql
	 * @return
	 */
 	public String replaceVal(String sql,TSBaseUserEntity t){
 		sql  = sql.replace("#{id}",String.valueOf(t.getId()));
 		sql  = sql.replace("#{activitisync}",String.valueOf(t.getActivitisync()));
 		sql  = sql.replace("#{browser}",String.valueOf(t.getBrowser()));
 		sql  = sql.replace("#{password}",String.valueOf(t.getPassword()));
 		sql  = sql.replace("#{realname}",String.valueOf(t.getRealname()));
 		sql  = sql.replace("#{signature}",String.valueOf(t.getSignature()));
 		sql  = sql.replace("#{status}",String.valueOf(t.getStatus()));
 		sql  = sql.replace("#{userkey}",String.valueOf(t.getUserkey()));
 		sql  = sql.replace("#{username}",String.valueOf(t.getUsername()));
 		sql  = sql.replace("#{departid}",String.valueOf(t.getDepartid()));
 		sql  = sql.replace("#{UUID}",UUID.randomUUID().toString());
 		return sql;
 	}
}