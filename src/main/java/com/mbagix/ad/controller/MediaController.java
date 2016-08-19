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
import com.mbagix.ad.service.ReportService;
/**
 * 매체 컨트롤러  
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

@RequestMapping("/media")
@Controller(value = "mediaController")

public class MediaController {
	
	//public static  int LIST_COUNT=10;
	@Resource(name = "memberService")
	private MemberService memberService;
	
	@Resource(name = "admService")
	private AdmService admService;
	
	@Resource(name = "adInfoService")
	private AdInfoService adInfoService;
	
	@Resource(name = "reportService")
	private ReportService reportService;
	
	@RequestMapping("/")
    public String home(@ModelAttribute("userInfo") Member login) {
		
		System.err.println(login);
		
		
		if(login.getMemberSq()==null){
 			return "/login";
		}
        return "redirect:/media/ad_unit.jsp";
    }
	@RequestMapping("/index")
    public String index( HttpServletRequest request) {
		
		
		Member login = (Member)request.getSession().getAttribute("userInfo");
		//System.err.println(login);
		if(login==null){
 			return "/login";
		}
		return "redirect:/media/ad_unit.jsp";
    }
	@RequestMapping(value="/stat",method = RequestMethod.GET , produces="application/json; charset=utf-8")
	@ResponseBody
	public Object stat( @RequestParam Map<String,Object> map,HttpServletRequest request) {
		
		JsonResult jsonResult = new JsonResult();
		
		try{
			//codeTblService.d
			
		}catch(Exception ex){
			jsonResult.setMsg(ex.getMessage());
			jsonResult.setSuccess(false);	
		}
		return jsonResult;
		
	}
	@RequestMapping(value="/adUnit",method = RequestMethod.GET , produces="application/json; charset=utf-8")
	@ResponseBody
	public Object adUnitList( @RequestParam Map<String,Object> map,HttpServletRequest request) {
		
		JsonResult jsonResult = new JsonResult();
		
		try{
			//codeTblService.d
			//if(page==null) page=1;
			//Map param = new HashMap<String, Object>();
			//param.put("offset", 0);
			//param.put("count", LIST_COUNT);
			Member login = (Member)request.getSession().getAttribute("userInfo");
			map.put("memberSq", login.getMemberSq());
			//map.put("memberSq", 4);
			Integer total = adInfoService.getTotalAdUnit(map);
			Map res = new HashMap();
			res.put("draw", map.get("draw"));
			res.put("recordsTotal", total);
			res.put("recordsFiltered", total);
			List<Map> list = adInfoService.getAllAdUnit(map);
			
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
	@RequestMapping(value="/adUnit/{adUnitSq}",method = RequestMethod.GET , produces="application/json; charset=utf-8")
	@ResponseBody
	public Object adUnitSelect(@PathVariable("adUnitSq") Integer adUnitSq ,@RequestParam Map<String,Object> map,HttpServletRequest request) {
		
		JsonResult jsonResult = new JsonResult();
		
		try{
			Member login = (Member)request.getSession().getAttribute("userInfo");
			map.put("memberSq", login.getMemberSq());
			map.put("adUnitSq", adUnitSq);
			//map.put("memberSq", 4);
			Map item = adInfoService.getAdUnit(map);
			//map.put("address",postAddrService.getAddress((Integer)map.get("address_sq")));
			jsonResult.setData(item);
			
			//memberService.updateViewCount(membe);
		}catch(Exception ex){
			jsonResult.setMsg(ex.getMessage());
			jsonResult.setSuccess(false);	
		}
		
		return jsonResult;
		
		
		
	}
	
	@RequestMapping(value="/adUnit/{adUnitSq}",method = RequestMethod.DELETE, produces="application/json")
	@ResponseBody
	public Object adUnitDelete(@PathVariable("adUnitSq") Integer adUnitSq,HttpServletRequest request) {
		//logger.info("goodDelete");
		JsonResult jsonResult = new JsonResult();
		
		try{
			
			Map map = new HashMap();
			map.put("adUnitSq", adUnitSq);
			Member login = (Member)request.getSession().getAttribute("userInfo");
			//map.put("memberSq", login.getMemberSq());
			map.put("memberSq", 4);
			adInfoService.deleteAdUnit(map);
		}catch(Exception ex){
			jsonResult.setMsg(ex.getMessage());
			jsonResult.setSuccess(false);	
		}
		
		return jsonResult;
	}
	
	@RequestMapping(value="/adUnit/{adUnitSq}",method = RequestMethod.PUT , produces="application/json")
	@ResponseBody
	public Object adUnitUpdate(@PathVariable("adUnitSq") Integer adUnitSq, @RequestBody Map  map,HttpServletRequest request) {
		
		
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
			Member login = (Member)request.getSession().getAttribute("userInfo");
			//map.put("memberSq", login.getMemberSq());
			map.put("memberSq", 4);
			adInfoService.updateAdUnit(map);
		}catch(Exception ex){
			jsonResult.setMsg(ex.getMessage());
			jsonResult.setSuccess(false);	
		}
		
		return jsonResult;
	}
	
	@RequestMapping(value="/adUnit",method = RequestMethod.POST , produces="application/json; charset=utf-8")
	@ResponseBody
	public Object adUnitSave(@RequestBody Map<String,Object> map,HttpServletRequest request) {
		
		//Integer member_code = 0;
		JsonResult<String> jsonResult = new JsonResult<String>();
		try{
			
			Member login = (Member)request.getSession().getAttribute("userInfo");
			map.put("memberSq", login.getMemberSq());
			//map.put("memberSq", 4);
			
			Map serviceInfo = adInfoService.getService(map);
			map.put("adType", map.get("adType"));
			adInfoService.addAdUnit(map);
		}catch(Exception ex){
			ex.printStackTrace();
			jsonResult.setMsg(ex.getMessage());
			jsonResult.setSuccess(false);	
		}
		return jsonResult;
		
		
	}
	
	/// service
	
	@RequestMapping(value="/service",method = RequestMethod.GET , produces="application/json; charset=utf-8")
	@ResponseBody
	public Object serviceList( @RequestParam Map<String,Object> map,HttpServletRequest request) {
		
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
			jsonResult.setData(adInfoService.getAllService(map));
			
			//if(page==1){
			//	jsonResult.setTotal(codeTblService.getTotal());
			//}
		}catch(Exception ex){
			jsonResult.setMsg(ex.getMessage());
			jsonResult.setSuccess(false);	
		}
		return jsonResult;
		
	}
	@RequestMapping(value="/service/{serviceSq}",method = RequestMethod.GET , produces="application/json; charset=utf-8")
	@ResponseBody
	public Object serviceSelect(@PathVariable("serviceSq") Integer serviceSq ,@RequestParam Map<String,Object> map,HttpServletRequest request) {
		
		JsonResult jsonResult = new JsonResult();
		
		try{
			Member login = (Member)request.getSession().getAttribute("userInfo");
			map.put("memberSq", login.getMemberSq());
			//map.put("memberSq", 4);
			Map item = adInfoService.getService(map);
			//map.put("address",postAddrService.getAddress((Integer)map.get("address_sq")));
			jsonResult.setData(item);
			
			//memberService.updateViewCount(membe);
		}catch(Exception ex){
			jsonResult.setMsg(ex.getMessage());
			jsonResult.setSuccess(false);	
		}
		
		return jsonResult;
		
		
		
	}
	
	@RequestMapping(value="/service/{serviceSq}",method = RequestMethod.DELETE, produces="application/json")
	@ResponseBody
	public Object serviceDelete(@PathVariable("serviceSq") Integer serviceSq,HttpServletRequest request) {
		//logger.info("goodDelete");
		JsonResult jsonResult = new JsonResult();
		
		try{
			
			Map map = new HashMap();
			map.put("serviceSq", serviceSq);
			Member login = (Member)request.getSession().getAttribute("userInfo");
			map.put("memberSq", login.getMemberSq());
			//map.put("memberSq", 4);
			adInfoService.deleteService(map);
		}catch(Exception ex){
			jsonResult.setMsg(ex.getMessage());
			jsonResult.setSuccess(false);	
		}
		
		return jsonResult;
	}
	
	@RequestMapping(value="/service/{serviceSq}",method = RequestMethod.PUT , produces="application/json")
	@ResponseBody
	public Object serviceUpdate(@PathVariable("serviceSq") Integer serviceSq, @RequestBody Map  map,HttpServletRequest request) {
		
		
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
			Member login = (Member)request.getSession().getAttribute("userInfo");
			map.put("memberSq", login.getMemberSq());
			//map.put("memberSq", 4);
			adInfoService.updateService(map);
		}catch(Exception ex){
			jsonResult.setMsg(ex.getMessage());
			jsonResult.setSuccess(false);	
		}
		
		return jsonResult;
	}
	
	@RequestMapping(value="/service",method = RequestMethod.POST , produces="application/json; charset=utf-8")
	@ResponseBody
	public Object serviceSave(@RequestBody Map<String,Object> map,HttpServletRequest request) {
		
		//Integer member_code = 0;
		JsonResult<String> jsonResult = new JsonResult<String>();
		try{
			
			Member login = (Member)request.getSession().getAttribute("userInfo");
			map.put("memberSq", login.getMemberSq());
			//map.put("memberSq", 4);
			adInfoService.addService(map);
			
			List<Map> categoryList = (List<Map>)map.get("categoryList");
			if(categoryList!=null){
				for(Map category:categoryList){
					if(category!=null && !category.isEmpty()){
						category.put("memberSq",map.get("memberSq"));
						category.put("serviceSq",map.get("serviceSq"));
						adInfoService.addServiceCategory(category);
					}
				}
			}
		}catch(Exception ex){
			ex.printStackTrace();
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
			List list = new ArrayList();
				
			
			list=reportService.getDailyMcGroupByDate(map);
			
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
	@RequestMapping(value="/monthMc",method = RequestMethod.GET , produces="application/json; charset=utf-8")
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
	
	@RequestMapping(value="/dailyMcGroupByAdUnit",method = RequestMethod.GET , produces="application/json; charset=utf-8")
	@ResponseBody
	public Object dailyMcGroupByAdUnitList( @RequestParam Map<String,Object> map,HttpServletRequest request) {
		
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

