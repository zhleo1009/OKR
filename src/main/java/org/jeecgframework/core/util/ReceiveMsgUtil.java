package org.jeecgframework.core.util;

import java.io.IOException;

import org.jeecgframework.core.constant.Globals;
import org.jeecgframework.web.system.service.SystemService;
import org.springframework.beans.factory.annotation.Autowired;

import com.linkage.netmsg.NetMsgclient;
import com.linkage.netmsg.server.AnswerBean;
import com.linkage.netmsg.server.ReceiveMsg;
import com.linkage.netmsg.server.ReturnMsgBean;
import com.linkage.netmsg.server.UpMsgBean;
/**
 * 下行短信发送工具类
 * @author wudq
 *
 */
public class ReceiveMsgUtil extends ReceiveMsg {
		
	@Autowired
	private SystemService systemService;
	/**
	 * 获取下行短信返回状态和短信ID的方法
	 */
	public void getAnswer(AnswerBean answerBean) {
		super.getAnswer(answerBean);
		//序列Id
//		String seqIdString = answerBean.getSeqId();
		//短信状态 ,0表示提交至API平台成功
		int status = answerBean.getStatus();
		//下行短信ID，用来唯一标识一条下行短信
		String msgId = answerBean.getMsgId();

		//此处加入接收短信返回状态和短信ID的处理代码（即:将接收到的信息做入库处理）
		String msg = "下行短信ID：" + msgId;
		if(0 == status){
			msg += "发送成功";
		}else if(1 == status){
			msg += "系统错误";
		}else if(2 == status){
			msg += "帐号错误";
		}else if(3 == status){
			msg += "密码错误";		
		}else if(4 == status){
			msg += "连接数超过限制";
		}else if(5 == status){
			msg += "秒发送条目数超过限制";
		}else if(6 == status){
			msg += "目的号码受限制";
		}else if(7 == status){
			msg += "网络错误";
		}else if(8 == status){
			msg += "月发送条目数超过限制";
		}else if(9 == status){
			msg += "客户端关闭连接";
		}else if(10 == status){
			msg += "短信网关关闭连接";
		}else if(11 == status){
			msg += "超时退出";
		}else if(12 == status){
			msg += "连接数据库错误";
		}else if(13 == status){
			msg += "连接短信网关错误";
		}else if(14 == status){
			msg += "非法发送内容";
		}else if(15 == status){
			msg += "非法发送时间";
		}else if(16 == status){
			msg += "socket连接已经关闭";
		}else if(23 == status){
			msg += "发送号码前缀错误";
		}
		
		systemService.addLog(msg, Globals.LOG_TYPE_SENDSMS, Globals.Log_Leavel_INFO);

	}

	/**
	 * 接收上行短信的方法
	 */
	public void getUpMsg(UpMsgBean upMsgBean) {
		super.getUpMsg(upMsgBean);
	}

	/**
	 *  获取下行短信回执的方法
	 */
	public void getReturnMsg(ReturnMsgBean returnMsgBean) {
		super.getReturnMsg(returnMsgBean);

		String sequenceId = returnMsgBean.getSequenceId();
		// 短信的msgId 
		String msgId = returnMsgBean.getMsgId();
		// 发送号码
		String sendNum = returnMsgBean.getSendNum();
		// 接收号码 
		String receiveNum = returnMsgBean.getReceiveNum();
		// 短信提交时间 
		String submitTime = returnMsgBean.getSubmitTime();
		// 短信下发时间
		String sendTime = returnMsgBean.getSendTime();
		// 短信状态 
		String msgStatus = returnMsgBean.getMsgStatus();
		// 短信错误代码
		int msgErrStatus = returnMsgBean.getMsgErrStatus();

		//此处加入接收短信回执的处理代码
		System.out.println("ReturnMsgBean sequenceId: " + sequenceId);
		System.out.println("ReturnMsgBean msgId: " + msgId);
		System.out.println("ReturnMsgBean sendNum: " + sendNum);
		System.out.println("ReturnMsgBean receiveNum: " + receiveNum);
		System.out.println("ReturnMsgBean submitTime: " + submitTime);
		System.out.println("ReturnMsgBean sendTime: " + sendTime);
		System.out.println("ReturnMsgBean msgStatus: " + msgStatus);
		System.out.println("ReturnMsgBean msgErrStatus: " + msgErrStatus);
	}
	
	/**
	 * 据配置的信息获得NetMsgclient对象
	 * @param ipAddress API公网接连IP地址
	 * @param port     API访问端口号
	 * @param username  用户名
	 * @param password  密码
	 * 获取验证过的NetMsgclient对象，
	 * @return  netMsgclient：null
	 */
	public  NetMsgclient getNetMsgclient(){
		
		//ReceiveMsgUtil为ReceiveMsg类的子类，构造时，构造自己继承的子类就行
        ReceiveMsg receiveMsg = new ReceiveMsgUtil();
        NetMsgclient client   = new NetMsgclient();
        try {
        	PropertiesUtil util = new PropertiesUtil("sysConfig.properties");
        	//初始化参数 
        	client = client.initParameters(util.readProperty("receiveMsg.ipAddress"), Integer.parseInt(util.readProperty("receiveMsg.port")),
				util.readProperty("receiveMsg.username"), util.readProperty("receiveMsg.pwd"), receiveMsg);
		
			if (client.anthenMsg(client)) {
				return client;
			}
		} catch (IOException e) {
			
			e.printStackTrace();
		}
		return null;
	}	
}
