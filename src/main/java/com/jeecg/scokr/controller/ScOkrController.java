package com.jeecg.scokr.controller;
import java.io.IOException;
import java.net.URI;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolation;
import javax.validation.Validator;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.jeecgframework.core.beanvalidator.BeanValidators;
import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.common.exception.BusinessException;
import org.jeecgframework.core.common.hibernate.qbc.CriteriaQuery;
import org.jeecgframework.core.common.model.json.AjaxJson;
import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.constant.Globals;
import org.jeecgframework.core.util.DateUtils;
import org.jeecgframework.core.util.ExceptionUtil;
import org.jeecgframework.core.util.MyBeanUtils;
import org.jeecgframework.core.util.ResourceUtil;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.poi.excel.ExcelImportUtil;
import org.jeecgframework.poi.excel.entity.ExportParams;
import org.jeecgframework.poi.excel.entity.ImportParams;
import org.jeecgframework.poi.excel.entity.vo.NormalExcelConstants;
import org.jeecgframework.tag.core.easyui.TagUtil;
import org.jeecgframework.tag.vo.datatable.SortDirection;
import org.jeecgframework.web.system.pojo.base.TSDepart;
import org.jeecgframework.web.system.pojo.base.TSRole;
import org.jeecgframework.web.system.pojo.base.TSRoleUser;
import org.jeecgframework.web.system.pojo.base.TSUser;
import org.jeecgframework.web.system.service.SystemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.UriComponentsBuilder;

import com.jeecg.project.entity.ProjectEntity;
import com.jeecg.scokr.entity.ScOkrEntity;
import com.jeecg.scokr.service.ScOkrServiceI;

/**   
 * @Title: Controller
 * @Description: 员工日程计划
 * @author 张浩
 * @date 2017-01-14 12:46:18
 * @version V1.0   
 *
 */
@Scope("prototype")
@Controller
@RequestMapping("/scOkrController")
public class ScOkrController extends BaseController {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(ScOkrController.class);

	@Autowired
	private ScOkrServiceI scOkrService;
	@Autowired
	private SystemService systemService;
	@Autowired
	private Validator validator;
	
	private String message;
	
	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}


	/**
	 * 员工日程计划列表 页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "list")
	public ModelAndView list(HttpServletRequest request) {
		return new ModelAndView("com/jeecg/scokr/scOkrList");
	}

	/**
	 * easyui AJAX请求数据
	 * 
	 * @param request
	 * @param response
	 * @param dataGrid
	 * @param user
	 */

	@RequestMapping(params = "datagrid")
	public void datagrid(ScOkrEntity scOkr,HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
		CriteriaQuery cq = new CriteriaQuery(ScOkrEntity.class, dataGrid);
		//查询条件组装器
		
		//查询当前部门OKR
	    TSUser user = ResourceUtil.getSessionUserName();
        String orgCode =  user.getCurrentDepart().getOrgCode();
        scOkr.setSysOrgCode(orgCode);
        
      //部门页面不显示草稿
		 cq.notEq("bpmStatus", "3");      
		
		  
		  
		  
		org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, scOkr, request.getParameterMap());
		try{
		    // 自定义追加查询条件
		
           
			//默认当前周
			String beginDate = request.getParameter("createDate_begin");
			String endDate = request.getParameter("createDate_end");
			if (StringUtils.isBlank(beginDate) || StringUtils.isBlank(endDate))
			{
				beginDate = DateUtils.date_sdf.format(DateUtils.getWeekStartDate());
				endDate = DateUtils.date_sdf.format(DateUtils.getWeekEndDate());
	        }
			   cq.ge("createDate", beginDate);
	           cq.lt("createDate", endDate);
	         
           
		}catch (Exception e) {
			throw new BusinessException(e.getMessage());
		}
		cq.add();
		this.scOkrService.getDataGridReturn(cq, true);
		TagUtil.datagrid(response, dataGrid);
	}

	
	
	
	
	
	
	
	
	
	/**
	 * 员工日程计划列表 页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "easylist")
	public ModelAndView easylist(HttpServletRequest request) {
		return new ModelAndView("com/jeecg/scokr/ScOkrList-easy");
	}

	/**
	 * easyui AJAX请求数据
	 * 
	 * @param request
	 * @param response
	 * @param dataGrid
	 * @param user
	 */

	@RequestMapping(params = "datagrideasy")
	public void datagriEasy(ScOkrEntity scOkr,HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
		CriteriaQuery cq = new CriteriaQuery(ScOkrEntity.class, dataGrid);
		//查询条件组装器
		org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, scOkr, request.getParameterMap());
		try{
		    // 自定义追加查询条件
            String query_createDate_begin = request.getParameter("workingDate_begin");
            String query_createDate_end = request.getParameter("workingDate_end");
            if (StringUtil.isNotEmpty(query_createDate_begin))
            {
                cq.ge("workingDate",
                    new SimpleDateFormat("yyyy-MM-dd").parse(query_createDate_begin));
            }
            if (StringUtil.isNotEmpty(query_createDate_end))
            {
                cq.le("workingDate",
                    new SimpleDateFormat("yyyy-MM-dd").parse(query_createDate_end));
            }
		   //将完成度转换为百分比显示
          
           
		}catch (Exception e) {
			throw new BusinessException(e.getMessage());
		}
		cq.add();
		this.scOkrService.getDataGridReturn(cq, true);
		TagUtil.printWriterJson(response, dataGrid);
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/**
	 * 员工日程计划列表 页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "mylist")
	public ModelAndView mylist(HttpServletRequest request) {
		return new ModelAndView("com/jeecg/scokr/scOkrList-my");
	}

	/**
	 * easyui AJAX请求数据
	 * 
	 * @param request
	 * @param response
	 * @param dataGrid
	 * @param user
	 */

	@RequestMapping(params = "datagridMy")
	public void datagridMy(ScOkrEntity scOkr,HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
		CriteriaQuery cq = new CriteriaQuery(ScOkrEntity.class, dataGrid);
		
		TSUser u = ResourceUtil.getSessionUserName();
		scOkr.setUserId(u.getId());
	
		//查询条件组装器
		org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, scOkr, request.getParameterMap());
		try{
		    // 自定义追加查询条件
			//默认当前周
			String beginDate = request.getParameter("createDate_begin");
			String endDate = request.getParameter("createDate_end");
			if (StringUtils.isBlank(beginDate) || StringUtils.isBlank(endDate))
			{
				beginDate = DateUtils.date_sdf.format(DateUtils.getWeekStartDate());
				endDate = DateUtils.date_sdf.format(DateUtils.getWeekEndDate());
	        }
			   cq.ge("createDate", beginDate);
	           cq.lt("createDate", endDate);
          
           
		}catch (Exception e) {
			throw new BusinessException(e.getMessage());
		}
		cq.add();
		this.scOkrService.getDataGridReturn(cq, true);
		TagUtil.datagrid(response, dataGrid);
	}

	
	
	
	
	
	
	
	
	/**
	 * 删除员工日程计划
	 * 
	 * @return
	 */
	@RequestMapping(params = "doDel")
	@ResponseBody
	public AjaxJson doDel(ScOkrEntity scOkr, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		scOkr = systemService.getEntity(ScOkrEntity.class, scOkr.getId());
		message = "删除成功";
		try{
			scOkrService.delete(scOkr);
			systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
		}catch(Exception e){
			e.printStackTrace();
			message = "删除失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}
	
	/**
	 * 批量删除员工日程计划
	 * 
	 * @return
	 */
	 @RequestMapping(params = "doBatchDel")
	@ResponseBody
	public AjaxJson doBatchDel(String ids,HttpServletRequest request){
		AjaxJson j = new AjaxJson();
		message = "删除成功";
		try{
			for(String id:ids.split(",")){
				ScOkrEntity scOkr = systemService.getEntity(ScOkrEntity.class, 
				Integer.parseInt(id)
				);
				scOkrService.delete(scOkr);
				systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
			}
		}catch(Exception e){
			e.printStackTrace();
			message = "删除失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}


	/**
	 * 添加员工日程计划
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(params = "doAdd")
	@ResponseBody
	public AjaxJson doAdd(Boolean doCommit,ScOkrEntity scOkr, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		message = "操作成功";
		try{
		    
		    if(!doCommit){
		        //保存草稿
		        scOkr.setBpmStatus("3");
		    }else{
		        
		        if(scOkr.getPercent()!=null&&scOkr.getPercent()!=""){
	                //状态为已提交
	                scOkr.setBpmStatus("1");
	            }else{
	                //状态为待完成
	                scOkr.setBpmStatus("2");
	            }
		        
		    }
		    
		    
		    
		    //获取当前用户
		   TSUser user =  ResourceUtil.getSessionUserName();
		   scOkr.setUserId(user.getId());
		   String orgCode = user.getCurrentDepart().getOrgCode();
		   scOkr.setSysOrgCode(orgCode);
		   scOkr.setSysCompanyCode("A05");
		   if(null == scOkr.getFinishTime() || scOkr.getFinishTime().length() == 0) {
			   scOkr.setFinishTime(null);
		   }
		    scOkr.setCreateDate(DateUtils.formatDate(new Date(), "yyyy-MM-dd HH:mm:ss"));
			scOkrService.save(scOkr);
			systemService.addLog(message, Globals.Log_Type_INSERT, Globals.Log_Leavel_INFO);
		}catch(Exception e){
			e.printStackTrace();
			message = "操作失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}
	
	/**
	 * 更新员工日程计划
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(params = "doUpdate")
	@ResponseBody
	public AjaxJson doUpdate(Boolean doCommit,ScOkrEntity scOkr, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		message = "操作成功";
		ScOkrEntity t = scOkrService.get(ScOkrEntity.class, scOkr.getId());
		try {
			MyBeanUtils.copyBeanNotNull2Bean(scOkr, t);
			
			
			  if(!doCommit){
	                //保存草稿
	                t.setBpmStatus("3");
	            }else{
	                
	                if(t.getPercent()!=null&&t.getPercent()!=""){
	                    //状态为已提交
	                    t.setBpmStatus("1");
	                }else{
	                    //状态为待完成
	                    t.setBpmStatus("2");
	                }
	                
	            }
			  //解决Data truncation: Incorrect datetime value: '' for column 'finish_time'
	            if("".equals(t.getFinishTime())){
	                t.setFinishTime(null);
	            }
		
			  //获取当前用户
	           TSUser user =  ResourceUtil.getSessionUserName();
	           t.setUserId(user.getId());
			scOkrService.saveOrUpdate(t);
			systemService.addLog(message, Globals.Log_Type_UPDATE, Globals.Log_Leavel_INFO);
		} catch (Exception e) {
			e.printStackTrace();
			message = "操作失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}
	
	
	
	
	
	/**
	 * 员工日程计划新增页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "goAdd")
	public ModelAndView goAdd(ScOkrEntity scOkr, HttpServletRequest req) {
		if (StringUtil.isNotEmpty(scOkr.getId())) {
			scOkr = scOkrService.getEntity(ScOkrEntity.class, scOkr.getId());
			req.setAttribute("scOkrPage", scOkr);
		}
		return new ModelAndView("com/jeecg/scokr/scOkr-add");
	}
	/**
	 * 员工日程计划编辑页面跳转
	 * 
	 * @return
	 * @throws ParseException 
	 */
	@RequestMapping(params = "goUpdate")
	public ModelAndView goUpdate(ScOkrEntity scOkr, HttpServletRequest req) throws ParseException {
		if (StringUtil.isNotEmpty(scOkr.getId())) {
			
			scOkr = scOkrService.getEntity(ScOkrEntity.class, scOkr.getId());
			
			scOkr.setPlanTime(DateUtils.dateformat(scOkr.getPlanTime(), "yyyy-MM-dd"));
			
			if(scOkr.getFinishTime()!=null){
				
				scOkr.setFinishTime(DateUtils.dateformat(scOkr.getFinishTime(), "yyyy-MM-dd"));
			}
			
			scOkr.setUpdateDate(new Date());
			req.setAttribute("scOkrPage", scOkr);
		}
		return new ModelAndView("com/jeecg/scokr/scOkr-update");
	}
	
	
	
	/**
     * 员工日程计划编辑2页面跳转
     * 
     * @return
     * @throws ParseException 
     */
    @RequestMapping(params = "goUpdate2")
    public ModelAndView goUpdate2(ScOkrEntity scOkr, HttpServletRequest req) throws ParseException {
        if (StringUtil.isNotEmpty(scOkr.getId())) {
            
            scOkr = scOkrService.getEntity(ScOkrEntity.class, scOkr.getId());
            
            scOkr.setPlanTime(DateUtils.dateformat(scOkr.getPlanTime(), "yyyy-MM-dd"));
            
            if(scOkr.getFinishTime()!=null){
                
                scOkr.setFinishTime(DateUtils.dateformat(scOkr.getFinishTime(), "yyyy-MM-dd"));
            }
            
            scOkr.setUpdateDate(new Date());
            req.setAttribute("scOkrPage", scOkr);
        }
        return new ModelAndView("com/jeecg/scokr/scOkr-update2");
    }
    
	
	
	
	
	
	
	/**
	 * 员工日程计划详情页面跳转
	 * 
	 * @return
	 * @throws ParseException 
	 */
	@RequestMapping(params = "goDetail")
	public ModelAndView goDetail(ScOkrEntity scOkr, HttpServletRequest req) throws ParseException {
		if (StringUtil.isNotEmpty(scOkr.getId())) {
			
			scOkr = scOkrService.getEntity(ScOkrEntity.class, scOkr.getId());
			
			scOkr.setPlanTime(DateUtils.dateformat(scOkr.getPlanTime(), "yyyy-MM-dd"));
			
			if(scOkr.getFinishTime()!=null){
				
				scOkr.setFinishTime(DateUtils.dateformat(scOkr.getFinishTime(), "yyyy-MM-dd"));
			}
			
			scOkr.setUpdateDate(new Date());
			req.setAttribute("scOkrPage", scOkr);
		}
		return new ModelAndView("com/jeecg/scokr/scOkr-detail");
	}
	
	
	
	
	
	
	
	
	/**
	 * 导入功能跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "upload")
	public ModelAndView upload(HttpServletRequest req) {
		req.setAttribute("controller_name","scOkrController");
		return new ModelAndView("common/upload/pub_excel_upload");
	}
	
	/**
	 * 导出excel
	 * 
	 * @param request
	 * @param response
	 */
	@RequestMapping(params = "exportXls")
	public String exportXls(ScOkrEntity scOkr,HttpServletRequest request,HttpServletResponse response
			, DataGrid dataGrid,ModelMap modelMap) {
		
		
		CriteriaQuery cq = new CriteriaQuery(ScOkrEntity.class, dataGrid);
		cq.addOrder("userId",SortDirection.desc );
		cq.notEq("bpmStatus", "3");

		TSUser u = ResourceUtil.getSessionUserName();
		//获取角色id
		List<TSRoleUser> sRoleUser = systemService.findByProperty(TSRoleUser.class,"TSUser.id", u.getId());
		if(sRoleUser.get(0).getTSRole().getId().equals("8a8ab0b246dc81120146dc81818b0051")){
		    scOkr.setUserId(u.getId());
		}
		org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, scOkr, request.getParameterMap());
		cq.add();
		
		List<ScOkrEntity> scOkrs = this.scOkrService.getListByCriteriaQuery(cq,false);
		
		
		modelMap.put(NormalExcelConstants.FILE_NAME,"江苏速度信息科技OKR-"+"成果转换组-"+DateUtils.formatDate(new Date(), "yyyy-MM-dd"));
		modelMap.put(NormalExcelConstants.CLASS,ScOkrEntity.class);
		modelMap.put(NormalExcelConstants.PARAMS,new ExportParams("员工日程计划列表", "导出人:"+ResourceUtil.getSessionUserName().getRealName(),
			"导出信息"));
		modelMap.put(NormalExcelConstants.DATA_LIST,scOkrs);
		return NormalExcelConstants.JEECG_EXCEL_VIEW;
	}
	/**
	 * 导出excel 使模板
	 * 
	 * @param request
	 * @param response
	 */
	@RequestMapping(params = "exportXlsByT")
	public String exportXlsByT(ScOkrEntity scOkr,HttpServletRequest request,HttpServletResponse response
			, DataGrid dataGrid,ModelMap modelMap) {
    	modelMap.put(NormalExcelConstants.FILE_NAME,"员工日程计划");
    	modelMap.put(NormalExcelConstants.CLASS,ScOkrEntity.class);
    	modelMap.put(NormalExcelConstants.PARAMS,new ExportParams("员工日程计划列表", "导出人:"+ResourceUtil.getSessionUserName().getRealName(),
    	"导出信息"));
    	modelMap.put(NormalExcelConstants.DATA_LIST,new ArrayList());
    	return NormalExcelConstants.JEECG_EXCEL_VIEW;
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(params = "importExcel", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson importExcel(HttpServletRequest request, HttpServletResponse response) {
		AjaxJson j = new AjaxJson();
		
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
		for (Map.Entry<String, MultipartFile> entity : fileMap.entrySet()) {
			MultipartFile file = entity.getValue();// 获取上传文件对象
			ImportParams params = new ImportParams();
			params.setTitleRows(2);
			params.setHeadRows(1);
			params.setNeedSave(true);
			try {
				List<ScOkrEntity> listScOkrEntitys = ExcelImportUtil.importExcel(file.getInputStream(),ScOkrEntity.class,params);
				for (ScOkrEntity scOkr : listScOkrEntitys) {
					scOkrService.save(scOkr);
				}
				j.setMsg("文件导入成功！");
			} catch (Exception e) {
				j.setMsg("文件导入失败！");
				logger.error(ExceptionUtil.getExceptionMessage(e));
			}finally{
				try {
					file.getInputStream().close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return j;
	}
	
	@RequestMapping(method = RequestMethod.GET)
	@ResponseBody
	public List<ScOkrEntity> list() {
		List<ScOkrEntity> listScOkrs=scOkrService.getList(ScOkrEntity.class);
		return listScOkrs;
	}
	
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	@ResponseBody
	public ResponseEntity<?> get(@PathVariable("id") String id) {
		ScOkrEntity task = scOkrService.get(ScOkrEntity.class, id);
		if (task == null) {
			return new ResponseEntity(HttpStatus.NOT_FOUND);
		}
		return new ResponseEntity(task, HttpStatus.OK);
	}

	@RequestMapping(method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<?> create(@RequestBody ScOkrEntity scOkr, UriComponentsBuilder uriBuilder) {
		//调用JSR303 Bean Validator进行校验，如果出错返回含400错误码及json格式的错误信息.
		Set<ConstraintViolation<ScOkrEntity>> failures = validator.validate(scOkr);
		if (!failures.isEmpty()) {
			return new ResponseEntity(BeanValidators.extractPropertyAndMessage(failures), HttpStatus.BAD_REQUEST);
		}

		//保存
		scOkrService.save(scOkr);

		//按照Restful风格约定，创建指向新任务的url, 也可以直接返回id或对象.
		Integer id = scOkr.getId();
		URI uri = uriBuilder.path("/rest/scOkrController/" + id).build().toUri();
		HttpHeaders headers = new HttpHeaders();
		headers.setLocation(uri);

		return new ResponseEntity(headers, HttpStatus.CREATED);
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.PUT, consumes = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<?> update(@RequestBody ScOkrEntity scOkr) {
		//调用JSR303 Bean Validator进行校验，如果出错返回含400错误码及json格式的错误信息.
		Set<ConstraintViolation<ScOkrEntity>> failures = validator.validate(scOkr);
		if (!failures.isEmpty()) {
			return new ResponseEntity(BeanValidators.extractPropertyAndMessage(failures), HttpStatus.BAD_REQUEST);
		}

		//保存
		scOkrService.saveOrUpdate(scOkr);

		//按Restful约定，返回204状态码, 无内容. 也可以返回200状态码.
		return new ResponseEntity(HttpStatus.NO_CONTENT);
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
	@ResponseStatus(HttpStatus.NO_CONTENT)
	public void delete(@PathVariable("id") String id) {
		scOkrService.deleteEntityById(ScOkrEntity.class, id);
	}
}
