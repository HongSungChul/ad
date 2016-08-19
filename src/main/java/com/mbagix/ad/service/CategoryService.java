package com.mbagix.ad.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.mbagix.ad.mapper.CategoryMapper;


/**
 * 카테고리  서비스
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
@Service(value = "categoryService")
public class CategoryService {
	@Resource(name = "categoryMapper")
    private CategoryMapper categoryMapper;	
	
	///////////////////ad_info table///////////////
	public Integer getTotalCg1(Map<String,Object> map){
		return categoryMapper.getTotalCg1(map);
	}
	public List<Map> getAllCg1(Map<String,Object> map) {
		
		return categoryMapper.getAllCg1(map);
	}
	
	
	public Map getCg1(Map<String,Object> map){
		return categoryMapper.getCg1(map);
	}
	
	public void updateCg1(Map cg1) {
		categoryMapper.updateCg1(cg1);
	}
	
	public void addCg1(Map cg1) {
		categoryMapper.addCg1(cg1);
	}
	
	public void deleteCg1(Map<String,Object> condition) {
		categoryMapper.deleteCg1(condition);
	}
	public void upCg1(Map cg1) {
		categoryMapper.upCg1(cg1);
	}
	
	///////////////////ad_request table///////////////
	public Integer getTotalCg2(Map<String,Object> map){
		return categoryMapper.getTotalCg2(map);
	}
	public List<Map> getAllCg2(Map<String,Object> map) {
		
		return categoryMapper.getAllCg2(map);
	}
	
	
	public Map getCg2(Map<String,Object> map){
		return categoryMapper.getCg2(map);
	}
	
	public void updateCg2(Map cg2) {
		categoryMapper.updateCg2(cg2);
	}
	
	public void addCg2(Map cg2) {
		categoryMapper.addCg2(cg2);
	}
	public void upCg2(Map cg2) {
		categoryMapper.upCg2(cg2);
	}
	
	public void deleteCg2(Map<String,Object> condition) {
		categoryMapper.deleteCg2(condition);
	}
}
