package org.jeecgframework.core.util;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.beanutils.BeanUtils;

public class ListUtils {

	/**
	 * 按新的Class对象复制
	 * 
	 * @param source
	 *            list, example: list
	 * @param dest
	 *            class, example: UserEntity.class;
	 */
	public static <E> List<E> copyTo(List<?> source, Class<E> destinationClass) throws Exception {
		if (source.size() == 0)
			return new ArrayList();
		List<E> res = new ArrayList<E>(source.size());
		for (Object o : source) {
			E e = destinationClass.newInstance();
			BeanUtils.copyProperties(e, o);
			res.add(e);
		}
		return res;
	}

	public static boolean isNullOrEmpty(List list) {
		return list == null || list.isEmpty();
	}

	/**
	 * @Description:把数组转换为一个用逗号分隔的字符串 ，以便于用in+String 查询
	 */
	public static String converToString(String[] ig) {
		String str = "";
		if (ig != null && ig.length > 0) {
			for (int i = 0; i < ig.length; i++) {
				str += ig[i] + ",";
			}
		}
		str = str.substring(0, str.length() - 1);
		return str;
	}

	/**
	 * @Description:把list转换为一个用逗号分隔的字符串
	 */
	public static String listToString(List list) {
		StringBuilder sb = new StringBuilder();
		if (list != null && list.size() > 0) {
			for (int i = 0; i < list.size(); i++) {
				if (i < list.size() - 1) {
					sb.append(list.get(i) + ",");
				} else {
					sb.append(list.get(i));
				}
			}
		}
		return sb.toString();
	}
}
