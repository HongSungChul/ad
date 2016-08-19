package com.mbagix.ad.controller;


import java.util.ArrayList;
import java.util.Calendar;
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
import org.springframework.web.servlet.ModelAndView;

import com.mbagix.ad.model.JsonResult;
import com.mbagix.ad.model.Member;
import com.mbagix.ad.service.AdInfoService;
import com.mbagix.ad.service.AdmService;
import com.mbagix.ad.service.MemberService;
import com.mbagix.ad.service.PointService;
import com.mbagix.ad.service.ReportService;
/**
 * 광고주 컨트롤러   
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

@RequestMapping("/advertiser")
@Controller(value = "advertiserController")
//@SessionAttributes("userInfo")
public class AdvertiserController {
	
	public static  int LIST_COUNT=10;
	@Resource(name = "memberService")
	private MemberService memberService;
	
	@Resource(name = "admService")
	private AdmService admService;
	
	@Resource(name = "adInfoService")
	private AdInfoService adInfoService;
	
	@Resource(name = "reportService")
	private ReportService reportService;
	
	@Resource(name = "pointService")
	private PointService pointService;
	
	
	@RequestMapping("")
    public String home1(@ModelAttribute("userInfo") Member login) {
		
        return "aaa";
    }
	@RequestMapping("/")
    public String home(@ModelAttribute("userInfo") Member login) {
		
		System.err.println(login);
		
		
		if(login.getMemberSq()==null){
			return "redirect:/login.jsp";
		}
        return "redirect:/advertiser/index.jsp";
    }
	
	@RequestMapping("/index")
    public ModelAndView index( HttpServletRequest request) {
		
		
		Member login = (Member)request.getSession().getAttribute("userInfo");
		//System.err.println(login);
		ModelAndView mav = new ModelAndView();
		
		if(login==null){
			mav.setViewName("/login");
 			return mav;
		}
		Map param = new HashMap();
		param.put("memberSq", login.getMemberSq());
		
		Map res = new HashMap();
		mav.addObject("admCnt",admService.getTotalAdm(param)); // 전체 광고물 갯수 
		
		mav.addObject("biddingCnt",admService.getTotalBidding(param)); //입찰한갯수
		
		mav.addObject("advertisingCnt",admService.getTotalAdvertising(param));//광고집행갯수 
		
		mav.addObject("kwCntInfo",admService.getKwCntFromBidding(login.getMemberSq())); //입찰키워드
		
		mav.addObject("memberInfo",memberService.getMember(login.getMemberSq()));
		
		param.put("gubun", "A");//적입 
		Calendar cal = Calendar.getInstance();
	
		param.put("endDate",cal.getTime());
		cal.set(Calendar.DAY_OF_MONTH, 1);
		param.put("startDate",cal.getTime());
		
		mav.addObject("recentMonthSaveSum",pointService.getSumPointLog(param));
		
		param.put("gubun","B");
		param.put("kind","B");
		mav.addObject("recentMonthUseSum",pointService.getSumPointLog(param));
		
		
		cal = Calendar.getInstance();
		
		
		cal.add(Calendar.DATE, -1);
		cal.set(Calendar.HOUR_OF_DAY, 0);
		cal.set(Calendar.MINUTE, 0);
		//cal.set(Calendar.HOUR_OF_DAY, 0);
		param.put("startDate",cal.getTime());
		
		cal.set(Calendar.HOUR_OF_DAY, 24);
		param.put("endDate",cal.getTime());
		mav.addObject("yesterdayUseSum",pointService.getSumPointLog(param));
		//mav.addObject("test","test");
		mav.setViewName("/advertiser/index");
		return mav;
        //return "/advertiser/index";
    }
	@RequestMapping(value="/stat",method = RequestMethod.GET , produces="application/json; charset=utf-8")
	@ResponseBody
	public Object stat( @RequestParam Map<String,Object> map,HttpServletRequest request) {
		
		//System.err.println(login);
		JsonResult jsonResult = new JsonResult();
		
		try{
			Member login = (Member)request.getSession().getAttribute("userInfo");
			//System.err.println(login);
			//ModelAndView mav = new ModelAndView();
			Map data = new HashMap();
			if(login==null){
				//mav.setViewName("/login");
	 			//return mav;
			}else{
				Map param = new HashMap();
				param.put("memberSq", login.getMemberSq());
				
				Map res = new HashMap();
				data.put("admCnt",admService.getTotalAdm(param)); // 전체 광고물 갯수 
				
				data.put("biddingCnt",admService.getTotalBidding(param)); //입찰한갯수
				
				data.put("advertisingCnt",admService.getTotalAdvertising(param));//광고집행갯수 
				
				data.put("kwCntInfo",admService.getKwCntFromBidding(login.getMemberSq())); //입찰키워드
				
				data.put("memberInfo",memberService.getMember(login.getMemberSq()));
				
				param.put("gubun", "A");//적입 
				Calendar cal = Calendar.getInstance();
			
				param.put("endDate",cal.getTime());
				cal.set(Calendar.DAY_OF_MONTH, 1);
				param.put("startDate",cal.getTime());
				
				data.put("recentMonthSaveSum",pointService.getSumPointLog(param));
				
				param.put("gubun","B");
				param.put("kind","B");
				data.put("recentMonthUseSum",pointService.getSumPointLog(param));
				
				
				cal = Calendar.getInstance();
				
				
				cal.add(Calendar.DATE, -1);
				cal.set(Calendar.HOUR_OF_DAY, 0);
				cal.set(Calendar.MINUTE, 0);
				//cal.set(Calendar.HOUR_OF_DAY, 0);
				param.put("startDate",cal.getTime());
				
				cal.set(Calendar.HOUR_OF_DAY, 24);
				param.put("endDate",cal.getTime());
				data.put("yesterdayUseSum",pointService.getSumPointLog(param));
				//mav.addObject("test","test");
				
			}
			jsonResult.setData(data);;
		}catch(Exception ex){
			jsonResult.setMsg(ex.getMessage());
			jsonResult.setSuccess(false);	
		}
		return jsonResult;
		
	}
	
	@RequestMapping(value="/member",method = RequestMethod.GET , produces="application/json; charset=utf-8")
	@ResponseBody
	public Object memberList( @RequestParam Map<String,Object> map,@ModelAttribute Member login) {
		
		//System.err.println(login);
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
			
			Member login = (Member)request.getSession().getAttribute("userInfo");
			map.put("memberSq", login.getMemberSq());
			
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
			Member login = (Member)request.getSession().getAttribute("userInfo");
			map.put("memberSq", login.getMemberSq());
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
			Member login = (Member)request.getSession().getAttribute("userInfo");
			map.put("memberSq", login.getMemberSq());
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
			Member login = (Member)request.getSession().getAttribute("userInfo");
			map.put("memberSq", login.getMemberSq());
			
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
			
			Member login = (Member)request.getSession().getAttribute("userInfo");
			map.put("memberSq", login.getMemberSq());
			adInfoService.addAdInfo(map);
		}catch(Exception ex){
			ex.printStackTrace();
			jsonResult.setMsg(ex.getMessage());
			jsonResult.setSuccess(false);	
		}
		return jsonResult;
		
		
	}
///////// adMReq//////////////////
	
	// start=0&draw=4&length=1
	@RequestMapping(value="/admReq",method = RequestMethod.GET , produces="application/json; charset=utf-8")
	@ResponseBody
	public Object adAdmReqList( @RequestParam Map<String,Object> map,HttpServletRequest request) {
		
		//System.err.println(login);
		JsonResult jsonResult = new JsonResult();
		
		try{
			//codeTblService.d
			//if(page==null) page=1;
			//Map param = new HashMap<String, Object>();
			//param.put("offset", 0);
			//param.put("count", LIST_COUNT);
			
			Member login = (Member)request.getSession().getAttribute("userInfo");
			map.put("memberSq", login.getMemberSq());
			
			//jsonResult.setData(adInfoService.getAllAdInfo(param));
			
			Integer total = adInfoService.getTotalAdmReq(map);
			Map res = new HashMap();
			res.put("draw", map.get("draw"));
			res.put("recordsTotal", total);
			res.put("recordsFiltered", total);
			List<Map> list = adInfoService.getAllAdmReq(map);
			for(Map item:list){
				List kwList = adInfoService.getAllAdmReqKw(item);
				item.put("kwList", kwList);
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
			Member login = (Member)request.getSession().getAttribute("userInfo");
			map.put("memberSq", login.getMemberSq());
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
	public Object adReqDelete(@PathVariable("admReqSq") Integer admReqSq,HttpServletRequest request) {
		//logger.info("goodDelete");
		JsonResult jsonResult = new JsonResult();
		
		try{
			Map map = new HashMap<String,Object>();
			map.put("admReqSq", admReqSq);
			Member login = (Member)request.getSession().getAttribute("userInfo");
			map.put("memberSq", login.getMemberSq());
			adInfoService.deleteAdmReq(map);
		}catch(Exception ex){
			jsonResult.setMsg(ex.getMessage());
			jsonResult.setSuccess(false);	
		}
		
		return jsonResult;
	}
	
	@RequestMapping(value="/admReq/{admReqSq}",method = RequestMethod.PUT , produces="application/json")
	@ResponseBody
	public Object adAdmReqUpdate(@PathVariable("admReqSq") Integer admReqSq, @RequestBody Map  map,HttpServletRequest request) {
		
		
		
		JsonResult jsonResult = new JsonResult();
		//Integer member_code=0;
		try{
			Member login = (Member)request.getSession().getAttribute("userInfo");
			map.put("memberSq", login.getMemberSq());
			
			adInfoService.updateAdmReq(map);
		}catch(Exception ex){
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
			Member login = (Member)request.getSession().getAttribute("userInfo");
			List<Map> kwList=(List<Map>)map.get("kwList");
			Map adInfo = (Map)map.get("adInfo");
			adInfo.put("result","A");
			adInfo.put("kind","A");
			adInfo.put("memberSq", login.getMemberSq());
			adInfoService.addAdmReq(adInfo);
			for(Map item:kwList){
				item.put("memberSq", login.getMemberSq());
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
			
			Member login = (Member)request.getSession().getAttribute("userInfo");
			//map.put("memberSq", login.getMemberSq());
			map.put("memberSq", login.getMemberSq());
			//jsonResult.setData(adInfoService.getAllAdInfo(param));
			
			List list = admService.getAllAdm(map);
			Integer total = admService.getTotalAdm(map);
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
			Member login = (Member)request.getSession().getAttribute("userInfo");
			map.put("memberSq", login.getMemberSq());
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
			Member login = (Member)request.getSession().getAttribute("userInfo");
			map.put("memberSq", login.getMemberSq());
			admService.deleteAdm(map);
		}catch(Exception ex){
			jsonResult.setMsg(ex.getMessage());
			jsonResult.setSuccess(false);	
		}
		
		return jsonResult;
	}
	
	@RequestMapping(value="/adm/{admSq}",method = RequestMethod.PUT , produces="application/json")
	@ResponseBody
	public Object adAdmUpdate(@PathVariable("admSq") Integer admSq, @RequestBody Map  map,HttpServletRequest request) {
		
		
		
			JsonResult jsonResult = new JsonResult();
			//Integer member_code=0;
			try{
				Member login = (Member)request.getSession().getAttribute("userInfo");
				map.put("memberSq", login.getMemberSq());
				
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
			Member login = (Member)request.getSession().getAttribute("userInfo");
			map.put("memberSq", login.getMemberSq());
			admService.addAdm(map);
		}catch(Exception ex){
			ex.printStackTrace();
			jsonResult.setMsg(ex.getMessage());
			jsonResult.setSuccess(false);	
		}
		return jsonResult;
	}
	
	/////////bidding
	@RequestMapping(value="/biddingList",method = RequestMethod.GET , produces="application/json; charset=utf-8")
	@ResponseBody
	public Object biddingList1( @RequestParam(value="admSq", required=true) Integer admSq,
			@RequestParam Map<String,Object> map,HttpServletRequest request) {
		
		//System.err.println(login);
		JsonResult jsonResult = new JsonResult();
		
		try{
			
			
			Member login = (Member)request.getSession().getAttribute("userInfo");
			//map.put("memberSq", login.getMemberSq());
			map.put("memberSq", login.getMemberSq());
			
			List<Map> biddingList = admService.getAllAdmKw(map);
			
			for(Map item:biddingList){
				Map where = new HashMap();
				where.put("kw1Sq", item.get("kw1Sq"));
				where.put("kw2Sq", item.get("kw2Sq"));
				//System.err.println(where);
				List<Map> bList = admService.getAllBiddingByPoint(where);
				//System.err.println(bList);
				int ranking=1;
				for(Map bid:bList){
					item.put("price"+ranking, bid.get("point"));
					if(bid.get("memberSq").equals(map.get("memberSq"))){
						item.put("myRanking", ranking);
						item.put("myPrice", bid.get("point"));
					}
					ranking++;
				}
			}
			jsonResult.setData(biddingList);
		}catch(Exception ex){
			jsonResult.setMsg(ex.getMessage());
			jsonResult.setSuccess(false);	
		}
		return jsonResult;
		
	}
	@RequestMapping(value="/bidding",method = RequestMethod.POST , produces="application/json; charset=utf-8")
	@ResponseBody
	public Object biddingSave(@RequestBody Map<String,Object> map,HttpServletRequest request) {
		
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
			map.put("memberSq", login.getMemberSq());
			admService.deleteBidding(map);
			admService.addBidding(map);
			admService.flushAdvertiser((Integer)map.get("kw1Sq"), (Integer)map.get("kw2Sq"));
		}catch(Exception ex){
			jsonResult.setMsg(ex.getMessage());
			jsonResult.setSuccess(false);	
		}
		return jsonResult;
		
	}
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
			
			Member login = (Member)request.getSession().getAttribute("userInfo");
			//map.put("memberSq", login.getMemberSq());
			map.put("memberSq", login.getMemberSq());
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
			map.put("memberSq", login.getMemberSq());
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
	
	@RequestMapping(value="/dailyAc",method = RequestMethod.GET , produces="application/json; charset=utf-8")
	@ResponseBody
	public Object dailyAcList( @RequestParam Map<String,Object> map,HttpServletRequest request) {
		
		//System.err.println(login);
		JsonResult jsonResult = new JsonResult();
		
		try{
			Member login = (Member)request.getSession().getAttribute("userInfo");
			map.put("memberSq", login.getMemberSq());
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
			
			Member login = (Member)request.getSession().getAttribute("userInfo");
			map.put("memberSq", login.getMemberSq());
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
	@RequestMapping(value="/dailyMc",method = RequestMethod.GET , produces="application/json; charset=utf-8")
	@ResponseBody
	public Object dailyMcList( @RequestParam Map<String,Object> map,HttpServletRequest request) {
		
		//System.err.println(login);
		JsonResult jsonResult = new JsonResult();
		
		try{
			Member login = (Member)request.getSession().getAttribute("userInfo");
			map.put("memberSq", login.getMemberSq());
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
			Member login = (Member)request.getSession().getAttribute("userInfo");
			map.put("memberSq", login.getMemberSq());
			List list = new ArrayList();
				
			
			list=reportService.getDailyAcGroupByAdm(map);
			
			Map res = new HashMap();
			res.put("draw", map.get("draw"));
			res.put("recordsTotal", list.size());
			res.put("recordsFiltered", list.size());
			admService.getSyncAdmTitle(list);
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
}

