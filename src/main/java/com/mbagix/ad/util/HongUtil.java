package com.mbagix.ad.util;

import java.util.Iterator;
import java.util.Map;
/**
 * 해시 연산
 *
 * <pre>
 * <b>History:</b>
 *    작성자, 1.1, 2016.3.9 초기작성
 * </pre>
 *
 * @author 홍성철
 * @version 1.2
 * @see    None
 */
public class HongUtil {
	public static void merge(Map a,Map b){
		Iterator it = b.keySet().iterator();
		while(it.hasNext()){
			Object key = it.next();
			a.put(key, b.get(key));
		}
	}
}
