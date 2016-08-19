
package com.mbagix.ad.mapper;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.mbagix.ad.model.Member;
/**
 * 포인트 관련 맵퍼  
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
public interface PointMapper {
	
	/**
	 * 포인트로그 목록 
	 * @param condition
	 * @return
	 */
	public List<Map> getAllPointLog(Map<String,Object> condition);
	/**
	 * 포인트로그 갯수 
	 * @param map
	 * @return
	 */
    public Integer getTotalPointLog(Map<String,Object> map);
    /**
     * 포인트로그 추가 
     * @param pointLog
     */
    public void addPointLog(Map pointLog);
    /**
     * 포인트로그 조회 
     * @param condition
     * @return
     */
    public Map getPointLog(Map<String,Object> condition);
    /**
     * 포인트로그 총합 
     * @param condition
     * @return
     */
    public BigDecimal getSumPointLog(Map<String,Object> condition);
    /**
     * 포인트로그 수정 
     * @param condition
     */
    public void updatePointLog(Map<String,Object> condition);
    
    /**
     * 포인트 추가 
     * @param point
     */
    public void addPoint(Map point);
    /**
     * 포인트 사용 
     * @param point
     */
    public void usePoint(Map point);
    
    /**
     * 광고포인트 사용 
     * @param point
     * @return
     */
    public int useAdPoint(Map point);
    
    /**
     * 광고포인트 이동 
     * @param point
     */
    public void moveToAdPoint(Map point);
    
    
}
