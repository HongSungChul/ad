package com.mbagix.ad.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Service;

import com.mbagix.ad.mapper.AdmMapper;
import com.mbagix.ad.mapper.KeywordMapper;
import com.mbagix.ad.mapper.MemberMapper;
import com.mbagix.ad.mapper.PointMapper;
import com.mbagix.ad.util.HongUtil;

/**
 * 광고물  서비스
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
@Service(value = "admService")
public class AdmService {
	/**
	 * 광고물 맵퍼
	 */
	@Resource(name = "admMapper")
    private AdmMapper admMapper;	
	
	/**
	 * 키워드 맵퍼
	 */
	@Resource(name = "keywordMapper")
    private KeywordMapper keywordMapper;
	
	/**
	 * 포인트 맵퍼
	 */
	@Resource(name = "pointMapper")
    private PointMapper pointMapper;
	
	/**
	 * 회원 맵퍼
	 */
	@Resource(name = "memberMapper")
    private MemberMapper memberMapper;
	
	/**
	 * 광고물 추가   
	 *
	 * @param Map map -광고물 
	*/
	public void view(Map<String,Object> map){
		System.out.println(map);
		admMapper.addView(map);
	}
	public void getSyncAdmTitle(List<Map> list){
		if(list.size()>0){
			List<Map> rList = admMapper.getAllAdmTitle(list);
			for(Map user:list){
				for(Map member:rList){
					if(member.get("admSq").equals(user.get("admSq"))){
						user.put("title", member.get("title"));
						//user.put("userid", member.get("userid"));
						break;
					}
				}
			}
		}
	}
	public void click(Map<String,Object> map){
		try{
			//System.err.println(map);
			Integer recentCnt = admMapper.getClickRecentCount(map);
			
			//System.out.println(recentCnt);
			if(recentCnt>0) return;
			
			// 광고물 수유주 
			Map adm = admMapper.getAdm(map);
			
			Map advertising = admMapper.getAdvertising(map);
			
			//memberMapper.addMember(member);
			Map member = new HashMap();
			member.put("memberSq", adm.get("memberSq"));
			member.put("point", advertising.get("price"));
			try{
				
				int ret = pointMapper.useAdPoint(member);
				/*if(ret!=1){
					Map admMap = new  HashMap();
					admMap.put("admSq", adm.get("admSq"));
					admMap.put("kw1Sq", advertising.get("kw1Sq"));
					admMap.put("kw2Sq", advertising.get("kw2Sq"));
					admMapper.deleteBidding(admMap);
					
					//admMapper.deleteBidding(admMap);
				}*/
				
			}catch(Exception ex1){
				ex1.printStackTrace();
				/*pointMapper.moveToAdPoint(member);
				int ret = pointMapper.useAdPoint(member);
				Map admMap = new  HashMap();
				admMap.put("admSq", adm.get("admSq"));
				admMap.put("kw1Sq", advertising.get("kw1Sq"));
				admMap.put("kw2Sq", advertising.get("kw2Sq"));
				admMapper.deleteBidding(admMap);*/
			}
			map.put("point", advertising.get("price"));
			//map.put("check","A");
			admMapper.addClick(map);
			
		}catch(Exception ex){
			ex.printStackTrace();
		}
	}
	///////////////////ad_info table///////////////
	public Integer getTotalAdm(Map<String,Object> map){
		return admMapper.getTotalAdm(map);
	}
	public List<Map> getAllAdm(Map<String,Object> map) {
		
		return admMapper.getAllAdm(map);
	}
	public Map getAdm(Map<String,Object> map){
		return admMapper.getAdm(map);
	}
	
	public void updateAdm(Map adm) {
		admMapper.updateAdm(adm);
	}
	
	public void addAdm(Map adm) {
		admMapper.addAdm(adm);
	}
	
	public void deleteAdm(Map<String,Object> condition) {
		admMapper.deleteAdm(condition);
	}
	/////////////////
	public List<Map> getAllAdmKw(Map<String,Object> map) {
		
		return admMapper.getAllAdmKw(map);
	}
	public void addAdmKw(Map admKw) {
		admMapper.addAdmKw(admKw);
	}
	
	public List<Map> getAllBiddingByPoint(Map<String,Object> map) {
		
		return admMapper.getAllBiddingByPoint(map);
	}
	public List<Map> getAllBidding(Map<String,Object> map) {
		
		return admMapper.getAllBidding(map);
	}
	public Integer getTotalBidding(Map<String,Object> map) {
		
		return admMapper.getTotalBidding(map);
	}

	public void addBidding(Map bidding) {
		admMapper.addBidding(bidding);
	}
	public void deleteBidding(Map<String,Object> condition) {
		admMapper.deleteBidding(condition);
	}
	////////advertising
	
	public Integer getTotalAdvertising(Map<String,Object> map){
		return admMapper.getTotalAdvertising(map);
	}
	
	public Map getKwCntFromBidding(Integer memberSq){
		return admMapper.getKwCntFromBidding(memberSq);
	}
	public List<Map> advertisingList(String s) {
		
		return admMapper.advertisingList(s);
	}
	public List<Map> getAllAdvertising(Map<String,Object> map) {
		
		return admMapper.getAllAdvertising(map);
	}
	public Map getAdvertising(Map<String,Object> map){
		return admMapper.getAdvertising(map);
	}
	
	public void updateAdvertising(Map advertising) {
		admMapper.updateAdvertising(advertising);
	}
	
	public void addAdvertising(Map advertising) {
		admMapper.addAdvertising(advertising);
	}
	
	public void deleteAdvertising(Map<String,Object> condition) {
		admMapper.deleteAdvertising(condition);
	}
	/*
	public void getSyncBiddingStatus(List<Map> list){
		if(list.size()>0){
			List<Map> rList = memberMapper.getAllCompanyName(list);
			for(Map user:list){
				for(Map member:rList){
					if(member.get("memberSq").equals(user.get("memberSq"))){
						user.put("companyName", member.get("companyName"));
						user.put("userid", member.get("userid"));
						break;
					}
				}
			}
		}
	}*/
	
	public List<Map> getKw1FromBidding(){
		return admMapper.getKw1FromBidding();
	}
    
    
    public List<Map> getKwFromBidding(Integer kw1Sq){
    	return admMapper.getKwFromBidding(kw1Sq);
    }
	
    //광고주를 정산해라........
    
	public void flushCalc(Map member){
		
	}
	
    ////////////advertiser 를 생성해라 (with kw1Sq kw2Sq 로)
	
    
	public void flushAdvertiser(Integer kw1Sq,Integer kw2Sq){
		
		Map<String,Object> condition = new HashMap<String,Object>();
		condition.put("kw1Sq", kw1Sq);
		condition.put("kw2Sq", kw2Sq);
		List<Map> list= admMapper.getAllBiddingByPoint(condition);
		int ranking=1;
		int price=0;
		if(list.size()>3){
			price = (Integer)list.get(3).get("point");
		}else if(list.size()>0){
			price = (Integer)list.get(list.size()-1).get("point");
		}
		Map kw1 = keywordMapper.getKw1(condition);
		Map kw2 = keywordMapper.getKw2(condition);
		admMapper.deleteAdvertising(condition); // 현재광고집행삭제 
		for(Map item:list){ // 입찰금액순으로,
			condition.put("admSq", item.get("admSq"));
			
			Map adm = admMapper.getAdm(condition); // 광고물 정보 
			
			if(adm!=null){
				
				Map ad = new HashMap();
				ad.put("kind", kw2.get("kind"));
				HongUtil.merge(ad, adm);
				HongUtil.merge(ad, item);
				//ad.put("kw1Sq", kw1Sq);
				//ad.put("kw2Sq", kw2Sq);
				ad.put("kw1Name", kw1.get("name"));
				ad.put("kw2Name", kw2.get("name"));
			    
				ad.put("sortOrder", ranking);
				ad.put("price", price);
				//ad.setAdmSq((Integer)adm.get("admSq"));
				//ad.setDescription((String)adm.get("description"));
				admMapper.addAdvertising(ad);
			}else{
				continue;
			}
			if(ranking==3) break;
			ranking++;
			
		}
	}
	
	public void addRequest(Map request) {
		admMapper.addRequest(request);
	}
	
	public List<Map> getAllWordUser(Map request){
		return admMapper.getAllWordUser(request);
	}
	
	public List<Map> getAllWordSite(Map request){
		return admMapper.getAllWordSite(request);
	}
	
	public void addWordSite(Map wordSite) {
		admMapper.addWordSite(wordSite);
	}
	public Map getWordSite(Map wordSite) {
		return admMapper.getWordSite(wordSite);
	}
	public void deleteWordSite(Map<String,Object> condition) {
		admMapper.deleteWordSite(condition);
	}
	
}
