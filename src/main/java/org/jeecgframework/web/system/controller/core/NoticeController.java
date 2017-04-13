package org.jeecgframework.web.system.controller.core;

import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.regex.Matcher;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.common.exception.BusinessException;
import org.jeecgframework.core.common.hibernate.qbc.CriteriaQuery;
import org.jeecgframework.core.common.model.json.AjaxJson;
import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.constant.Globals;
import org.jeecgframework.core.util.DateUtils;
import org.jeecgframework.core.util.MutiLangUtil;
import org.jeecgframework.core.util.MyBeanUtils;
import org.jeecgframework.core.util.PropertiesUtil;
import org.jeecgframework.core.util.ResourceUtil;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.tag.core.easyui.TagUtil;
import org.jeecgframework.web.system.pojo.base.TSNotice;
import org.jeecgframework.web.system.pojo.base.TSNoticeReadUser;
import org.jeecgframework.web.system.pojo.base.TSUser;
import org.jeecgframework.web.system.service.NoticeService;
import org.jeecgframework.web.system.service.SystemService;
import org.jeecgframework.web.system.util.ConvertDocUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

/**
 * 通知公告
 * @author alax
 * 
 */
@Scope("prototype")
@Controller
@RequestMapping("/noticeController")
public class NoticeController extends BaseController{
	private SystemService systemService;
	
	@Autowired
	private NoticeService noticeService;
	private String message;
	
	@Autowired
	public void setSystemService(SystemService systemService) {
		this.systemService = systemService;
	}
	
	private PropertiesUtil util = new PropertiesUtil("sysConfig.properties");
	
	/**
	 * 取得用户可读通知公告
	 * 
	 * @param user
	 * @param req
	 * @return
	 */
	@RequestMapping(params = "getNoticeList")
	@ResponseBody
	public AjaxJson getNoticeList(HttpServletRequest req) {
		AjaxJson j = new AjaxJson();
		try {
			TSUser user = ResourceUtil.getSessionUserName();

			List<Map<String, Object>> noticeList = noticeService.getNoticeList(user.getId(), 1, 10);
			
			//update-end-Alex 20160310 for:去除LIMIT,解决数据库兼容性问题
			
			//将List转换成JSON存储
			JSONArray result = new JSONArray();
			if(noticeList!=null && noticeList.size()>0){
				for(int i=0;i<noticeList.size();i++){
					JSONObject jsonParts = new JSONObject();
					jsonParts.put("id", noticeList.get(i).get("id"));
					jsonParts.put("noticeTitle", noticeList.get(i).get("notice_title"));
					jsonParts.put("createTime", DateUtils.date2Str((Date)noticeList.get(i).get("create_time"), DateUtils.datetimeFormat) );
					result.add(jsonParts);	
				}
			}
			
			Map<String,Object> attrs = new HashMap<String, Object>();
			attrs.put("noticeList", result);
			
			String tip = MutiLangUtil.getMutiLangInstance().getLang("notice.tip");
			attrs.put("tip", tip);
			String seeAll = MutiLangUtil.getMutiLangInstance().getLang("notice.seeAll");
			attrs.put("seeAll", seeAll);
			j.setAttributes(attrs);
			
			//获取通知公告总数
			String sql2 = "";
			sql2 += " SELECT count(*) as count FROM  t_s_notice t WHERE";
			sql2 += " (t.notice_level = '1' ";
			sql2 += " OR (t.notice_level = '2' AND EXISTS (SELECT 1 FROM t_s_notice_authority_role r,t_s_role_user ru WHERE r.role_id = ru.roleid AND t.id = r.notice_id AND ru.userid = '"+user.getId()+"'))";
			sql2 += " OR (t.notice_level = '3' AND EXISTS (SELECT 1 FROM t_s_notice_authority_user u WHERE t.id = u.notice_id AND u.user_id = '"+user.getId()+"'))";
			sql2 += " ) AND NOT EXISTS (SELECT 1 FROM t_s_notice_read_user rd WHERE t.id = rd.notice_id AND rd.user_id = '"+user.getId()+"') AND t.is_delete = 0";
			List<Map<String, Object>> resultList2 =  systemService.findForJdbc(sql2);
			Object count = resultList2.get(0).get("count");
			j.setObj(count);
		} catch (Exception e) {
			j.setSuccess(false);
			e.printStackTrace();
		}
		return j;
	}
	
	/**
	 * 获取公告列表(未读)
	 * @param req
	 * @return
	 */
	@RequestMapping(params = "getAfficheList")
	@ResponseBody
	public AjaxJson getAfficheList(HttpServletRequest req) {
		AjaxJson j = new AjaxJson();
		try {
			TSUser user = ResourceUtil.getSessionUserName();
//			
			String sql = "";
			sql += " SELECT * FROM  t_s_notice t WHERE";
			sql += " (t.notice_level = '1' ";
			sql += " OR (t.notice_level = '2' AND EXISTS (SELECT 1 FROM t_s_notice_authority_role r,t_s_role_user ru WHERE r.role_id = ru.roleid AND t.id = r.notice_id AND ru.userid = '"+user.getId()+"'))";
			sql += " OR (t.notice_level = '3' AND EXISTS (SELECT 1 FROM t_s_notice_authority_user u WHERE t.id = u.notice_id AND u.user_id = '"+user.getId()+"'))";
			sql += " ) AND t.notice_type = '2' AND NOT EXISTS (SELECT 1 FROM t_s_notice_read_user rd WHERE t.id = rd.notice_id AND rd.user_id = '"+user.getId()+"')";
			//update-begin-Alex 20160310 for:去除LIMIT,解决数据库兼容性问题
			sql += " ORDER BY t.create_time DESC ";		
			List<Map<String, Object>> noticeList =  systemService.findForJdbc(sql,1,10);
			//update-end-Alex 20160310 for:去除LIMIT,解决数据库兼容性问题
			
			//将List转换成JSON存储
			JSONArray result = new JSONArray();
			if(noticeList!=null && noticeList.size()>0){
				for(int i=0;i<noticeList.size();i++){
					JSONObject jsonParts = new JSONObject();
					jsonParts.put("id", noticeList.get(i).get("id"));
					jsonParts.put("noticeTitle", noticeList.get(i).get("notice_title"));
					result.add(jsonParts);	
				}
			}
			
			Map<String,Object> attrs = new HashMap<String, Object>();
			attrs.put("noticeList", result);
			
			String tip = MutiLangUtil.getMutiLangInstance().getLang("notice.tip");
			attrs.put("tip", tip);
			String seeAll = MutiLangUtil.getMutiLangInstance().getLang("notice.seeAll");
			attrs.put("seeAll", seeAll);
			j.setAttributes(attrs);
			
			//获取通知公告总数
			String sql2 = "";
			sql2 += " SELECT count(*) as count FROM  t_s_notice t WHERE";
			sql2 += " (t.notice_level = '1' ";
			sql2 += " OR (t.notice_level = '2' AND EXISTS (SELECT 1 FROM t_s_notice_authority_role r,t_s_role_user ru WHERE r.role_id = ru.roleid AND t.id = r.notice_id AND ru.userid = '"+user.getId()+"'))";
			sql2 += " OR (t.notice_level = '3' AND EXISTS (SELECT 1 FROM t_s_notice_authority_user u WHERE t.id = u.notice_id AND u.user_id = '"+user.getId()+"'))";
			sql2 += " ) AND t.notice_type = '2' AND NOT EXISTS (SELECT 1 FROM t_s_notice_read_user rd WHERE t.id = rd.notice_id AND rd.user_id = '"+user.getId()+"')";
			List<Map<String, Object>> resultList2 =  systemService.findForJdbc(sql2);
			Object count = resultList2.get(0).get("count");
			j.setObj(count);
		} catch (Exception e) {
			j.setSuccess(false);
			e.printStackTrace();
		}
		return j;
	}
	
	/**
	 * 获取通知列表(未读)
	 * @param req
	 * @return
	 */
	@RequestMapping(params = "getnformList")
	@ResponseBody
	public AjaxJson getnformList(HttpServletRequest req) {
		AjaxJson j = new AjaxJson();
		try {
			TSUser user = ResourceUtil.getSessionUserName();
//			
			String sql = "";
			sql += " SELECT * FROM  t_s_notice t WHERE";
			sql += " (t.notice_level = '1' ";
			sql += " OR (t.notice_level = '2' AND EXISTS (SELECT 1 FROM t_s_notice_authority_role r,t_s_role_user ru WHERE r.role_id = ru.roleid AND t.id = r.notice_id AND ru.userid = '"+user.getId()+"'))";
			sql += " OR (t.notice_level = '3' AND EXISTS (SELECT 1 FROM t_s_notice_authority_user u WHERE t.id = u.notice_id AND u.user_id = '"+user.getId()+"'))";
			sql += " ) AND t.notice_type = '1' AND NOT EXISTS (SELECT 1 FROM t_s_notice_read_user rd WHERE t.id = rd.notice_id AND rd.user_id = '"+user.getId()+"')";
			//update-begin-Alex 20160310 for:去除LIMIT,解决数据库兼容性问题
			sql += " ORDER BY t.create_time DESC ";		
			List<Map<String, Object>> noticeList =  systemService.findForJdbc(sql,1,10);
			//update-end-Alex 20160310 for:去除LIMIT,解决数据库兼容性问题
			
			//将List转换成JSON存储
			JSONArray result = new JSONArray();
			if(noticeList!=null && noticeList.size()>0){
				for(int i=0;i<noticeList.size();i++){
					JSONObject jsonParts = new JSONObject();
					jsonParts.put("id", noticeList.get(i).get("id"));
					jsonParts.put("noticeTitle", noticeList.get(i).get("notice_title"));
					result.add(jsonParts);	
				}
			}
			
			Map<String,Object> attrs = new HashMap<String, Object>();
			attrs.put("noticeList", result);
			
			String tip = MutiLangUtil.getMutiLangInstance().getLang("notice.tip");
			attrs.put("tip", tip);
			String seeAll = MutiLangUtil.getMutiLangInstance().getLang("notice.seeAll");
			attrs.put("seeAll", seeAll);
			j.setAttributes(attrs);
			
			//获取通知公告总数
			String sql2 = "";
			sql2 += " SELECT count(*) as count FROM  t_s_notice t WHERE";
			sql2 += " (t.notice_level = '1' ";
			sql2 += " OR (t.notice_level = '2' AND EXISTS (SELECT 1 FROM t_s_notice_authority_role r,t_s_role_user ru WHERE r.role_id = ru.roleid AND t.id = r.notice_id AND ru.userid = '"+user.getId()+"'))";
			sql2 += " OR (t.notice_level = '3' AND EXISTS (SELECT 1 FROM t_s_notice_authority_user u WHERE t.id = u.notice_id AND u.user_id = '"+user.getId()+"'))";
			sql2 += " ) AND t.notice_type = '1' AND NOT EXISTS (SELECT 1 FROM t_s_notice_read_user rd WHERE t.id = rd.notice_id AND rd.user_id = '"+user.getId()+"')";
			List<Map<String, Object>> resultList2 =  systemService.findForJdbc(sql2);
			Object count = resultList2.get(0).get("count");
			j.setObj(count);
		} catch (Exception e) {
			j.setSuccess(false);
			e.printStackTrace();
		}
		return j;
	}
	
	
	/**
	 * 通知公告列表（阅读）
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "noticeList")
	public ModelAndView noticeList(HttpServletRequest request) {
		return new ModelAndView("system/user/noticeList");
	}
	
	/**
	 * 通知公告详情
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "goNotice")
	public ModelAndView noticeInfo(TSNotice notice,HttpServletRequest request) {
		if (StringUtil.isNotEmpty(notice.getId())) {
			notice = this.systemService.getEntity(TSNotice.class, notice.getId());
			request.setAttribute("notice", notice);
			
			
			notice.setReadCount(notice.getReadCount() + 1);
			systemService.saveOrUpdate(notice);
			
		}
		return new ModelAndView("system/user/noticeinfo");
	}
	
	
	/**
	 * 
	 * 
	 * @param notice
	 * @param request
	 * @return
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping(params = "goAndReadNotice")
	public ModelAndView goAndReadNotice(TSNotice notice,HttpServletRequest request){
		if (StringUtil.isNotEmpty(notice.getId())) {
			notice = this.systemService.getEntity(TSNotice.class, notice.getId());
			notice.setReadCount(notice.getReadCount() + 1);
			systemService.saveOrUpdate(notice);
			
			request.setAttribute("tSNoticePage", notice);
			
			
			TSUser user = ResourceUtil.getSessionUserName();
			TSNoticeReadUser readUser = new TSNoticeReadUser();
			readUser.setNoticeId(notice.getId());
			readUser.setUserId(user.getId());
			readUser.setCreateTime(new Date());
			systemService.saveOrUpdate(readUser);
			
			
			//展现文件
			String filePath =  notice.getFilePath();
			
			if(!StringUtil.isEmpty(filePath)){
				request.setAttribute("filePath", filePath);
				String[] filePaths = filePath.split("\\|");
				List<Map<String, String>> files = new ArrayList<Map<String, String>>();
				Map<String, String> params = null;
				for (String s : filePaths) {
					params = new HashMap<String, String>();
					int pLastIndex = s.lastIndexOf(".");
					int _lastIndex = s.lastIndexOf("_");
					String fileName = s.substring(0, _lastIndex) + "." + s.substring(pLastIndex + 1, s.length());
					params.put("fileRealName",fileName);
					params.put("fileName", s);
					files.add(params);
				}
				request.setAttribute("files", files);
			}
			
			
		}
		return new ModelAndView("system/user/tSNotice-detail");
	}
	
	
	/**
	 * 获取当前用户所有公告
	 * 
	 * 构建列表数据
	 * 
	 * @param request
	 * @param response
	 * @param dataGrid
	 * @param user
	 */
	@RequestMapping(params = "datagrid")
	public void datagrid(TSNotice notice,HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
		
//			CriteriaQuery cq = new CriteriaQuery(TSNotice.class, dataGrid);
//			//查询条件组装器
//			org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, notice, request.getParameterMap());
//			this.noticeService.getDataGridReturn(cq, true);
			
			TSUser user = ResourceUtil.getSessionUserName();
			String sql = "";
			sql = sql + " SELECT * FROM  t_s_notice t WHERE";
			sql = sql + " (t.notice_level = '1' ";
			sql = sql + " OR (t.notice_level = '2' AND EXISTS (SELECT 1 FROM t_s_notice_authority_role r,t_s_role_user ru WHERE r.role_id = ru.roleid AND t.id = r.notice_id AND ru.userid = '"+user.getId()+"'))";
			sql = sql + " OR (t.notice_level = '3' AND EXISTS (SELECT 1 FROM t_s_notice_authority_user u WHERE t.id = u.notice_id AND u.user_id = '"+user.getId()+"'))) AND t.is_delete = 0 ";
			if(StringUtil.isNotEmpty(request.getParameter("noticeTitle"))){
				sql += " AND t.notice_title ='" + request.getParameter("noticeTitle") + "'";
			}
			
			if(dataGrid.getSort() != null && dataGrid.getSort().equals("createTime")){
				sql +=  " ORDER BY t.create_time " + dataGrid.getOrder();
			}
			
			//sql = sql + " ORDER BY t.create_time DESC";
			
			List<Map<String, Object>> resultList =  systemService.findForJdbc(sql,dataGrid.getPage(),dataGrid.getRows());
			//将List转换成JSON存储
			//update-begin--Author:xugj  Date:20160330 for：#1012 【平台bug】系统公告列表时间格式不对
			List<Map<String, Object>> noticeList = new ArrayList<Map<String, Object>>();
			if(resultList!=null && resultList.size()>0){
				for(int i=0;i<resultList.size();i++){
					Map<String, Object> obj =  resultList.get(i);
					Map<String, Object> n = new HashMap<String, Object>();
					n.put("id",String.valueOf(obj.get("id")));
					n.put("noticeTitle", String.valueOf(obj.get("notice_title")));
					n.put("noticeContent", String.valueOf(obj.get("notice_content")));
					n.put("createTime", String.valueOf(obj.get("create_time")));

					List<Map<String, Object>> readinfo =  systemService.findForJdbc("select * from t_s_notice_read_user where notice_id = ? and user_id = ? ",n.get("id"),user.getId());
					if(readinfo!=null && readinfo.size()>0){
						n.put("isRead","1"); //已读
					}else{
						n.put("isRead","0");//未读
					}
					noticeList.add(n);	
				}
			}
			//update-end--Author:xugj  Date:20160330 for：#1012 【平台bug】系统公告列表时间格式不对

			dataGrid.setResults(noticeList);
			String sql2 = "";
			sql2 = sql2 + " SELECT count(*) AS count FROM  t_s_notice t WHERE";
			sql2 = sql2 + " (t.notice_level = '1' ";
			sql2 = sql2 + " OR (t.notice_level = '2' AND EXISTS (SELECT 1 FROM t_s_notice_authority_role r,t_s_role_user ru WHERE r.role_id = ru.roleid AND t.id = r.notice_id AND ru.userid = '"+user.getId()+"'))";
			sql2 = sql2+ " OR (t.notice_level = '3' AND EXISTS (SELECT 1 FROM t_s_notice_authority_user u WHERE t.id = u.notice_id AND u.user_id = '"+user.getId()+"'))) AND t.is_delete = 0 ";
			if(StringUtil.isNotEmpty(request.getParameter("noticeTitle"))){
				sql2 += " AND t.notice_title ='" + request.getParameter("noticeTitle") + "'";
			}
			
			List<Map<String, Object>> resultList2 =  systemService.findForJdbc(sql2);
			Object count = resultList2.get(0).get("count");
			dataGrid.setTotal(Integer.valueOf(count.toString()));
			TagUtil.datagrid(response, dataGrid);
	}
	
	
	
	
	/**
	 * 阅读通知公告
	 * @param user
	 * @param req
	 * @return
	 */
	@RequestMapping(params = "updateNoticeRead")
	@ResponseBody
	public AjaxJson updateNoticeRead(String noticeId,HttpServletRequest req) {
		AjaxJson j = new AjaxJson();
		try {
			TSUser user = ResourceUtil.getSessionUserName();
			TSNoticeReadUser readUser = new TSNoticeReadUser();
			readUser.setNoticeId(noticeId);
			readUser.setUserId(user.getId());
			readUser.setCreateTime(new Date());
			systemService.saveOrUpdate(readUser);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return j;
	}
	
	/**
	 * 通知公告列表(管理) 页面跳转
	 *
	 * 
	 * @return
	 */
	@RequestMapping(params = "tSNotice")
	public ModelAndView tSNotice(HttpServletRequest request) {
		return new ModelAndView("system/user/tSNoticeList");
	}

	/**
	 * easyui AJAX请求数据
	 * 
	 * @param request
	 * @param response
	 * @param dataGrid
	 * @param user
	 */

	@RequestMapping(params = "datagrid2")
	public void datagrid2(TSNotice tSNotice,HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
		CriteriaQuery cq = new CriteriaQuery(TSNotice.class, dataGrid);
		//查询条件组装器
		org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, tSNotice, request.getParameterMap());
		try{
		//自定义追加查询条件
			cq.eq("isDelete", 0);
			
		}catch (Exception e) {
			throw new BusinessException(e.getMessage());
		}
		cq.add();
		this.noticeService.getDataGridReturn(cq, true);
		TagUtil.datagrid(response, dataGrid);
	}

	/**
	 * 删除通知公告，软删除
	 * 
	 * @return
	 */
	@RequestMapping(params = "doDel")
	@ResponseBody
	public AjaxJson doDel(TSNotice tSNotice, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		tSNotice = systemService.getEntity(TSNotice.class, tSNotice.getId());
		message = "通知公告删除成功";
		try{
			tSNotice.setIsDelete(1);
			noticeService.saveOrUpdate(tSNotice);
			
			//noticeService.delete(tSNotice);
			systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
		}catch(Exception e){
			e.printStackTrace();
			message = "通知公告删除失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}
	
	
	/**
	 * 批量删除通知公告
	 * 
	 * @return
	 */
	 @RequestMapping(params = "doBatchRead")
	@ResponseBody
	public AjaxJson doBatchRead(String ids,HttpServletRequest request){
		AjaxJson j = new AjaxJson();
		message = "通知公告阅读成功";
		try{
			for(String id:ids.split(",")){
				TSNotice tSNotice = systemService.getEntity(TSNotice.class, 
				id
				);
				TSUser user = ResourceUtil.getSessionUserName();
				TSNoticeReadUser readUser = new TSNoticeReadUser();
				readUser.setNoticeId(tSNotice.getId());
				readUser.setUserId(user.getId());
				readUser.setCreateTime(new Date());
				systemService.saveOrUpdate(readUser);
				systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
			}
		}catch(Exception e){
			e.printStackTrace();
			message = "通知公告阅读失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}
	
	/**
	 * 批量删除通知公告，软删除
	 * 
	 * @return
	 */
	 @RequestMapping(params = "doBatchDel")
	@ResponseBody
	public AjaxJson doBatchDel(String ids,HttpServletRequest request){
		AjaxJson j = new AjaxJson();
		message = "通知公告删除成功";
		try{
			for(String id:ids.split(",")){
				TSNotice tSNotice = systemService.getEntity(TSNotice.class, 
				id
				);
				
				tSNotice.setIsDelete(1);
				noticeService.saveOrUpdate(tSNotice);
				//noticeService.delete(tSNotice);
				systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
			}
		}catch(Exception e){
			e.printStackTrace();
			message = "通知公告删除失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}


	/**
	 * 添加通知公告
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(params = "doAdd")
	@ResponseBody
	public AjaxJson doAdd(TSNotice tSNotice, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		message = "通知公告添加成功";
		try{
			
			TSUser user = ResourceUtil.getSessionUserName();
			tSNotice.setCreateUser(user.getRealName());
			tSNotice.setCreateTime(new Date());
			tSNotice.setReadCount(0);
			String filePath = request.getParameter("filePath");
			
			if(!StringUtil.isEmpty(filePath)){
				tSNotice.setFilePath(filePath);
			}else{
				tSNotice.setFilePath(null);
			}
			tSNotice.setIsDelete(0);
			
			noticeService.save(tSNotice);
			systemService.addLog(message, Globals.Log_Type_INSERT, Globals.Log_Leavel_INFO);
		}catch(Exception e){
			e.printStackTrace();
			message = "通知公告添加失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}
	
	/**
	 * 更新通知公告
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(params = "doUpdate")
	@ResponseBody
	public AjaxJson doUpdate(TSNotice tSNotice, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		message = "通知公告更新成功";
		TSNotice t = noticeService.get(TSNotice.class, tSNotice.getId());
		try {
			MyBeanUtils.copyBeanNotNull2Bean(tSNotice, t);
			if(StringUtil.isEmpty(tSNotice)){
				t.setFilePath(null);
			}
			noticeService.saveOrUpdate(t);
			systemService.addLog(message, Globals.Log_Type_UPDATE, Globals.Log_Leavel_INFO);
		} catch (Exception e) {
			e.printStackTrace();
			message = "通知公告更新失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}
	

	/**
	 * 通知公告新增页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "goAdd")
	public ModelAndView goAdd(TSNotice tSNotice, HttpServletRequest req) {
		if (StringUtil.isNotEmpty(tSNotice.getId())) {
			tSNotice = noticeService.getEntity(TSNotice.class, tSNotice.getId());
			req.setAttribute("tSNoticePage", tSNotice);
		}
		return new ModelAndView("system/user/tSNotice-add");
	}
	/**
	 * 通知公告编辑页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "goUpdate")
	public ModelAndView goUpdate(TSNotice tSNotice, HttpServletRequest req) {
		if (StringUtil.isNotEmpty(tSNotice.getId())) {
			tSNotice = noticeService.getEntity(TSNotice.class, tSNotice.getId());
			if(tSNotice.getNoticeTerm()==null){
				tSNotice.setNoticeTerm(new Date());
			}
			req.setAttribute("tSNoticePage", tSNotice);
			
			//展现文件
			String filePath =  tSNotice.getFilePath();
			if(!StringUtil.isEmpty(filePath)){
				req.setAttribute("filePath", filePath);
				String[] filePaths = filePath.split("\\|");
				List<Map<String, String>> files = new ArrayList<Map<String, String>>();
				Map<String, String> params = null;
				for (String s : filePaths) {
					params = new HashMap<String, String>();
					int pLastIndex = s.lastIndexOf(".");
					int _lastIndex = s.lastIndexOf("_");
					String fileName = s.substring(0, _lastIndex) + "." + s.substring(pLastIndex + 1, s.length());
					params.put("fileRealName",fileName);
					params.put("fileName", s);
					files.add(params);
				}
				req.setAttribute("files", files);
			}
			
		}
		return new ModelAndView("system/user/tSNotice-update");
	}
	
	
	/**
	 * 查看详情
	 * 
	 * @param tSNotice
	 * @param req
	 * @return
	 */
	@RequestMapping(params = "goDetail")
	public ModelAndView goDetail(TSNotice tSNotice, HttpServletRequest req) {
		if (StringUtil.isNotEmpty(tSNotice.getId())) {
			tSNotice = noticeService.getEntity(TSNotice.class, tSNotice.getId());
			if(tSNotice.getNoticeTerm()==null){
				tSNotice.setNoticeTerm(new Date());
			}
			tSNotice.setReadCount(tSNotice.getReadCount() + 1);
			systemService.saveOrUpdate(tSNotice);
			
			req.setAttribute("tSNoticePage", tSNotice);
			
			//展现文件
			String filePath =  tSNotice.getFilePath();
			if(!StringUtil.isEmpty(filePath)){
				req.setAttribute("filePath", filePath);
				String[] filePaths = filePath.split("\\|");
				List<Map<String, String>> files = new ArrayList<Map<String, String>>();
				Map<String, String> params = null;
				for (String s : filePaths) {
					if("".equals(s)){
						continue;
					}
					params = new HashMap<String, String>();
					int pLastIndex = s.lastIndexOf(".");
					int _lastIndex = s.lastIndexOf("_");
					String fileName = s.substring(0, _lastIndex) + "." + s.substring(pLastIndex + 1, s.length());
					params.put("fileRealName",fileName);
					params.put("fileName", s);
					files.add(params);
				}
				req.setAttribute("files", files);
			}
			
		}
		return new ModelAndView("system/user/tSNotice-detail");
	}
	
	/**
	 * 获取公告列表（app）
	 * @param token
	 * @param request
	 * @param response
	 * @param dataGrid
	 * @return
	 */
	@RequestMapping(params = "app_MobileGetAfficheList",method=RequestMethod.GET)
	@ResponseBody
	public AjaxJson app_GetAfficheList(String token,HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
		AjaxJson j = new AjaxJson();
		try {
			TSUser user = systemService.findUniqueByProperty(TSUser.class, "appToken", token);
			Map<String,Object> attrs = new HashMap<String, Object>();
			
			//获取通知公告总数
			String sql2 = "SELECT count(1) as count FROM  t_s_notice t where t.is_delete='0'";
			/*sql2 += " SELECT count(*) as count FROM  t_s_notice t WHERE";
			sql2 += " (t.notice_level = '1' ";
			sql2 += " OR (t.notice_level = '2' AND EXISTS (SELECT 1 FROM t_s_notice_authority_role r,t_s_role_user ru WHERE r.role_id = ru.roleid AND t.id = r.notice_id AND ru.userid = '"+user.getId()+"'))";
			sql2 += " OR (t.notice_level = '3' AND EXISTS (SELECT 1 FROM t_s_notice_authority_user u WHERE t.id = u.notice_id AND u.user_id = '"+user.getId()+"'))";
			sql2 += " ) AND t.notice_type = '2' AND NOT EXISTS (SELECT 1 FROM t_s_notice_read_user rd WHERE t.id = rd.notice_id AND rd.user_id = '"+user.getId()+"')";
			*/List<Map<String, Object>> resultList2 =  systemService.findForJdbc(sql2);
			int count = Integer.parseInt(String.valueOf(resultList2.get(0).get("count")));
			attrs.put("total", count);
			
			String sql = "SELECT * FROM  t_s_notice t where t.is_delete='0' order by t.create_time desc";
			List<Map<String, Object>> noticeList =  systemService.findForJdbc(sql,dataGrid.getPage(),dataGrid.getRows());
			
			//将List转换成JSON存储
			JSONArray result = new JSONArray();
			if(noticeList!=null && noticeList.size()>0){
				for(int i=0;i<noticeList.size();i++){
					JSONObject jsonParts = new JSONObject();
					jsonParts.put("id", noticeList.get(i).get("id"));
					jsonParts.put("noticeTitle", noticeList.get(i).get("notice_title"));
					result.add(jsonParts);	
				}
			}
			attrs.put("rows", result);
			j.setObj(attrs);
			
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("code", "0000");
			j.setAttributes(params);
		} catch (Exception e) {
			j.setSuccess(false);
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("code", "0001");
			j.setAttributes(params);
			j.setMsg("操作失败");
			e.printStackTrace();
		}
		return j;
	}
	
	/**
	 * 获取公告详情（app）
	 * @param token
	 * @param id
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "app_MobileGetNotice",method=RequestMethod.GET)
	@ResponseBody
	public AjaxJson app_GetNotice(String token,String id,HttpServletRequest request) {
		AjaxJson j=new AjaxJson();
		try {
			Map<String, Object> params = new HashMap<String, Object>();
			if(id == null){
				params.put("code", "2001");
				j.setAttributes(params);
				j.setMsg("id为空");
				j.setSuccess(false);
				return j;
			}
			
			PropertiesUtil util = new PropertiesUtil("sysConfig.properties");
			String webUrl = util.readProperty("domain");
			
			TSNotice notice = this.systemService.getEntity(TSNotice.class, id);
			String filepath = notice.getFilePath();
			filepath = StringUtils.trimToEmpty(filepath);
			
			String strNoticeContent = notice.getNoticeContent();
			strNoticeContent = strNoticeContent.replace("ueditor/jsp/upload", webUrl + "/ueditor/jsp/upload");
			
			//系统切换前的通知通告放在old目录
			String strDateDir = "";
			if(DateUtils.date2Str(notice.getCreateTime(), DateUtils.yyyyMMdd).compareTo("20161130")<=0){
				strDateDir = "old";
			}else{
				strDateDir = DateUtils.date2Str(notice.getCreateTime(), DateUtils.yyyyMMdd);
			}
			
			String strReturnFilepath = "";
//			String fileName = "";
			if(filepath.indexOf("|")>-1){
				String[] fileName_arr = filepath.split("\\|");
				for(int i=0;i<fileName_arr.length;i++){
					
					String str = fileName_arr[i];
//					int _lastIndex = str.lastIndexOf("_");
					
					if(i==fileName_arr.length-1){
//						fileName += str.substring(0, _lastIndex);
						
						strReturnFilepath += webUrl + "/upload/tz/" + strDateDir + "/" + str;
					}else{
//						fileName += str.substring(0, _lastIndex) + "|";
						strReturnFilepath += webUrl + "/upload/tz/" + strDateDir + "/" + str  + "|";
					}
				}
				notice.setFileName(strReturnFilepath);
			}else{
				notice.setFileName(webUrl + "/upload/tz/" + strDateDir + "/" + filepath);
			}

			TSUser user = systemService.findUniqueByProperty(TSUser.class, "appToken", token);
			TSNoticeReadUser readUser = new TSNoticeReadUser();
			readUser.setNoticeId(id);
			readUser.setUserId(user.getId());
			readUser.setCreateTime(new Date());
			systemService.saveOrUpdate(readUser);
			
			notice.setNoticeContent(strNoticeContent);
			j.setObj(notice);
			params.put("code", "0000");
			j.setAttributes(params);
			j.setMsg("获取公告详情成功");
		} catch (Exception e) {
			Map<String, Object> params = new HashMap<String, Object>();
			e.printStackTrace();
			j.setMsg("获取公告详情失败，程序异常");
			params.put("code", "0001");
			j.setAttributes(params);
			j.setSuccess(false);
			}
		return j;
	}
	
	public static void main(String[] args) {
		
		
		System.out.println("_12%&".replaceAll("&", "_").replaceAll("%", "_"));
		
	}
	
	/*
	 * 上传附件
	 */
	@RequestMapping(params = "importArchive", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson importArchive(HttpServletRequest request, HttpServletResponse response) {
		
		AjaxJson j = new AjaxJson();
		
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
		for (Map.Entry<String, MultipartFile> entity : fileMap.entrySet()) {
			MultipartFile file = entity.getValue();// 获取上传文件对象
			
			PropertiesUtil util = new PropertiesUtil("sysConfig.properties");
			String baseFolder = util.readProperty("fileBasePath") + File.separator + DateUtils.date2Str(DateUtils.yyyyMMdd);
			
			File dir = new File(baseFolder);
			if(!dir.exists()){
				dir.mkdirs();
			}
			
			String oFile = file.getOriginalFilename().replaceAll(" ", "").replaceAll("%", "_").replaceAll("&", "_");
			
			int lastIndex = oFile.lastIndexOf(".");
			
			String fileName = oFile.substring(0, lastIndex) + "_" + UUID.randomUUID().toString().replace("-", "");
			
			String fileExt = oFile.substring(oFile.lastIndexOf(".") + 1, oFile.length());
			
			fileName =  fileName + "." + fileExt;
			
			String filePath = baseFolder + File.separator + fileName;
			
			DataOutputStream outputStream = null;
			
			InputStream inputStream = null;
			
			try {

				inputStream = file.getInputStream();
				outputStream = new DataOutputStream(new FileOutputStream(filePath));
				int len = inputStream.available();

				// 判断长度是否大于1M
				if (len <= 1024 * 1024) {
					byte[] bytes = new byte[len];
					inputStream.read(bytes);
					outputStream.write(bytes);
				} else {
					int byteCount = 0;
					// 1M逐个读取
					byte[] bytes = new byte[1024 * 1024];
					while ((byteCount = inputStream.read(bytes)) != -1) {
						outputStream.write(bytes, 0, byteCount);
					}
				}
				
				j.setMsg(fileName);
				
			} catch (Exception e) {
				j.setMsg("文件导入失败！");
				j.setSuccess(false);
			}finally{
				try {
					file.getInputStream().close();
				} catch (IOException e) {
					e.printStackTrace();
				}
				
				if(outputStream != null){
					try {
						outputStream.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
		}
		return j;
	}
	
	
	/**
	 * 导出附加
	 * 
	 * @param id
	 * @param fileName
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(params = "exportArchive")
	public void exportArchive(String id, String fileName, HttpServletRequest request,HttpServletResponse response) throws Exception {
		TSNotice notice = systemService.getEntity(TSNotice.class, id);
		Date createTime = notice.getCreateTime();
		
		PropertiesUtil util = new PropertiesUtil("sysConfig.properties");
		String fileBasePath = util.readProperty("fileBasePath");
		
		//获取输出流
		String filePath = "";
						
		if(DateUtils.date2Str(createTime, DateUtils.yyyyMMdd).compareTo("20161130") <= 0){
			filePath = fileBasePath + File.separator + "old" + File.separator + fileName;
		}else{
			filePath = fileBasePath + File.separator + DateUtils.date2Str(createTime, DateUtils.yyyyMMdd) + 
					File.separator + fileName;
		}
		System.out.println(filePath);
		
		File file = new File(filePath);
		
		FileInputStream inputStream = null;
		OutputStream stream = null;
		try {
			
			inputStream = new FileInputStream(file);
			byte[] data = new byte[(int)file.length()];
			inputStream.read(data);
			
			
			    inputStream.close();
			    
			    response.setContentType("application/x-download");
			    
			    int pLastIndex = fileName.lastIndexOf(".");
				int _lastIndex = fileName.lastIndexOf("_");
				String fileRealName = fileName.substring(0, _lastIndex) + "." + fileName.substring(pLastIndex + 1, fileName.length());
			    
//			    String[] split = fileName.split("\\.");
//			    String fileRealName = split[0].split("\\_")[0] + "." + split[1];
			    fileRealName = new String(fileRealName.getBytes("UTF-8"),"iso8859-1");
			    response.addHeader("Content-Disposition","attachment;filename=\"" + fileRealName + "\"");  

			    stream = response.getOutputStream();
			    stream.write(data);
			    
//			    stream.flush();
//			    stream.close();
			    
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
			response.getWriter().print("下载文件不存在");
		}catch (Exception e) {
			e.printStackTrace();
			response.getWriter().print("下载文件发生错误");
		}finally{
			if(inputStream != null){
				inputStream.close();
			}
			if(stream != null){
				stream.flush();
			    stream.close();
			}
		}
		
	}
	
	
	/**
	 * 预览附加
	 * 
	 * @param request
	 * @param response
	 * @throws UnsupportedEncodingException 
	 * @throws Exception
	 */
	@RequestMapping(params = "app_MobileViewOffice",method=RequestMethod.GET)
	   public String app_MobileViewOffice(String token,HttpServletRequest request, HttpServletResponse response){
		 
		   String sourceFilePath=request.getParameter("src");
		   try {
			sourceFilePath = URLDecoder.decode(sourceFilePath,"utf-8");
			  String id = request.getParameter("id");
			   TSNotice notice=systemService.getEntity(TSNotice.class, id);
			   Date createTime = notice.getCreateTime();
			   String strDateDir = "";
			   //老的附件放在old目录下
			   if(DateUtils.date2Str(createTime, DateUtils.yyyyMMdd).compareTo("20161130") <= 0){
				   strDateDir = "old";
			   }else{
				   strDateDir = DateUtils.date2Str(createTime, DateUtils.yyyyMMdd);
			   }
			   
			   Map<String,Object> resultMap= ConvertDocUtils.getInstance().convertDocToHtml(sourceFilePath,strDateDir);
			   String pageUrl=(String)resultMap.get("pageUrl");
			   boolean result=(Boolean) resultMap.get("result");

			   if(result){//转换成功

				   return "redirect:"+pageUrl;
				   
			   }else{
				   String message=(String)resultMap.get("message");
				   request.setAttribute("message", message);
				   return "redirect:"+util.readProperty("staticServerPath")+ "error.html";
			   }
		   } catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			 return "redirect:"+util.readProperty("staticServerPath")+ "error.html";
		   }
		 
	}
	
}
