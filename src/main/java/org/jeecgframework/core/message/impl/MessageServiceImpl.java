package org.jeecgframework.core.message.impl;

import java.util.Date;
import java.util.Map;

import org.antlr.grammar.v3.ANTLRv3Parser.exceptionGroup_return;
import org.jeecgframework.core.constant.Globals;
import org.jeecgframework.core.message.IMessageService;
import org.jeecgframework.core.util.PropertiesUtil;
import org.jeecgframework.core.util.ReceiveMsgUtil;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.web.sms.entity.TSSmsEntity;
import org.jeecgframework.web.sms.service.TSSmsServiceI;
import org.jeecgframework.web.sms.util.Constants;
import org.jeecgframework.web.sms.util.TuiSongMsgUtil;
import org.jeecgframework.web.system.pojo.base.TSUser;
import org.jeecgframework.web.system.service.SystemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.linkage.netmsg.NetMsgclient;

@Service("cgMessageService")
@Transactional
public class MessageServiceImpl implements IMessageService {

	@Autowired
	private TSSmsServiceI tSSmsService;
	@Autowired
	private SystemService systemService;

	@Override
	public void sendInnerMessage(String receiverUserId, String title, String content, String senderUserName) throws Exception {

		TSSmsEntity ts = new TSSmsEntity();
		ts.setCreateDate(new Date());
		ts.setEsContent(content);
		ts.setEsReceiverUserId(receiverUserId);
		if (StringUtil.isEmpty(senderUserName)) {
			ts.setEsSender("系统消息");
		} else {
			ts.setEsSender(senderUserName);
		}
		ts.setEsTitle(title);
		ts.setEsType(Constants.SMS_SEND_TYPE_3);// 系统提醒
		ts.setIsRead(0);// 未读
		ts.setEsSendtime(new Date());
		ts.setEsStatus(Constants.SMS_SEND_STATUS_2);// 发送成功
		tSSmsService.save(ts);

	}

	@Override
	public void sendInnerMessageWithTemplate(String code, String title, Map<String, Object> map, String receiverUserId, String receiverUserName,
			String senderUserName) throws Exception {
		try {
			TSSmsEntity ts = TuiSongMsgUtil
					.sendMessage(title, Constants.SMS_SEND_TYPE_3, code, map, receiverUserId, receiverUserName, senderUserName);
			if (ts != null) {
				tSSmsService.save(ts);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception(e.getMessage());
		}

	}
	
	@Override
	public String sendSMSByPeUserId(String peUserId, String content) throws Exception {
		
		TSUser user = systemService.findUniqueByProperty(TSUser.class, "peUserId", peUserId);
		
		String result = sendSMSByTSUser(user, content);
		if(result == null){
			return "peUserId：" + peUserId + "，用户不存在";
		}
		
		return result;
	}
	
	
	@Override
	public String sendSMSByUserId(String userId, String content) throws Exception {
		
		TSUser user = systemService.getEntity(TSUser.class, userId);
		
		String result = sendSMSByTSUser(user, content);
		if(result == null){
			return "uesrId：" + userId + "，用户不存在";
		}
		
		return result;
	}
	
	

	@Override
	public String sendSMSByUserName(String userName, String content) throws Exception {
		
		TSUser user = systemService.findUniqueByProperty(TSUser.class, "userName", userName);
		
		String result = sendSMSByTSUser(user, content);
		if(result == null){
			return "userName：" + userName + "，用户不存在";
		}
		
		return result;
	}

	private String sendSMSByTSUser(TSUser user, String content) throws Exception{
		String returnMsg = "";
		if (null != user) {
			NetMsgclient netMsgclient = new ReceiveMsgUtil().getNetMsgclient();
			PropertiesUtil util = new PropertiesUtil("sysConfig.properties");
			String sendType = util.readProperty("receiveMsg.sendType");
			int isNeedReport = 1;
			if(null != netMsgclient){
				//sendType:发送类型  0:计费号码发送,1:绑定号码轮询  isNeedReport:是否需要回执
				for (int i = 0; i < 3; i++) {
					returnMsg = netMsgclient.sendMsg(netMsgclient, Integer.parseInt(sendType), user.getMobilePhone(), content, isNeedReport);
					if (null != returnMsg && ("16").equals(returnMsg)) {
						Thread.sleep(3000);
						returnMsg = netMsgclient.sendMsg(netMsgclient, Integer.parseInt(sendType), user.getMobilePhone(), content, isNeedReport);
						if(i == 2){
							String msg = "userId为：" + user.getId() + "第" + i + "次短信未发送成功";
							systemService.addLog(msg, Globals.LOG_TYPE_SENDSMS, Globals.Log_Leavel_INFO);
							netMsgclient.closeConn();
							return "连接出现异常";
						}
					
					}else if(null != returnMsg && returnMsg.length()==9){
						break;
					}
				}
				
			}else{
				return "企业通账号认证未通过";
			}
			return "发送成功";
		}
		return null;
		
	}
	
}
