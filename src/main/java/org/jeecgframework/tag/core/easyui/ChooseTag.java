package org.jeecgframework.tag.core.easyui;

import java.io.IOException;

import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.commons.lang3.StringUtils;
import org.apache.xpath.FoundIndex;
import org.jeecgframework.core.util.MutiLangUtil;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.core.util.UUIDGenerator;


/**
 * 
 * 类描述：选择器标签
 * 
 * @author:  张代浩
 * @date： 日期：2012-12-7 时间：上午10:17:45
 * @version 1.0
 */
public class ChooseTag extends TagSupport {
	protected String hiddenName;
	protected String chooseName;
	protected String textname;//显示文本框字段
	protected String icon;
	protected String title;
	protected String url;
	protected String top;
	protected String left;
	protected String width;
	protected String height;
	protected String name;
	protected String hiddenid;// 隐藏框取值ID
	protected Boolean isclear = false;
	protected String fun;//自定义回调函数
	protected String inputTextname;
	protected String langArg;
	protected Boolean isInit = false;//是否初始化
	
	protected Boolean minFlag = true;
	protected Boolean maxFlag = true;
	protected Boolean resize = true;
	
	protected String multiType;//多选类型
	
	protected String focusSelector;//获取焦点选择器

	public int doStartTag() throws JspTagException {
		return EVAL_PAGE;
	}

	public int doEndTag() throws JspTagException {
		try {
			title = MutiLangUtil.doMutiLang(title, langArg);
			JspWriter out = this.pageContext.getOut();
			out.print(end().toString());
			out.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return EVAL_PAGE;
	}

	public StringBuffer end() {
		String confirm = MutiLangUtil.getMutiLangInstance().getLang("common.confirm");
		String cancel = MutiLangUtil.getMutiLangInstance().getLang("common.close");
		String methodname = UUIDGenerator.generate().replaceAll("-", "");
		StringBuffer sb = new StringBuffer();
		
		if(StringUtil.isEmpty(focusSelector)){
			String barName = MutiLangUtil.getMutiLangInstance().getLang("common.select", langArg);
			if(StringUtils.isNotBlank(chooseName)){
				barName = chooseName ;
			}
			sb.append("<a href=\"#\" class=\"easyui-linkbutton\"  icon=\"" + icon + "\" onClick=\"choose_"+methodname+ StringUtil.replace("()\">{0}</a>", "{0}", barName));
		}else {
			sb.append("<script type=\"text/javascript\">$(function(){$('" + focusSelector + "').focus(choose_"+methodname+");})</script>");
		}
		
		if (isclear&&StringUtil.isNotEmpty(textname)) {
			sb.append("<a style=\"margin-left: 4px;\"href=\"#\" class=\"easyui-linkbutton\" plain=\"true\" icon=\"icon-redo\" onClick=\"clearAll_"+methodname+ StringUtil.replace("();\">{0}</a>", "{0}", MutiLangUtil.getMutiLangInstance().getLang("common.clear", langArg)));
		}
		
		sb.append("<script type=\"text/javascript\">");
		sb.append("var windowapi = frameElement.api, W = windowapi.opener;");
		sb.append("function choose_"+methodname+"(){");
		 //--author：zhoujf-----start----date:20150531--------for: 编辑用户，选择角色,弹出的角色列表页面，默认没选中 标签扩展
		sb.append("var url = ").append("'").append(url).append("';");
		if(isInit){
			sb.append("var initValue = ").append("$(\'#" + hiddenName + "\').val();");
			sb.append("url += ").append("'&ids='+initValue;"); 
		}
		// --author：zhoujf------end-----date:20150531--------for: 编辑用户，选择角色,弹出的角色列表页面，默认没选中 标签扩展
		sb.append("if(typeof(windowapi) == 'undefined'){");
			sb.append("$.dialog({");
			sb.append("content: \'url:\'+url,");
			sb.append("zIndex: getzIndex(),");
			if (title != null) {
				sb.append("title: \'" + title + "\',");
			}
			sb.append("lock : true,");
			if (width != null) {
				sb.append("width :" + width + ",");
			} else {
				sb.append("width :400,");
			}
			if (height != null) {
				sb.append("height :" + height + ",");
			} else {
				sb.append("height :350,");
			}
			if (left != null) {
				sb.append("left :" + left + ",");
			} else {
				sb.append("left :'50%',");
			}
			if (top != null) {
				sb.append("top :" + top + ",");
			} else {
				sb.append("top :'50%',");
			}
			sb.append("opacity : 0.4,");
			sb.append("button : [ {");
			sb.append(StringUtil.replace("name : \'{0}\',", "{0}", confirm));
			sb.append("callback : clickcallback_"+methodname+",");
			sb.append("focus : true");
			sb.append("}, {");
			sb.append(StringUtil.replace("name : \'{0}\',","{0}", cancel));
			sb.append("callback : function() {");
			sb.append("}");
			sb.append("} ]");
			sb.append("});");
		sb.append("}else{");// lhgDialog设置
			sb.append("$.dialog({");
			sb.append("content: \'url:\'+url,");
			sb.append("zIndex: getzIndex(),");
			if (title != null) {
				sb.append("title: \'" + title + "\',");
			}
			sb.append("lock : true,");
			sb.append("parent:windowapi,");
			if (width != null) {
				sb.append("width :" + width + ",");
			} else {
				sb.append("width :400,");
			}
			if (height != null) {
				sb.append("height :" + (Integer.valueOf(height) + 8) + ",");//弥补easyUI高度不足的问题
			} else {
				sb.append("height :350,");
			}
			if (left != null) {
				sb.append("left :" + left + ",");
			} else {
				sb.append("left :'50%',");
			}
			if (top != null) {
				sb.append("top :" + top + ",");
			} else {
				sb.append("top :'50%',");
			}
			
			sb.append("min :" + minFlag + ",");
			sb.append("max :" + maxFlag + ",");
			sb.append("resize :" + resize + ",");
			
			sb.append("opacity : 0.4,");
			sb.append("button : [ {");
			sb.append(StringUtil.replace("name : \'{0}\',", "{0}", confirm));
			sb.append("callback : clickcallback_"+methodname+",");
			sb.append("focus : true");
			sb.append("}, {");
			sb.append(StringUtil.replace("name : \'{0}\',","{0}", cancel));
			sb.append("callback : function() {");
			sb.append("}");
			sb.append("} ]");
			sb.append("});");
			sb.append("}");
		sb.append("}");
		clearAll(sb,methodname);
		callback(sb,methodname);
		sb.append("</script>");
		return sb;
	}
	/**
	 * 清除
	 * @param sb
	 */
	private void clearAll(StringBuffer sb,String methodname) {
		String[] textnames=null;
		String[] inputTextnames=null;
		//update-begin--Author: jg_huangxg  Date: 20160330 for： 防止空指针
		if (!StringUtil.isEmpty(this.textname)) {
			textnames = textname.split(",");
		}
		//update-end--Author: jg_huangxg  Date: 20160330 for： 防止空指针
		if(StringUtil.isNotEmpty(inputTextname)){
			inputTextnames = inputTextname.split(",");
		}else{
			inputTextnames = textnames;
		}
		if (isclear&&StringUtil.isNotEmpty(textname)) {
			sb.append("function clearAll_"+methodname+"(){");
			for (int i = 0; i < textnames.length; i++) {
				inputTextnames[i]=inputTextnames[i].replaceAll("\\[", "\\\\\\\\[").replaceAll("\\]", "\\\\\\\\]").replaceAll("\\.", "\\\\\\\\.");
				sb.append("if($(\'#" + inputTextnames[i] + "\').length>=1){");
				sb.append("$(\'#" + inputTextnames[i] + "\').val('');");
				sb.append("$(\'#" + inputTextnames[i] + "\').blur();");
				sb.append("}");
				sb.append("if($(\"input[name='" + inputTextnames[i] + "']\").length>=1){");
				sb.append("$(\"input[name='" + inputTextnames[i] + "']\").val('');");
				sb.append("$(\"input[name='" + inputTextnames[i] + "']\").blur();");
				sb.append("}");
			}
			sb.append("$(\'#" + hiddenName + "\').val(\"\");");
			sb.append("}");
			}
	}
	/**
	 * 点击确定回填
	 * @param sb
	 */
	private void callback(StringBuffer sb,String methodname) {
		sb.append("function clickcallback_" + methodname + "(){");
		sb.append("iframe = this.iframe.contentWindow;");
		String[] textnames = null;
		String[] inputTextnames = null;
		if (StringUtil.isNotEmpty(textname)) {
			textnames = textname.split(",");
			if (StringUtil.isNotEmpty(inputTextname)) {
				inputTextnames = inputTextname.split(",");
			} else {
				inputTextnames = textnames;
			}

			if(multiType == null){
				
				for (int i = 0; i < textnames.length; i++) {
					inputTextnames[i] = inputTextnames[i].replaceAll("\\[", "\\\\\\\\[").replaceAll("\\]", "\\\\\\\\]")
							.replaceAll("\\.", "\\\\\\\\.");
					sb.append("var " + textnames[i] + "=iframe.get" + name + "Selections(\'" + textnames[i] + "\');	");
					sb.append("if($(\'#" + inputTextnames[i] + "\').length>=1){");
					sb.append("$(\'#" + inputTextnames[i] + "\').val(" + textnames[i] + ");");
					sb.append("$(\'#" + inputTextnames[i] + "\').blur();");
					sb.append("}");
					sb.append("if($(\"input[name='" + inputTextnames[i] + "']\").length>=1){");
					sb.append("$(\"input[name='" + inputTextnames[i] + "']\").val(" + textnames[i] + ");");
					sb.append("$(\"input[name='" + inputTextnames[i] + "']\").blur();");
					sb.append("}");
				}
				
			}else if(multiType != null && multiType.equals("user")){//将人员选择器中选择的人员传回隐藏域
				
				for (int i = 0; i < textnames.length; i++) {
					inputTextnames[i] = inputTextnames[i].replaceAll("\\[", "\\\\\\\\[").replaceAll("\\]", "\\\\\\\\]")
							.replaceAll("\\.", "\\\\\\\\.");
					sb.append("var " + textnames[i] + " = ''; var id = '';");
					sb.append("$.each($(iframe.document.getElementById('selectedUsers')).find('[userid]'),function(index, divElt){if(!realName){");
					sb.append("realName += $(divElt).attr('realname');");
					sb.append("}else{realName += ',' + $(divElt).attr('realname');}");
					sb.append("if(!id){id += $(divElt).attr('peuserid');}else{id += ',' + $(divElt).attr('peuserid');}});");
					
					sb.append("if($(\'#" + inputTextnames[i] + "\').length>=1){");
					sb.append("$(\'#" + inputTextnames[i] + "\').val(" + textnames[i] + ");");
					sb.append("$(\'#" + inputTextnames[i] + "\').blur();");
					sb.append("}");
					sb.append("if($(\"input[name='" + inputTextnames[i] + "']\").length>=1){");
					sb.append("$(\"input[name='" + inputTextnames[i] + "']\").val(" + textnames[i] + ");");
					sb.append("$(\"input[name='" + inputTextnames[i] + "']\").blur();");
					sb.append("}");
				}
				
			}
			
		}
		
		if(multiType == null){//原先默认的，要实现自己的getXXXSelections方法
			if (StringUtil.isNotEmpty(hiddenName)) {
				sb.append("var id =iframe.get" + name + "Selections(\'" + hiddenid + "\');");
				sb.append("if (id!== undefined &&id!=\"\"){");
				sb.append("$(\'#" + hiddenName + "\').val(id);");
				sb.append("}");
			}
		}else{//指定自定义的多选
			if (StringUtil.isNotEmpty(hiddenName)) {
				sb.append("if (id!== undefined &&id!=\"\"){");
				sb.append("$(\'#" + hiddenName + "\').val(id);");
				sb.append("}");
			}
		}
		
		
		if (StringUtil.isNotEmpty(fun)) {
			sb.append("" + fun + "();");// 执行自定义函数
		}
		sb.append("}");
	}
	

	public void setHiddenName(String hiddenName) {
		this.hiddenName = hiddenName;
	}
	
	public void setChooseName(String chooseName) {
		this.chooseName = chooseName;
	}
	public void setName(String name) {
		this.name = name;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	public void setTextname(String textname) {
		this.textname = textname;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public void setTop(String top) {
		this.top = top;
	}

	public void setLeft(String left) {
		this.left = left;
	}

	public void setWidth(String width) {
		this.width = width;
	}

	public void setHeight(String height) {
		this.height = height;
	}

	public void setIsclear(Boolean isclear) {
		this.isclear = isclear;
	}

	public void setHiddenid(String hiddenid) {
		this.hiddenid = hiddenid;
	}
	public void setFun(String fun) {
		this.fun = fun;
	}

	public String getInputTextname() {
		return inputTextname;
	}

	public void setInputTextname(String inputTextname) {
		this.inputTextname = inputTextname;
	}

	public String getLangArg() {
		return langArg;
	}

	public void setLangArg(String langArg) {
		this.langArg = langArg;
	}
	
	public void setIsInit(Boolean isInit) {
		this.isInit = isInit;
	}


	public Boolean getResize() {
		return resize;
	}

	public void setResize(Boolean resize) {
		this.resize = resize;
	}

	public Boolean getMinFlag() {
		return minFlag;
	}

	public void setMinFlag(Boolean minFlag) {
		this.minFlag = minFlag;
	}

	public Boolean getMaxFlag() {
		return maxFlag;
	}

	public void setMaxFlag(Boolean maxFlag) {
		this.maxFlag = maxFlag;
	}

	public String getMultiType() {
		return multiType;
	}

	public void setMultiType(String multiType) {
		this.multiType = multiType;
	}

	public String getFocusSelector() {
		return focusSelector;
	}

	public void setFocusSelector(String focusSelector) {
		this.focusSelector = focusSelector;
	}

	
	
	
	
	
	
	
}
