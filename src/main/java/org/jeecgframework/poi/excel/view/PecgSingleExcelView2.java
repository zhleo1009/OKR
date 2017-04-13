package org.jeecgframework.poi.excel.view;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.DataFormat;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.jeecgframework.core.util.DateUtils;
import org.jeecgframework.poi.excel.entity.vo.NormalExcelConstants;
import org.jeecgframework.web.system.pojo.base.TSDepart;
import org.jeecgframework.web.system.pojo.base.TSUser;
import org.jeecgframework.web.system.service.SystemService;
import org.jeecgframework.web.system.util.ExcelReader;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.jeecg.project.entity.ProjectEntity;
import com.jeecg.scokr.entity.ScOkrEntity;
import com.jeecg.scworkinghours.entity.ScWorkingHoursEntity;

/**
 * 从JeecgSingleExcelView改造来
 * 
 * @ClassName: PecgSingleExcelView
 * @Description: TODO
 * @CreateDate 2017-2-5
 * @Author 张浩
 *
 */
@SuppressWarnings("unchecked")
@Controller(NormalExcelConstants.JEECG_EXCEL_VIEW)
public class PecgSingleExcelView2 extends JeecgSingleExcelView{
	
	public PecgSingleExcelView2() {
        super();
    }
	
	@Autowired
    private SystemService systemService;
	

	//通过userId获取 realName
    private String getUserNameById(String userId){
         TSUser user = systemService.get(TSUser.class, userId);
         if(null!=user){
             return user.getRealName();
         }
         return "";
        
    }
    
    //通过id返回departname
    private String getDepartNameById(String id){
        TSDepart depart = systemService.findUniqueByProperty(TSDepart.class, "id", id);
        if(null != depart){
            return depart.getDepartname();
        }
       
         return "";
    }
    

	//通过syscode返回departname
    private String getDepartNameByCode(String code){
        TSDepart needOrg = systemService.findUniqueByProperty(TSDepart.class, "orgCode", code);
        if (needOrg != null) {
            return needOrg.getDepartname();
        }
    
         return "";
    }
    
    
    
    

    @Override
    protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
                                           HttpServletResponse response) throws Exception {
        String codedFileName = "临时文件";
        Workbook workbook = null;
     
        //获取模板路径
        String proPath = request.getServletContext().getRealPath("");
       // workbook =  ExcelReader.createWb( proPath+"/doc/Temp-001.xlsx"); 
        workbook =  ExcelReader.createWb( proPath+"/doc/Temp-002.xlsx"); 
            
        // sheet 对应一个工作页  
        Sheet sheet = workbook.getSheetAt(1);  
        
        List<ScOkrEntity> dataList = (List<ScOkrEntity>)model.get(NormalExcelConstants.DATA_LIST);
               
               for (int j = 0; j < dataList.size(); j++) {  
                   ScOkrEntity entity = dataList.get(j);
                   // 创建一行：从第4行开始，跳过属性列  
                   Row row = sheet.getRow(j + 3);  
                   // 在一行内循环  
//                   //第1列
//                   Cell first = row.createCell(0);  
//                   first.setCellValue(getDepartNameByCode(entity.getSysOrgCode()));  
//                   //第2列
//                   Cell second = row.createCell(1);  
//                   second.setCellValue(getDepartNameByCode(entity.getSysCompanyCode()));  
                   //第3列
                   Cell third = row.getCell(2);  
                   third.setCellValue(entity.getObjective());  
                   //第4列
                   Cell fourth = row.getCell(3);  
                   fourth.setCellValue(entity.getKeyResult());  
                   //第5列
                   Cell five = row.getCell(4);  
                   five.setCellValue(entity.getMission()); 
                   //第6列
                   Cell six = row.getCell(5);  
                   six.setCellValue(getUserNameById(entity.getUserId()));
                   //第7列
                   Cell seven = row.getCell(6); 
                   String planTime = entity.getPlanTime();
                   if(planTime != null){
                       seven.setCellValue(DateUtils.dateformat(planTime, "yyyy-MM-dd"));
                   }
                   //第8列
                   Cell eight = row.getCell(7);  
                   eight.setCellValue(entity.getDifficulties());
                   
                   /*第9列
                    */
                   Cell nine = row.getCell(8);  
                   if (!"".equals(entity.getPercent()))
                   {
                	   nine.setCellValue(entity.getPercent()+"%");
                   }
                   
                   
                   
                   //第10列
                   Cell ten = row.getCell(9);  
                   ten.setCellValue(entity.getUnfinishedReason());
                   //第11列
                   Cell eleven = row.getCell(10);  
                   eleven.setCellValue(getDepartNameById(entity.getNeedOrgCode()));
                   //第12列
                   Cell twelve = row.getCell(11);  
                   String finishTime = entity.getFinishTime();
                   if(finishTime != null){
                       twelve.setCellValue(DateUtils.dateformat(finishTime, "yyyy-MM-dd"));
                   }
               }  
               
        
        
        
        if (model.containsKey(NormalExcelConstants.FILE_NAME)) {
            codedFileName = (String) model.get(NormalExcelConstants.FILE_NAME);
        }
        if (workbook instanceof HSSFWorkbook) {
            codedFileName += HSSF;
            setExcelStyle((HSSFWorkbook)workbook);
        } else {
            codedFileName += XSSF;
        }
        if (isIE(request)) {
            codedFileName = java.net.URLEncoder.encode(codedFileName, "UTF8");
        } else {
            codedFileName = new String(codedFileName.getBytes("UTF-8"), "ISO-8859-1");
        }
        response.setHeader("content-disposition", "attachment;filename=" + codedFileName);
        ServletOutputStream out = response.getOutputStream();
        
        workbook.write(out);
        out.flush();
    }
    
    /**
     * 自定义excel样式，row-微软雅黑加粗14，row2-微软雅黑加粗12，row3-微软雅黑加粗10
     * 
     * @createby bkzhao
     * @param workbook
     */
    private void setExcelStyle(HSSFWorkbook workbook){
    	
    	//调整字体
		HSSFSheet sheet = workbook.getSheetAt(0);
		 
		int rowNum = sheet.getFirstRowNum();
		
		// row1
		HSSFRow row = sheet.getRow(rowNum);
		int cellNum = row.getFirstCellNum();
		HSSFCell cell = row.getCell(cellNum);
		
		HSSFFont font = workbook.createFont(); 
		font.setFontName("微软雅黑");
        font.setFontHeightInPoints((short) 14);
        font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		cell.getCellStyle().setFont(font);
		
		// row2
		HSSFFont fontRow2 = workbook.createFont(); 
		fontRow2.setFontName("微软雅黑");
		fontRow2.setFontHeightInPoints((short) 10);
		fontRow2.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		row = sheet.getRow(rowNum + 1);
		cellNum = row.getFirstCellNum();
		cell = row.getCell(cellNum);
		cell.getCellStyle().setFont(fontRow2);
		
		
		// 列头样式
		row = sheet.getRow(rowNum + 2);
		int first = row.getFirstCellNum();
		int last = row.getLastCellNum();
		
		for (int i = first; i < last; i++) {
			cell = row.getCell(i);
			HSSFFont fontRow3 = workbook.createFont(); 
			fontRow3.setFontName("微软雅黑");
			fontRow3.setFontHeightInPoints((short) 10);
			fontRow3.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
			cell.getCellStyle().setFont(fontRow3);
		}
		
    }

}
