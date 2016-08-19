package com.mbagix.ad.mapper;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.mbagix.ad.model.AdInfo;
/**
 * 카테고리 관련 맵퍼  
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
public interface CategoryMapper {
	
	/**
	 * 1차카테고리 목록 
	 * @param condition
	 * @return
	 */
	public List<Map> getAllCg1(Map<String,Object> condition);
	/**
	 * 1차카테고리 조회 
	 * @param map
	 * @return
	 */
    public Map getCg1(Map<String,Object> map);
    /**
     * 1차카케고리 갯수 
     * @param map
     * @return
     */
    public Integer getTotalCg1(Map<String,Object> map);
    /**
     * 1차카테고리 추가 
     * @param cg1
     */
    public void addCg1(Map cg1);
    /**
     * 1차카테고리  수정 
     * @param cg1
     */
    public void upCg1(Map cg1);
    /**
     * 1차카테고리 수정 
     * @param cg1
     */
    public void updateCg1(Map cg1);
    /**
     * 1차카테고리 삭제 
     * @param condition
     */
    public void deleteCg1(Map<String,Object> condition);
    
    
    
    /**
     * 2차카테고리 목록 
     * @param condition
     * @return
     */
    public List<Map> getAllCg2(Map<String,Object> condition);
    /**
     * 2차카테고리 조회 
     * @param map
     * @return
     */
    public Map getCg2(Map<String,Object> map);
    /**
     * 2차케테고리갯수 
     * @param map
     * @return
     */
    public Integer getTotalCg2(Map<String,Object> map);
    /**
     * 2차카테고리 추가 
     * @param cg2
     */
    public void addCg2(Map cg2);
    /**
     * 2차카테고리 수정 
     * @param cg2
     */
    public void upCg2(Map cg2);
    /**
     * 2차카테고리 수정 
     * @param cg2
     */
    public void updateCg2(Map cg2);
    /**
     * 2차케테고리 삭제
     * @param condition
     */
    public void deleteCg2(Map<String,Object> condition);
}