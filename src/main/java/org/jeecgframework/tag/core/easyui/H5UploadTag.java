package org.jeecgframework.tag.core.easyui;

import java.io.IOException;

import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.jeecgframework.core.util.MutiLangUtil;

/**
 * h5-UploadiFive
 * 
 * @ClassName: H5UploadTag
 * @Description: TODO
 * @CreateDate 2016-8-31
 * @Author 赵宝坤
 *
 */
public class H5UploadTag extends TagSupport {
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -5785289518517198944L;
	
	protected String id;// ID
	protected String uploadScript;//url
	protected String name;//控件名称
	protected String extend="false";//默认为全部file文件
	protected String buttonText="浏览";//按钮文本
	protected boolean multi=true;//是否多文件
	//protected String queueID="filediv";//文件容器ID
	protected boolean dialog=true;//是否是弹出窗口模式
	protected String callback;//队列上传后回调函数
	protected boolean auto=false;//是否自动上传
	protected String onUploadSuccess;//上传成功处理函数
	protected String buttonClass;//按钮样式
	
	protected String formId;// 对应formId，指定传入的form中对应的参数
	protected String formData;// 传入form中对应的参数id，用,分割
	
	protected String height = "25";
	
	protected String width = "100";
	
	
	public String getHeight() {
		return height;
	}
	public void setHeight(String height) {
		this.height = height;
	}
	public String getWidth() {
		return width;
	}
	public void setWidth(String width) {
		this.width = width;
	}
	public String getFormId() {
		return formId;
	}
	public void setFormId(String formId) {
		this.formId = formId;
	}
	public String getFormData() {
		return formData;
	}
	public void setFormData(String formData) {
		this.formData = formData;
	}
	public void setOnUploadSuccess(String onUploadSuccess) {
		this.onUploadSuccess = onUploadSuccess;
	}
	public void setAuto(boolean auto) {
		this.auto = auto;
	}
	public void setCallback(String callback) {
		this.callback = callback;
	}
	public void setDialog(boolean dialog) {
		this.dialog = dialog;
	}
//	public void setQueueID(String queueID) {
//		this.queueID = queueID;
//	}
	public void setButtonText(String buttonText) {
		this.buttonText = buttonText;
	}
	public void setMulti(boolean multi) {
		this.multi = multi;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public String getButtonClass() {
		return buttonClass;
	}
	public void setButtonClass(String buttonClass) {
		this.buttonClass = buttonClass;
	}
	
	public int doStartTag() throws JspTagException {
		return EVAL_PAGE;
	}
	public int doEndTag() throws JspTagException {
		try {
			JspWriter out = this.pageContext.getOut();
			out.print(end().toString());
			out.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return EVAL_PAGE;
	}
	public StringBuffer end() {
		StringBuffer sb = new StringBuffer();
		if ("pic".equals(extend)) {
			extend = "image/*";
		}
		sb.append("<link href=\"plug-in/uploadifive/1.2.2/uploadifive.css\" rel=\"stylesheet\" />");
		sb.append("<script type=\"text/javascript\" src=\"plug-in/uploadifive/1.2.2/jquery.uploadifive.min.js\"></script>");
		sb.append("<script type=\"text/javascript\">");
		sb.append("var param = {};");
				
		
				if (formData!=null) {
					
					String[] paramnames=formData.split(",");				
					for (int i = 0; i < paramnames.length; i++) {
						String paramname=paramnames[i];
						sb.append("var "+paramname+"=$(\'#"+paramname+"\').val();");
					}				 
			        sb.append("var o = {");
			        for (int i = 0; i < paramnames.length; i++) {
						String paramname=paramnames[i];
						if (i==paramnames.length-1) {
							sb.append("'"+paramname+"':"+paramname+"");	
						}else{
							sb.append("'"+paramname+"':"+paramname+",");
						}
					}
			        sb.append("};");
			        sb.append("param = o;");
			        
			        
				}else if (formId!=null) {
					sb.append(" var o = {};");
            		sb.append("    var _array = $('#"+formId+"').serializeArray();");
            		sb.append("    $.each(_array, function() {");
            		sb.append("        if (o[this.name]) {");
            		sb.append("            if (!o[this.name].push) {");
            		sb.append("                o[this.name] = [ o[this.name] ];");
            		sb.append("            }");
            		sb.append("            o[this.name].push(this.value || '');");
            		sb.append("        } else {");
            		sb.append("            o[this.name] = this.value || '';");
            		sb.append("        }");
            		sb.append("    });");
            		sb.append("param = o;");
            		//sb.append("$(\'#"+id+"\').uploadify(\"settings\", \"formData\", o);");
				};
				
				
				sb.append("var flag = false;"
				+"var serverMsg=\"\";"
				+ "$(function(){"
				+"$(\'#"+id+"\').uploadifive({"
				+"buttonText:\'"+MutiLangUtil.getMutiLangInstance().getLang(buttonText)+"\',"
				+"auto:"+auto+","
				+"multi:"+multi+","
				+"height:" + height + ","
				+"width:" + width + ","
				+"formData:param,"
				+"buttonClass:\'" + buttonClass +"\'," 
				//+"queueID:\'"+queueID+"\',"
				+"fileType:\'"+extend+"\',"//文件格式
				+"fileSizeLimit:\'15MB\',"
				+"uploadScript:\'" + uploadScript	 + "\',"		
				+"onQueueComplete : function(queueData) { ");
				
				if(dialog)//一般在对话框中显示
				{
				sb.append("var win = frameElement.api.opener;"  	  
	            +"win.reloadTable();"
	            +"parent.layer.msg(serverMsg);"
	            +"frameElement.api.close();");
				}
				else
				{
				  if(callback!=null)
				  sb.append(""+callback+"();");
				}
				sb.append("},");
				
				
				//上传成功处理函数
				sb.append("onUploadComplete : function(file, data) {");
				sb.append("var result=$.parseJSON(data);");
				if(onUploadSuccess!=null)
				{
				sb.append(onUploadSuccess+"(file,data);");
				}
				sb.append("if(result.success){");
				sb.append("var win = frameElement.api.opener;");
				sb.append("serverMsg = result.msg;");
				sb.append("}");
				sb.append("},");
				sb.append("onError : function(errorType, file) {");
				sb.append(" layer.msg('文件大小超出15M');");
				sb.append("},");
				sb.append("});");
				sb.append("});"
	   			
				
				+"function upload() {"
				+"	$(\'#"+id+"\').uploadifive('upload');"
				+"		return flag;"
				+"}"
				+"function cancel() {"
				+"$(\'#"+id+"\').uploadifive('cancel');"				
				+"}"				
				+"</script>");	
		       sb.append("<span id=\""+id+"span\"><input type=\"file\" name=\""+name+"\" id=\""+id+"\" /></span>");
		        
		return sb;
	}
	
	
	public void setId(String id) {
		this.id = id;
	}
	public void setExtend(String extend) {
		this.extend = extend;
	}
	public String getUploadScript() {
		return uploadScript;
	}
	public void setUploadScript(String uploadScript) {
		this.uploadScript = uploadScript;
	}

	
}
