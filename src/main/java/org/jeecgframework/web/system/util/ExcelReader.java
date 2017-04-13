/*
 * 文件名：ExcelReader.java
 * 版权：Copyright by 
 * 描述：
 * 修改人：Administrator
 * 修改时间：2017年2月4日
 * 跟踪单号：
 * 修改单号：
 * 修改内容：
 */

package org.jeecgframework.web.system.util;



import java.io.FileInputStream;
import java.io.IOException;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

/**
 * 读取Excel 97~2003 xls格式 /2007~ xlsx格式
 * @author      ZhangLiKun
 * @mail        likun_zhang@yeah.net
 * @date        2013-5-11
 */
public class ExcelReader {

    /**
     * 创建工作簿对象
     * @param filePath
     * @return
     * @throws IOException
     * @date    2013-5-11
     */
    public static final Workbook createWb(String filePath) throws IOException {
        if(StringUtils.isBlank(filePath)) {
            throw new IllegalArgumentException("参数错误!!!") ;
        }
        if(filePath.trim().toLowerCase().endsWith("xls")) {
            return new HSSFWorkbook(new FileInputStream(filePath)) ;
        } else if(filePath.trim().toLowerCase().endsWith("xlsx")) {
            return new XSSFWorkbook(new FileInputStream(filePath)) ;
        } else {
            throw new IllegalArgumentException("不支持除：xls/xlsx以外的文件格式!!!") ;
        }
    }
    
   public static void main(String[] args)
{
       Workbook wb;
    try
    {
        wb = createWb("src/main/webapp/doc/Temp-001.xlsx");
        System.out.println(wb.getSheetName(1));
    }
    catch (IOException e)
    {
        // TODO Auto-generated catch block
        e.printStackTrace();
    }
    
}
    
}