
package com.mbagix.ad.mapper;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.mbagix.ad.model.Member;

/**
 * 리포트관련 맵퍼  
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
public interface ReportMapper {
	
	/**
	 * 일일광고주 통계 목록 
	 * @param condition
	 * @return
	 */
	public List<Map> getAllDailyAc(Map<String,Object> condition);
	
	/**
	 * 일일광고주 통계 갯수 
	 * @param map
	 * @return
	 */
    public Integer getTotalDailyAc(Map<String,Object> map);
    /**
     * 수집일로 일일광고주통계 목록 
     * @param condition
     * @return
     */
    public List<Map> getAllDailyAcByCollDate(Map<String,Object> condition);
    /**
     * 수집일로 일일광고주통계 갯수 
     * @param map
     * @return
     */
    public Integer getTotalDailyAcByCollDate(Map<String,Object> map);
    /**
     * 날짜로 일일광고주그룹 목록 
     * @param map
     * @return
     */
    public List<Map> getDailyAcGroupByDate(Map<String,Object> map);
    /**
     * 광고물로 일일광고그룹 목록 
     * @param map
     * @return
     */
    public List<Map> getDailyAcGroupByAdm(Map<String,Object> map);
    /**
     * 일일광고주 추가 
     * @param pointLog
     */
    public void addDailyAc(Map pointLog);
    /**
     * 일일광고 조회 
     * @param condition
     * @return
     */
    public Map getDailyAc(Map<String,Object> condition);
    /**
     * 클릭으로 일일광고주 조회 
     * @param condition
     * @return
     */
    public Map getDailyAcByClick(Map<String,Object> condition);
    /**
     * 보기로 일일광고주 조회 
     * @param condition
     * @return
     */
    public Map getDailyAcByView(Map<String,Object> condition);
    /**
     * 일일고아고주 수정 
     * @param condition
     */
    public void updateDailyAc(Map<String,Object> condition);
    
    /**
     * 일일광고주 삭제  
     * @param condition
     */
    public void deleteDailyAc(Map<String,Object> condition);
    
    /**
     * 일일매체 목록 
     * @param condition
     * @return
     */
    public List<Map> getAllDailyMc(Map<String,Object> condition);
    /**
     * 일일매체 갯수 
     * @param map
     * @return
     */
    public Integer getTotalDailyMc(Map<String,Object> map);
    /**
     * 수집일로 일일매체 목록 
     * @param condition
     * @return
     */
    public List<Map> getAllDailyMcByCollDate(Map<String,Object> condition);
    /**
     * 수집일로 일일매체 갯수 
     * @param map
     * @return
     */
    public Integer getTotalDailyMcByCollDate(Map<String,Object> map);
    /**
     * 일일매체 추가 
     * @param pointLog
     */
    public void addDailyMc(Map pointLog);
    /**
     * 일일매체 조회 
     * @param condition
     * @return
     */
    public Map getDailyMc(Map<String,Object> condition);
    /**
     * 클릭으로 일일매체 조회 
     * @param condition
     * @return
     */
    public Map getDailyMcByClick(Map<String,Object> condition);
    /**
     * 뷰로 일일매체 조회 
     * @param condition
     * @return
     */
    public Map getDailyMcByView(Map<String,Object> condition);
    /**
     * 일일매체 수정 
     * @param condition
     */
    public void updateDailyMc(Map<String,Object> condition);
    /**
     * 일일매체 삭제 
     * @param condition
     */
    public void deleteDailyMc(Map<String,Object> condition);
    /**
     * 날짜로 일일매체그룹 목록 
     * @param map
     * @return
     */
    public List<Map> getDailyMcGroupByDate(Map<String,Object> map);
    
    /**
     * 키워드로 일일매체 목록 
     * @param condition
     * @return
     */
    public List<Map> getAllDailyKw(Map<String,Object> condition);
    /**
     * 키워드로 일일메체 갯수 
     * @param map
     * @return
     */
    public Integer getTotalDailyKw(Map<String,Object> map);
    //public List<Map> getAllDailyMcByCollDate(Map<String,Object> condition);
    //public Integer getTotalDailyMcByCollDate(Map<String,Object> map);
    /**
     * 일일키워드 추가 
     * @param pointLog
     */
    public void addDailyKw(Map pointLog);
    /**
     * 일일키워드 조회 
     * @param condition
     * @return
     */
    public Map getDailyKw(Map<String,Object> condition);
    /**
     * 클릭으로 일일키워드 조회 
     * @param condition
     * @return
     */
    public Map getDailyKwByClick(Map<String,Object> condition);
    /**
     * 뷰료 일일키워드 조회 
     * @param condition
     * @return
     */
    public Map getDailyKwByView(Map<String,Object> condition);
    /**
     * 일일키워드 수정 
     * @param condition
     */
    public void updateDailyKw(Map<String,Object> condition);
    /**
     * 일일키워드 삭제 
     * @param condition
     */
    public void deleteDailyKw(Map<String,Object> condition);
    
    /**
     * 월광고주 목록 
     * @param condition
     * @return
     */
    public List<Map> getAllMonthAc(Map<String,Object> condition);
    /**
     * 일로 월광고주그룹 목록 
     * @param condition
     * @return
     */
    public List<Map> getMonthAcGroupByDate(Map<String,Object> condition);
    /**
     * 월광고주갯수 
     * @param map
     * @return
     */
    public Integer getTotalMonthAc(Map<String,Object> map);
    /**
     * 월광고주 추가 
     * @param pointLog
     */
    public void addMonthAc(Map pointLog);
    /**
     * 월광고주 조회 
     * @param condition
     * @return
     */
    public Map getMonthAc(Map<String,Object> condition);
    public void updateMonthAc(Map<String,Object> condition);
    /**
     * 월광고주 삭제 
     * @param condition
     */
    public void deleteMonthAc(Map<String,Object> condition);
    
    /**
     * 월매체 목록 
     * @param condition
     * @return
     */
    public List<Map> getAllMonthMc(Map<String,Object> condition);
    /**
     * 월매체 갯수 
     * @param map
     * @return
     */
    public Integer getTotalMonthMc(Map<String,Object> map);
    /**
     * 월매체 추가 
     * @param pointLog
     */
    public void addMonthMc(Map pointLog);
    /**
     * 월매체 조회 
     * @param condition
     * @return
     */
    public Map getMonthMc(Map<String,Object> condition);
    /**
     * 월매체 수정 
     * @param condition
     */
    public void updateMonthMc(Map<String,Object> condition);
    /**
     * 월매체 삭제 
     * @param condition
     */
    public void deleteMonthMc(Map<String,Object> condition);
    /**
     * 날짜로 일일키워드그룹 목록 
     * @param map
     * @return
     */
    public List<Map> getDailyKwGroupByDate(Map<String,Object> map);
    
    /**
     * 키워드로 광고주갯수 
     * @param condition
     * @return
     */
    public Integer getAdvertiserCountByKw(Map<String,Object> condition);
}
