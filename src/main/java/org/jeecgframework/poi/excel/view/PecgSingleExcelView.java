package org.jeecgframework.poi.excel.view;

import java.util.Collection;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Workbook;
import org.jeecgframework.poi.excel.ExcelExportUtil;
import org.jeecgframework.poi.excel.entity.ExportParams;
import org.jeecgframework.poi.excel.entity.vo.NormalExcelConstants;
import org.jeecgframework.poi.excel.export.ExcelExportServer;
import org.springframework.stereotype.Controller;

/**
 * 从JeecgSingleExcelView改造来
 * 
 * @ClassName: PecgSingleExcelView
 * @Description: TODO
 * @CreateDate 2016-8-19
 * @Author 赵宝坤
 *
 */
@SuppressWarnings("unchecked")
@Controller(NormalExcelConstants.JEECG_EXCEL_VIEW)
public class PecgSingleExcelView extends JeecgSingleExcelView{
	
	public PecgSingleExcelView() {
        super();
    }

    @Override
    protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
                                           HttpServletResponse response) throws Exception {
        String codedFileName = "临时文件";
        Workbook workbook = null;
        if (model.containsKey(NormalExcelConstants.MAP_LIST)) {
            List<Map<String, Object>> list = (List<Map<String, Object>>) model
                .get(NormalExcelConstants.MAP_LIST);
            if (list.size() == 0) {
                throw new RuntimeException("MAP_LIST IS NULL");
            }
            workbook = ExcelExportUtil.exportExcel(
                (ExportParams) list.get(0).get(NormalExcelConstants.PARAMS), (Class<?>) list.get(0)
                    .get(NormalExcelConstants.CLASS),
                (Collection<?>) list.get(0).get(NormalExcelConstants.DATA_LIST));
            for (int i = 1; i < list.size(); i++) {
                new ExcelExportServer().createSheet(workbook,
                    (ExportParams) list.get(i).get(NormalExcelConstants.PARAMS), (Class<?>) list
                        .get(i).get(NormalExcelConstants.CLASS),
                    (Collection<?>) list.get(i).get(NormalExcelConstants.DATA_LIST));
            }
        } else {
            workbook = ExcelExportUtil.exportExcel(
                (ExportParams) model.get(NormalExcelConstants.PARAMS),
                (Class<?>) model.get(NormalExcelConstants.CLASS),
                (Collection<?>) model.get(NormalExcelConstants.DATA_LIST));
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
