package com.mbagix.ad.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.mbagix.ad.mapper.SysMapper;
import com.mbagix.ad.model.CodeTbl;


/**
 * 시스템 관련 서비스
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
@Service(value = "sysService")
public class SysService {
	@Resource(name = "sysMapper")
    private SysMapper sysMapper;	
	
	
	public List<CodeTbl> getAllCodeTbl(String gCode) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("gCode", gCode);
		return sysMapper.getAllCodeTbl(map);
	}
	
	public CodeTbl getCodeTbl(String gCode,String key) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("gCode", gCode);
		map.put("key", key);
		return sysMapper.getCodeTbl(map);
	}
}
