
package com.mbagix.ad.mapper;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.mbagix.ad.model.Member;

/**
 * 회원관련 맵퍼  
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
public interface MemberMapper {
	/**
	 * 회사명으로 회원 목록 
	 * @param list
	 * @return
	 */
	public List<Map> getAllCompanyName(List<Map> list);
	/**
	 * 회원목록 
	 * @param condition
	 * @return
	 */
	public List<Map> getAllMember(Map<String,Object> condition);
	/**
	 * 회원조회 
	 * @param memberSq
	 * @return
	 */
    public Map getMember(Integer memberSq);
    /**
     * 아이디로 회원 조회 
     * @param userid
     * @return
     */
    public Member findByUserid(String  userid);
    /**
     * 회원 갯수 
     * @param map
     * @return
     */
    public Integer getTotalMember(Map<String,Object> map);
    /**
     * 회원 추가 
     * @param member
     */
    public void addMember(Map member);
    /**
     * 회원 수정 
     * @param member
     */
    public void updateMember(Map member);
    /**
     * 회원 삭제 
     * @param memberSq
     */
    public void deleteMember(Integer memberSq);
}
