package com.jeecg.userinfo.service;
import com.jeecg.userinfo.entity.UserInfoEntity;

import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.common.service.CommonService;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

public interface UserInfoServiceI extends CommonService{
	
 	public <T> void delete(T entity);
 	
 	public <T> Serializable save(T entity);
 	
 	public <T> void saveOrUpdate(T entity);
 	
 	/**
	 * 默认按钮-sql增强-新增操作
	 * @param id
	 * @return
	 */
 	public boolean doAddSql(UserInfoEntity t);
 	/**
	 * 默认按钮-sql增强-更新操作
	 * @param id
	 * @return
	 */
 	public boolean doUpdateSql(UserInfoEntity t);
 	/**
	 * 默认按钮-sql增强-删除操作
	 * @param id
	 * @return
	 */
 	public boolean doDelSql(UserInfoEntity t);
 	
 	public Map<String, Object> getUserInfo(String username);
 	
 	public List<Map<String, Object>> getUserList(UserInfoEntity userInfo,DataGrid dataGrid,String sqlCon);
 	
 	public int countForuser(UserInfoEntity userInfo,String sqlCon);
 	
 	public Map<String, Object> getUserDetail(String id);
 	
 	public Map<String, Object> getUserEntity(String user_id);
 	
 	public Map<String, Object> getUserInfoById(String id);
}
