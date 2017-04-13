package com.jeecg.bbs.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Validator;

import org.apache.log4j.Logger;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.common.exception.BusinessException;
import org.jeecgframework.core.common.model.json.AjaxJson;
import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.util.ResourceUtil;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.web.system.pojo.base.TSUser;
import org.jeecgframework.web.system.service.SystemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.jeecg.bbscomment.entity.BbsCommentEntity;
import com.jeecg.bbscomment.service.BbsCommentServiceI;
import com.jeecg.bbsedition.entity.BbsEditionEntity;
import com.jeecg.bbsedition.service.BbsEditionServiceI;
import com.jeecg.bbspost.entity.BbsPostEntity;
import com.jeecg.bbspost.service.BbsPostServiceI;
import com.jeecg.userinfo.service.UserInfoServiceI;

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
@RequestMapping("/bbsController")
public class BbsController extends BaseController {
    /**
     * Logger for this class
     */
    @SuppressWarnings("unused")
    private static final Logger logger = Logger.getLogger(BbsController.class);

    @Autowired
    BbsPostServiceI bbsPostServiceI;
    @Autowired
    BbsCommentServiceI bbsCommentServiceI;
    @Autowired
    private BbsEditionServiceI bbsEditionService;
    @Autowired
    private BbsPostServiceI bbsPostService;
    @Autowired
    private UserInfoServiceI userInfoService;
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
  * 跳转到论坛页面
  * @param request
  * @return
  */
    @RequestMapping(params = "bbs")
    public ModelAndView bbs(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView("bbs/bbsIndex");
        List<BbsEditionEntity> list = bbsEditionService.findByQueryString("FROM BbsEditionEntity");
        mv.addObject("bbsEditionList", list);
        return mv;
    }
    
    

    /**
     * 发帖页面
     * 
     * @return
     */
    @RequestMapping(params = "bbsPush")
    public ModelAndView bbsPush(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView("bbs/bbsPush");
        String editionId = request.getParameter("editionId");
        
        TSUser user = ResourceUtil.getSessionUserName();
        mv.addObject("userName", user.getRealName());
        
        if(StringUtil.isNotEmpty(editionId)){
            BbsEditionEntity bbsEdition = bbsEditionService.getEntity(BbsEditionEntity.class, Long.valueOf(editionId));
            mv.addObject("bbsEdition", bbsEdition);
        }
        
        List<BbsEditionEntity> list = bbsEditionService.findByQueryString("FROM BbsEditionEntity");
        mv.addObject("bbsEditionList", list);
        return mv;
    }
    

    /**
     * 
     * TODO(这里用一句话描述这个方法的作用，如：方法{@code saveComment}是用来回复评论......。)
     * 
     * @param bbsCommentEntity
     * @param request
     * @return
     */
    @RequestMapping(params = "saveBbsPost")
    @ResponseBody
    public AjaxJson saveBbsPost(BbsPostEntity bbsPostEntity, HttpServletRequest request) {
        AjaxJson j = new AjaxJson();
        message = "回复评论成功";
        try {
			TSUser user = ResourceUtil.getSessionUserName();
        	bbsPostEntity.setPostUserid(user.getId());
        	bbsPostEntity.setPostUserName(user.getRealName());
            bbsPostServiceI.save(bbsPostEntity);
            j.setSuccess(true);
        } catch (Exception e) {
            e.printStackTrace();
            message = "回复评论失败";
            throw new BusinessException(e.getMessage());
        }
        j.setMsg(message);
        j.setObj(bbsPostEntity.getEditionId());
        return j;
    }

    /**
     * 
     * TODO(这里用一句话描述这个方法的作用，如：方法{@code saveComment}是用来回复评论......。)
     * 
     * @param bbsCommentEntity
     * @param request
     * @return
     */
    @RequestMapping(params = "saveComment")
    @ResponseBody
    public AjaxJson saveComment(BbsCommentEntity bbsCommentEntity, HttpServletRequest request) {
        AjaxJson j = new AjaxJson();
        message = "回复评论成功";
        try {
            String id = request.getParameter("id");
            bbsCommentEntity.setPostId(Long.valueOf(id));
            TSUser user = ResourceUtil.getSessionUserName();
            bbsCommentEntity.setCommentUserid(user.getId());
            bbsCommentEntity.setCommentUserName(user.getRealName());
            bbsCommentServiceI.save(bbsCommentEntity);
            j.setSuccess(true);
        } catch (Exception e) {
            e.printStackTrace();
            message = "回复评论失败";
            throw new BusinessException(e.getMessage());
        }
        j.setMsg(message);
        return j;
    }

    /**
     * 用户资料列表 页面跳转
     * 
     * @return
     */
    @RequestMapping(params = "bbsList")
    public ModelAndView bbsList(HttpServletRequest request, DataGrid dataGrid) {

        ModelAndView mv = new ModelAndView("bbs/bbsList");
        String editionId = request.getParameter("editionId");
        if(StringUtil.isNotEmpty(editionId)){
            BbsEditionEntity bbsEdition = bbsEditionService.getEntity(BbsEditionEntity.class, Long.valueOf(editionId));
            mv.addObject("bbsEdition", bbsEdition);

            DetachedCriteria detachedCriteria = DetachedCriteria.forClass(BbsPostEntity.class);
            detachedCriteria.add(Restrictions.eq("editionId",Long.valueOf(editionId) ));
            detachedCriteria.addOrder(Order.desc("createDate"));  
            List list = pageBaseMethod(request, detachedCriteria, bbsPostServiceI, 8);

            mv.addObject("editionId", editionId);
            mv.addObject("bbsPostList", list);
        }
     
        return mv;
    }

    /**
     * 用户资料列表 页面跳转
     * 
     * @return
     */
    @RequestMapping(params = "bbsInfo")
    public ModelAndView bbsInfo(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView("bbs/bbsInfo");
        String bbsPostId = request.getParameter("bbsPostId");
        BbsPostEntity bbsPost = bbsPostService.getEntity(BbsPostEntity.class, Long.valueOf(bbsPostId));
        mv.addObject("bbsPost", bbsPost);
        
        TSUser user = ResourceUtil.getSessionUserName();
        mv.addObject("userName", user.getRealName());
        
        
        BbsEditionEntity bbsEdition = bbsEditionService.getEntity(BbsEditionEntity.class, bbsPost.getEditionId());
        mv.addObject("bbsEdition", bbsEdition);
        

        DetachedCriteria detachedCriteria = DetachedCriteria.forClass(BbsCommentEntity.class);
        detachedCriteria.add(Restrictions.eq("postId", Long.valueOf(bbsPostId)));
        List list = pageBaseMethod(request, detachedCriteria, bbsCommentServiceI, 10);
        mv.addObject("postId", bbsPostId);
        mv.addObject("bbsCommentList", list);
        return mv;

    }



}
