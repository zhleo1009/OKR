package org.jeecgframework.web.system.util;
import java.io.*;


import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;
import org.apache.commons.codec.digest.*;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.jeecgframework.core.util.PropertiesUtil;

import sun.net.www.protocol.file.FileURLConnection;
import sun.net.www.protocol.ftp.FtpURLConnection;
public class ConvertDocUtils {
	 private static ConvertDocUtils instance;

	    private static boolean DEBUG=false;
	    private final static String OUTPUT_FOLDER="c:/Users/Administrator/Desktop/nginx/";//输出文件夹
	    private final static String CONVERT_LIB_FOLDER="c:/Users/Administrator/Desktop/convertLib/lib/";//转换jar所在文件夹
	    private final static String STATIC_SERVER="http://192.168.99.158:80/";//用户查看html的，静态服务器地址
	    private final static String STATIC_FROM_SERVER="http://localhost:8080/";//下载文件服务器地址
	    private PropertiesUtil util = new PropertiesUtil("sysConfig.properties");
	    
	    public static ConvertDocUtils getInstance() {
	        if (instance == null) instance = new ConvertDocUtils();
	        return instance;
	    }


	    /**
	     * 获取文件md5值
	     *
	     * @param filePath
	     */
	    private String getFileMd5(String filePath) throws FileNotFoundException {
	        FileInputStream fis = new FileInputStream(filePath);
	        try {
	            String md5 = DigestUtils.md5Hex(IOUtils.toByteArray(fis));
	            IOUtils.closeQuietly(fis);
	            return md5;
	        } catch (IOException e) {
	            e.printStackTrace();

	        }
	        return null;
	    }


	    /**
	     * 判断文件是否已经转换过,根据文件md5名判断
	     *
	     * @param filePath
	     */
	    private boolean checkIfFileConverted(String filePath) {
	        try {
	            String md5 = getFileMd5(filePath);
	            if (StringUtils.isNotBlank(md5) && StringUtils.isNotEmpty(md5)) {

	                String searchFileName =DEBUG?OUTPUT_FOLDER+"html"+File.separator+md5+".html":util.readProperty("convertDocOutput")+"html"+File.separator+md5+".html";
	                return checkToConvertFileExist(searchFileName);
	            } else {
	                System.err.println("文件md5值获取失败!");
	                return false;
	            }
	        } catch (FileNotFoundException e) {
	            e.printStackTrace();
	        }
	        return false;

	    }


	    private boolean checkToConvertFileExist(String path) {
	        File file = new File(path);
	        if (!file.exists()) {
	            return false;
	        }
	        return true;
	    }


	    /**
	     * 调用jar，转换office to html
	     *
	     * @param path
	     */
	    private Map<String, Object> convertDocToHtmlCmd(String path) throws FileNotFoundException{
	        Map<String, Object> resultMap = new HashMap<String, Object>();
	        String searchFileCmd =DEBUG? "java -jar " + CONVERT_LIB_FOLDER+ "jodconverter-cli-2.2.2.jar \"" + path + "\" " + OUTPUT_FOLDER+"html"+ File.separator + getFileMd5(path) + ".html":"java -jar " + util.readProperty("convertLibPath")+ "jodconverter-cli-2.2.2.jar " + path + " " + util.readProperty("convertDocOutput")+"html"+ File.separator + getFileMd5(path) + ".html";
	        System.out.println(searchFileCmd);
	        String[] result = execute(searchFileCmd);
	        boolean resultFlag = checkIfFileConverted(path);//转换结束后再去查一遍文件
	        if (!resultFlag) {//含有错误信息，转换失败
	            System.err.println(result[1]);
	            resultMap.put("result", false);
	            resultMap.put("pageUrl", "");
	            return null;
	        } else {
	            System.out.println(result[0]);
	            resultMap.put("result", true);
	            resultMap.put("pageUrl", DEBUG?STATIC_SERVER + getFileMd5(path) + ".html":util.readProperty("staticServerPath")+ getFileMd5(path) +".html");
	            return resultMap;
	        }


	    }


	    /**
	     * 公共方法，将文档转成html
	     *
	     * @param path
	     * @return result true成功 false失败
	     */
	    public Map<String, Object> convertDocToHtml(String path,String dateDir) throws FileNotFoundException{
	        Map<String, Object> resultMap = new HashMap<String, Object>();
	        if (StringUtils.isEmpty(path) || StringUtils.isBlank(path)) {
	            resultMap.put("result", false);
	            resultMap.put("message", "文件路径为空!");
	            return resultMap;
	        }

	        String suffix = path.substring(path.lastIndexOf(".") + 1, path.length());
	        if (suffix.toLowerCase().equals("txt") || suffix.toLowerCase().equals("doc") || suffix.toLowerCase().equals("docx") || suffix.toLowerCase().equals("ppt") || suffix.toLowerCase().equals("pptx") || suffix.toLowerCase().equals("xls") || suffix.toLowerCase().equals("xlsx") || suffix.toLowerCase().equals("pdf")) {
	            path = path.replace("\\", File.separator).replace("/", File.separator);
	           
//	            String searchSourceFileName =DEBUG?OUTPUT_FOLDER+"source"+File.separator+path:util.readProperty("convertDocOutput")+"source"+File.separator+path;
//
//	            System.out.println(searchSourceFileName);
	        
	            
	          //文件在服务器上的真实路径
                String realpath = util.readProperty("fileBasePath")+File.separator+ dateDir+ File.separator +path;
	            
	            if (checkIfFileConverted(realpath)) {//转换过的文件已经存在的话，则直接返回页面路径
	                System.out.println("找到文件啦！！");
	                resultMap.put("result", true);
	                resultMap.put("pageUrl", DEBUG?STATIC_SERVER + getFileMd5(realpath) + ".html":util.readProperty("staticServerPath") + getFileMd5(realpath) + ".html");
	                return resultMap;

	            } else {
	            	//转换文件
	                //从服务器下载文件
//	                downLoadFile(path,dateDir);
//	                System.out.println("文件没有找到！！！");
	               // String searchFileName =DEBUG?OUTPUT_FOLDER+"source"+File.separator+path:initParameter.getConvertDocOutput()+"source"+File.separator  + path;
//	                String searchFileName =DEBUG?OUTPUT_FOLDER+"source"+File.separator+path:util.readProperty("convertDocOutput")+"source"+File.separator+path;
	                
	                

	                if (checkToConvertFileExist(realpath)) {//文件存在则转换
	                    return convertDocToHtmlCmd(realpath);
	                } else {
	                    resultMap.put("result", false);
	                    resultMap.put("message", "文件不存在!");
	                    return resultMap;
	                }

	            }
	        } else {
	            resultMap.put("result", false);
	            resultMap.put("message", "不支持该格式的在线预览！");
	            return resultMap;
	        }


	    }


	    /**
	     * 执行shell命令
	     *
	     * @param cmds
	     * @return
	     */
	    private String[] execute(String cmds) {
	        try {
	            String[] resultStr = new String[2];
	            Process ps = Runtime.getRuntime().exec(cmds);

	            resultStr[0] = loadStream(ps.getInputStream());//正确输出信息
	            resultStr[1] = loadStream(ps.getErrorStream());//错误输出信息
	            return resultStr;
	        } catch (IOException ioe) {
	            ioe.printStackTrace();
	        }
	        return null;
	    }

	    private static int BUFFER_SIZE = 8096; //缓冲区大小

	    public  void downLoadFile(String remoteFileName,String dateDir) {
	        FileOutputStream fos = null;
	        BufferedInputStream bis = null;
	        FtpURLConnection fileUrl = null;
	        URL url = null;
	        byte[] buf = new byte[BUFFER_SIZE];
	        int size = 0;
	        
            String path = util.readProperty("fileBasePath")+File.separator+ dateDir+ File.separator +remoteFileName;

	        String remoteFileUrl=DEBUG?STATIC_FROM_SERVER+remoteFileName:"ftp://"+path;

	        String outputFilePath=DEBUG?OUTPUT_FOLDER+"source"+File.separator+remoteFileName:util.readProperty("convertDocOutput")+"source"+File.separator+remoteFileName;
	        File file = new File(outputFilePath);
	        if(!file.getParentFile().exists()) {
	            //如果目标文件所在的目录不存在，则创建父目录
	            System.out.println("目标文件所在目录不存在，准备创建它！");
	            if(!file.getParentFile().mkdirs()) {
	                System.out.println("创建目标文件所在目录失败！");
	            }
	        }
	        System.out.println(remoteFileUrl);

	        //连接指定的资源
	        try {
	            //建立链接
	            url = new URL(remoteFileUrl);
	            fileUrl = (FtpURLConnection) url.openConnection();
	            fileUrl.connect();
	            //获取网络输入流
	            bis = new BufferedInputStream(fileUrl.getInputStream());
	            //建立文件
	            fos = new FileOutputStream(outputFilePath);

	            System.out.println("正在获取链接[" + remoteFileUrl + "]的内容...\n将其保存为文件[" +
	                    outputFilePath + "]");
	            //保存文件
	            while ((size = bis.read(buf)) != -1)
	                fos.write(buf, 0, size);
	            fos.close();
	            bis.close();
//	            fileUrl.disconnect();
	           // convertDocToHtml(outputFilePath);
	        } catch (IOException e) {
	            e.printStackTrace();
	        }


	    }


	    public static void main(String[] args) throws FileNotFoundException {
//	        ConvertDocUtils.getInstance().convertDocToHtml("test/test.docx");

//	        String path = "/Users/Aaron/Desktop/test.xls";
//	        String suffix = path.substring(path.lastIndexOf("."), path.length());
//	        System.out.println(suffix);
	//
//	        path = path.replaceAll("\\\\", File.separator).replaceAll("/", File.separator);
//	        System.out.println(path);

//	        String v = getMd5ByFile(new File(path));
//	        System.out.println("MD5:"+v.toUpperCase());
	//
//	        FileInputStream fis= new FileInputStream(path);
//	        try{
//	            String md5 = DigestUtils.md5Hex(IOUtils.toByteArray(fis));
//	            IOUtils.closeQuietly(fis);
//	            System.out.println("MD5:"+md5);
//	        }catch (IOException e){
//	            e.printStackTrace();
	//
//	        }

	    }

	    /**
	     * 命令输出
	     *
	     * @param in
	     * @return
	     * @throws IOException
	     */
	    private String loadStream(InputStream in) throws IOException {
	        int ptr = 0;
	        in = new BufferedInputStream(in);
	        StringBuffer buffer = new StringBuffer();
	        while ((ptr = in.read()) != -1) {
	            buffer.append((char) ptr);
	        }
	        return buffer.toString();
	    }


//	    private  String getMd5ByFile(File file) throws FileNotFoundException {
//	        String value = null;
//	        FileInputStream in = new FileInputStream(file);
//	        try {
//	            MappedByteBuffer byteBuffer = in.getChannel().map(FileChannel.MapMode.READ_ONLY, 0, file.length());
//	            MessageDigest md5 = MessageDigest.getInstance("MD5");
//	            md5.update(byteBuffer);
//	            BigInteger bi = new BigInteger(1, md5.digest());
//	            value = bi.toString(16);
//	        } catch (Exception e) {
//	            e.printStackTrace();
//	        } finally {
//	            if(null != in) {
//	                try {
//	                    in.close();
//	                } catch (IOException e) {
//	                    e.printStackTrace();
//	                }
//	            }
//	        }
//	        return value;
//	    }

}
