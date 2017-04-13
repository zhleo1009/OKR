package org.jeecgframework.tag.core.easyui;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.jeecgframework.web.system.pojo.base.TSFunction;

import org.jeecgframework.core.util.ListtoMenu;


/**
 * 系统菜单标签
 * 
 * @ClassName: MenuTag
 * @Description: TODO
 * @CreateDate 2016-4-28
 * @Author 赵宝坤
 * @MobileNo 13851854433
 * @Email 153317923@qq.com
 *
 */
public class MenuTag extends TagSupport {
	private static final long serialVersionUID = 1L;
	protected String style = "easyui";// 菜单样式
	protected List<TSFunction> parentFun;// 一级菜单
	protected List<TSFunction> childFun;// 二级菜单
	protected Map<Integer, List<TSFunction>> menuFun;// 菜单Map

	public void setParentFun(List<TSFunction> parentFun) {
		this.parentFun = parentFun;
	}

	public void setChildFun(List<TSFunction> childFun) {
		this.childFun = childFun;
	}

	public int doStartTag() throws JspTagException {
		return EVAL_PAGE;
	}

	public int doEndTag() throws JspTagException {
		try {
			JspWriter out = this.pageContext.getOut();
			String menu = (String) this.pageContext.getSession().getAttribute("leftMenuCache" + style);
			if (menu != null) {
				out.print(menu);
			} else {
				menu = end().toString();
				this.pageContext.getSession().setAttribute("leftMenuCache" + style, menu);
				out.print(menu);

			}

		} catch (IOException e) {
			e.printStackTrace();
		}
		return EVAL_PAGE;
	}

	public StringBuffer end() {
		StringBuffer sb = new StringBuffer();
		if (style.equals("easyui")) {
			sb.append("<ul id=\"nav\" class=\"easyui-tree tree-lines\" fit=\"true\" border=\"false\">");
			sb.append(ListtoMenu.getEasyuiMultistageTree(menuFun, style));
			sb.append("</ul>");
		}
		if (style.equals("shortcut")) {
			sb.append("<div id=\"nav\" style=\"display:block;\" class=\"easyui-accordion\" fit=\"true\" border=\"false\">");
			sb.append(ListtoMenu.getEasyuiMultistageTree(menuFun, style));
			sb.append("</div>");
		}
		if (style.equals("bootstrap")) {
			sb.append(ListtoMenu.getBootMenu(parentFun, childFun));
		}
		if (style.equals("json")) {
			sb.append("<script type=\"text/javascript\">");
			sb.append("var _menus=" + ListtoMenu.getMenu(parentFun, childFun));
			sb.append("</script>");
		}
		if (style.equals("june_bootstrap")) {
			sb.append(ListtoMenu.getBootstrapMenu(menuFun));
		}
		if (style.equals("ace")) {
			sb.append(ListtoMenu.getAceMultistageTree(menuFun));
		}
		if (style.equals("diy")) {
			sb.append(ListtoMenu.getDIYMultistageTree(menuFun));
		}
		if(style.equals("lte")){// add by zbk
			sb.append(ListtoMenu.getLteMultistageTree(menuFun));
		}
		return sb;
	}

	public void setStyle(String style) {
		this.style = style;
	}

	public void setMenuFun(Map<Integer, List<TSFunction>> menuFun) {
		this.menuFun = menuFun;
	}

}
