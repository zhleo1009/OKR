package com.jeecg.scworkinghours.controller;


import java.io.IOException;
import java.net.URI;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolation;
import javax.validation.Validator;

import org.apache.commons.collections.CollectionUtils;
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
import com.jeecg.project.service.ProjectServiceI;
import com.jeecg.scworkinghours.entity.FullCalendarEventDto;
import com.jeecg.scworkinghours.entity.ScWorkingHoursEntity;
import com.jeecg.scworkinghours.entity.ScWorkingHoursEntityPage;
import com.jeecg.scworkinghours.service.ScWorkingHoursServiceI;


/**
 * @Title: Controller
 * @Description: 项目工时表
 * @author onlineGenerator
 * @date 2016-11-23 17:42:30
 * @version V1.0
 */
@Scope("prototype")
@Controller
@RequestMapping("/scWorkingHoursController")
public class ScWorkingHoursController extends BaseController
{
    /**
     * Logger for this class
     */
    private static final Logger logger = Logger.getLogger(ScWorkingHoursController.class);

    @Autowired
    private ScWorkingHoursServiceI scWorkingHoursService;

    @Autowired
    private ProjectServiceI projectService;

    @Autowired
    private SystemService systemService;

    @Autowired
    private Validator validator;

    private String message;

    public String getMessage()
    {
        return message;
    }

    public void setMessage(String message)
    {
        this.message = message;
    }

    @RequestMapping(params = "getEvent")
    @ResponseBody
    public AjaxJson getEvent(ScWorkingHoursEntity attendanceData, HttpServletRequest request,
                             DataGrid dataGrid)
    {

        AjaxJson j = new AjaxJson();
        String message = "获取event信息成功";
        try
        {
            attendanceData.setDeleteStatus(0);
            Date startDate = DateUtils.parseDate(request.getParameter("start"), "yyyy-MM-dd");
            Date endDate = DateUtils.parseDate(request.getParameter("end"), "yyyy-MM-dd");
            CriteriaQuery cq = new CriteriaQuery(ScWorkingHoursEntity.class, dataGrid);
            // 查询条件组装器
            org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq,
                attendanceData);

            cq.ge("workingDate", startDate);
            cq.lt("workingDate", endDate);
            Map<String, Object> orderMap = new HashMap<String, Object>();
            orderMap.put("workingDate", SortDirection.asc);
            cq.setOrder(orderMap);
            cq.add();

            List<ScWorkingHoursEntity> results = this.scWorkingHoursService.getListByCriteriaQuery(
                cq, false);

            List<FullCalendarEventDto> events = new ArrayList<FullCalendarEventDto>();
            FullCalendarEventDto fullCalendarDto = null;
            for (ScWorkingHoursEntity attendanceDataEntity : results)
            {

                fullCalendarDto = new FullCalendarEventDto();
                String attendDateStr = DateUtils.formatDate(attendanceDataEntity.getWorkingDate(),
                    "yyyy-MM-dd");
                fullCalendarDto.setId("" + attendanceDataEntity.getId());
                fullCalendarDto.setStart(attendDateStr);

                if (StringUtils.isNotBlank(attendanceDataEntity.getUserId()))
                {
                    TSUser user = systemService.getEntity(TSUser.class,
                        attendanceDataEntity.getUserId());
                    if (null != user)
                    {
                        fullCalendarDto.setTitle(user.getRealName());
                    }
                }

                ProjectEntity proj = projectService.getEntity(ProjectEntity.class,
                    attendanceDataEntity.getProjectId());
                if (null != proj)
                {

                    if (StringUtil.isNotEmpty(fullCalendarDto.getTitle())) ;
                    fullCalendarDto.setTitle(
                        fullCalendarDto.getTitle() + ":" + proj.getProjectName() + "\n用时："
                                             + attendanceDataEntity.getWorkingHours() + "工时");

                    fullCalendarDto.setContent(
                        proj.getProjectName() + "，用时：" + attendanceDataEntity.getWorkingHours());

                }

                fullCalendarDto.setColor("#00A65A");

                events.add(fullCalendarDto);

            }

            j.setObj(events);

        }
        catch (Exception e)
        {
            message = "获取event信息失败";
            e.printStackTrace();
            j.setSuccess(false);
        }
        j.setMsg(message);
        return j;
    }

    /**
     * 项目工时表列表 页面跳转
     * 
     * @return
     */
    @RequestMapping(params = "calendarList")
    public ModelAndView calendarList(HttpServletRequest request)
    {
        return new ModelAndView("com/jeecg/scworkinghours/scWorkingHoursList-calendar");
    }

    /**
     * 项目工时表列表 页面跳转
     * 
     * @return
     */
    @RequestMapping(params = "myweeklist")
    public ModelAndView myweeklist(HttpServletRequest request)
    {
        ModelAndView mv = new ModelAndView("com/jeecg/scworkinghours/scWorkingHoursList-myweek");
        List<ProjectEntity> pList = projectService.getList(ProjectEntity.class);
        mv.addObject("project", pList);
        List<TSUser> userList = systemService.getList(TSUser.class);
        mv.addObject("userList", userList);
        return mv;
    }

    /**
     * easyui AJAX请求数据
     * 
     * @param begintime
     *            开始时间
     * @param endtime
     *            结束时间
     */
    @RequestMapping(params = "datagridMyWeek")
    public void datagridMyWeek(DataGrid dataGrid, ScWorkingHoursEntity scWorkingHours,
                               HttpServletRequest request, HttpServletResponse response)
    {
        // 查询条件组装器
        try
        {
            TSUser u = ResourceUtil.getSessionUserName();
            scWorkingHours.setUserId(u.getId());
            scWorkingHours.setDeleteStatus(0);

            String beginDate = request.getParameter("begintime");

            String endDate = request.getParameter("endtime");

            // cal.add(Calendar.DAY_OF_WEEK,2);

            if (StringUtils.isBlank(beginDate) || StringUtils.isBlank(endDate))
            {
                beginDate = DateUtils.date_sdf.format(DateUtils.getWeekStartDate());
                endDate = DateUtils.date_sdf.format(DateUtils.getWeekEndDate());
            }

            /*
             * SELECT * FROM T_Employee WHERE FNumber BETWEEN 'DEV001' AND 'DEV008' AND FName LIKE
             * '%J%' AND FSalary BETWEEN 3000 AND 6000
             */
            String countSql = "select count(1) from (select * from sc_working_hours where  working_date between '"
                              + beginDate + "' and '" + endDate + "'  AND delete_Status = 0 ";
            if (StringUtil.isNotEmpty(scWorkingHours.getProjectId()))
            {
                countSql = countSql + " and project_id='" + scWorkingHours.getProjectId() + "'";
            }
            if (StringUtil.isNotEmpty(scWorkingHours.getUserId()))
            {
                countSql = countSql + " and user_id='" + scWorkingHours.getUserId() + "'";
            }
            countSql = countSql + " GROUP BY project_id,user_id) aa";
            Long total = scWorkingHoursService.getCountForJdbc(countSql);

            // 1.group by 根据project_id和user_id分页展示列表。
            String topSql = "select id as id,project_id as projectId,user_id as userId from sc_working_hours where working_date between '"
                            + beginDate + "' and '" + endDate + "'  AND delete_Status = 0 ";
            if (StringUtil.isNotEmpty(scWorkingHours.getProjectId()))
            {
                topSql = topSql + " and project_id='" + scWorkingHours.getProjectId() + "'";
            }
            if (StringUtil.isNotEmpty(scWorkingHours.getUserId()))
            {
                topSql = topSql + " and user_id='" + scWorkingHours.getUserId() + "'";
            }
            topSql += " GROUP BY project_id,user_id";
            List<ScWorkingHoursEntity> topList = scWorkingHoursService.findObjForJdbc(topSql,
                dataGrid.getPage(), dataGrid.getRows(), ScWorkingHoursEntity.class);

            if (null != topList && topList.size() > 0)
            {
                for (ScWorkingHoursEntity sc : topList)
                {
                    // TODO 2.根据project_id和user_id和开始时间结束时间查询工时列表(4个参数，注意类型转换)
                    String childSql = "select id as id,project_id as projectId,user_id as userId,working_Date AS workingDate ,working_Hours AS workingHours,note AS note  from sc_working_hours where working_date between '"
                                      + beginDate + "' and '" + endDate + "' and project_id ='"
                                      + sc.getProjectId()
                                      + "'  AND delete_Status = 0  and user_id = '"
                                      + sc.getUserId() + "'";
                    List<Object[]> childList = scWorkingHoursService.findListbySql(childSql);

                    if (null != childList && childList.size() > 0)
                    {
                        for (Object[] child : childList)
                        {
                            // 判断时间是星期几
                            Date time = DateUtils.parseDate(child[3].toString(), "yyyy-MM-dd");

                            String week = DateUtils.getWeekOfDate(time);
                            if ("星期一".equals(week))
                            {
                                if (null != child[4])
                                    sc.setWorkingHours1(child[4].toString());

                            }
                            else if ("星期二".equals(week))
                            {
                                if (null != child[4])
                                    sc.setWorkingHours2(child[4].toString());

                            }
                            else if ("星期三".equals(week))
                            {
                                // 这个空了 我怎么判断?
                                if (null != child[4])
                                    sc.setWorkingHours3(child[4].toString());
                            }
                            else if ("星期四".equals(week))
                            {
                                if (null != child[4])
                                    sc.setWorkingHours4(child[4].toString());

                            }
                            else if ("星期五".equals(week))
                            {
                                if (null != child[4])
                                    sc.setWorkingHours5(child[4].toString());

                            }
                            else if ("星期六".equals(week))
                            {
                                if (null != child[4])
                                    sc.setWorkingHours6(child[4].toString());
                            }
                            else if ("星期日".equals(week))
                            {
                                if (null != child[4])
                                    sc.setWorkingHours7(child[4].toString());
                            }
                        }
                    }
                }
            }
            // 这里是结果集装载
            dataGrid.setResults(topList);
            dataGrid.setTotal(total.intValue());

        }
        catch (Exception e)
        {
            e.printStackTrace();
            throw new BusinessException(e.getMessage());
        }

        TagUtil.printWriterJson(response, dataGrid);
    }

    /**
     * 项目工时表列表 页面跳转
     * 
     * @return
     */
    @RequestMapping(params = "weeklist")
    public ModelAndView weeklist(HttpServletRequest request)
    {

        ModelAndView mv = new ModelAndView("com/jeecg/scworkinghours/scWorkingHoursList-week");
        // List<ProjectEntity> projectList = projectService.findListbySql("SELECT id,project_name
        // as projectName from project ");
        List<ProjectEntity> projectList = projectService.getList(ProjectEntity.class);
        mv.addObject("project", projectList);
        List<TSUser> userList = systemService.getList(TSUser.class);
        mv.addObject("userList", userList);
        return mv;
    }

    /**
     * easyui AJAX请求数据 需要某个人只能访问他自己所在组织机构所管理的项目的工时。 使用SQL拼接。 注意：
     * 1.在新增项目信息时，需绑定具体机构。一个机构可以绑定多个项目。机构-项目为一对多关系。 2.机构信息参照TSDepart.java实体类。其中orgcode为其唯一索引。
     * 3.该方法功能流程为。获取当前用户ID，再根据用户ID取得TSDepart所在机构信息，得到orgcode。 TSUser user =
     * ResourceUtil.getSessionUserName(); String orgCode =
     * user.getCurrentDepart().getOrgCode();//此方法待测试。观察是否可以正确获取？
     * 4.projectServce层，需要提供根据部门机构CODE查询所参与的项目方法。例如 public List<ProjectEntity>
     * queryListByOrgCode(String orgcode){return list} 5.sql语法： select * from sc_working_hours
     * where projectId exists (projectId1,projectId2,projectId3...) and parm =...
     * 
     * @param request
     * @param response
     * @param dataGrid
     * @param user
     */
    @RequestMapping(params = "datagridWeekz")
    public void datagridWeekz(DataGrid dataGrid, ScWorkingHoursEntity scWorkingHours,
                              HttpServletRequest request, HttpServletResponse response)
    {
        // 查询条件组装器
        try
        {

            TSUser user = ResourceUtil.getSessionUserName();
            String id = user.getCurrentDepart().getId();
            scWorkingHours.setUserId(user.getId());
            scWorkingHours.setDeleteStatus(0);

            List<ProjectEntity> listPro = projectService.findByProperty(ProjectEntity.class, "org",
                id);
            String ids = "";
            if (null != listPro && listPro.size() > 0)
            {
                for (ProjectEntity p : listPro)
                {
                    ids += "'" + p.getId() + "',";
                }

                if (StringUtil.isNotEmpty(ids))
                {
                    ids = ids.substring(0, ids.length() - 1);
                }

            }
            // if(!"A05".equals(user.getCurrentDepart().getOrgCode())){
            // dataGrid.setResults(new ArrayList<ScWorkingHoursEntity>());
            // dataGrid.setTotal(0);
            // TagUtil.printWriterJson(response, dataGrid);
            // return;
            // }

            String beginDate = request.getParameter("begintime");

            String endDate = request.getParameter("endtime");

            // cal.add(Calendar.DAY_OF_WEEK,2);

            if (StringUtils.isBlank(beginDate) || StringUtils.isBlank(endDate))
            {
                beginDate = DateUtils.date_sdf.format(DateUtils.getWeekStartDate());
                endDate = DateUtils.date_sdf.format(DateUtils.getWeekEndDate());
            }

            /*
             * SELECT * FROM T_Employee WHERE FNumber BETWEEN 'DEV001' AND 'DEV008' AND FName LIKE
             * '%J%' AND FSalary BETWEEN 3000 AND 6000
             */
            String countSql = "select count(1) from (select * from sc_working_hours where  working_date between '"
                              + beginDate + "' and '" + endDate + "'  AND delete_Status = 0 ";
            if (StringUtil.isNotEmpty(ids))
            {
                countSql = countSql + " and project_id in (" + ids + ")";
            }
            if (StringUtil.isNotEmpty(scWorkingHours.getProjectId()))
            {
                countSql = countSql + " and project_id='" + scWorkingHours.getProjectId() + "'";
            }
            if (StringUtil.isNotEmpty(scWorkingHours.getUserId()))
            {
                countSql = countSql + " and user_id='" + scWorkingHours.getUserId() + "'";
            }
            countSql = countSql + " GROUP BY project_id,user_id) aa";
            Long total = scWorkingHoursService.getCountForJdbc(countSql);

            // 1.group by 根据project_id和user_id分页展示列表。
            String topSql = "select id as id,project_id as projectId,user_id as userId from sc_working_hours where working_date between '"
                            + beginDate + "' and '" + endDate + "'  AND delete_Status = 0  ";

            if (StringUtil.isNotEmpty(ids))
            {
                topSql = topSql + " and project_id in (" + ids + ")";
            }

            if (StringUtil.isNotEmpty(scWorkingHours.getProjectId()))
            {
                topSql = topSql + " and project_id='" + scWorkingHours.getProjectId() + "'";
            }
            if (StringUtil.isNotEmpty(scWorkingHours.getUserId()))
            {
                topSql = topSql + " and user_id='" + scWorkingHours.getUserId() + "'";
            }
            topSql += " GROUP BY project_id,user_id";
            List<ScWorkingHoursEntity> topList = scWorkingHoursService.findObjForJdbc(topSql,
                dataGrid.getPage(), dataGrid.getRows(), ScWorkingHoursEntity.class);

            if (null != topList && topList.size() > 0)
            {
                for (ScWorkingHoursEntity sc : topList)
                {
                    // TODO 2.根据project_id和user_id和开始时间结束时间查询工时列表(4个参数，注意类型转换)
                    String childSql = "select id as id,project_id as projectId,user_id as userId,working_Date AS workingDate ,working_Hours AS workingHours,note AS note  from sc_working_hours where working_date between '"
                                      + beginDate + "' and '" + endDate + "' and project_id ='"
                                      + sc.getProjectId() + "' and user_id = '" + sc.getUserId()
                                      + "'  AND delete_Status = 0 ";
                    List<Object[]> childList = scWorkingHoursService.findListbySql(childSql);

                    if (null != childList && childList.size() > 0)
                    {
                        for (Object[] child : childList)
                        {
                            weekBean(sc,child);
                        }
                    }
                }
            }
            // 这里是结果集装载
            dataGrid.setResults(topList);
            dataGrid.setTotal(total.intValue());

        }
        catch (Exception e)
        {
            e.printStackTrace();
            throw new BusinessException(e.getMessage());
        }

        TagUtil.printWriterJson(response, dataGrid);
    }

    /**
     * 项目工时表列表 页面跳转
     * 
     * @return
     */
    @RequestMapping(params = "list")
    public ModelAndView list(HttpServletRequest request)
    {
        return new ModelAndView("com/jeecg/scworkinghours/scWorkingHoursList");
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
    public void datagrid(ScWorkingHoursEntity scWorkingHours, HttpServletRequest request,
                         HttpServletResponse response, DataGrid dataGrid)
    {
        CriteriaQuery cq = new CriteriaQuery(ScWorkingHoursEntity.class, dataGrid);
        // 查询条件组装器
        TSUser user = ResourceUtil.getSessionUserName();
        scWorkingHours.setUserId(user.getId());
        scWorkingHours.setDeleteStatus(0);
        org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, scWorkingHours,
            request.getParameterMap());
        try
        {
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
        }
        catch (Exception e)
        {
            throw new BusinessException(e.getMessage());
        }
        cq.add();
        this.scWorkingHoursService.getDataGridReturn(cq, true);
        // String sql ="select sum(working_hours) as ssum from sc_working_hours where 1=1 ";
        // if(StringUtil.isNotEmpty(scWorkingHours.getProjectId())){
        // sql=sql+" and project_id='"+scWorkingHours.getProjectId()+"'";
        // }
        // if(StringUtil.isNotEmpty(scWorkingHours.getUserId())){
        // sql=sql+" and user_id='"+scWorkingHours.getUserId()+"'";
        // }
        // String total_salary = String.valueOf(systemService.findOneForJdbc(sql).get("ssum"));
        // System.out.println("合计:"+total_salary);
        // dataGrid.setFooter("workingHours:合计"+total_salary);
        //
        TagUtil.datagrid(response, dataGrid);
    }

    /**
     * 项目工时表列表 页面跳转
     * 
     * @return
     */
    @RequestMapping(params = "myList")
    public ModelAndView myList(HttpServletRequest request)
    {
        return new ModelAndView("com/jeecg/scworkinghours/scWorkingHoursList-my");
    }

    /**
     * my workinghours
     */

    @RequestMapping(params = "datagridForme")
    public void datagridForme(ScWorkingHoursEntity scWorkingHours, HttpServletRequest request,
                              HttpServletResponse response, DataGrid dataGrid)
    {
        CriteriaQuery cq = new CriteriaQuery(ScWorkingHoursEntity.class, dataGrid);

        TSUser u = ResourceUtil.getSessionUserName();
        scWorkingHours.setUserId(u.getId());
        scWorkingHours.setDeleteStatus(0);

        // 查询条件组装器
        org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, scWorkingHours,
            request.getParameterMap());
        try
        {
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

        }
        catch (Exception e)
        {
            throw new BusinessException(e.getMessage());
        }
        cq.add();
        this.scWorkingHoursService.getDataGridReturn(cq, true);
        // String sql ="select sum(working_hours) as ssum from sc_working_hours where 1=1 ";
        // if(StringUtil.isNotEmpty(scWorkingHours.getProjectId())){
        // sql=sql+" and project_id='"+scWorkingHours.getProjectId()+"'";
        // }
        // if(StringUtil.isNotEmpty(scWorkingHours.getUserId())){
        // sql=sql+" and user_id='"+scWorkingHours.getUserId()+"'";
        // }
        //
        // String total_salary = String.valueOf(systemService.findOneForJdbc(sql).get("ssum"));
        // dataGrid.setFooter("workingHours:合计"+total_salary);
        //
        TagUtil.datagrid(response, dataGrid);
    }

    /**
     * 工时填报 页面跳转
     * 
     * @return
     */
    @RequestMapping(params = "addweek")
    public ModelAndView addweek(HttpServletRequest request)
    {
        ModelAndView mv = new ModelAndView("com/jeecg/scworkinghours/scWorkingHoursList-addweek");
        List<ProjectEntity> pList =  projectService.findByProperty(ProjectEntity.class, "deleteStatus", 0);
        mv.addObject("project", pList);
       
        List<TSUser> userList = systemService.getList(TSUser.class);
        mv.addObject("userList", userList);
        TSUser user = ResourceUtil.getSessionUserName();
        mv.addObject("user", user);
        return mv;
    }

    /**
     * easyui AJAX请求数据 工时填报
     * 
     * @param begintime
     *            开始时间
     * @param endtime
     *            结束时间
     */
    @RequestMapping(params = "datagridAdd")
    public void datagridAdd(DataGrid dataGrid, ScWorkingHoursEntity scWorkingHours,
                            HttpServletRequest request, HttpServletResponse response)
    {
        // 查询条件组装器
        try
        {
            TSUser user = ResourceUtil.getSessionUserName();
            TSDepart depart = user.getCurrentDepart();
            // 当前用户只能看到自己的.
            scWorkingHours.setDeleteStatus(0);

            String beginDate = request.getParameter("begintime");

            String endDate = request.getParameter("endtime");

            if (StringUtils.isBlank(beginDate) || StringUtils.isBlank(endDate))
            {
                beginDate = DateUtils.date_sdf.format(DateUtils.getWeekStartDate());
                endDate = DateUtils.date_sdf.format(DateUtils.getWeekEndDate());
            }
            StringBuffer countSql = new StringBuffer(
                "select count(*) from sc_working_hours where  working_date between '" + beginDate
                                                     + "' and '" + endDate
                                                     + "' AND delete_Status = 0 ");

            List<TSRoleUser> sRoleUser = systemService.findByProperty(TSRoleUser.class,
                "TSUser.id", user.getId());
            String userRole = "";
            for (TSRoleUser tsRoleUser : sRoleUser)
            {
                userRole += tsRoleUser.getTSRole().getRoleCode() + ",";
            }

            // userRole 为当前用户拥有哪些角色 例如:amdin,mananger,普通员工,部门经理,以数据库为准.
            // 下面SQL 只有当他是普通员工时才加这个条件其余级别高的 都不过滤
            String ids = "";
            if ("manager,".equals(userRole))
            {
                countSql.append(" and user_id ='" + user.getId() + "' ");
            }
            else
            {
                if (userRole.contains("部门经理"))
                {

                    List<ProjectEntity> listPro = projectService.findByProperty(
                        ProjectEntity.class, "org", depart.getId());

                    if (null != listPro && listPro.size() > 0)
                    {
                        for (ProjectEntity p : listPro)
                        {
                            ids += "'" + p.getId() + "',";
                        }
                        if (StringUtil.isNotEmpty(ids))
                        {
                            ids = ids.substring(0, ids.length() - 1);
                        }
                    }
                    if (StringUtil.isNotEmpty(ids))
                    {
                        countSql.append(" and project_id in (" + ids + ")");
                    }
                }

            }

            if (StringUtil.isNotEmpty(scWorkingHours.getProjectId()))
            {
                countSql.append(" and project_id='" + scWorkingHours.getProjectId() + "' ");
            }

            Long total = scWorkingHoursService.getCountForJdbc(countSql.toString());

            
            
            //list
            StringBuffer topSql = new StringBuffer(
                "select swh.id as id,p.project_name as projectName,tsbu.realname as realName,"
                                                   + "swh.working_date as workingDate,swh.working_hours as workingHours,swh.note as note from sc_working_hours swh "
                                                   + "LEFT JOIN project p on swh.project_id=p.id LEFT JOIN t_s_base_user tsbu ON swh.user_id=tsbu.ID "
                                                   + "where  swh.working_date between '"
                                                   + beginDate + "' and '" + endDate
                                                   + "'  AND swh.delete_Status = 0  ");

            // 获取部门限制再拼接进sql
            if ("manager,".equals(userRole))
            {
                // 这里的判断为普通员工独有
                topSql.append(" and swh.user_id ='" + user.getId() + "' ");
            }
            else
            {
                if (userRole.contains("部门经理"))
                {
                    if (StringUtil.isNotEmpty(ids))
                    {
                        topSql.append(" and swh.project_id in (" + ids + ")");
                    }
                }
            }

            if (StringUtil.isNotEmpty(scWorkingHours.getProjectId()))
            {
                topSql.append(" and swh.project_id='" + scWorkingHours.getProjectId() + "'");
            }

            List<ScWorkingHoursEntity> topList = scWorkingHoursService.findObjForJdbc(
                topSql.toString(), dataGrid.getPage(), dataGrid.getRows(),
                ScWorkingHoursEntity.class);

            if (null != topList && topList.size() > 0)
            {
                for (ScWorkingHoursEntity sc : topList)
                {
                   packageBean(sc);

                }
            }
            // 这里是结果集装载
            dataGrid.setResults(topList);
            dataGrid.setTotal(total.intValue());

        }
        catch (Exception e)
        {
            e.printStackTrace();
            throw new BusinessException(e.getMessage());
        }

        TagUtil.printWriterJson(response, dataGrid);
    }
    
    
  
    
    
    
    
    
    
    
    
    
    /**
     * 删除项目工时表
     * 
     * @return
     */
    @RequestMapping(params = "doDel")
    @ResponseBody
    public AjaxJson doDel(ScWorkingHoursEntity scWorkingHours, HttpServletRequest request)
    {
        AjaxJson j = new AjaxJson();
        message = "项目工时表更新成功";
        ScWorkingHoursEntity t = scWorkingHoursService.get(ScWorkingHoursEntity.class,
            scWorkingHours.getId());
        try
        {

            MyBeanUtils.copyBeanNotNull2Bean(scWorkingHours, t);
            t.setDeleteStatus(1);
            scWorkingHoursService.saveOrUpdate(t);
        }
        catch (Exception e)
        {
            e.printStackTrace();
            message = "项目工时表更新失败";
            throw new BusinessException(e.getMessage());
        }
        j.setMsg(message);
        return j;
    }

    /**
     * 批量删除项目工时表
     * 
     * @return
     */
    @RequestMapping(params = "doBatchDel")
    @ResponseBody
    public AjaxJson doBatchDel(String ids, HttpServletRequest request)
    {
        AjaxJson j = new AjaxJson();
        message = "项目工时表删除成功";
        try
        {
            if (StringUtil.isEmpty(ids))
            {
                return j;
            }
            for (String id : ids.split(","))
            {
                ScWorkingHoursEntity scWorkingHours = systemService.getEntity(
                    ScWorkingHoursEntity.class, id);
                scWorkingHours.setDeleteStatus(1);
                scWorkingHoursService.saveOrUpdate(scWorkingHours);
                // systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
            message = "项目工时表删除失败";
            throw new BusinessException(e.getMessage());
        }
        j.setMsg(message);
        return j;
    }

    /**
     * 行 保存新增/更新的行数据
     * 
     * @param page
     * @return
     */
    @RequestMapping(params = "saveRows")
    @ResponseBody
    public AjaxJson saveRows(ScWorkingHoursEntityPage scWorkingHoursEntityPage,
                             ScWorkingHoursEntity scWorkingHours, HttpServletRequest request)
    {
        List<ScWorkingHoursEntity> scw = scWorkingHoursEntityPage.getScWorkingHours();
        AjaxJson j = new AjaxJson();
       
        if (CollectionUtils.isNotEmpty(scw))
        {
            for (ScWorkingHoursEntity ScWorking : scw)
            {
                if (StringUtil.isNotEmpty(ScWorking.getId()))
                {
                    ScWorkingHoursEntity t = scWorkingHoursService.get(ScWorkingHoursEntity.class,
                        ScWorking.getId());
                    try
                    {
                        message = "信息被更新成功";
                        MyBeanUtils.copyBeanNotNull2Bean(ScWorking, t);
                        // 插入当前用户
                        TSUser u = ResourceUtil.getSessionUserName();
                        t.setUserId(u.getId());
                        t.setDeleteStatus(0);
                        scWorkingHoursService.saveOrUpdate(t);
                    }
                    catch (Exception e)
                    {
                        e.printStackTrace();
                    }
                }
                else
                {
                    message = "信息被添加成功";
                    // 插入当前用户
                    TSUser u = ResourceUtil.getSessionUserName();
                    ScWorking.setUserId(u.getId());
                    ScWorking.setDeleteStatus(0);
                    scWorkingHoursService.save(ScWorking);
                }
            }
        }
        j.setMsg(message);
        return j;
    }
    
    
    
    
    
    
    
    
    

    /**
     * 添加项目工时表
     * 
     * @param ids
     * @return
     */
    @RequestMapping(params = "doAdd")
    @ResponseBody
    public AjaxJson doAdd(ScWorkingHoursEntity scWorkingHours, HttpServletRequest request)
    {
        AjaxJson j = new AjaxJson();
        message = "项目工时表添加成功";
        try
        {
            // 插入当前用户
            TSUser u = ResourceUtil.getSessionUserName();
            scWorkingHours.setUserId(u.getId());
            scWorkingHours.setDeleteStatus(0);
            scWorkingHoursService.save(scWorkingHours);
            systemService.addLog(message, Globals.Log_Type_INSERT, Globals.Log_Leavel_INFO);
        }
        catch (Exception e)
        {
            e.printStackTrace();
            message = "项目工时表添加失败";
            throw new BusinessException(e.getMessage());
        }
        j.setMsg(message);
        return j;
    }

    /**
     * 更新项目工时表
     * 
     * @param ids
     * @return
     */
    @RequestMapping(params = "doUpdate")
    @ResponseBody
    public AjaxJson doUpdate(ScWorkingHoursEntity scWorkingHours, HttpServletRequest request)
    {
        AjaxJson j = new AjaxJson();
        message = "项目工时表更新成功";
        ScWorkingHoursEntity t = scWorkingHoursService.get(ScWorkingHoursEntity.class,
            scWorkingHours.getId());
        try
        {

            MyBeanUtils.copyBeanNotNull2Bean(scWorkingHours, t);
            // 插入当前用户
            TSUser u = ResourceUtil.getSessionUserName();
            t.setUserId(u.getId());
            scWorkingHoursService.saveOrUpdate(t);
            // systemService.addLog(message, Globals.Log_Type_UPDATE, Globals.Log_Leavel_INFO);
        }
        catch (Exception e)
        {
            e.printStackTrace();
            message = "项目工时表更新失败";
            throw new BusinessException(e.getMessage());
        }
        j.setMsg(message);
        return j;
    }

    /**
     * 项目工时表新增页面跳转
     * 
     * @return
     */
    @RequestMapping(params = "goAdd")
    public ModelAndView goAdd(ScWorkingHoursEntity scWorkingHours, HttpServletRequest req)
    {
        if (StringUtil.isNotEmpty(scWorkingHours.getId()))
        {
            scWorkingHours = scWorkingHoursService.getEntity(ScWorkingHoursEntity.class,
                scWorkingHours.getId());
            req.setAttribute("scWorkingHoursPage", scWorkingHours);
        }
        return new ModelAndView("com/jeecg/scworkinghours/scWorkingHours-add");
    }

    /**
     * 项目工时表编辑页面跳转
     * 
     * @return
     */
    @RequestMapping(params = "goUpdate")
    public ModelAndView goUpdate(ScWorkingHoursEntity scWorkingHours, HttpServletRequest req)
    {
        if (StringUtil.isNotEmpty(scWorkingHours.getId()))
        {
            scWorkingHours = scWorkingHoursService.getEntity(ScWorkingHoursEntity.class,
                scWorkingHours.getId());
            req.setAttribute("scWorkingHoursPage", scWorkingHours);
        }
        return new ModelAndView("com/jeecg/scworkinghours/scWorkingHours-update");
    }

    /**
     * 导入功能跳转
     * 
     * @return
     */
    @RequestMapping(params = "upload")
    public ModelAndView upload(HttpServletRequest req)
    {
        req.setAttribute("controller_name", "scWorkingHoursController");
        return new ModelAndView("common/upload/pub_excel_upload");
    }

    /**
     * 导出excel
     * 
     * @param request
     * @param response
     */
    @RequestMapping(params = "exportXls")
    public String exportXls(ScWorkingHoursEntity scWorkingHours, HttpServletRequest request,
                            HttpServletResponse response, DataGrid dataGrid, ModelMap modelMap)
    {
        CriteriaQuery cq = new CriteriaQuery(ScWorkingHoursEntity.class, dataGrid);
        scWorkingHours.setDeleteStatus(0);
        org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, scWorkingHours,
            request.getParameterMap());
        List<ScWorkingHoursEntity> scWorkingHourss = this.scWorkingHoursService.getListByCriteriaQuery(
            cq, false);
        // 导出excel 将userId和projectId转换成name
        for (ScWorkingHoursEntity scWorkingHoursEntity : scWorkingHourss)
        {
            String userId = scWorkingHoursEntity.getUserId();
            TSUser user = systemService.get(TSUser.class, userId);
            if (user != null)
            {
                scWorkingHoursEntity.setUserId(user.getRealName());
            }

            String projectId = scWorkingHoursEntity.getProjectId();
            ProjectEntity project = projectService.get(ProjectEntity.class, projectId);
            if (project != null)
            {
                scWorkingHoursEntity.setProjectId(project.getProjectName());
            }
        }

        modelMap.put(NormalExcelConstants.FILE_NAME, "项目工时表");
        modelMap.put(NormalExcelConstants.CLASS, ScWorkingHoursEntity.class);
        modelMap.put(NormalExcelConstants.PARAMS, new ExportParams("项目工时表列表",
            "导出人:" + ResourceUtil.getSessionUserName().getRealName(), "导出信息"));
        modelMap.put(NormalExcelConstants.DATA_LIST, scWorkingHourss);
        return NormalExcelConstants.JEECG_EXCEL_VIEW;
    }

    /**
     * 导出excel 使模板
     * 
     * @param request
     * @param response
     */
    @SuppressWarnings("rawtypes")
    @RequestMapping(params = "exportXlsByT")
    public String exportXlsByT(ScWorkingHoursEntity scWorkingHours, HttpServletRequest request,
                               HttpServletResponse response, DataGrid dataGrid, ModelMap modelMap)
    {
        modelMap.put(NormalExcelConstants.FILE_NAME, "项目工时表");
        modelMap.put(NormalExcelConstants.CLASS, ScWorkingHoursEntity.class);
        modelMap.put(NormalExcelConstants.PARAMS, new ExportParams("项目工时表列表",
            "导出人:" + ResourceUtil.getSessionUserName().getRealName(), "导出信息"));
        modelMap.put(NormalExcelConstants.DATA_LIST, new ArrayList());
        return NormalExcelConstants.JEECG_EXCEL_VIEW;
    }

    @RequestMapping(params = "importExcel", method = RequestMethod.POST)
    @ResponseBody
    public AjaxJson importExcel(HttpServletRequest request, HttpServletResponse response)
    {
        AjaxJson j = new AjaxJson();

        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest)request;
        Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
        for (Map.Entry<String, MultipartFile> entity : fileMap.entrySet())
        {
            MultipartFile file = entity.getValue();// 获取上传文件对象
            ImportParams params = new ImportParams();
            params.setTitleRows(2);
            params.setHeadRows(1);
            params.setNeedSave(true);
            try
            {
                List<ScWorkingHoursEntity> listScWorkingHoursEntitys = ExcelImportUtil.importExcel(
                    file.getInputStream(), ScWorkingHoursEntity.class, params);
                for (ScWorkingHoursEntity scWorkingHours : listScWorkingHoursEntitys)
                {
                    scWorkingHoursService.save(scWorkingHours);
                }
                j.setMsg("文件导入成功！");
            }
            catch (Exception e)
            {
                j.setMsg("文件导入失败！");
                logger.error(ExceptionUtil.getExceptionMessage(e));
            }
            finally
            {
                try
                {
                    file.getInputStream().close();
                }
                catch (IOException e)
                {
                    e.printStackTrace();
                }
            }
        }
        return j;
    }

    @RequestMapping(method = RequestMethod.GET)
    @ResponseBody
    public List<ScWorkingHoursEntity> list()
    {
        List<ScWorkingHoursEntity> listScWorkingHourss = scWorkingHoursService.getList(
            ScWorkingHoursEntity.class);
        return listScWorkingHourss;
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    @ResponseBody
    public ResponseEntity<?> get(@PathVariable("id") String id)
    {
        ScWorkingHoursEntity task = scWorkingHoursService.get(ScWorkingHoursEntity.class, id);
        if (task == null)
        {
            return new ResponseEntity(HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity(task, HttpStatus.OK);
    }

    @RequestMapping(method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<?> create(@RequestBody ScWorkingHoursEntity scWorkingHours,
                                    UriComponentsBuilder uriBuilder)
    {
        // 调用JSR303 Bean Validator进行校验，如果出错返回含400错误码及json格式的错误信息.
        Set<ConstraintViolation<ScWorkingHoursEntity>> failures = validator.validate(
            scWorkingHours);
        if (!failures.isEmpty())
        {
            return new ResponseEntity(BeanValidators.extractPropertyAndMessage(failures),
                HttpStatus.BAD_REQUEST);
        }

        // 保存
        scWorkingHoursService.save(scWorkingHours);

        // 按照Restful风格约定，创建指向新任务的url, 也可以直接返回id或对象.
        String id = scWorkingHours.getId();
        URI uri = uriBuilder.path("/rest/scWorkingHoursController/" + id).build().toUri();
        HttpHeaders headers = new HttpHeaders();
        headers.setLocation(uri);

        return new ResponseEntity(headers, HttpStatus.CREATED);
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.PUT, consumes = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<?> update(@RequestBody ScWorkingHoursEntity scWorkingHours)
    {
        // 调用JSR303 Bean Validator进行校验，如果出错返回含400错误码及json格式的错误信息.
        Set<ConstraintViolation<ScWorkingHoursEntity>> failures = validator.validate(
            scWorkingHours);
        if (!failures.isEmpty())
        {
            return new ResponseEntity(BeanValidators.extractPropertyAndMessage(failures),
                HttpStatus.BAD_REQUEST);
        }

        // 保存
        scWorkingHoursService.saveOrUpdate(scWorkingHours);

        // 按Restful约定，返回204状态码, 无内容. 也可以返回200状态码.
        return new ResponseEntity(HttpStatus.NO_CONTENT);
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void delete(@PathVariable("id") String id)
    {
        scWorkingHoursService.deleteEntityById(ScWorkingHoursEntity.class, id);
    }
    
    
    
    
    
    /**
     * 
     * Description: <br>
     * 1、…<br>
     * 2、…<br>
     * Implement: <br>
     * 1、…<br>
     * 2、…<br>
     * 
     * @param sc 
     * @see
     */
    private void packageBean(ScWorkingHoursEntity sc){
        try
        {
        String WorkingDate = DateUtils.date_sdf.format(sc.getWorkingDate());
        int result = DateUtils.dayForWeek(WorkingDate);

        if (result == 1)
        {
            sc.setWorkingHours1(sc.getWorkingHours());
        }
        else if (result == 2)
        {
            sc.setWorkingHours2(sc.getWorkingHours());
        }
        else if (result == 3)
        {
            sc.setWorkingHours3(sc.getWorkingHours());
        }
        else if (result == 4)
        {
            sc.setWorkingHours4(sc.getWorkingHours());
        }
        else if (result == 5)
        {
            sc.setWorkingHours5(sc.getWorkingHours());
        }
        else if (result == 6)
        {
            sc.setWorkingHours6(sc.getWorkingHours());
        }
        else if (result == 7)
        {
            sc.setWorkingHours7(sc.getWorkingHours());
        }
        }
        catch (Exception e)
        {
           e.printStackTrace();
        }
    }

    
    
    
    /**
     * 
     * Description: <br>
     * 1、…<br>
     * 2、…<br>
     * Implement: <br>
     * 1、…<br>
     * 2、…<br>
     * 
     * @param sc
     * @param child 
     * @see
     */
    private void weekBean(ScWorkingHoursEntity sc,Object[] child){
        try
        {
            // 判断时间是星期几
            Date time = DateUtils.parseDate(child[3].toString(), "yyyy-MM-dd");

            String week = DateUtils.getWeekOfDate(time);
            if ("星期一".equals(week))
            {
                if (null != child[4])
                    sc.setWorkingHours1(child[4].toString());

            }
            else if ("星期二".equals(week))
            {
                if (null != child[4])
                    sc.setWorkingHours2(child[4].toString());

            }
            else if ("星期三".equals(week))
            {
                if (null != child[4])
                    sc.setWorkingHours3(child[4].toString());
            }
            else if ("星期四".equals(week))
            {
                if (null != child[4])
                    sc.setWorkingHours4(child[4].toString());

            }
            else if ("星期五".equals(week))
            {
                if (null != child[4])
                    sc.setWorkingHours5(child[4].toString());

            }
            else if ("星期六".equals(week))
            {
                if (null != child[4])
                    sc.setWorkingHours6(child[4].toString());
            }
            else if ("星期日".equals(week))
            {
                if (null != child[4])
                    sc.setWorkingHours7(child[4].toString());
            }
        }
        catch (NumberFormatException e)
        {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        catch (ParseException e)
        {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    

}
