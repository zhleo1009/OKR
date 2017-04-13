package org.jeecgframework.core.message;

import java.util.Map;

/**
 * cg系统消息处理
 * 
 * @ClassName: IMessageService
 * @Description: TODO
 * @CreateDate 2016-7-25
 * @Author 赵宝坤
 * 
 */
public interface IMessageService {

	/**
	 * 发送站内信
	 * 
	 * @param receiverUserId	接收人userId
	 * @param title	标题
	 * @param content	内容
	 * @param senderUserName	发送人名称，可以为null
	 * @throws Exception
	 */
	public void sendInnerMessage(String receiverUserId, String title, String content, String senderUserName) throws Exception;

	
	/**
	 * 使用消息中间件-业务配置的模块进行消息发送
	 * 
	 * @param code
	 * @param title
	 * @param map
	 * @param receiverUserId
	 * @param receiverUserName	可为null
	 * @param senderUserName	可为null
	 * @throws Exception
	 */
	public void sendInnerMessageWithTemplate( String code,String title,
			Map<String, Object> map, String receiverUserId, String receiverUserName, String senderUserName) throws Exception;
	
	
	
	/**
	 * 发送短信接口，使用联创sms实现
	 * @param peUserId  用户peUserId 
	 * @param content  短信内容
	 * @return 
	 * @throws Exception
	 */
	 public String sendSMSByPeUserId(String peUserId,String content) throws Exception;
	 
	 
	 /**
	  * 
	  * @param peUserId
	  * @param content
	  * @return
	  * @throws Exception
	  */
	 public String sendSMSByUserId(String userId,String content) throws Exception;
	 
	 
	 /**
	  * 
	  * @param peUserId
	  * @param content
	  * @return
	  * @throws Exception
	  */
	 public String sendSMSByUserName(String userName,String content) throws Exception;

}
