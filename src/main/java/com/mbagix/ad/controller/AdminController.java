package com.mbagix.ad.controller;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mbagix.ad.model.JsonResult;
import com.mbagix.ad.model.Member;
import com.mbagix.ad.service.AdInfoService;
import com.mbagix.ad.service.AdmService;
import com.mbagix.ad.service.MemberService;
import com.mbagix.ad.service.PointService;
import com.mbagix.ad.service.ReportService;
/**
 * 슈펴 관리자 컨트롤러
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
@RequestMapping("/admin")
@Controller(value = "adminController")
//@SessionAttributes("userInfo")
public class AdminController {
	/**
	 * 목록카운트
	 */
	public static  int LIST_COUNT=10;
	
	/**
	 * 사용자 서비스 
	 */
	@Resource(name = "memberService")
	private MemberService memberService;
	
	/**
	 * 광고물 서비스
	 */
	@Resource(name = "admService")
	private AdmService admService;
	
	/**
	 * 광고정보 서비스
	 */
	@Resource(name = "adInfoService")
	private AdInfoService adInfoService;
	
	/**
	 * 포인트 서비스
	 */
	@Resource(name = "pointService")
	private PointService pointService;
	
	/**
	 * 리포트 서비스 
	 */
	@Resource(name = "reportService")
	private ReportService reportService;
	
	
	/**
	 * 메인화면
	 *
	 * @param Member login 사용자정보
	 * @return String 뷰페이지
	 */
	@RequestMapping("/")
    public String home(@ModelAttribute("userInfo") Member login) {
		
		//System.err.println(111);
		
		
		if(login.getMemberSq()==null){
			return "redirect:/admin/login.jsp";
		}
        return "/advertiser/index.jsp";
    }
	
	/**
	 * 인덱스 페이지
	 *
	 * @param HttpServletRequest request
	 * @return String 뷰페이지
	 */
	@RequestMapping("/index")
    public String index( HttpServletRequest request) {
		
		
		Member login = (Member)request.getSession().getAttribute("userInfo");
		System.err.println(login);
		if(login==null){
 			return "redirect:/login.jsp";
		}
        return "/advertiser/index.jsp";
    }
	
	/**
	 * 사용자 목록
	 *
	 * @param Map map 파라미터, Member login 로긴 정보
	 * @return String json 현태 
	 */
	@RequestMapping(value="/member",method = RequestMethod.GET , produces="application/json; charset=utf-8")
	@ResponseBody
	public Object memberList( @RequestParam Map<String,Object> map,@ModelAttribute Member login) {
		
		//System.err.println(login);
		JsonResult jsonResult = new JsonResult();
		
		try{
			//codeTblService.d
			//if(page==null) page=1;
			/*Map param = new HashMap<String, Object>();
			param.put("offset", 0);
			param.put("count", LIST_COUNT);
			
			jsonResult.setData(memberService.getAllMember(param));
			*/
			
			Integer total = memberService.getTotalMember(map);
			Map res = new HashMap();
			res.put("draw", map.get("draw"));
			res.put("recordsTotal", total);
			res.put("recordsFiltered", total);
			res.put("data", memberService.getAllMember(map));
			
			return res;
			
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
	 * 사용자 정보 조회 
	 *
	 * @param Integer memberSq 사용자고유번호
	 * @return String json 형태 
	 */
	@RequestMapping(value="/member/{memberSq}",method = RequestMethod.GET , produces="application/json; charset=utf-8")
	@ResponseBody
	public Object memberSelect(@PathVariable("memberSq") Integer memberSq ) {
		
		JsonResult jsonResult = new JsonResult();
		
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
	 * 사용자 정보 삭제 
	 *
	 * @param Integer memberSq 사용자고유번호
	 * @return String json 형태 
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
	 * 사용자 정보 갱신 
	 *
	 * @param Integer memberSq 사용자고유번호, Map map 사용자 정보
	 * @return String json 형태 
	 */
	@RequestMapping(value="/member/{memberSq}",method = RequestMethod.PUT , produces="application/json")
	@ResponseBody
	public Object memberUpdate(@PathVariable("memberSq") Integer memberSq, @RequestBody Map  map) {
		
		
		
		JsonResult jsonResult = new JsonResult();
		//Integer member_code=0;
		try{
			
			
			memberService.updateMember(map);
		}catch(Exception ex){
			jsonResult.setMsg(ex.getMessage());
			jsonResult.setSuccess(false);	
		}
		
		return jsonResult;
	}
	
	/**
	 * 사용자 정보 추가 
	 *
	 * @param Map map 사용자정보
	 * @return String json 형태 
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
	
	///////// ad_info//////////////////
	
	// start=0&draw=4&length=1
	/**
	 * 사용자 정보 삭제 
	 *
	 * @param Map map 광고정보
	 * @return String json 형태 
	 */
	@RequestMapping(value="/adInfo",method = RequestMethod.GET , produces="application/json; charset=utf-8")
	@ResponseBody
	public Object adInfoList( @RequestParam Map<String,Object> map,HttpServletRequest request) {
		
		//System.err.println(login);
		JsonResult jsonResult = new JsonResult();
		
		try{
			//codeTblService.d
			//if(page==null) page=1;
			//Map param = new HashMap<String, Object>();
			//param.put("offset", 0);
			//param.put("count", LIST_COUNT);
			
			//Member login = (Member)request.getSession().getAttribute("userInfo");
			//map.put("memberSq", login.getMemberSq());
			
			//jsonResult.setData(adInfoService.getAllAdInfo(param));
			
			Integer total = adInfoService.getTotalAdInfo(map);
			Map res = new HashMap();
			res.put("draw", map.get("draw"));
			res.put("recordsTotal", total);
			res.put("recordsFiltered", total);
			res.put("data", adInfoService.getAllAdInfo(map));
			
			return res;
			//if(page==1){
			//	jsonResult.setTotal(codeTblService.getTotal());
			//}
		}catch(Exception ex){
			jsonResult.setMsg(ex.getMessage());
			jsonResult.setSuccess(false);	
		}
		return jsonResult;
		
	}
	@RequestMapping(value="/adInfo/{adInfoSq}",method = RequestMethod.GET , produces="application/json; charset=utf-8")
	@ResponseBody
	public Object adInfoSelect(@PathVariable("adInfoSq") Integer adInfoSq ,HttpServletRequest request) {
		
		JsonResult jsonResult = new JsonResult();
		
		try{
			Map map = new HashMap<String,Object>();
			map.put("adInfoSq", adInfoSq);
			//Member login = (Member)request.getSession().getAttribute("userInfo");
			//map.put("memberSq", login.getMemberSq());
			map = adInfoService.getAdInfo(map);
			//map.put("address",postAddrService.getAddress((Integer)map.get("address_sq")));
			if(map==null){
				jsonResult.setMsg("No Data");
				jsonResult.setSuccess(false);
			}else{
				jsonResult.setData(map);
			}
			
			//memberService.updateViewCount(membe);
		}catch(Exception ex){
			jsonResult.setMsg(ex.getMessage());
			jsonResult.setSuccess(false);	
		}
		return jsonResult;
	}
	
	@RequestMapping(value="/adInfo/{adInfoSq}",method = RequestMethod.DELETE, produces="application/json")
	@ResponseBody
	public Object adInfoDelete(@PathVariable("adInfoSq") Integer adInfoSq,HttpServletRequest request) {
		//logger.info("goodDelete");
		JsonResult jsonResult = new JsonResult();
		
		try{
			Map map = new HashMap<String,Object>();
			map.put("adInfoSq", adInfoSq);
			//Member login = (Member)request.getSession().getAttribute("userInfo");
			//map.put("memberSq", login.getMemberSq());
			adInfoService.deleteAdInfo(map);
		}catch(Exception ex){
			jsonResult.setMsg(ex.getMessage());
			jsonResult.setSuccess(false);	
		}
		
		return jsonResult;
	}
	
	@RequestMapping(value="/adInfo/{adInfoSq}",method = RequestMethod.PUT , produces="application/json")
	@ResponseBody
	public Object adInfoUpdate(@PathVariable("adInfoSq") Integer adInfoSq, @RequestBody Map  map,HttpServletRequest request) {
		
		
		
		JsonResult jsonResult = new JsonResult();
		//Integer member_code=0;
		try{
			//Member login = (Member)request.getSession().getAttribute("userInfo");
			//map.put("memberSq", login.getMemberSq());
			
			adInfoService.updateAdInfo(map);
		}catch(Exception ex){
			jsonResult.setMsg(ex.getMessage());
			jsonResult.setSuccess(false);	
		}
		
		return jsonResult;
	}
	
	@RequestMapping(value="/adInfo",method = RequestMethod.POST , produces="application/json; charset=utf-8")
	@ResponseBody
	public Object adInfoSave(@RequestBody Map<String,Object> map,HttpServletRequest request) {
		
		//Integer member_code = 0;
		
		 
		JsonResult<String> jsonResult = new JsonResult<String>();
		try{
			
			//Member login = (Member)request.getSession().getAttribute("userInfo");
			//map.put("memberSq", login.getMemberSq());
			adInfoService.addAdInfo(map);
		}catch(Exception ex){
			ex.printStackTrace();
			jsonResult.setMsg(ex.getMessage());
			jsonResult.setSuccess(false);	
		}
		return jsonResult;
		
		
	}
///////// admReq//////////////////
	
	// start=0&draw=4&length=1
	@RequestMapping(value="/admReq",method = RequestMethod.GET , produces="application/json; charset=utf-8")
	@ResponseBody
	public Object admReqList( @RequestParam Map<String,Object> map,HttpServletRequest request) {
		
		//System.err.println(login);
		JsonResult jsonResult = new JsonResult();
		
		try{
			
			
			Integer total = adInfoService.getTotalAdmReq(map);
			Map res = new HashMap();
			res.put("draw", map.get("draw"));
			res.put("recordsTotal", total);
			res.put("recordsFiltered", total);
			List<Map> list = adInfoService.getAllAdmReq(map);
			if(list.size()>0){
				memberService.getSyncCompanyName(list);
				for(Map item:list){
					List kwList = adInfoService.getAllAdmReqKw(item);
					item.put("kwList", kwList);
				}
			}
			res.put("data", list);
			
			return res;
			//if(page==1){
			//	jsonResult.setTotal(codeTblService.getTotal());
			//}
		}catch(Exception ex){
			jsonResult.setMsg(ex.getMessage());
			jsonResult.setSuccess(false);	
		}
		return jsonResult;
		
	}
	@RequestMapping(value="/admReq/{admReqSq}",method = RequestMethod.GET , produces="application/json; charset=utf-8")
	@ResponseBody
	public Object admReqSelect(@PathVariable("admReqSq") Integer admReqSq ,HttpServletRequest request) {
		
		JsonResult jsonResult = new JsonResult();
		
		try{
			Map map = new HashMap<String,Object>();
			map.put("admReqSq", admReqSq);
			//Member login = (Member)request.getSession().getAttribute("userInfo");
			//map.put("memberSq", login.getMemberSq());
			map = adInfoService.getAdmReq(map);
			//map.put("address",postAddrService.getAddress((Integer)map.get("address_sq")));
			if(map==null){
				jsonResult.setMsg("No Data");
				jsonResult.setSuccess(false);
			}else{
				jsonResult.setData(map);
			}
			
			//memberService.updateViewCount(membe);
		}catch(Exception ex){
			jsonResult.setMsg(ex.getMessage());
			jsonResult.setSuccess(false);	
		}
		return jsonResult;
	}
	
	@RequestMapping(value="/admReq/{admReqSq}",method = RequestMethod.DELETE, produces="application/json")
	@ResponseBody
	public Object admReqDelete(@PathVariable("admReqSq") Integer admReqSq,HttpServletRequest request) {
		//logger.info("goodDelete");
		JsonResult jsonResult = new JsonResult();
		
		try{
			Map map = new HashMap<String,Object>();
			map.put("admReqSq", admReqSq);
			//Member login = (Member)request.getSession().getAttribute("userInfo");
			//map.put("memberSq", login.getMemberSq());
			adInfoService.deleteAdmReq(map);
		}catch(Exception ex){
			jsonResult.setMsg(ex.getMessage());
			jsonResult.setSuccess(false);	
		}
		
		return jsonResult;
	}
	
	@RequestMapping(value="/admReq/{admReqSq}",method = RequestMethod.PUT , produces="application/json")
	@ResponseBody
	public Object admReqUpdate(@PathVariable("admReqSq") Integer admReqSq, @RequestBody Map  map,HttpServletRequest request) {
		
		
		
		JsonResult jsonResult = new JsonResult();
		//Integer member_code=0;
		try{
			//Member login = (Member)request.getSession().getAttribute("userInfo");
			//map.put("memberSq", login.getMemberSq());
			String result = (String)map.get("result");
			if(result.equals("C")){//허가
				admService.addAdm(map);
				List<Map> kwList=(List<Map>)map.get("kwList");
				for(Map item:kwList){
					item.put("admSq", map.get("admSq"));
					admService.addAdmKw(item);
				}
				//Map adInfo = (Map)map.get("adInfo");
			}
			adInfoService.updateAdmReq(map);
		}catch(Exception ex){
			ex.printStackTrace();
			jsonResult.setMsg(ex.getMessage());
			jsonResult.setSuccess(false);	
		}
		
		return jsonResult;
	}
	
	@RequestMapping(value="/admReq",method = RequestMethod.POST , produces="application/json; charset=utf-8")
	@ResponseBody
	public Object admReqSave(@RequestBody Map<String,Object> map,HttpServletRequest request) {
		JsonResult<String> jsonResult = new JsonResult<String>();
		try{
			//Member login = (Member)request.getSession().getAttribute("userInfo");
			List<Map> kwList=(List<Map>)map.get("kwList");
			Map adInfo = (Map)map.get("adInfo");
			adInfo.put("result","A");
			adInfo.put("kind","A");
			//adInfo.put("memberSq", login.getMemberSq());
			adInfoService.addAdmReq(adInfo);
			for(Map item:kwList){
				//item.put("memberSq", login.getMemberSq());
				item.put("admReqSq", adInfo.get("admReqSq"));
				adInfoService.addAdmReqKw(item);
			}
		}catch(Exception ex){
			ex.printStackTrace();
			jsonResult.setMsg(ex.getMessage());
			jsonResult.setSuccess(false);	
		}
		return jsonResult;
	}
	
	///////// adm//////////////////
	
	//start=0&draw=4&length=1
	@RequestMapping(value="/adm",method = RequestMethod.GET , produces="application/json; charset=utf-8")
	@ResponseBody
	public Object admList( @RequestParam Map<String,Object> map,HttpServletRequest request) {
		
		//System.err.println(login);
		JsonResult jsonResult = new JsonResult();
		
		try{
			//codeTblService.d
			//if(page==null) page=1;
			//Map param = new HashMap<String, Object>();
			//param.put("offset", 0);
			//param.put("count", LIST_COUNT);
			
			//Member login = (Member)request.getSession().getAttribute("userInfo");
			//map.put("memberSq", login.getMemberSq());
			
			//jsonResult.setData(adInfoService.getAllAdInfo(param));
			
			Integer total = admService.getTotalAdm(map);
			List list = admService.getAllAdm(map);
			Map res = new HashMap();
			res.put("draw", map.get("draw"));
			res.put("recordsTotal", total);
			res.put("recordsFiltered", total);
			memberService.getSyncCompanyName(list);
			res.put("data", list);
			return res;
			//if(page==1){
			//	jsonResult.setTotal(codeTblService.getTotal());
			//}
		}catch(Exception ex){
			jsonResult.setMsg(ex.getMessage());
			jsonResult.setSuccess(false);	
		}
		return jsonResult;
		
	}
	@RequestMapping(value="/adm/{admSq}",method = RequestMethod.GET , produces="application/json; charset=utf-8")
	@ResponseBody
	public Object admSelect(@PathVariable("admSq") Integer admSq ,HttpServletRequest request) {
		
		JsonResult jsonResult = new JsonResult();
		
		try{
			Map map = new HashMap<String,Object>();
			map.put("admSq", admSq);
			//Member login = (Member)request.getSession().getAttribute("userInfo");
			//map.put("memberSq", login.getMemberSq());
			map = admService.getAdm(map);
			//map.put("address",postAddrService.getAddress((Integer)map.get("address_sq")));
			if(map==null){
				jsonResult.setMsg("No Data");
				jsonResult.setSuccess(false);
			}else{
				jsonResult.setData(map);
			}
			
			//memberService.updateViewCount(membe);
		}catch(Exception ex){
			jsonResult.setMsg(ex.getMessage());
			jsonResult.setSuccess(false);	
		}
		return jsonResult;
	}
	
	@RequestMapping(value="/adm/{admSq}",method = RequestMethod.DELETE, produces="application/json")
	@ResponseBody
	public Object admDelete(@PathVariable("admSq") Integer admSq,HttpServletRequest request) {
		//logger.info("goodDelete");
		JsonResult jsonResult = new JsonResult();
		
		try{
			Map map = new HashMap<String,Object>();
			map.put("admSq", admSq);
			//Member login = (Member)request.getSession().getAttribute("userInfo");
			//map.put("memberSq", login.getMemberSq());
			admService.deleteAdm(map);
		}catch(Exception ex){
			jsonResult.setMsg(ex.getMessage());
			jsonResult.setSuccess(false);	
		}
		
		return jsonResult;
	}
	
	@RequestMapping(value="/adm/{admSq}",method = RequestMethod.PUT , produces="application/json")
	@ResponseBody
	public Object admUpdate(@PathVariable("admSq") Integer admSq, @RequestBody Map  map,HttpServletRequest request) {
		
		
		
			JsonResult jsonResult = new JsonResult();
			//Integer member_code=0;
			try{
				//Member login = (Member)request.getSession().getAttribute("userInfo");
				//map.put("memberSq", login.getMemberSq());
				
				admService.updateAdm(map);
		}catch(Exception ex){
			jsonResult.setMsg(ex.getMessage());
			jsonResult.setSuccess(false);	
		}
		
		return jsonResult;
	}
	
	@RequestMapping(value="/adm",method = RequestMethod.POST , produces="application/json; charset=utf-8")
	@ResponseBody
	public Object admSave(@RequestBody Map<String,Object> map,HttpServletRequest request) {
		JsonResult<String> jsonResult = new JsonResult<String>();
		try{
			//Member login = (Member)request.getSession().getAttribute("userInfo");
			//map.put("memberSq", login.getMemberSq());
			admService.addAdm(map);
		}catch(Exception ex){
			ex.printStackTrace();
			jsonResult.setMsg(ex.getMessage());
			jsonResult.setSuccess(false);	
		}
		return jsonResult;
	}
	
	//////////////bidding/////////////
	
	@RequestMapping(value="/bidding",method = RequestMethod.GET , produces="application/json; charset=utf-8")
	@ResponseBody
	public Object biddingList( @RequestParam Map<String,Object> map,HttpServletRequest request) {
		
		//System.err.println(login);
		JsonResult jsonResult = new JsonResult();
		
		try{
			//codeTblService.d
			//if(page==null) page=1;
			//Map param = new HashMap<String, Object>();
			//param.put("offset", 0);
			//param.put("count", LIST_COUNT);
			
			//Member login = (Member)request.getSession().getAttribute("userInfo");
			//map.put("memberSq", login.getMemberSq());
			//map.put("memberSq", 2);
			//jsonResult.setData(adInfoService.getAllAdInfo(param));
			
			Integer total = admService.getTotalBidding(map);
			List list = admService.getAllBidding(map);
			memberService.getSyncCompanyName(list);
			Map res = new HashMap();
			res.put("draw", map.get("draw"));
			res.put("recordsTotal", total);
			res.put("recordsFiltered", total);
			res.put("data", list);
			
			return res;
			//if(page==1){
			//	jsonResult.setTotal(codeTblService.getTotal());
			//}
		}catch(Exception ex){
			ex.printStackTrace();
			jsonResult.setMsg(ex.getMessage());
			jsonResult.setSuccess(false);	
		}
		return jsonResult;
		
	}
	
	////advertising
	@RequestMapping(value="/advertising",method = RequestMethod.GET , produces="application/json; charset=utf-8")
	@ResponseBody
	public Object advertisingList( @RequestParam Map<String,Object> map,HttpServletRequest request) {
		
		//System.err.println(login);
		JsonResult jsonResult = new JsonResult();
		
		try{
			//codeTblService.d
			//if(page==null) page=1;
			//Map param = new HashMap<String, Object>();
			//param.put("offset", 0);
			//param.put("count", LIST_COUNT);
			
			Member login = (Member)request.getSession().getAttribute("userInfo");
			//map.put("memberSq", login.getMemberSq());
			//map.put("memberSq", 2);
			//jsonResult.setData(adInfoService.getAllAdInfo(param));
			
			Integer total = admService.getTotalAdvertising(map);
			List list = admService.getAllAdvertising(map);
			memberService.getSyncCompanyName(list);
			Map res = new HashMap();
			res.put("draw", map.get("draw"));
			res.put("recordsTotal", total);
			res.put("recordsFiltered", total);
			res.put("data", list);
			
			return res;
			//if(page==1){
			//	jsonResult.setTotal(codeTblService.getTotal());
			//}
		}catch(Exception ex){
			ex.printStackTrace();
			jsonResult.setMsg(ex.getMessage());
			jsonResult.setSuccess(false);	
		}
		return jsonResult;
		
	}
	@RequestMapping(value="/advertising/{admSq}/{kw1Sq}/{kw2Sq}",method = RequestMethod.DELETE, produces="application/json")
	@ResponseBody
	public Object advertisingDelete(@PathVariable("admSq") Integer admSq,@PathVariable("kw1Sq") Integer kw1Sq,@PathVariable("kw2Sq") Integer kw2Sq,HttpServletRequest request) {
		//logger.info("goodDelete");
		JsonResult jsonResult = new JsonResult();
		
		try{
			Map map = new HashMap<String,Object>();
			map.put("admSq", admSq);
			map.put("kw1Sq", kw1Sq);
			map.put("kw2Sq", kw2Sq);
			//Member login = (Member)request.getSession().getAttribute("userInfo");
			//map.put("memberSq", login.getMemberSq());
			admService.deleteAdvertising(map);
		}catch(Exception ex){
			jsonResult.setMsg(ex.getMessage());
			jsonResult.setSuccess(false);	
		}
		
		return jsonResult;
	}
	
	////////////poingLog/////////////////
	

	@RequestMapping(value="/pointLog",method = RequestMethod.GET , produces="application/json; charset=utf-8")
	@ResponseBody
	public Object poingLogList( @RequestParam Map<String,Object> map,HttpServletRequest request) {
		
		//System.err.println(login);
		JsonResult jsonResult = new JsonResult();
		
		try{
			//codeTblService.d
			//if(page==null) page=1;
			//Map param = new HashMap<String, Object>();
			//param.put("offset", 0);
			//param.put("count", LIST_COUNT);
			
			//Member login = (Member)request.getSession().getAttribute("userInfo");
			//map.put("memberSq", login.getMemberSq());
			
			//jsonResult.setData(adInfoService.getAllAdInfo(param));
			
			Integer total = pointService.getTotalPointLog(map);
			List list = pointService.getAllPointLog(map);
			memberService.getSyncCompanyName(list);
			
			Map res = new HashMap();
			res.put("draw", map.get("draw"));
			res.put("recordsTotal", total);
			res.put("recordsFiltered", total);
			res.put("data", list);
			res.put("success", true);
			return res;
			//if(page==1){
			//	jsonResult.setTotal(codeTblService.getTotal());
			//}
		}catch(Exception ex){
			jsonResult.setMsg(ex.getMessage());
			jsonResult.setSuccess(false);	
		}
		return jsonResult;
		
	}


	@RequestMapping(value="/pointLog",method = RequestMethod.POST , produces="application/json; charset=utf-8")
	@ResponseBody
	public Object pointLogSave(@RequestBody Map<String,Object> map,HttpServletRequest request) {
		
		//Integer member_code = 0;
		
		 
		JsonResult<String> jsonResult = new JsonResult<String>();
		try{
			
			//Member login = (Member)request.getSession().getAttribute("userInfo");
			//map.put("memberSq", login.getMemberSq());
			pointService.addPointLog(map);
		}catch(Exception ex){
			ex.printStackTrace();
			jsonResult.setMsg(ex.getMessage());
			jsonResult.setSuccess(false);	
		}
		return jsonResult;
		
		
	}
	
	
	////////포인트 적립 
	
	@RequestMapping(value="/pointSave",method = RequestMethod.POST , produces="application/json; charset=utf-8")
	@ResponseBody
	public Object pointSave(@RequestBody Map<String,Object> map,HttpServletRequest request) {
		
		//Integer member_code = 0;
		
		 //아이디 
		JsonResult<String> jsonResult = new JsonResult<String>();
		try{
			
			//Member login = (Member)request.getSession().getAttribute("userInfo");
			//map.put("memberSq", login.getMemberSq());
			pointService.pointSave(map);
		}catch(Exception ex){
			ex.printStackTrace();
			jsonResult.setMsg(ex.getMessage());
			jsonResult.setSuccess(false);	
		}
		return jsonResult;
		
		
	}
	@RequestMapping(value="/pointUse",method = RequestMethod.POST , produces="application/json; charset=utf-8")
	@ResponseBody
	public Object pointUse(@RequestBody Map<String,Object> map,HttpServletRequest request) {
		
		//Integer member_code = 0;
		
		 //아이디 
		JsonResult<String> jsonResult = new JsonResult<String>();
		try{
			
			//Member login = (Member)request.getSession().getAttribute("userInfo");
			//map.put("memberSq", login.getMemberSq());
			pointService.pointUse(map);
		}catch(Exception ex){
			ex.printStackTrace();
			jsonResult.setMsg(ex.getMessage());
			jsonResult.setSuccess(false);	
		}
		return jsonResult;
		
		
	}
	
	/// dailyAc
	@RequestMapping(value="/dailyAc",method = RequestMethod.GET , produces="application/json; charset=utf-8")
	@ResponseBody
	public Object dailyAcList( @RequestParam Map<String,Object> map,HttpServletRequest request) {
		
		//System.err.println(login);
		JsonResult jsonResult = new JsonResult();
		
		try{
			
			List list = new ArrayList();
				
			
			list=reportService.getDailyAcGroupByDate(map);
			
			Map res = new HashMap();
			res.put("draw", map.get("draw"));
			res.put("recordsTotal", list.size());
			res.put("recordsFiltered", list.size());
			//memberService.getSyncCompanyName(list);
			res.put("data", list);
			return res;
			//if(page==1){
			//	jsonResult.setTotal(codeTblService.getTotal());
			//}
		}catch(Exception ex){
			jsonResult.setMsg(ex.getMessage());
			jsonResult.setSuccess(false);	
		}
		return jsonResult;
		
	}
	@RequestMapping(value="/monthAc",method = RequestMethod.GET , produces="application/json; charset=utf-8")
	@ResponseBody
	public Object monthAcList( @RequestParam Map<String,Object> map,HttpServletRequest request) {
		
		//System.err.println(login);
		JsonResult jsonResult = new JsonResult();
		
		try{
			
			List list=reportService.getMonthAcGroupByDate(map);
			
			Map res = new HashMap();
			res.put("draw", map.get("draw"));
			res.put("recordsTotal", list.size());
			res.put("recordsFiltered", list.size());
			//memberService.getSyncCompanyName(list);
			res.put("data", list);
			return res;
			//if(page==1){
			//	jsonResult.setTotal(codeTblService.getTotal());
			//}
		}catch(Exception ex){
			jsonResult.setMsg(ex.getMessage());
			jsonResult.setSuccess(false);	
		}
		return jsonResult;
		
	}
	
	@RequestMapping(value="/dailyKw",method = RequestMethod.GET , produces="application/json; charset=utf-8")
	@ResponseBody
	public Object dailyKwList( @RequestParam Map<String,Object> map,HttpServletRequest request) {
		
		//System.err.println(login);
		JsonResult jsonResult = new JsonResult();
		
		try{
			
			List list=reportService.getAllDailyKw(map);
			Map res = new HashMap();
			res.put("draw", map.get("draw"));
			res.put("recordsTotal", list.size());
			res.put("recordsFiltered", list.size());
			//memberService.getSyncCompanyName(list);
			res.put("data", list);
			return res;
			//if(page==1){
			//	jsonResult.setTotal(codeTblService.getTotal());
			//}
		}catch(Exception ex){
			jsonResult.setMsg(ex.getMessage());
			jsonResult.setSuccess(false);	
		}
		return jsonResult;
		
	}
	// 관리자 매체 전체.
	// 매체사 날짜별로...
	@RequestMapping(value="/dailyMc",method = RequestMethod.GET , produces="application/json; charset=utf-8")
	@ResponseBody
	public Object dailyMcList( @RequestParam Map<String,Object> map,HttpServletRequest request) {
		
		//System.err.println(login);
		JsonResult jsonResult = new JsonResult();
		
		try{
			
			List list=reportService.getDailyMcGroupByDate(map);
			Map res = new HashMap();
			res.put("draw", map.get("draw"));
			res.put("recordsTotal", list.size());
			res.put("recordsFiltered", list.size());
			//memberService.getSyncCompanyName(list);
			res.put("data", list);
			return res;
			//if(page==1){
			//	jsonResult.setTotal(codeTblService.getTotal());
			//}
		}catch(Exception ex){
			jsonResult.setMsg(ex.getMessage());
			jsonResult.setSuccess(false);	
		}
		return jsonResult;
		
	}
	@RequestMapping(value="/dailyAcGroupByAdm",method = RequestMethod.GET , produces="application/json; charset=utf-8")
	@ResponseBody
	public Object dailyAcGroupByAdmList( @RequestParam Map<String,Object> map,HttpServletRequest request) {
		
		//System.err.println(login);
		JsonResult jsonResult = new JsonResult();
		
		try{
			
			List list = new ArrayList();
				
			
			list=reportService.getDailyAcGroupByAdm(map);
			
			Map res = new HashMap();
			res.put("draw", map.get("draw"));
			res.put("recordsTotal", list.size());
			res.put("recordsFiltered", list.size());
			//memberService.getSyncCompanyName(list);
			res.put("data", list);
			return res;
			//if(page==1){
			//	jsonResult.setTotal(codeTblService.getTotal());
			//}
		}catch(Exception ex){
			jsonResult.setMsg(ex.getMessage());
			jsonResult.setSuccess(false);	
		}
		return jsonResult;
		
	}
	
	
	////////// wordSite
	
	@RequestMapping(value="/wordSite",method = RequestMethod.GET , produces="application/json; charset=utf-8")
	@ResponseBody
	public Object wordSiteList( @RequestParam Map<String,Object> map) {
		
		//System.err.println(login);
		JsonResult jsonResult = new JsonResult();
		
		try{
			//codeTblService.d
			//if(page==null) page=1;
			/*Map param = new HashMap<String, Object>();
			param.put("offset", 0);
			param.put("count", LIST_COUNT);
			
			jsonResult.setData(memberService.getAllMember(param));
			*/
			
			Integer total = memberService.getTotalMember(map);
			Map res = new HashMap();
			res.put("draw", map.get("draw"));
			res.put("recordsTotal", total);
			res.put("recordsFiltered", total);
			res.put("data", admService.getAllWordSite(map));
			
			return res;
			
			//if(page==1){
			//	jsonResult.setTotal(codeTblService.getTotal());
			//}
		}catch(Exception ex){
			jsonResult.setMsg(ex.getMessage());
			jsonResult.setSuccess(false);	
		}
		return jsonResult;
		
	}
	@RequestMapping(value="/wordSite/{wordSiteSq}",method = RequestMethod.GET , produces="application/json; charset=utf-8")
	@ResponseBody
	public Object wordSelect(@PathVariable("wordSiteSq") Integer wordSiteSq ) {
		
		JsonResult jsonResult = new JsonResult();
		
		try{
			Map req = new HashMap();
			req.put("wordSiteSq",wordSiteSq);
			Map map = admService.getWordSite(req);
			//map.put("address",postAddrService.getAddress((Integer)map.get("address_sq")));
			jsonResult.setData(map);
			
			//memberService.updateViewCount(membe);
		}catch(Exception ex){
			jsonResult.setMsg(ex.getMessage());
			jsonResult.setSuccess(false);	
		}
		return jsonResult;
	}
	
	@RequestMapping(value="/wordSite/{wordSiteSq}",method = RequestMethod.DELETE, produces="application/json")
	@ResponseBody
	public Object wordSiteDelete(@PathVariable("wordSiteSq") Integer wordSiteSq) {
		//logger.info("goodDelete");
		JsonResult jsonResult = new JsonResult();
		
		try{
			Map req = new HashMap();
			req.put("wordSiteSq",wordSiteSq);
			admService.deleteWordSite(req);
		}catch(Exception ex){
			jsonResult.setMsg(ex.getMessage());
			jsonResult.setSuccess(false);	
		}
		
		return jsonResult;
	}
	
	@RequestMapping(value="/wordSite/{wordSiteSq}",method = RequestMethod.PUT , produces="application/json")
	@ResponseBody
	public Object wordSiteUpdate(@PathVariable("wordSiteSq") Integer wordSiteSq, @RequestBody Map  map) {
		
		
		
		JsonResult jsonResult = new JsonResult();
		//Integer member_code=0;
		try{
			
			
			//memberService.updateMember(map);
		}catch(Exception ex){
			jsonResult.setMsg(ex.getMessage());
			jsonResult.setSuccess(false);	
		}
		
		return jsonResult;
	}
	
	@RequestMapping(value="/wordSite",method = RequestMethod.POST , produces="application/json; charset=utf-8")
	@ResponseBody
	public Object wordSiteSave(@RequestBody Map<String,Object> map) {
		
		//Integer member_code = 0;
		System.err.println(map);
		JsonResult<String> jsonResult = new JsonResult<String>();
		try{
			admService.addWordSite(map);
		}catch(Exception ex){
			ex.printStackTrace();
			jsonResult.setMsg(ex.getMessage());
			jsonResult.setSuccess(false);	
		}
		return jsonResult;
		
		
	}
}

