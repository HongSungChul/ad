package com.mbagix.ad.mapper;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

/**
 * 광고물 관련 맵퍼  
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
public interface AdmMapper {
	/**
	 * 광고물 제목 조회 
	 * @param list
	 * @return
	 */
	public List<Map> getAllAdmTitle(List<Map> list);
	 
	
	/**
	 * 광고물 조회 
	 * @param condition
	 * @return
	 */
	public List<Map> getAllAdm(Map<String,Object> condition);
	
	/**
	 * 회원정보로 광고물 조회 
	 * @param memberSq
	 * @return
	 */
	@Select("SELECT * FROM adm WHERE memberSq = #{memberSq} and status='A'")
    public List<Map> queryAdmByMember(@Param("memberSq") Integer memberSq);
    
	/**
	 * 광고물 조회 
	 * @param map
	 * @return
	 */
    public Map getAdm(Map<String,Object> map);
    /**
     * 광고물 갯수 
     * @param map
     * @return
     */
    public Integer getTotalAdm(Map<String,Object> map);
    /**
     * 광고물 조회 
     * @param adm
     */
    public void addAdm(Map adm);
    /**
     * 사용자워드 추가 
     * @param word
     */
    public void addWordUser(Map word);
    /**
     * 광고물 갱신 
     * @param adm
     */
    public void updateAdm(Map adm);
    
    /**
     * 광고물 삭제 
     * @param condition
     */
    public void deleteAdm(Map<String,Object> condition);
    
    /**
     * 광고물키워드 목록 
     * @param condition
     * @return
     */
    public List<Map> getAllAdmKw(Map<String,Object> condition);
    /**
     * 광고물키워드 추가 
     * @param admKw
     */
    public void addAdmKw(Map admKw);
    
    /**
     * 포인트순으로 입착내역 목록 
     * @param condition
     * @return
     */
    public List<Map> getAllBiddingByPoint(Map<String,Object> condition);
    /**
     * 입찰내역 목록 
     * @param condition
     * @return
     */
    public List<Map> getAllBidding(Map<String,Object> condition);
    /**
     * 입찰갯수 
     * @param map
     * @return
     */
    public Integer getTotalBidding(Map<String,Object> map);
    /**
     * 입찰 추가 
     * @param bidding
     */
    public void addBidding(Map bidding);
    
    /**
     * 입찰 삭제 
     * @param condition
     */
    public void deleteBidding(Map<String,Object> condition);
    
   
    
    public List<Map> getAllAdvertising(Map<String,Object> condition);
    public Map getAdvertising(Map<String,Object> map);
    public Integer getTotalAdvertising(Map<String,Object> map);
    public void addAdvertising(Map advertising);
    public void updateAdvertising(Map advertising);
    public void deleteAdvertising(Map<String,Object> condition);
    
    /**
     * 광고 목록 
     * @param kw1Name
     * @return
     */
    
    @Select("SELECT * FROM advertising WHERE kw1Name = #{kw1Name}")
    public List<Map> advertisingList(@Param("kw1Name") String kw1Name);
    
    /**
     * 입찰 1차키워드 목록 
     * @return
     */
    @Select("SELECT distinct kw1Sq FROM bidding group by kw1Sq")
    public List<Map> getKw1FromBidding();
    
    /**
     * 입찰 키워드목록 
     * @param kw1Sq
     * @return
     */
    @Select("SELECT distinct kw1Sq,kw2Sq FROM bidding where kw1Sq=#{kw1Sq} group by kw1Sq,kw2Sq")
    public List<Map> getKwFromBidding(@Param("kw1Sq") Integer kw1Sq);
    
    /**
     * 입찰키워드갯수 
     * @param memberSq
     * @return
     */
    @Select("SELECT count(distinct kw1Sq) kw1Cnt,count(distinct kw2Sq) kw2Cnt FROM bidding where memberSq=#{memberSq}")
    public Map getKwCntFromBidding(@Param("memberSq") Integer memberSq);
    /**
     * 클릭  목록 
     * @param condition
     * @return
     */
    public List<Map> getAllClick(Map<String,Object> condition);
    /**
     * 클릭 조회 
     * @param map
     * @return
     */
    public Map getClick(Map<String,Object> map);
    /**
     * 클릭 추가 
     * @param click
     */
    public void addClick(Map click);
    /**
     * 클릭 수정 
     * @param click
     */
    public void updateClick(Map click);
    /**
     * 날짜순으로 포인트 조회 
     * @param map
     * @return
     */
    public BigDecimal getPointByDate(Map<String,Object> map);
    /**
     * 뷰 추가 
     * @param view
     */
    public void addView(Map view);
    
    /**
     * 최근 클릭 갯수 
     * @param map
     * @return
     */
    public Integer getClickRecentCount(Map<String,Object> map);
 
    
    /**
     * 요청 추가 
     * @param request
     */
    public void addRequest(Map request);
    
    
    /**
     * 회원 광고단윈 검색 
     * @param memberSq
     * @return
     */
    @Select("SELECT * FROM adUnit WHERE memberSq = #{memberSq} and status='A'")
    public List<Map> queryAdUnitByMember(@Param("memberSq") Integer memberSq);
    
    
    /**
     * 요청 목록 
     * @param condition
     * @return
     */
    public List<Map> getAllRequest(Map<String,Object> condition);
    
    /**
     * 워드사이트 목록 
     * @param condition
     * @return
     */
    public List<Map> getAllWordSite(Map<String,Object> condition);
    
    /**
     * 워드사이트 조회 
     * @param condition
     * @return
     */
    public Map getWordSite(Map<String,Object> condition);
    
    /**
     * 워드사용자 목록  
     * @param condition
     * @return
     */
    public List<Map> getAllWordUser(Map<String,Object> condition);
    /**
     * 광고단위 목록 
     * @param condition
     * @return
     */
    public List<Map>  getAllAdUid(Map<String,Object> condition);
    /**
     * 워드사이트 추가 
     */
    public void addWordSite(Map view);
    
    /**
     * 워드사용자 삭제 
     * @param condition
     */
    public void deleteWordUser(Map<String,Object> condition);
    
    /**
     * 워드사이트 삭제 
     * @param condition
     */
    public void deleteWordSite(Map<String,Object> condition);
}