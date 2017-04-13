package com.jeecg.userinfo.controller;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URI;
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

import org.apache.log4j.Logger;
import org.jeecgframework.core.beanvalidator.BeanValidators;
import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.common.exception.BusinessException;
import org.jeecgframework.core.common.hibernate.qbc.CriteriaQuery;
import org.jeecgframework.core.common.model.json.AjaxJson;
import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.constant.Globals;
import org.jeecgframework.core.util.ExceptionUtil;
import org.jeecgframework.core.util.ImageParm;
import org.jeecgframework.core.util.ImageUtil;
import org.jeecgframework.core.util.MyBeanUtils;
import org.jeecgframework.core.util.ResourceUtil;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.poi.excel.ExcelImportUtil;
import org.jeecgframework.poi.excel.entity.ExportParams;
import org.jeecgframework.poi.excel.entity.ImportParams;
import org.jeecgframework.poi.excel.entity.vo.NormalExcelConstants;
import org.jeecgframework.tag.core.easyui.TagUtil;
import org.jeecgframework.web.system.pojo.base.TSUser;
import org.jeecgframework.web.system.service.SystemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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

import com.jeecg.userinfo.entity.TSBaseUserEntity;
import com.jeecg.userinfo.entity.TSUserEntity;
import com.jeecg.userinfo.entity.UserInfoEntity;
import com.jeecg.userinfo.service.TSBaseUserServiceI;
import com.jeecg.userinfo.service.TSUserServiceI;
import com.jeecg.userinfo.service.UserInfoServiceI;

import net.sf.json.JSONObject;

/**   
 * @Title: Controller
 * @Description: 用户资料
 * @author onlineGenerator
 * @date 2016-07-26 17:55:32
 * @version V1.0   
 *
 */
@Scope("prototype")
@Controller
@RequestMapping("/userInfoController")
public class UserInfoController extends BaseController {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(UserInfoController.class);

	@Autowired
	private UserInfoServiceI userInfoService;
	@Autowired
	private TSBaseUserServiceI tsBaseUserService;
	@Autowired
	private TSUserServiceI tsUserService;
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
	 * 用户资料列表 页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "bbs")
	public ModelAndView bbs(HttpServletRequest request) {
		return new ModelAndView("bbs/index");
	}
	
	
	/**
	 * 用户资料列表 页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "bbsList")
	public ModelAndView bbsList(HttpServletRequest request) {
		return new ModelAndView("bbs/bbsList");
	}
	
	/**
	 * 用户资料列表 页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "bbsInfo")
	public ModelAndView bbsInfo(HttpServletRequest request) {
		return new ModelAndView("bbs/bbsInfo");
	}
	
	@RequestMapping(params = "userinfo")
	public ModelAndView userinfo(HttpServletRequest request) {
		String username=request.getParameter("username");
		if(username==null||username==""){
			username=ResourceUtil.getSessionUserName().getUserName();
		}
		Map<String,Object> map=userInfoService.getUserInfo(username);
		request.setAttribute("userinfo", map);
		return new ModelAndView("com/jeecg/userinfo/userInfo");
	}
	
	/**
	 * 用户资料列表 页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "bbsPush")
	public ModelAndView bbsPush(HttpServletRequest request) {
		return new ModelAndView("bbs/bbsPush");
	}
	
	
	
	
	

	/**
	 * 用户资料列表 页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "list")
	public ModelAndView list(HttpServletRequest request) {
		return new ModelAndView("com/jeecg/userinfo/userInfoList");
	}

	@RequestMapping(params = "userlist")
	public ModelAndView userlist(HttpServletRequest request) {
		return new ModelAndView("com/jeecg/userinfo/userInfo-list");
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
	public void datagrid(UserInfoEntity userInfo,HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
		CriteriaQuery cq = new CriteriaQuery(UserInfoEntity.class, dataGrid);
		//查询条件组装器
		org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, userInfo, request.getParameterMap());
		try{
		//自定义追加查询条件
		}catch (Exception e) {
			throw new BusinessException(e.getMessage());
		}
		cq.add();
		this.userInfoService.getDataGridReturn(cq, true);
		TagUtil.datagrid(response, dataGrid);
	}
	
	@RequestMapping(params ="getUserList")
	@ResponseBody
	public Map<String, Object> getUserList(UserInfoEntity userInfo,HttpServletRequest request,Model model,DataGrid dataGrid){
		String realname=request.getParameter("realname");
		String sex=request.getParameter("sex");
		String user_no=request.getParameter("user.no");
		String departname=request.getParameter("departname");
		String zaigang=request.getParameter("zaigang");
		String sqlCon="";
		if(realname!=null&&realname!=""){
			sqlCon+=" and b.realname like '%" + realname + "%'";
		}
		if(sex!=null&&sex!=""){
			sqlCon+=" and info.sex =" + sex;
		}
		if(user_no!=null&&user_no!=""){
			sqlCon+=" and u.user_no like '%" + user_no + "%'";
		}
		if(departname!=null&&departname!=""){
			sqlCon+="and d.departname like '%" + departname + "%'";
		}
		if(zaigang!=null&&zaigang!=""){
			sqlCon+="and info.zaigang =" + zaigang;
		}
		 Map<String, Object> infoMap = new HashMap<String, Object>();
		 List<Map<String, Object>> userlist= userInfoService.getUserList(userInfo,dataGrid,sqlCon);
		 int  total = userInfoService.countForuser(userInfo,sqlCon);
		 infoMap.put("total", total);
		 infoMap.put("rows", userlist);
		 return infoMap;
	}
	
	
	/**
	 * 删除用户资料
	 * 
	 * @return
	 */
	@RequestMapping(params = "doDel")
	@ResponseBody
	public AjaxJson doDel(UserInfoEntity userInfo, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		userInfo = systemService.getEntity(UserInfoEntity.class, userInfo.getId());
		message = "用户资料删除成功";
		try{
			userInfoService.delete(userInfo);
			systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
		}catch(Exception e){
			e.printStackTrace();
			message = "用户资料删除失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}
	
	/**
	 * 批量删除用户资料
	 * 
	 * @return
	 */
	@RequestMapping(params = "doBatchDel")
	@ResponseBody
	public AjaxJson doBatchDel(String ids,HttpServletRequest request){
		AjaxJson j = new AjaxJson();
		message = "用户资料删除成功";
		try{
			for(String id:ids.split(",")){
				UserInfoEntity userInfo = systemService.getEntity(UserInfoEntity.class, 
				Integer.parseInt(id)
				);
				userInfoService.delete(userInfo);
				systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
			}
		}catch(Exception e){
			e.printStackTrace();
			message = "用户资料删除失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}


	/**
	 * 添加用户资料
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(params = "doAdd")
	@ResponseBody
	public AjaxJson doAdd(UserInfoEntity userInfo, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		message = "用户资料添加成功";
		try{
			TSUser user = ResourceUtil.getSessionUserName();
			userInfo.setUserId(user.getId());
			userInfoService.save(userInfo);
			systemService.addLog(message, Globals.Log_Type_INSERT, Globals.Log_Leavel_INFO);
		}catch(Exception e){
			e.printStackTrace();
			message = "用户资料添加失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}
	
	@RequestMapping(params = "goRsInfo")
	public ModelAndView goRsInfo(HttpServletRequest request){
		String id=request.getParameter("id");
		Map<String, Object> map=userInfoService.getUserDetail(id);
		request.setAttribute("userinfo", map);
		return new ModelAndView("com/jeecg/userinfo/rsinfo");
	}
	
	@RequestMapping(params = "goZlbInfo")
	public ModelAndView goZlbInfo(HttpServletRequest request){
		String id=request.getParameter("id");
		Map<String, Object> map=userInfoService.getUserDetail(id);
		request.setAttribute("userinfo", map);
		return new ModelAndView("com/jeecg/userinfo/zlbinfo");
	}
	
	/**
	 * 用户资料编辑页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "goPerfect")
	public ModelAndView goPerfect(UserInfoEntity userInfo, HttpServletRequest req) {
		TSUser user = ResourceUtil.getSessionUserName();
		UserInfoEntity	t =	userInfoService.findUniqueByProperty(UserInfoEntity.class, "userId", user.getId());
		if (null!=t ) {
			req.setAttribute("userInfoPage", t);
		}
		return new ModelAndView("com/jeecg/userinfo/userInfo-update");
	}
	
	/**
	 * 更新用户资料
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(params = "doUpdate")
	@ResponseBody
	public AjaxJson doUpdate(UserInfoEntity userInfo, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		message = "用户资料更新成功";
	
		try {
			if(null==userInfo.getId()){
				TSUser user = ResourceUtil.getSessionUserName();
				userInfo.setUserId(user.getId());
				userInfoService.save(userInfo);
			}else{
				UserInfoEntity t = userInfoService.get(UserInfoEntity.class, userInfo.getId());
				MyBeanUtils.copyBeanNotNull2Bean(userInfo, t);
				userInfoService.saveOrUpdate(t);
			}
		
			systemService.addLog(message, Globals.Log_Type_UPDATE, Globals.Log_Leavel_INFO);
		} catch (Exception e) {
			e.printStackTrace();
			message = "用户资料更新失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}
	
	@RequestMapping(params = "doUpdateRs")
	@ResponseBody
	public AjaxJson doUpdateRs(HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		message = "更新成功";
		try {
			String id=request.getParameter("id");
			String laowugongsi=request.getParameter("laowugongsi");
			String laodonghetongtype=request.getParameter("laodonghetongtype");
			String laowugongsiperson=request.getParameter("laowugongsiperson");
			String hetongendtime=request.getParameter("hetongendtime");
			String yonggongtype=request.getParameter("yonggongtype");
			String zhiwei=request.getParameter("zhiwei");
			String status=request.getParameter("status");
			String user_id=request.getParameter("user_id");
			String sfzfilename=request.getParameter("sfzfilename");
			String sfzfilepath=request.getParameter("sfzfilepath");
			String xlfilename=request.getParameter("xlfilename");
			String xlfilepath=request.getParameter("xlfilepath");
			String zcfilename=request.getParameter("zcfilename");
			String zcfilepath=request.getParameter("zcfilepath");
			
			UserInfoEntity userinfo=userInfoService.get(UserInfoEntity.class,Integer.parseInt(id));
			userinfo.setLaowugongsi(laowugongsi);
			userinfo.setLaowugongsiperson(laowugongsiperson);
			userinfo.setLaodonghetongtype(laodonghetongtype);
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");//小写的mm表示的是分钟  
			userinfo.setHetongendtime(sdf.parse(hetongendtime));
			userinfo.setYonggongtype(yonggongtype);
			userinfo.setZhiwei(zhiwei);
			userinfo.setSfzfilename(sfzfilename);
			userinfo.setSfzfilepath(sfzfilepath);
			userinfo.setZcfilename(zcfilename);
			userinfo.setZcfilepath(zcfilepath);
			userinfo.setXlfilename(xlfilename);
			userinfo.setXlfilepath(xlfilepath);
			userInfoService.updateEntitie(userinfo);
			
			TSBaseUserEntity baseuser=tsBaseUserService.get(TSBaseUserEntity.class, user_id);
			baseuser.setStatus(Integer.parseInt(status));
			tsBaseUserService.saveOrUpdate(baseuser);
			
			systemService.addLog(message, Globals.Log_Type_UPDATE, Globals.Log_Leavel_INFO);
		} catch (Exception e) {
			e.printStackTrace();
			message = "更新失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}
	
	@RequestMapping(params = "doUpdateZlb")
	@ResponseBody
	public AjaxJson doUpdateZlb(HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		message = "更新成功";
		try {
			String id=request.getParameter("id");
			String hxl3_xl=request.getParameter("hxl3_xl");
			String hxl3_xx=request.getParameter("hxl3_xx");
			String hxl3_zy=request.getParameter("hxl3_zy");
			String hxl3_sj=request.getParameter("hxl3_sj");
			String hxl2_xl=request.getParameter("hxl2_xl");
			String hxl2_xx=request.getParameter("hxl2_xx");
			String hxl2_zy=request.getParameter("hxl2_zy");
			String hxl2_sj=request.getParameter("hxl2_sj");
			String hxl1_xl=request.getParameter("hxl1_xl");
			String hxl1_xx=request.getParameter("hxl1_xx");
			String hxl1_zy=request.getParameter("hxl1_zy");
			String hxl1_sj=request.getParameter("hxl1_sj");
			String jishuzhicheng=request.getParameter("jishuzhicheng");
			String zhicheng=request.getParameter("zhicheng");
			UserInfoEntity userinfo=userInfoService.get(UserInfoEntity.class,Integer.parseInt(id));
			userinfo.setHxl1Sj(hxl1_sj);
			userinfo.setHxl1Xl(hxl1_xl);
			userinfo.setHxl1Xx(hxl1_xx);
			userinfo.setHxl1Zy(hxl1_zy);
			userinfo.setHxl2Sj(hxl2_sj);
			userinfo.setHxl2Xl(hxl2_xl);
			userinfo.setHxl2Xx(hxl2_xx);
			userinfo.setHxl2Zy(hxl2_zy);
			userinfo.setHxl3Sj(hxl3_sj);
			userinfo.setHxl3Xl(hxl3_xl);
			userinfo.setHxl3Xx(hxl3_xx);
			userinfo.setHxl3Zy(hxl3_zy);
			userinfo.setJishuzhicheng(jishuzhicheng);
			userinfo.setZhicheng(zhicheng);
			userInfoService.updateEntitie(userinfo);
			systemService.addLog(message, Globals.Log_Type_UPDATE, Globals.Log_Leavel_INFO);
		} catch (Exception e) {
			e.printStackTrace();
			message = "更新失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}
	
	@RequestMapping(params = "updateUser")
	@ResponseBody
	public AjaxJson updateUser(UserInfoEntity userInfo,TSUserEntity tsUser,TSBaseUserEntity tsBaseUser, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		message = "用户资料更新成功";
		try {
			if(null==userInfo.getId()){
				TSUser user = ResourceUtil.getSessionUserName();
				userInfo.setUserId(user.getId());
				userInfoService.save(userInfo);
			}else{
				UserInfoEntity t = userInfoService.get(UserInfoEntity.class, userInfo.getId());
				MyBeanUtils.copyBeanNotNull2Bean(userInfo, t);
				userInfoService.saveOrUpdate(t);
			}
			
			String realname=tsBaseUser.getRealname();
			String user_id=userInfo.getUserId();
			String mobile=tsUser.getMobilephone();
			String email=tsUser.getEmail();
			String qq=tsUser.getQq();
			
			TSBaseUserEntity baseInfo=tsBaseUserService.get(TSBaseUserEntity.class, user_id);
			baseInfo.setRealname(realname);
			tsBaseUserService.saveOrUpdate(baseInfo);
			
			Map<String, Object> map=userInfoService.getUserEntity(user_id);
			TSUserEntity users=new TSUserEntity();
			users.setId(String.valueOf(map.get("id")));
			users.setEmail(email);
			users.setMobilephone(mobile);
			users.setOfficephone(String.valueOf(map.get("officePhone")));
			users.setSignaturefile(String.valueOf(map.get("signatureFile")));
			users.setUpdateName(ResourceUtil.getSessionUserName().getRealName());
			users.setUpdateDate(new Date());
			users.setUpdateBy(ResourceUtil.getSessionUserName().getUserName());
			users.setCreateName(String.valueOf(map.get("create_name")));
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
			users.setCreateDate(sdf.parse(String.valueOf(map.get("create_date"))));
			users.setCreateBy(String.valueOf(map.get("create_by")));
			users.setPeUserid(String.valueOf(map.get("pe_userid")));
			users.setOnDuty(String.valueOf(map.get("on_duty")));
			users.setUserNo(String.valueOf(map.get("user_no")));
			users.setAppToken(String.valueOf(map.get("app_token")));
			users.setQq(qq);
			systemService.updateEntitie(users);
		} catch (Exception e) {
			e.printStackTrace();
			message = "用户资料更新失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}
	

	/**
	 * 用户资料新增页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "goAdd")
	public ModelAndView goAdd(UserInfoEntity userInfo, HttpServletRequest req) {
		if (StringUtil.isNotEmpty(userInfo.getId())) {
			userInfo = userInfoService.getEntity(UserInfoEntity.class, userInfo.getId());
			req.setAttribute("userInfoPage", userInfo);
		}
		return new ModelAndView("com/jeecg/userinfo/userInfo-add");
	}
	/**
	 * 用户资料编辑页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "goUpdate")
	public ModelAndView goUpdate(UserInfoEntity userInfo, HttpServletRequest req) {
		if (StringUtil.isNotEmpty(userInfo.getId())) {
			userInfo = userInfoService.getEntity(UserInfoEntity.class, userInfo.getId());
			req.setAttribute("userInfoPage", userInfo);
		}
		return new ModelAndView("com/jeecg/userinfo/userInfo-update");
	}
	
	/**
	 * 用户资料编辑页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "goUploadPic")
	public ModelAndView goUploadPic(UserInfoEntity userInfo, HttpServletRequest req) {
		return new ModelAndView("com/jeecg/userinfo/userInfo-uploadPic");
	}
	
	
	@SuppressWarnings("unused")
	@RequestMapping(params = "doUploadPic", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson doUploadPic(HttpServletRequest request, HttpServletResponse response) {
		
		TSUser user = ResourceUtil.getSessionUserName();
		UserInfoEntity	t =	userInfoService.findUniqueByProperty(UserInfoEntity.class, "userId", user.getId());
		if(null==t){
		  t = new UserInfoEntity();
		  t.setUserId(user.getId());
		  userInfoService.save(t);
		}
		
		
		AjaxJson j = new AjaxJson();
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
		String avatar_src = request.getParameter("avatar_src");
		String avatar_data = request.getParameter("avatar_data");
		ImageParm ImageParm = (ImageParm)JSONObject.toBean(JSONObject.fromObject(avatar_data), ImageParm.class);
		
		//获取头像保存目录
		String headPicDir = ResourceUtil.getConfigByName("headPicDir");
		String uploadPath = headPicDir +File.separator+ user.getId()+File.separator;
		String url = request.getRequestURL().toString();
		String  showPath =request.getScheme() +"://"+request.getServerName()+":"+request.getServerPort()+ "/"+ ResourceUtil.getConfigByName("headPicGo");
		
		File f = new File(uploadPath);
		  if (!f.exists()) {
	            f.mkdirs();
	        }
		  
		for (Map.Entry<String, MultipartFile> entity : fileMap.entrySet()) {
			MultipartFile file = entity.getValue();// 获取上传文件对象
			try {
		
				String suffix = ImageUtil.getFileNameSuffix(file.getOriginalFilename());
				String tempFileName ="temp_"+user.getId()+"."+suffix;
				String resultName = "myHeadpic_"+user.getId()+System.currentTimeMillis()+"."+suffix;
				   if(file.getSize()>0){     
		                try {
		                SaveFileFromInputStream(file.getInputStream(),uploadPath,tempFileName);
		                ImageUtil.spin(ImageParm.getRotate(), new File( uploadPath+tempFileName),uploadPath+resultName);
		                File spinFile=new File( uploadPath+resultName);
						File resultFile=new File( uploadPath+ resultName);
						ImageUtil.cutImage(ImageParm.getX(), ImageParm.getY(), ImageParm.getWidth(), ImageParm.getHeight(), spinFile, resultFile);
		                } catch (IOException e) {
		                    System.out.println(e.getMessage());
		                    j.setSuccess(false);
		                	j.setMsg("图片上传失败！");
		                    return j;
		                }
		            }
				t.setHeadPicPath(user.getId()+"/"+ resultName);
				userInfoService.saveOrUpdate(t);
				
				j.setObj(showPath+"/"+ user.getId()+"/"+ resultName);		
				j.setMsg("图片上传成功！");
			} catch (Exception e) {
				j.setMsg("图片上传失败！");
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
	
	
	@RequestMapping(params = "tofindPic")
    public void picToJSP(HttpServletRequest request,HttpServletResponse response){
	
		String userId = request.getParameter("userId");
		if(StringUtil.isEmpty(userId)){
			TSUser user = ResourceUtil.getSessionUserName();
			userId = user.getId();
		}
		
		UserInfoEntity	t =	userInfoService.findUniqueByProperty(UserInfoEntity.class, "userId", userId);
		if(null==t){
			  t = new UserInfoEntity();
			  t.setUserId(userId);
			  userInfoService.save(t);
			}
		String headPicDir = ResourceUtil.getConfigByName("headPicDir");
    	String pic = headPicDir+File.separator+ t.getHeadPicPath();
        response.setContentType("text/html; charset=UTF-8");
        FileInputStream fis = null;
     
        OutputStream os = null;
        
        try {  
        	
        	fis =   new FileInputStream(pic);
        	os =  response.getOutputStream();
                int count = 0;
                byte[] buffer = new byte[1024*1024];
                while ( (count = fis.read(buffer)) != -1 ){
                	   os.write(buffer, 0, count);
                }
     
       } catch (Exception e) {  
//           e.printStackTrace();  
       }    finally {
    	   try {
    		   if(os!=null){
    			   os.close();	
               }
    		   if(fis != null){
    			   fis.close();	
    		   }
    		   
  			} catch (IOException e) {
  				e.printStackTrace();
  			}
                   }
          
    }  

	
	  public void SaveFileFromInputStream(InputStream stream,String path,String filename) throws IOException
	    {      
	        FileOutputStream fs=new FileOutputStream( path + "/"+ filename);
	        byte[] buffer =new byte[1024*1024];
	        int bytesum = 0;
	        int byteread = 0; 
	        while ((byteread=stream.read(buffer))!=-1)
	        {
	           bytesum+=byteread;
	           fs.write(buffer,0,byteread);
	           fs.flush();
	        } 
	        fs.close();
	        stream.close();      
	}
	
	
	
	
	
	
	/**
	 * 导入功能跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "upload")
	public ModelAndView upload(HttpServletRequest req) {
		req.setAttribute("controller_name","userInfoController");
		return new ModelAndView("common/upload/pub_excel_upload");
	}
	
	/**
	 * 导出excel
	 * 
	 * @param request
	 * @param response
	 */
	@RequestMapping(params = "exportXls")
	public String exportXls(UserInfoEntity userInfo,HttpServletRequest request,HttpServletResponse response
			, DataGrid dataGrid,ModelMap modelMap) {
		CriteriaQuery cq = new CriteriaQuery(UserInfoEntity.class, dataGrid);
		org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, userInfo, request.getParameterMap());
		List<UserInfoEntity> userInfos = this.userInfoService.getListByCriteriaQuery(cq,false);
		modelMap.put(NormalExcelConstants.FILE_NAME,"用户资料");
		modelMap.put(NormalExcelConstants.CLASS,UserInfoEntity.class);
		modelMap.put(NormalExcelConstants.PARAMS,new ExportParams("用户资料列表", "导出人:"+ResourceUtil.getSessionUserName().getRealName(),
			"导出信息"));
		modelMap.put(NormalExcelConstants.DATA_LIST,userInfos);
		return NormalExcelConstants.JEECG_EXCEL_VIEW;
	}
	/**
	 * 导出excel 使模板
	 * 
	 * @param request
	 * @param response
	 */
	@RequestMapping(params = "exportXlsByT")
	public String exportXlsByT(UserInfoEntity userInfo,HttpServletRequest request,HttpServletResponse response
			, DataGrid dataGrid,ModelMap modelMap) {
    	modelMap.put(NormalExcelConstants.FILE_NAME,"用户资料");
    	modelMap.put(NormalExcelConstants.CLASS,UserInfoEntity.class);
    	modelMap.put(NormalExcelConstants.PARAMS,new ExportParams("用户资料列表", "导出人:"+ResourceUtil.getSessionUserName().getRealName(),
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
				List<UserInfoEntity> listUserInfoEntitys = ExcelImportUtil.importExcel(file.getInputStream(),UserInfoEntity.class,params);
				for (UserInfoEntity userInfo : listUserInfoEntitys) {
					userInfoService.save(userInfo);
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
	public List<UserInfoEntity> list() {
		List<UserInfoEntity> listUserInfos=userInfoService.getList(UserInfoEntity.class);
		return listUserInfos;
	}
	
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	@ResponseBody
	public ResponseEntity<?> get(@PathVariable("id") String id) {
		UserInfoEntity task = userInfoService.get(UserInfoEntity.class, id);
		if (task == null) {
			return new ResponseEntity(HttpStatus.NOT_FOUND);
		}
		return new ResponseEntity(task, HttpStatus.OK);
	}

	@RequestMapping(method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<?> create(@RequestBody UserInfoEntity userInfo, UriComponentsBuilder uriBuilder) {
		//调用JSR303 Bean Validator进行校验，如果出错返回含400错误码及json格式的错误信息.
		Set<ConstraintViolation<UserInfoEntity>> failures = validator.validate(userInfo);
		if (!failures.isEmpty()) {
			return new ResponseEntity(BeanValidators.extractPropertyAndMessage(failures), HttpStatus.BAD_REQUEST);
		}

		//保存
		userInfoService.save(userInfo);

		//按照Restful风格约定，创建指向新任务的url, 也可以直接返回id或对象.
		String id = userInfo.getId()+"";
		URI uri = uriBuilder.path("/rest/userInfoController/" + id).build().toUri();
		HttpHeaders headers = new HttpHeaders();
		headers.setLocation(uri);

		return new ResponseEntity(headers, HttpStatus.CREATED);
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.PUT, consumes = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<?> update(@RequestBody UserInfoEntity userInfo) {
		//调用JSR303 Bean Validator进行校验，如果出错返回含400错误码及json格式的错误信息.
		Set<ConstraintViolation<UserInfoEntity>> failures = validator.validate(userInfo);
		if (!failures.isEmpty()) {
			return new ResponseEntity(BeanValidators.extractPropertyAndMessage(failures), HttpStatus.BAD_REQUEST);
		}

		//保存
		userInfoService.saveOrUpdate(userInfo);

		//按Restful约定，返回204状态码, 无内容. 也可以返回200状态码.
		return new ResponseEntity(HttpStatus.NO_CONTENT);
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
	@ResponseStatus(HttpStatus.NO_CONTENT)
	public void delete(@PathVariable("id") String id) {
		userInfoService.deleteEntityById(UserInfoEntity.class, id);
	}
	
	/**
	 * 获取个人基本信息（app）
	 * @param token
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "app_MobileGetUserInfo",method=RequestMethod.GET)
	@ResponseBody
	public AjaxJson app_MobileGetUserInfo(String token,HttpServletRequest request,HttpServletResponse response) {
		AjaxJson j=new AjaxJson();
		try {
			Map<String, Object> params = new HashMap<String, Object>();
			TSUser user = systemService.findUniqueByProperty(TSUser.class, "appToken", token);
//			TSUser user = ResourceUtil.getSessionUserName();
			
			Map<String, Object> map=userInfoService.getUserInfoById(user.getId());
			j.setObj(map);
			params.put("code", "0000");
			j.setAttributes(params);
			j.setMsg("获取消息详情成功");
		} catch (Exception e) {
			Map<String, Object> params = new HashMap<String, Object>();
			e.printStackTrace();
			j.setMsg("获取消息详情失败，程序异常");
			params.put("code", "0001");
			j.setAttributes(params);
			j.setSuccess(false);
			}
		return j;
	}
}
