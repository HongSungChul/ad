package com.mbagix.ad.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.mbagix.ad.model.CodeTbl;

/**
 * 시스템 관련 맵퍼  
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



@Repository
public interface SysMapper {
	
	/**
	 * 코드테이블 목록 
	 * @param map
	 * @return
	 */
	public List<CodeTbl> getAllCodeTbl(Map<String,Object> map);
	
	/**
	 * 코드테이블 조회 
	 * @param map
	 * @return
	 */
	public CodeTbl getCodeTbl(Map<String,Object> map);
	
	
}
