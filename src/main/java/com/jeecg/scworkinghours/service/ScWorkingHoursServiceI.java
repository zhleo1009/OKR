package com.jeecg.scworkinghours.service;
import com.jeecg.scworkinghours.entity.ScWorkingHoursEntity;
import org.jeecgframework.core.common.service.CommonService;

import java.io.Serializable;

public interface ScWorkingHoursServiceI extends CommonService{
	
 	public <T> void delete(T entity);
 	
 	public <T> Serializable save(T entity);
 	
 	public <T> void saveOrUpdate(T entity);
 	
 	/**
	 * 默认按钮-sql增强-新增操作
	 * @param id
	 * @return
	 */
 	public boolean doAddSql(ScWorkingHoursEntity t);
 	/**
	 * 默认按钮-sql增强-更新操作
	 * @param id
	 * @return
	 */
 	public boolean doUpdateSql(ScWorkingHoursEntity t);
 	/**
	 * 默认按钮-sql增强-删除操作
	 * @param id
	 * @return
	 */
 	public boolean doDelSql(ScWorkingHoursEntity t);
}
