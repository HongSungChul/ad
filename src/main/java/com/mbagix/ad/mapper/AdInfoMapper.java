package com.mbagix.ad.mapper;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.mbagix.ad.model.AdInfo;

/**
 * 광고정보 관련 맵퍼  인터페이스
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
public interface AdInfoMapper {
	
	/**
	 * 광고정보 목록  
	 * @param condition
	 * @return
	 */
	
	public List<Map> getAllAdInfo(Map<String,Object> condition);
	/**
	 * 광고정보 조회 
	 * @param map
	 * @return
	 */
    public Map getAdInfo(Map<String,Object> map);
    /**
     * 광고정보갯수 
     * @param map
     * @return
     */
    public Integer getTotalAdInfo(Map<String,Object> map);
    /**
     * 광고정보 추가 
     * @param adInfo
     */
    public void addAdInfo(Map adInfo);
    /**
     * 광고정보갱신 
     * @param adInfo
     */
    public void updateAdInfo(Map adInfo);
    /**
     * 광고정보 삭제 
     * @param condition
     */
    public void deleteAdInfo(Map<String,Object> condition);
    
    
    
    /**
     * 광고물요청 목록 
     * @param condition
     * @return
     */
    public List<Map> getAllAdmReq(Map<String,Object> condition);
    /**
     * 광고물요청 조회 
     * @param map
     * @return
     */
    public Map getAdmReq(Map<String,Object> map);
    /**
     * 광고물요청갯수 
     * @param map
     * @return
     */
    public Integer getTotalAdmReq(Map<String,Object> map);
    /**
     * 광고물요청 추가 
     * @param admReq
     */
    public void addAdmReq(Map admReq);
    /**
     * 광고물요청 수정 
     * @param admReq
     */
    public void updateAdmReq(Map admReq);
    /**
     * 광고물 요청 삭제 
     * @param condition
     */
    public void deleteAdmReq(Map<String,Object> condition);
    
    
    /**
     * 광고물요청키워드 추가 
     * @param admReqKw
     */
    public void addAdmReqKw(Map admReqKw);
    /**
     * 광고물요청키워드 목록 
     * @param condition
     * @return
     */
    public List<Map> getAllAdmReqKw(Map<String,Object> condition);
    /**
     * 광고물요청키워드 삭제 
     * @param condition
     */
    public void deleteAdmReqKw(Map<String,Object> condition);
    
    
    /**
     * 광고단위 목록 
     * @param condition
     * @return
     */
    public List<Map> getAllAdUnit(Map<String,Object> condition);
    /**
     * 광고단위 조
     * @param map
     * @return
     */
    public Map getAdUnit(Map<String,Object> map);
    /**
     * 광고단위 갯수 
     * @param map
     * @return
     */
    public Integer getTotalAdUnit(Map<String,Object> map);
    /**
     * 광고단위 추가 
     * @param adUnit
     */
    public void addAdUnit(Map adUnit);
    /**
     * 광고단위 갱신 
     * @param adUnit
     */
    public void updateAdUnit(Map adUnit);
    /**
     * 광고단위 삭제 
     * @param condition
     */
    public void deleteAdUnit(Map<String,Object> condition);
    
    
    /**
     * 서비스 목록 
     * @param condition
     * @return
     */
    public List<Map> getAllService(Map<String,Object> condition);
    /**
     * 서비스 조회 
     * @param map
     * @return
     */
    public Map getService(Map<String,Object> map);
    /**
     * 서비스 객수 
     * @param map
     * @return
     */
    public Integer getTotalService(Map<String,Object> map);
    /**
     * 서비스 추가 
     * @param service
     */
    public void addService(Map service);
    /**
     * 서비스 수정 
     * @param service
     */
    public void updateService(Map service);
    /**
     * 서비스 삭제 
     * @param condition
     */
    public void deleteService(Map<String,Object> condition);
    
    /**
     * 서비스 카테고리 목록 
     * @param condition
     * @return
     */
    public List<Map> getAllServiceCategory(Map<String,Object> condition);
    
    /**
     * 광고단위번호로 1차키워드 조회 
     * @param condition
     * @return
     */
    public Map getKw1WithAdUnitSq(Map<String,Object> condition);
    /**
     * 최근 요청 목록조회 
     * @param condition
     * @return
     */
    public Map getRequestRecent(Map<String,Object> condition);
    
    /**
     * 서비스 카테고리 추가 
     * @param service
     */
    public void addServiceCategory(Map service);
}