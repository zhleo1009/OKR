package com.jeecg.project.controller;
import java.io.IOException;
import java.net.URI;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolation;
import javax.validation.Validator;

import org.apache.log4j.Logger;
import org.jeecgframework.core.beanvalidator.BeanValidators;
import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.common.exception.BusinessException;
import org.jeecgframework.core.common.hibernate.qbc.CriteriaQuery;
import org.jeecgframework.core.common.model.json.AjaxJson;
import org.jeecgframework.core.common.model.json.ComboBox;
import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.constant.Globals;
import org.jeecgframework.core.util.ExceptionUtil;
import org.jeecgframework.core.util.MyBeanUtils;
import org.jeecgframework.core.util.ResourceUtil;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.poi.excel.ExcelImportUtil;
import org.jeecgframework.poi.excel.entity.ExportParams;
import org.jeecgframework.poi.excel.entity.ImportParams;
import org.jeecgframework.poi.excel.entity.vo.NormalExcelConstants;
import org.jeecgframework.tag.core.easyui.TagUtil;
import org.jeecgframework.web.system.pojo.base.TSDepart;
import org.jeecgframework.web.system.pojo.base.TSRole;
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
import com.jeecg.project.service.ProjectServiceI;
import com.jeecg.scworkinghours.service.ScWorkingHoursServiceI;

/**   
 * @Title: Controller
 * @Description: 项目管理
 * @author onlineGenerator
 * @date 2016-11-23 17:42:02
 * @version V1.0   
 *
 */
@Scope("prototype")
@Controller
@RequestMapping("/projectController")
public class ProjectController extends BaseController {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(ProjectController.class);

	@Autowired
	private ProjectServiceI projectService;
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
	
	
	
	//
	 @RequestMapping(params = "getCombobox")
	 @ResponseBody
	public   List<ProjectEntity>   getCombobox()  
	{  
	     TSUser user = ResourceUtil.getSessionUserName();
	     String id = user.getCurrentDepart().getId();
	     
	    
	    List<ProjectEntity> list = null;
	    //根据登陆者不同 返回的LIST是不一样的.经理级别高.就越过部门限制
	    if("A05".equals(user.getCurrentDepart().getOrgCode())){
	        list = projectService.findByProperty(ProjectEntity.class, "deleteStatus", 0);
	        
           }
	    else{
	        list = projectService.findListbySql("select * from project where org='"+id+"' and delete_status=0");
	      
	    }
	
	    return  list;  
	}  
	
	
	
	   
    /**
     * 更新项目管理
     * 
     * @param ids
     * @return
     */
    @RequestMapping(params = "getNameById")
    @ResponseBody
    public AjaxJson getNameById(ProjectEntity project, HttpServletRequest request) {
        AjaxJson j = new AjaxJson();
        ProjectEntity t = projectService.get(ProjectEntity.class, project.getId());
        try {
            j.setMsg(t.getProjectName());
        } catch (Exception e) {
            e.printStackTrace();
            throw new BusinessException(e.getMessage());
        }
        return j;
    }
	


	/**
	 * 项目管理列表 页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "list")
	public ModelAndView list(HttpServletRequest request) {
		return new ModelAndView("com/jeecg/project/projectList");
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
	public void datagrid(ProjectEntity project,HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
		CriteriaQuery cq = new CriteriaQuery(ProjectEntity.class, dataGrid);
		//查询条件组装器
		TSUser user = ResourceUtil.getSessionUserName();
        String id = user.getCurrentDepart().getId();
         //情况1:普通人员只能看到所在组的项目.
        //select * from project where org = 4028879058cc71d30158cc7970dc0005;
        project.setOrg(id);
        project.setDeleteStatus(0);
        //情况2:研发组领导A05,需要看到所有项目数据.4028879058cc71d30158cc7970dc0005
        //(1)  select * from project where org= id1 or org = id2.
           //即 select * from project;
        if("A05".equals(user.getCurrentDepart().getOrgCode())){
            project.setOrg(null);
        }
        
        
		org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, project, request.getParameterMap());
		
		try{
		    
		//自定义追加查询条件
		}catch (Exception e) {
			throw new BusinessException(e.getMessage());
		}
		cq.add();
		this.projectService.getDataGridReturn(cq, true);
		TagUtil.datagrid(response, dataGrid);
	}
	
	@Autowired
	private ScWorkingHoursServiceI scWorkingHoursService;

	/**
	 * 删除项目管理
	 * 
	 * @return
	 */
	@RequestMapping(params = "doDel")
	@ResponseBody
	public AjaxJson doDel(ProjectEntity project, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		project = systemService.getEntity(ProjectEntity.class, project.getId());
		message = "项目管理删除成功";
		ProjectEntity del = projectService.get(ProjectEntity.class, project.getId());
		try{
		    //删除改为软删除
		    MyBeanUtils.copyBeanNotNull2Bean(project, del);
		    del.setDeleteStatus(1);
			// projectService.delete(project);
			projectService.saveOrUpdate(del);
			//
			if(StringUtil.isNotEmpty(project.getId())){
			    
			    scWorkingHoursService.executeSql("UPDATE sc_working_hours SET DELETE_STATUS= 1 where project_id  = '"+project.getId()+"'");
			}
			systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
		}catch(Exception e){
			e.printStackTrace();
			message = "项目管理删除失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}
	
	/**
	 * 批量删除项目管理
	 * 
	 * @return
	 */
	 @RequestMapping(params = "doBatchDel")
	@ResponseBody
	public AjaxJson doBatchDel(String ids,HttpServletRequest request){
		AjaxJson j = new AjaxJson();
		message = "项目管理删除成功";
		try{
			for(String id:ids.split(",")){
				ProjectEntity project = systemService.getEntity(ProjectEntity.class, 
				id
				);
				project.setDeleteStatus(1);
				projectService.saveOrUpdate(project);
				//projectService.delete(project);
			    if(StringUtil.isNotEmpty(project.getId())){
			        
			        scWorkingHoursService.executeSql("UPDATE sc_working_hours SET DELETE_STATUS= 1 where project_id  = '"+project.getId()+"'");
			    }
		            
			}
		}catch(Exception e){
			e.printStackTrace();
			message = "项目管理删除失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}


	/**
	 * 添加项目管理
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(params = "doAdd")
	@ResponseBody
	public AjaxJson doAdd(ProjectEntity project, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		message = "项目管理添加成功";
		try{
		    project.setCreateTime(new Date());
		    project.setDeleteStatus(0);
			projectService.save(project);
		}catch(Exception e){
			e.printStackTrace();
			message = "项目管理添加失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}
	
	/**
	 * 更新项目管理
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(params = "doUpdate")
	@ResponseBody
	public AjaxJson doUpdate(ProjectEntity project, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		message = "项目管理更新成功";
		ProjectEntity t = projectService.get(ProjectEntity.class, project.getId());
		try {
			MyBeanUtils.copyBeanNotNull2Bean(project, t);
			t.setCreateTime(new Date());
			projectService.saveOrUpdate(t);
		} catch (Exception e) {
			e.printStackTrace();
			message = "项目管理更新失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}
	

	/**
	 * 项目管理新增页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "goAdd")
	public ModelAndView goAdd(ProjectEntity project, HttpServletRequest req) {
		if (StringUtil.isNotEmpty(project.getId())) {
			project = projectService.getEntity(ProjectEntity.class, project.getId());
			req.setAttribute("projectPage", project);
		}
		return new ModelAndView("com/jeecg/project/project-add");
	}
	/**
	 * 项目管理编辑页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "goUpdate")
	public ModelAndView goUpdate(ProjectEntity project, HttpServletRequest req) {
		if (StringUtil.isNotEmpty(project.getId())) {
			project = projectService.getEntity(ProjectEntity.class, project.getId());
			req.setAttribute("projectPage", project);
		}
		return new ModelAndView("com/jeecg/project/project-update");
	}
	
	/**
     * 项目管理详情页面跳转
     * 
     * @return
     */
    @RequestMapping(params = "goDetail")
    public ModelAndView goDetail(ProjectEntity project, HttpServletRequest req) {
        if (StringUtil.isNotEmpty(project.getId())) {
            project = projectService.getEntity(ProjectEntity.class, project.getId());
            req.setAttribute("projectPage", project);
        }
        return new ModelAndView("com/jeecg/project/project-detail");
    }
	
	
	
	/**
	 * 导入功能跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "upload")
	public ModelAndView upload(HttpServletRequest req) {
		req.setAttribute("controller_name","projectController");
		return new ModelAndView("common/upload/pub_excel_upload");
	}
	
	/**
	 * 导出excel
	 * 
	 * @param request
	 * @param response
	 */
	@RequestMapping(params = "exportXls")
	public String exportXls(ProjectEntity project,HttpServletRequest request,HttpServletResponse response
			, DataGrid dataGrid,ModelMap modelMap) {
		CriteriaQuery cq = new CriteriaQuery(ProjectEntity.class, dataGrid);
		project.setDeleteStatus(0);
		org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, project, request.getParameterMap());
		List<ProjectEntity> projects = this.projectService.getListByCriteriaQuery(cq,false);
		 
		// 导出excel 将departId转换成departname
        for (ProjectEntity projectEntity : projects)
        {
            String departId = projectEntity.getOrg();
            TSDepart depart = systemService.get(TSDepart.class, departId);
            if(depart != null){
                projectEntity.setOrg(depart.getDepartname());
            }
        }
        
		modelMap.put(NormalExcelConstants.FILE_NAME,"项目管理");
		modelMap.put(NormalExcelConstants.CLASS,ProjectEntity.class);
		modelMap.put(NormalExcelConstants.PARAMS,new ExportParams("项目管理列表", "导出人:"+ResourceUtil.getSessionUserName().getRealName(),
			"导出信息"));
		modelMap.put(NormalExcelConstants.DATA_LIST,projects);
		return NormalExcelConstants.JEECG_EXCEL_VIEW;
	}
	/**
	 * 导出excel 使模板
	 * 
	 * @param request
	 * @param response
	 */
	@RequestMapping(params = "exportXlsByT")
	public String exportXlsByT(ProjectEntity project,HttpServletRequest request,HttpServletResponse response
			, DataGrid dataGrid,ModelMap modelMap) {
    	modelMap.put(NormalExcelConstants.FILE_NAME,"项目管理");
    	modelMap.put(NormalExcelConstants.CLASS,ProjectEntity.class);
    	modelMap.put(NormalExcelConstants.PARAMS,new ExportParams("项目管理列表", "导出人:"+ResourceUtil.getSessionUserName().getRealName(),
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
				List<ProjectEntity> listProjectEntitys = ExcelImportUtil.importExcel(file.getInputStream(),ProjectEntity.class,params);
				for (ProjectEntity project : listProjectEntitys) {
					projectService.save(project);
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
	public List<ProjectEntity> list() {
		List<ProjectEntity> listProjects=projectService.getList(ProjectEntity.class);
		return listProjects;
	}
	
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	@ResponseBody
	public ResponseEntity<?> get(@PathVariable("id") String id) {
		ProjectEntity task = projectService.get(ProjectEntity.class, id);
		if (task == null) {
			return new ResponseEntity(HttpStatus.NOT_FOUND);
		}
		return new ResponseEntity(task, HttpStatus.OK);
	}

	@RequestMapping(method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<?> create(@RequestBody ProjectEntity project, UriComponentsBuilder uriBuilder) {
		//调用JSR303 Bean Validator进行校验，如果出错返回含400错误码及json格式的错误信息.
		Set<ConstraintViolation<ProjectEntity>> failures = validator.validate(project);
		if (!failures.isEmpty()) {
			return new ResponseEntity(BeanValidators.extractPropertyAndMessage(failures), HttpStatus.BAD_REQUEST);
		}

		//保存
		projectService.save(project);

		//按照Restful风格约定，创建指向新任务的url, 也可以直接返回id或对象.
		String id = project.getId();
		URI uri = uriBuilder.path("/rest/projectController/" + id).build().toUri();
		HttpHeaders headers = new HttpHeaders();
		headers.setLocation(uri);

		return new ResponseEntity(headers, HttpStatus.CREATED);
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.PUT, consumes = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<?> update(@RequestBody ProjectEntity project) {
		//调用JSR303 Bean Validator进行校验，如果出错返回含400错误码及json格式的错误信息.
		Set<ConstraintViolation<ProjectEntity>> failures = validator.validate(project);
		if (!failures.isEmpty()) {
			return new ResponseEntity(BeanValidators.extractPropertyAndMessage(failures), HttpStatus.BAD_REQUEST);
		}

		//保存
		projectService.saveOrUpdate(project);

		//按Restful约定，返回204状态码, 无内容. 也可以返回200状态码.
		return new ResponseEntity(HttpStatus.NO_CONTENT);
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
	@ResponseStatus(HttpStatus.NO_CONTENT)
	public void delete(@PathVariable("id") String id) {
		projectService.deleteEntityById(ProjectEntity.class, id);
	}
	
	
	   /**
     * 选择项目跳转页面
     *
     * @return
     */
    @RequestMapping(params = "projectSelect")
    public String projectSelect() {
        return "com/jeecg/project/projectSelect";
    }
    
}
