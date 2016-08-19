package com.mbagix.ad.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.mbagix.ad.mapper.AdInfoMapper;
import com.mbagix.ad.model.AdInfo;
import com.sun.org.apache.bcel.internal.generic.RETURN;

/**
 * 광고정보  서비스
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
@Service(value = "adInfoService")
public class AdInfoService {
	/**
	 * 광고정보 맵퍼
	 */
	@Resource(name = "adInfoMapper")
    private AdInfoMapper adInfoMapper;	
	
	/**
	 * 총 광고정보 갯수 
	 *
	 * @param Map<String, Float> map -광고정보 검색조건 
	 * @return 광고갯수
	*/
	public Integer getTotalAdInfo(Map<String,Object> map){
		return adInfoMapper.getTotalAdInfo(map);
	}
	/**
	 * 광고정보 목록  
	 *
	 * @param Map<String, Object> map -광고정보 검색조건 
	 * @return 목록
	*/
	public List<Map> getAllAdInfo(Map<String,Object> map) {
		
		return adInfoMapper.getAllAdInfo(map);
	}
	
	
	/**
	 * 광고정보 조회  
	 *
	 * @param Map<String, Object> map -광고정보 검색조건 
	 * @return 광고정보
	*/
	public Map getAdInfo(Map<String,Object> map){
		return adInfoMapper.getAdInfo(map);
	}
	/**
	 * 광고정보 갱신  
	 *
	 * @param Map adInfo -광고정보 
	*/
	public void updateAdInfo(Map adInfo) {
		adInfoMapper.updateAdInfo(adInfo);
	}
	
	/**
	 * 광고정보 추가  
	 *
	 * @param Map adInfo -광고정보 
	*/
	public void addAdInfo(Map adInfo) {
		adInfoMapper.addAdInfo(adInfo);
	}
	/**
	 * 광고정보 삭제  
	 *
	 * @param Map adInfo -검색조건 
	*/
	public void deleteAdInfo(Map<String,Object> condition) {
		adInfoMapper.deleteAdInfo(condition);
	}
	
	
	/**
	 * 광고물요청 갯수   
	 *
	 * @param Map map -광고물요청 검색조건
	 * @return 갯수 
	*/
	public Integer getTotalAdmReq(Map<String,Object> map){
		return adInfoMapper.getTotalAdmReq(map);
	}
	/**
	 * 광고물요청 목록   
	 *
	 * @param Map map -광고물요청 검색조건
	 * @return 목록 
	*/
	public List<Map> getAllAdmReq(Map<String,Object> map) {
		
		return adInfoMapper.getAllAdmReq(map);
	}
	
	/**
	 * 광고물요청 조회   
	 *
	 * @param Map map -광고물 검색조건
	 * @return 광고물 
	*/
	public Map getAdmReq(Map<String,Object> map){
		return adInfoMapper.getAdmReq(map);
	}
	/**
	 * 광고물요청 삭제
	 *
	 * @param Map admReq -광고물 검색조건
	*/
	public void updateAdmReq(Map admReq) {
		adInfoMapper.updateAdmReq(admReq);
	}
	/**
	 * 광고물요청 추가   
	 *
	 * @param Map admReq -광고물요청
	*/
	public void addAdmReq(Map admReq) {
		adInfoMapper.addAdmReq(admReq);
	}
	/**
	 * 광고물요청 삭제
	 *
	 * @param Map con -광고물요청 검색조건
	*/
	public void deleteAdmReq(Map<String,Object> condition) {
		adInfoMapper.deleteAdmReq(condition);
	}
	
	/**
	 * 광고물요청 키워드 추가 
	 *
	 * @param Map admReqKw -광고물요청키워드
	*/
	public void addAdmReqKw(Map admReqKw) {
		adInfoMapper.addAdmReqKw(admReqKw);
	}
	/**
	 * 광고물요청 키워드 조회 
	 *
	 * @param Map map -검색조건
	 * @return 목록
	*/
	public List<Map> getAllAdmReqKw(Map<String,Object> map) {
		
		return adInfoMapper.getAllAdmReqKw(map);
	}
	/**
	 * 광고물요청키워드삭제 
	 *
	 * @param Map condition -검색조건
	*/
	public void deleteAdmReqKw(Map<String,Object> condition) {
		adInfoMapper.deleteAdmReqKw(condition);
	}
	
	/**
	 * 광고단위갯수 
	 *
	 * @param Map map -검색조건
	 * @return 결과
	*/
	public Integer getTotalAdUnit(Map<String,Object> map){
		return adInfoMapper.getTotalAdUnit(map);
	}
	/**
	 * 광고단위조회  
	 *
	 * @param Map map -검색조건
	 * @return 목록
	*/
	public List<Map> getAllAdUnit(Map<String,Object> map) {
	
		return adInfoMapper.getAllAdUnit(map);
	}
	
	/**
	 * 광고단위 조회 
	 *
	 * @param Map map -검색조건
	 * @return 결과
	*/
	public Map getAdUnit(Map<String,Object> map){
		return adInfoMapper.getAdUnit(map);
	}
	
	/**
	 * 광고단위 갱신 
	 *
	 * @param Map adUnit -광고단위
	*/
	public void updateAdUnit(Map adUnit) {
		adInfoMapper.updateAdInfo(adUnit);
	}
	/**
	 * 광고단위1차키워드 조회 
	 *
	 * @param Map condition -검색조건
	 * @return 결과
	*/
	public Map getKw1WithAdUnitSq(Map<String,Object> condition){
		return adInfoMapper.getKw1WithAdUnitSq(condition);
	}
	/**
	 * 최근요청 
	 *
	 * @param Map condition -검색조건
	 * @return 결과
	*/
	public Map getRequestRecent(Map<String,Object> condition){
		return adInfoMapper.getRequestRecent(condition);
	}
	/**
	 * 광고단위 추가 
	 *
	 * @param Map adUnit -광고단위
	*/
	public void addAdUnit(Map adUnit) {
		adInfoMapper.addAdUnit(adUnit);
	}
	/**
	 * 광고단위 삭제
	 *
	 * @param Map map -광고단위 검색조건
	*/
	public void deleteAdUnit(Map<String,Object> condition) {
		adInfoMapper.deleteAdUnit(condition);
	}
	/**
	 * 서비스 갯수
	 *
	 * @param Map map -서비스검색조건
	 * @return 갯수
	*/
	public Integer getTotalService(Map<String,Object> map){
		return adInfoMapper.getTotalService(map);
	}
	/**
	 * 서비스 목록
	 *
	 * @param Map map -서비스검색조건
	 * @return 목록
	*/
	public List<Map> getAllService(Map<String,Object> map) {
	
		return adInfoMapper.getAllService(map);
	}
	
	/**
	 * 서비스 조회
	 *
	 * @param Map map -서비스검색조건
	*/
	public Map getService(Map<String,Object> map){
		return adInfoMapper.getService(map);
	}
	/**
	 * 서비스 갱신
	 *
	 * @param Map service -서비스
	*/
	public void updateService(Map service) {
		adInfoMapper.updateService(service);
	}
	/**
	 * 서비스 추가
	 *
	 * @param Map service -서비스
	*/
	public void addService(Map service) {
		adInfoMapper.addService(service);
	}
	/**
	 * 서비스 삭제
	 *
	 * @param Map condition -서비스 검색조건
	*/
	public void deleteService(Map<String,Object> condition) {
		adInfoMapper.deleteService(condition);
	}
	/**
	 * 서비스 목록
	 *
	 * @param Map map -서비스검색조건
	 * @return 목록
	*/
	public List<Map> getAllServiceCategory(Map<String,Object> map) {
		
		return adInfoMapper.getAllServiceCategory(map);
	}
	/**
	 * 서비스카테고리 추가
	 *
	 * @param Map service -서비스카테고리
	*/
	public void addServiceCategory(Map service) {
		adInfoMapper.addServiceCategory(service);
	}
}
