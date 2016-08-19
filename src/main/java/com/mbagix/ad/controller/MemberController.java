package com.mbagix.ad.controller;


import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mbagix.ad.model.JsonResult;
import com.mbagix.ad.service.MemberService;
/**
 * 사용자 컨트롤러  
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

@RequestMapping("/member")
@Controller(value = "memberController")

public class MemberController {
	
	/**
	 * 목록갯수 
	 */
	public static  int LIST_COUNT=10;
	
	/**
	 * 회원서비스 
	 */
	@Resource(name = "memberService")
	private MemberService memberService;
	/**
	 * 회원 목록
	 *
	 * @param Map map 검색조건
	 * @return JsonResult 
	 */
	@RequestMapping(value="/member",method = RequestMethod.GET , produces="application/json; charset=utf-8")
	@ResponseBody
	public Object memberList( @RequestParam Map<String,Object> map) {
		
		JsonResult jsonResult = new JsonResult();
		
		try{
			//codeTblService.d
			//if(page==null) page=1;
			Map param = new HashMap<String, Object>();
			param.put("offset", 0);
			param.put("count", LIST_COUNT);
			
			jsonResult.setData(memberService.getAllMember(param));
			
			//if(page==1){
			//	jsonResult.setTotal(codeTblService.getTotal());
			//}
		}catch(Exception ex){
			jsonResult.setMsg(ex.getMessage());
			jsonResult.setSuccess(false);	
		}
		return jsonResult;
		
	}
	/**
	 * 회원 조회
	 *
	 * @param Integer memberSq -회원번호 
	 * @return JsonResult 
	 */
	@RequestMapping(value="/member/{memberSq}",method = RequestMethod.GET , produces="application/json; charset=utf-8")
	@ResponseBody
	public Object memberSelect(@PathVariable("memberSq") Integer memberSq ) {
		
		JsonResult jsonResult = new JsonResult();
		//System.err.println("lsjdfjdslfj");
		try{
			Map map = memberService.getMember(memberSq);
			//map.put("address",postAddrService.getAddress((Integer)map.get("address_sq")));
			jsonResult.setData(map);
			
			//memberService.updateViewCount(membe);
		}catch(Exception ex){
			jsonResult.setMsg(ex.getMessage());
			jsonResult.setSuccess(false);	
		}
		
		return jsonResult;
		
		
		
	}
	
	/**
	 * 회원 삭제
	 *
	 * @param Integer memberSq -회원번호 
	 * @return JsonResult 
	 */
	@RequestMapping(value="/member/{memberSq}",method = RequestMethod.DELETE, produces="application/json")
	@ResponseBody
	public Object memberDelete(@PathVariable("memberSq") Integer memberSq) {
		//logger.info("goodDelete");
		JsonResult jsonResult = new JsonResult();
		
		try{
			memberService.deleteMember(memberSq);
		}catch(Exception ex){
			jsonResult.setMsg(ex.getMessage());
			jsonResult.setSuccess(false);	
		}
		
		return jsonResult;
	}
	/**
	 * 회원 갱신
	 *
	 * @param Integer memberSq -회원번호 , Map map -회원정보 
	 * @return JsonResult 
	 */
	@RequestMapping(value="/member/{memberSq}",method = RequestMethod.PUT , produces="application/json")
	@ResponseBody
	public Object memberUpdate(@PathVariable("memberSq") Integer memberSq, @RequestBody Map  map) {
		
		
		//System.err.println(map);
		JsonResult jsonResult = new JsonResult();
		//Integer member_code=0;
		try{
			
			//postAddrService.deleteAddress((Integer)map.get("address_sq"));
			//Map address = (Map)map.get("address");
			//address.put("member_code", member_code);
			//address.put("location", Geocoding.getLocation(String.format("%1s %2s %3s %3s", address.get("dosi"),address.get("si"),address.get("dong"),address.get("detail_addr")))); 
			//postAddrService.addAddress(address);
			
			//map.put("member_code", member_code);
			//map.put("address_sq", address.get("address_sq"));
			memberService.updateMember(map);
		}catch(Exception ex){
			jsonResult.setMsg(ex.getMessage());
			jsonResult.setSuccess(false);	
		}
		
		return jsonResult;
	}
	
	/**
	 * 회원 추가
	 *
	 * @param Map map -회원정보  
	 * @return JsonResult 
	 */
	@RequestMapping(value="/member",method = RequestMethod.POST , produces="application/json; charset=utf-8")
	@ResponseBody
	public Object memberSave(@RequestBody Map<String,Object> map) {
		
		Integer member_code = 0;
		JsonResult<String> jsonResult = new JsonResult<String>();
		try{
			
			
			memberService.addMember(map);
		}catch(Exception ex){
			ex.printStackTrace();
			jsonResult.setMsg(ex.getMessage());
			jsonResult.setSuccess(false);	
		}
		return jsonResult;
		
		
	}
}

