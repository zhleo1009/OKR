package com.jeecg.scokr.service.impl;
import com.jeecg.scokr.service.ScOkrServiceI;
import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import com.jeecg.scokr.entity.ScOkrEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.UUID;
import java.io.Serializable;

@Service("scOkrService")
@Transactional
public class ScOkrServiceImpl extends CommonServiceImpl implements ScOkrServiceI {

	
 	public <T> void delete(T entity) {
 		super.delete(entity);
 		//执行删除操作配置的sql增强
		this.doDelSql((ScOkrEntity)entity);
 	}
 	
 	public <T> Serializable save(T entity) {
 		Serializable t = super.save(entity);
 		//执行新增操作配置的sql增强
 		this.doAddSql((ScOkrEntity)entity);
 		return t;
 	}
 	
 	public <T> void saveOrUpdate(T entity) {
 		super.saveOrUpdate(entity);
 		//执行更新操作配置的sql增强
 		this.doUpdateSql((ScOkrEntity)entity);
 	}
 	
 	/**
	 * 默认按钮-sql增强-新增操作
	 * @param id
	 * @return
	 */
 	public boolean doAddSql(ScOkrEntity t){
	 	return true;
 	}
 	/**
	 * 默认按钮-sql增强-更新操作
	 * @param id
	 * @return
	 */
 	public boolean doUpdateSql(ScOkrEntity t){
	 	return true;
 	}
 	/**
	 * 默认按钮-sql增强-删除操作
	 * @param id
	 * @return
	 */
 	public boolean doDelSql(ScOkrEntity t){
	 	return true;
 	}
 	
 	/**
	 * 替换sql中的变量
	 * @param sql
	 * @return
	 */
 	public String replaceVal(String sql,ScOkrEntity t){
 		sql  = sql.replace("#{id}",String.valueOf(t.getId()));
 		sql  = sql.replace("#{create_name}",String.valueOf(t.getCreateName()));
 		sql  = sql.replace("#{create_by}",String.valueOf(t.getCreateBy()));
 		sql  = sql.replace("#{create_date}",String.valueOf(t.getCreateDate()));
 		sql  = sql.replace("#{update_name}",String.valueOf(t.getUpdateName()));
 		sql  = sql.replace("#{update_by}",String.valueOf(t.getUpdateBy()));
 		sql  = sql.replace("#{update_date}",String.valueOf(t.getUpdateDate()));
 		sql  = sql.replace("#{sys_org_code}",String.valueOf(t.getSysOrgCode()));
 		sql  = sql.replace("#{sys_company_code}",String.valueOf(t.getSysCompanyCode()));
 		sql  = sql.replace("#{bpm_status}",String.valueOf(t.getBpmStatus()));
 		sql  = sql.replace("#{objective}",String.valueOf(t.getObjective()));
 		sql  = sql.replace("#{key_result}",String.valueOf(t.getKeyResult()));
 		sql  = sql.replace("#{mission}",String.valueOf(t.getMission()));
 		sql  = sql.replace("#{user_id}",String.valueOf(t.getUserId()));
 		sql  = sql.replace("#{plan_time}",String.valueOf(t.getPlanTime()));
 		sql  = sql.replace("#{difficulties}",String.valueOf(t.getDifficulties()));
 		sql  = sql.replace("#{percent}",String.valueOf(t.getPercent()));
 		sql  = sql.replace("#{unfinished_reason}",String.valueOf(t.getUnfinishedReason()));
 		sql  = sql.replace("#{need_org_code}",String.valueOf(t.getNeedOrgCode()));
 		sql  = sql.replace("#{finish_time}",String.valueOf(t.getFinishTime()));
 		sql  = sql.replace("#{UUID}",UUID.randomUUID().toString());
 		return sql;
 	}
}