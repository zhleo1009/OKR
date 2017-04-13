package org.jeecgframework.tag.core.easyui;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import org.jeecgframework.core.constant.Globals;
import org.jeecgframework.core.util.ApplicationContextUtil;
import org.jeecgframework.core.util.ResourceUtil;
import org.jeecgframework.core.util.oConvertUtils;
import org.jeecgframework.web.system.pojo.base.TSOperation;
import org.jeecgframework.web.system.service.SystemService;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * 权限tag
 * 
 * @ClassName: AuthTag
 * @Description: TODO
 * @CreateDate 2016-8-17
 * @Author 赵宝坤
 * 
 */
public class AuthTag extends TagSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = -3849053669672382442L;

	@Autowired
	private static SystemService systemService;

	private String operationCode;

	public String getOperationCode() {
		return operationCode;
	}

	public void setOperationCode(String operationCode) {
		this.operationCode = operationCode;
	}
	
	


	@SuppressWarnings("unchecked")
	@Override
	public int doStartTag() throws JspException {

		if (ResourceUtil.getSessionUserName().getUserName().equals("admin") || !Globals.BUTTON_AUTHORITY_CHECK) {
			return EVAL_BODY_INCLUDE;
		} else if (!oConvertUtils.isEmpty(operationCode)) {
			Set<String> operationCodes = (Set<String>) super.pageContext.getRequest().getAttribute(Globals.OPERATIONCODES);
			if (null != operationCodes) {
				List<String> operationCodesStr = new ArrayList<String>();
				for (String MyoperationCode : operationCodes) {
					if (oConvertUtils.isEmpty(MyoperationCode))
						break;
					systemService = ApplicationContextUtil.getContext().getBean(SystemService.class);
					TSOperation operation = systemService.getEntity(TSOperation.class, MyoperationCode);
					operationCodesStr.add(operation.getOperationcode());
				}
				if (operationCodesStr.contains(operationCode)) {
					return SKIP_BODY;
				}
			}
		}

		return EVAL_PAGE;
	}

}
