package com.mbagix.ad.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.mbagix.ad.mapper.KeywordMapper;

/**
 * 키워드  서비스
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
@Service(value = "keywordService")
public class KeywordService {
	@Resource(name = "keywordMapper")
    private KeywordMapper keywordMapper;	
	
	///////////////////ad_info table///////////////
	public Integer getTotalKw1(Map<String,Object> map){
		return keywordMapper.getTotalKw1(map);
	}
	public List<Map> getAllKw1(Map<String,Object> map) {
		
		return keywordMapper.getAllKw1(map);
	}
	
	
	public Map getKw1(Map<String,Object> map){
		return keywordMapper.getKw1(map);
	}
	
	public void updateKw1(Map cg1) {
		keywordMapper.updateKw1(cg1);
	}
	
	public void addKw1(Map cg1) {
		keywordMapper.addKw1(cg1);
	}
	
	public void deleteKw1(Map<String,Object> condition) {
		keywordMapper.deleteKw1(condition);
	}
	public void upKw1(Map cg1) {
		keywordMapper.upKw1(cg1);
	}
	
	///////////////////ad_request table///////////////
	public Integer getTotalKw2(Map<String,Object> map){
		return keywordMapper.getTotalKw2(map);
	}
	public List<Map> getAllKw2(Map<String,Object> map) {
		
		return keywordMapper.getAllKw2(map);
	}
	
	public List<Map> getAllKw2(Integer kw1Sq) {
		
		Map map = new HashMap();
		map.put("kw1Sq", kw1Sq);
		return getAllKw2(map);
	}
	public Map getKw2(Map<String,Object> map){
		return keywordMapper.getKw2(map);
	}
	
	public void updateKw2(Map cg2) {
		keywordMapper.updateKw2(cg2);
	}
	
	public void addKw2(Map cg2) {
		keywordMapper.addKw2(cg2);
	}
	public void upKw2(Map cg2) {
		keywordMapper.upKw2(cg2);
	}
	
	public void deleteKw2(Map<String,Object> condition) {
		keywordMapper.deleteKw2(condition);
	}
}
