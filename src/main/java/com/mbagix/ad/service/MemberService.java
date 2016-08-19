package com.mbagix.ad.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.mbagix.ad.mapper.MemberMapper;
import com.mbagix.ad.model.Member;

/**
 * 사용자 관련  서비스
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
@Service(value = "memberService")
public class MemberService {
	@Resource(name = "memberMapper")
    private MemberMapper memberMapper;	
	
	public void getSyncCompanyName(List<Map> list){
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
	}
	public Integer getTotalMember(Map<String,Object> map){
		return memberMapper.getTotalMember(map);
	}
	public List<Map> getAllMember(Map<String,Object> map) {
		
		return memberMapper.getAllMember(map);
	}
	
	
	public Map getMember(Integer memberSq){
		return memberMapper.getMember(memberSq);
	}
	public Member findByUserid(String  userid){
		return memberMapper.findByUserid(userid);
	}
	public void updateMember(Map member) {
		memberMapper.updateMember(member);
	}
	
	public void addMember(Map member) {
		memberMapper.addMember(member);
	}
	
	public void deleteMember(Integer memberSq) {
		memberMapper.deleteMember(memberSq);
	}
}
