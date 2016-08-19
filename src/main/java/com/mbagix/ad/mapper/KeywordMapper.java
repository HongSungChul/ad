package com.mbagix.ad.mapper;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.mbagix.ad.model.AdInfo;
/**
 * 키워드 관련  맵퍼  
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
public interface KeywordMapper {
	
	/**
	 * 1차키워드 목록  
	 * @param condition
	 * @return
	 */
	public List<Map> getAllKw1(Map<String,Object> condition);
	/**
	 * 1차키워드 조회 
	 * @param map
	 * @return
	 */
    public Map getKw1(Map<String,Object> map);
    /**
     * 1차키워드 갯수 
     * @param map
     * @return
     */
    public Integer getTotalKw1(Map<String,Object> map);
    /**
     * 1차키워드 추가 
     * @param cg1
     */
    public void addKw1(Map cg1);
    /**
     * 1차키워드 수정 
     * @param cg1
     * @return
     */
    public int upKw1(Map cg1);
    /**
     * 1차키워드 수정 
     * @param cg1
     */
    public void updateKw1(Map cg1);
    /**
     * 1차키워드 삭제 
     * @param condition
     */
    public void deleteKw1(Map<String,Object> condition);
    
    
    
   /**
    * 2차키워드 목록 
    * @param condition
    * @return
    */
    public List<Map> getAllKw2(Map<String,Object> condition);
    /**
     * 2차키워드 조회 
     * @param map
     * @return
     */
    public Map getKw2(Map<String,Object> map);
    /**
     * 2차키워드 갯수 
     * @param map
     * @return
     */
    public Integer getTotalKw2(Map<String,Object> map);
    /**
     * 2차키워드 추가 
     * @param cg2
     */
    public void addKw2(Map cg2);
    /**
     * 2차키워드 수정 
     * @param cg2
     */
    public void upKw2(Map cg2);
    /**
     * 2차키워드 수정 
     * @param cg2
     */
    public void updateKw2(Map cg2);
    /**
     * 2차키워드 삭제 
     * @param condition
     */
    public void deleteKw2(Map<String,Object> condition);
}