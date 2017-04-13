package org.jeecgframework.core.enums;

import org.jeecgframework.core.util.StringUtil;

/**
 * LTE样式
 * 
 * @ClassName: SysLTEIconEnum
 * @Description: TODO
 * @CreateDate 2016-4-28
 * @Author 赵宝坤
 * @MobileNo 13851854433
 * @Email 153317923@qq.com
 *
 */
public enum SysLTEIconEnum {
	
	default_icon("default","fa fa-list-alt", "默认"),
	back_icon("back","fa fa-briefcase", "返回"),
	pie_icon("pie","fa fa-bar-chart", "小饼状图"),
	pictures_icon("pictures","fa fa-picture", "图片"),
	pencil_icon("pencil","fa fa-edit", "笔"),
	map_icon("map","fa fa-globe", "小地图"),
	group_add_icon("group_add","fa fa-group", "组"),
	calculator_icon("calculator","fa fa-desktop", "计算器"),
	folder_icon("folder","fa fa-list","文件夹");


    /**
     * 风格
     */
    private String style;
    
    
    /**
     * 样式
     */
    private String themes;
    /**
     * 描述
     */
    private String desc;

    private SysLTEIconEnum(String style, String themes, String desc) {
        this.style = style;
        this.themes = themes;
        this.desc = desc;
    }
    
	public String getStyle() {
		return style;
	}

	public void setStyle(String style) {
		this.style = style;
	}

	public String getThemes() {
		return themes;
	}

	public void setThemes(String themes) {
		this.themes = themes;
	}

	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}


	public static SysLTEIconEnum toEnum(String style) {
		if (StringUtil.isEmpty(style)) {
			//默认风格
			return default_icon;
        }
		for(SysLTEIconEnum item : SysLTEIconEnum.values()) {
			if(item.getStyle().equals(style)) {
				return item;
			}
		}
		//默认风格
		return default_icon;
	}

    public String toString() {
        return "{style: " + style + ", themes: " + themes + ", desc: " + desc +"}";
    }
}
