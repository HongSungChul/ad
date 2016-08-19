package com.mbagix.ad.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.CookieGenerator;

import com.mbagix.ad.model.JsonResult;
import com.mbagix.ad.service.AdInfoService;
import com.mbagix.ad.service.AdmService;
import com.mbagix.ad.service.AnalService;
import com.mbagix.ad.service.CategoryService;
import com.mbagix.ad.service.KeywordService;
import com.mbagix.ad.service.SysService;

/**
 * api  제공 컨트롤러  
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

@RequestMapping("/api")
@Controller(value = "apiController")

public class ApiController {
	@Resource(name = "sysService")
	private SysService sysService;
	
	@Resource(name = "categoryService")
	private CategoryService categoryService;
	
	@Resource(name = "keywordService")
	private KeywordService keywordService;
	
	
	@Resource(name = "admService")
	private AdmService admService;
	
	
	@Resource(name = "adInfoService")
	private AdInfoService adInfoService;
	
	
	@Resource(name = "analService")
	private AnalService analService;
	
	
	private static String adUidName="bx_ad_uid";
	private String getAdUid(HttpServletRequest req,HttpServletResponse res){
		
		String reg_Id = getCookieVal(req,res,adUidName);
		
		if(reg_Id==null || reg_Id.equals("")){
			CookieGenerator cookieGer = new CookieGenerator();
			reg_Id = com.mbagix.ad.util.Convert.getRandomId();
			cookieGer.setCookieName(adUidName);
			cookieGer.addCookie(res, reg_Id);
			cookieGer.setCookieMaxAge(60*60*24*365*5);
			
		}
		return reg_Id;
	}
	private String getCookieVal(HttpServletRequest req,HttpServletResponse res,String cookieName){
		String cookieValue = "";
		Cookie[] cookies = req.getCookies();
			if (cookies != null && cookies.length > 0) {
				for (Cookie cookie : cookies) {
					if (cookieName.equals(cookie.getName())) {
						cookieValue = cookie.getValue();
						break;
					}
				}
		}
		
		return cookieValue;
	}
	@RequestMapping(value="/view",method = RequestMethod.POST,produces="application/json; charset=utf-8")
	@ResponseBody
	public Object view(@RequestBody Map<String,Object> map,HttpServletRequest request,HttpServletResponse response) {
		String adUid = getAdUid(request,response);
		try{
			
			System.err.println(map);
			//String adUnitSq = map.getParameter("adUnitSq");
			
			List<Map> adList = (List)map.get("adList");
			for(Map item:adList){
				item.put("requestSq",map.get("requestSq"));
				item.put("adUnitSq",map.get("adUnitSq"));
				item.put("ip", request.getRemoteAddr());
				item.put("referer", request.getHeader("referer"));
				item.put("adUid", adUid);
				admService.view(item);
			}
			
			
			//Map advertising = admService.getAdvertising(map);
			
			
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return "ok";
	}
	@RequestMapping(value="/click",method = RequestMethod.GET)
	@ResponseBody
	public Object click(@RequestParam Map<String,Object> map,HttpServletRequest request,HttpServletResponse response) {
		//logger.info("goodDelete");
		
		
		// 광고물 admSq
		// 키워드 -kw1Sq,kw2Sq
		// 광고단위 -adUnitSq
		// 
		
		// 광고집행건을 가져온다.
		String adUid = getAdUid(request,response);
		try{
			map.put("ip", request.getRemoteAddr());
			map.put("referer", request.getHeader("referer"));
			map.put("adUid", adUid);
			//Map advertising = admService.getAdvertising(map);
			
			admService.click(map);
			
			
			//response
			//price 
			
			
			// insert filed
			//admSq,kw1Sq,kw2Sq,admSq,adUnitSq,point,ip,referer,regDate//
			
			//admService.addClick
		}catch(Exception ex){
			
		}
		
		
		try{
			
			response.sendRedirect((String)map.get("url"));
		}catch(Exception ex){
			
		}
		return "";
		
	}
	
	@RequestMapping(value="/agent.js",headers="Accept=*/*",produces="text/javascript; charset=utf-8" )
	
	public ModelAndView agentJs(@RequestParam Map<String,Object> map,HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("/agent_js");
		return mav;
	}

	@RequestMapping(value="/ad.js",headers="Accept=*/*",produces="text/javascript; charset=utf-8" )
	
	public ModelAndView adJs(@RequestParam Map<String,Object> map,HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		/*List<Map> allList = admService.advertisingList((String)map.get("query"));
		
		Map data = new HashMap();
		if(allList!=null && allList.size()>0){
			
			mav.addObject("ad_num", allList.size());
		}else{
			mav.addObject("ad_num", 0);
		}*/
		
		mav.setViewName("/ad_js");
		return mav;
	}
	@RequestMapping(value ="/ad_confirm", produces =MediaType.APPLICATION_JSON_VALUE )
    public ResponseEntity<Object> adConfirm(@RequestParam Map<String,String> map,HttpServletRequest request,HttpServletResponse response) {
    	//Book book = new Book();
    	//book.setBookName("Ramayan");
    	//book.setWriter("Valmiki");
		Map data = new HashMap();
		String adUid = getAdUid(request,response);
		Map req = new HashMap();
		try{
			
			req.put("query", (String)map.get("query"));
			req.put("adUnitSq", map.get("adUnitSq"));
			req.put("ip", request.getRemoteAddr());
			req.put("referer", request.getHeader("referer"));
			req.put("originHost", map.get("originHost"));
			req.put("adUid",adUid);
			admService.addRequest(req);
			//System.err.println(req);
			data.put("requestSq",req.get("requestSq"));
			
			
			analService.createKeyword(adUid, 10);
		}catch(Exception ex){
			ex.printStackTrace();
		}
		
		if(map.get("adClient").charAt(0)=='a'){
			List<Map> allList = admService.advertisingList((String)map.get("query"));
			if(allList!=null && allList.size()>0){
				data.put("num", allList.size());
			}else{
				data.put("num", 0);
			}
		}else{
			Map hm = new HashMap();
			hm.put("adUid", adUid);
			System.err.println(adUid);
			List<Map> wordUserList = admService.getAllWordUser(hm);
			data.put("num", wordUserList.size());
		}
        return ResponseEntity.accepted().body(data);
    } 
	
	@RequestMapping(value="/ad.css",headers="Accept=*/*",method = RequestMethod.GET ,produces="text/css; charset=utf-8")
	public ModelAndView addCss(@RequestParam Map<String,Object> map,HttpServletRequest request) {
		
		ModelAndView mav = new ModelAndView();
		
    	mav.setViewName("/ad_css");
		return mav;
	}
	/*
	 * 검색광고 script,,,,,,
	 * 
	 */
	@RequestMapping(value="/adSearch.js",headers="Accept=*/*",method = RequestMethod.GET ,produces="text/javascript; charset=utf-8")
	public ModelAndView adSearch1(@RequestParam Map<String,Object> map,HttpServletRequest request,HttpServletResponse response) {
		
		String adUid = getAdUid(request,response);
		JsonResult jsonResult = new JsonResult();
		ModelAndView mav = new ModelAndView();
		List<Map> brandList = new ArrayList();
		List<Map> categoryList = new ArrayList();
		/*Map req = new HashMap();
		try{
			
			req.put("query", (String)map.get("query"));
			req.put("adUnitSq", map.get("adUnitSq"));
			req.put("ip", request.getRemoteAddr());
			req.put("referer", request.getHeader("referer"));
			req.put("adUid",adUid);
			admService.addRequest(req);
			//System.err.println(req);
			mav.addObject("requestSq",req.get("requestSq"));
		}catch(Exception ex){
			ex.printStackTrace();
		}*/
		try{
			//Map query = new HashMap();
			//query.put("kw1Name",map.get("query"));
			List<Map> allList = admService.advertisingList((String)map.get("query"));
			for(Map item:allList){
				if("A".equals(item.get("kind"))){
					brandList.add(item);
				}else{
					categoryList.add(item);
				}
			}
			
			ObjectMapper mapper = new ObjectMapper();
			
			if(brandList.size()==0 && categoryList.size()==0){
				mav.addObject("adList", "[]");
			}else if(brandList.size()!=0){
				String temp= mapper.writeValueAsString(arrangeAd(brandList));
				mav.addObject("adList", temp);
			}else if(categoryList.size()!=0){
				String temp= mapper.writeValueAsString(arrangeAd(categoryList));
				mav.addObject("adList", temp);
			}
			
		}catch(Exception ex){
			ex.printStackTrace();
			jsonResult.setMsg(ex.getMessage());
			jsonResult.setSuccess(false);
		}
		mav.addObject("test","test");
		
    	mav.setViewName("/ad_search1");
		return mav;
	}
	@RequestMapping(value="/adSearch.json",headers="Accept=*/*" ,produces="text/json; charset=utf-8")
	@ResponseBody
	public Object adSearchJson(@RequestParam Map<String,Object> map,HttpServletRequest request) {
		JsonResult jsonResult = new JsonResult();
		//ModelAndView mav = new ModelAndView();
		List<Map> brandList = new ArrayList();
		List<Map> categoryList = new ArrayList();
		Map req = new HashMap();
		try{
			
			req.put("query", (String)map.get("query"));
			req.put("adUnitSq", map.get("adUnitSq"));
			req.put("ip", request.getRemoteAddr());
			req.put("referer", request.getHeader("referer"));
			admService.addRequest(req);
			//System.err.println(req);
			//mav.addObject("requestSq",req.get("requestSq"));
		}catch(Exception ex){
			
		}
		try{
			//Map query = new HashMap();
			//query.put("kw1Name",map.get("query"));
			List<Map> allList = admService.advertisingList((String)map.get("query"));
			for(Map item:allList){
				if("A".equals(item.get("kind"))){
					brandList.add(item);
				}else{
					categoryList.add(item);
				}
			}
			Map res = new HashMap();
			res.put("requestSq",req.get("requestSq"));
			
			if(brandList.size()==0 && categoryList.size()==0){
				//jsonResult.setData(Collections.EMPTY_LIST);
				res.put("adList", Collections.EMPTY_LIST);
			}else if(brandList.size()!=0){
				//jsonResult.setData(arrangeAd(brandList));
				res.put("adList", arrangeAd(brandList));
			}else if(categoryList.size()!=0){
				//jsonResult.setData(arrangeAd(categoryList));
				res.put("adList", arrangeAd(categoryList));
			}
			jsonResult.setData(res);
			
		}catch(Exception ex){
			ex.printStackTrace();
			jsonResult.setMsg(ex.getMessage());
			jsonResult.setSuccess(false);
		}
		
		return jsonResult;
		
	}
	/*
	 * 검색광고 페이지,,,,,,
	 * 
	 */
	@RequestMapping(value="/adSearch.html.temp",headers="Accept=*/*",method = RequestMethod.GET ,produces="text/html; charset=utf-8")
	public ModelAndView adSearchHtml(@RequestParam Map<String,Object> map,HttpServletRequest request) {
		JsonResult jsonResult = new JsonResult();
		ModelAndView mav = new ModelAndView();
		mav.addObject("test","test");
		mav.setViewName("/ad_search_html");
		return mav;
	}
	/*
	 * 매치광고,,,,,,
	 * 
	 */
	
	//@RequestMapping(value="/adMatch.js",headers="Accept=*/*",method = RequestMethod.GET ,produces="text/javascript; charset=utf-8")
	/*public ModelAndView adMatch(@RequestParam Map<String,Object> map,HttpServletRequest request,HttpServletResponse response) {
		JsonResult jsonResult = new JsonResult();
		ModelAndView mav = new ModelAndView();
		List<Map> brandList = new ArrayList();
		List<Map> categoryList = new ArrayList();
		Map req = new HashMap();
		String adUid = getAdUid(request,response);
		map.put("adUid",adUid);
		
		try{
			//Map query = new HashMap();
			//query.put("kw1Name",map.get("query"));
			List<Map> wordUserList = admService.getAllWordUser(map);
			if(wordUserList.size()>0){
				List<Map> allList = admService.advertisingList((String)((Map)wordUserList.get(0)).get("word"));
				for(Map item:allList){
					if("A".equals(item.get("kind"))){
						brandList.add(item);
					}else{
						categoryList.add(item);
					}
				}
			}	
			ObjectMapper mapper = new ObjectMapper();
			
			if(brandList.size()==0 && categoryList.size()==0){
				mav.addObject("adList", "[]");
			}else if(brandList.size()!=0){
				String temp= mapper.writeValueAsString(arrangeAd(brandList));
				mav.addObject("adList", temp);
			}else if(categoryList.size()!=0){
				String temp= mapper.writeValueAsString(arrangeAd(categoryList));
				mav.addObject("adList", temp);
			}
			
		}catch(Exception ex){
			ex.printStackTrace();
			jsonResult.setMsg(ex.getMessage());
			jsonResult.setSuccess(false);
		}
		mav.addObject("test","test");
		
    	mav.setViewName("/ad_match");
		return mav;
	}*/
	@RequestMapping(value="/adMatch.js",headers="Accept=*/*",method = RequestMethod.GET ,produces="text/javascript; charset=utf-8")
	public ModelAndView adMatch(@RequestParam Map<String,Object> map,HttpServletRequest request,HttpServletResponse response) {
		JsonResult jsonResult = new JsonResult();
		ModelAndView mav = new ModelAndView();
		List<Map> brandList = new ArrayList();
		List<Map> categoryList = new ArrayList();
		Map req = new HashMap();
		String adUid = getAdUid(request,response);
		map.put("adUid",adUid);
		
		try{
			List<Map> wordUserList= analService.createKeyword(adUid, 10);
			//Map query = new HashMap();
			//query.put("kw1Name",map.get("query"));
			//List<Map> wordUserList = admService.getAllWordUser(map);
			if(wordUserList.size()>0){
				List<Map> allList = admService.advertisingList((String)((Map)wordUserList.get(0)).get("word"));
				for(Map item:allList){
					if("A".equals(item.get("kind"))){
						brandList.add(item);
					}else{
						categoryList.add(item);
					}
				}
			}	
			ObjectMapper mapper = new ObjectMapper();
			
			if(brandList.size()==0 && categoryList.size()==0){
				mav.addObject("adList", "[]");
			}else if(brandList.size()!=0){
				String temp= mapper.writeValueAsString(arrangeAd(brandList));
				mav.addObject("adList", temp);
			}else if(categoryList.size()!=0){
				String temp= mapper.writeValueAsString(arrangeAd(categoryList));
				mav.addObject("adList", temp);
			}
			
		}catch(Exception ex){
			ex.printStackTrace();
			jsonResult.setMsg(ex.getMessage());
			jsonResult.setSuccess(false);
		}
		mav.addObject("test","test");
		
    	mav.setViewName("/ad_match");
		return mav;
	}
	@RequestMapping(value="/adMatch.htm",method = RequestMethod.GET )
	public ModelAndView adMatchHtml(@RequestParam Map<String,Object> map,HttpServletRequest request,HttpServletResponse response) {
		JsonResult jsonResult = new JsonResult();
		getAdUid(request, response);
		ModelAndView mav = new ModelAndView();
		
    	mav.setViewName("/ad_match_iframe");
		return mav;
	}
	@RequestMapping(value="/adSearch.htm",method = RequestMethod.GET )
	public ModelAndView adSearchHtml(@RequestParam Map<String,Object> map,HttpServletRequest request,HttpServletResponse response) {
		JsonResult jsonResult = new JsonResult();
		getAdUid(request, response);
		ModelAndView mav = new ModelAndView();
		/*List<Map> brandList = new ArrayList();
		List<Map> categoryList = new ArrayList();
		Map req = new HashMap();
		try{
			
			req.put("query", (String)map.get("query"));
			req.put("adUnitSq", map.get("adUnitSq"));
			req.put("ip", request.getRemoteAddr());
			req.put("referer", request.getHeader("referer"));
			admService.addRequest(req);
			//System.err.println(req);
			mav.addObject("requestSq",req.get("requestSq"));
		}catch(Exception ex){
			
		}
		try{
			//Map query = new HashMap();
			//query.put("kw1Name",map.get("query"));
			List<Map> allList = admService.advertisingList((String)map.get("query"));
			for(Map item:allList){
				if("A".equals(item.get("kind"))){
					brandList.add(item);
				}else{
					categoryList.add(item);
				}
			}
			
			ObjectMapper mapper = new ObjectMapper();
			
			if(brandList.size()==0 && categoryList.size()==0){
				mav.addObject("adList", "[]");
			}else if(brandList.size()!=0){
				String temp= mapper.writeValueAsString(arrangeAd(brandList));
				mav.addObject("adList", temp);
			}else if(categoryList.size()!=0){
				String temp= mapper.writeValueAsString(arrangeAd(categoryList));
				mav.addObject("adList", temp);
			}
			
		}catch(Exception ex){
			ex.printStackTrace();
			jsonResult.setMsg(ex.getMessage());
			jsonResult.setSuccess(false);
		}
		mav.addObject("test","test");
		*/
    	mav.setViewName("/ad_search_iframe");
		return mav;
	}
	static class AdCompare implements Comparator<Map> {
		 
		/**
		 * 오름차순(ASC)
		 */
		@Override
		public int compare(Map arg0, Map arg1) {
			// TODO Auto-generated method stub
			Integer p0= (Integer)arg0.get("point");
			Integer p1= (Integer)arg1.get("point");
			if(p0==p1){
				Date d0= (Date)arg0.get("regDate");
				Date d1= (Date)arg1.get("regDate");
				return d0.compareTo(d1);
				
			 
			}else{
				return p0-p1;
			}
			
		}
 
	}
	static class RankingCompare implements Comparator<Map> {
		 
		/**
		 * 오름차순(ASC)
		 */
		@Override
		public int compare(Map arg0, Map arg1) {
			// TODO Auto-generated method stub
			Integer p0= (Integer)arg0.get("sortOrder");
			Integer p1= (Integer)arg1.get("sortOrder");
			return p0-p1;
			
		}
 
	}
	private List<Map> arrangeAd(List<Map> originList){
		//List rList = new ArrayList();
		
		Map m = new HashMap();
		for(Map map:originList){
			Map nMap = new HashMap();
			nMap.put("kw2Name",map.get("kw2Name"));
			nMap.put("point",map.get("point"));
			nMap.put("regDate",map.get("regDate"));
			//nMap.put("admSq",map.get("admSq"));
			//nMap.put("kw1Sq",map.get("kw1Sq"));
			//nMap.put("kw2Sq",map.get("kw2Sq"));
			nMap.put("adList",new ArrayList());
			
			m.put(map.get("kw2Name"),nMap);
			
		}
		for(Map map:originList){
			((List)((Map)m.get(map.get("kw2Name"))).get("adList")).add(map);
		}
		
		/*Iterator it = m.keySet().iterator();
		
		while(it.hasNext()){
			
		}*/
		List<Map> tList = new ArrayList<Map>(m.values());
		
		Collections.sort(tList, new AdCompare());
		for(Map map:tList){
			List<Map> adList =(List)map.get("adList");
			Collections.sort(adList, new RankingCompare());
			map.put("adList", adList);
		}
		return tList;
		
	}
	@RequestMapping(value="/code_tbl",method = RequestMethod.GET , produces="application/json; charset=utf-8")
	@ResponseBody
	public Object codeTbl(HttpServletRequest request) {
		
		JsonResult jsonResult = new JsonResult();
		
		try{
			//System.out.print(request.getQueryString());
			String g_code[] = request.getParameterValues("g_code");
			Map result = new HashMap();
			
			for(int i=0; i<g_code.length; i++){
				//Map cresult = new HashMap();
				result.put(g_code[i],sysService.getAllCodeTbl(g_code[i]));
				
			}
			jsonResult.setData(result);
		}catch(Exception ex){
			ex.printStackTrace();
			jsonResult.setMsg(ex.getMessage());
			jsonResult.setSuccess(false);
		}
		return jsonResult;
		//return codeTblService.getAll("","");
	}
	
	@RequestMapping(value="/category",method = RequestMethod.GET , produces="application/json; charset=utf-8")
	@ResponseBody
	public Object category(HttpServletRequest request) {
		
		/*List list = new ArrayList();
		TreeNode<EqpCategory> root = eqpCategoryService.getAll(map);
		if(root!=null)
			list.add(root);
		return list;
		*/
		
		
		JsonResult jsonResult = new JsonResult();
		List list = new ArrayList();
		try{
			//System.out.print(request.getQueryString());
			
			List<Map> cg1List = categoryService.getAllCg1(null);
			List<Map> cg2List = categoryService.getAllCg2(null);
			
			for(Map cg1:cg1List){
				
				Map item = new HashMap();
				item.put("text", cg1.get("name"));
				item.put("data", cg1);
				
				List nodes = new ArrayList();
				for(Map cg2:cg2List){
					
					if(cg1.get("cg1Sq").equals(cg2.get("cg1Sq"))){
						Map child = new HashMap();
						child.put("text",cg2.get("name"));
						child.put("data", cg2);
						nodes.add(child);
					}
				}
				if(nodes.size()>0){
					item.put("nodes",nodes);
				}
				list.add(item);
				
				//System.err.println(item);
			}
			//System.err.println(list);
			//list.add(list);
			jsonResult.setData(list);
		}catch(Exception ex){
			ex.printStackTrace();
			jsonResult.setMsg(ex.getMessage());
			jsonResult.setSuccess(false);
		}
		return jsonResult;
		//return codeTblService.getAll("","");
	}
	/////////// cg1//////////////////
	
	//start=0&draw=4&length=1
		@RequestMapping(value="/cg1",method = RequestMethod.GET , produces="application/json; charset=utf-8")
		@ResponseBody
		public Object cg1List( @RequestParam Map<String,Object> map,HttpServletRequest request) {
			
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
				
				Integer total = categoryService.getTotalCg1(map);
				Map res = new HashMap();
				res.put("draw", map.get("draw"));
				res.put("recordsTotal", total);
				res.put("recordsFiltered", total);
				res.put("data", categoryService.getAllCg1(map));
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
		@RequestMapping(value="/cg1/{cg1Sq}",method = RequestMethod.GET , produces="application/json; charset=utf-8")
		@ResponseBody
		public Object admSelect(@PathVariable("cg1Sq") Integer cg1Sq ,HttpServletRequest request) {
			
			JsonResult jsonResult = new JsonResult();
			
			try{
				Map map = new HashMap<String,Object>();
				map.put("cg1Sq", cg1Sq);
				
				map = categoryService.getCg1(map);
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
		
		@RequestMapping(value="/cg1/{cg1Sq}",method = RequestMethod.DELETE, produces="application/json")
		@ResponseBody
		public Object cg1Delete(@PathVariable("cg1Sq") Integer cg1Sq,HttpServletRequest request) {
			//logger.info("goodDelete");
			JsonResult jsonResult = new JsonResult();
			
			try{
				Map map = new HashMap<String,Object>();
				map.put("cg1Sq", cg1Sq);
				
				categoryService.deleteCg1(map);
			}catch(Exception ex){
				jsonResult.setMsg(ex.getMessage());
				jsonResult.setSuccess(false);	
			}
			
			return jsonResult;
		}
		
		@RequestMapping(value="/cg1/{cg1Sq}",method = RequestMethod.PUT , produces="application/json")
		@ResponseBody
		public Object cg1Update(@PathVariable("cg1Sq") Integer cg1Sq, @RequestBody Map  map,HttpServletRequest request) {
			
			
			
				JsonResult jsonResult = new JsonResult();
				//Integer member_code=0;
				try{
					//Member login = (Member)request.getSession().getAttribute("userInfo");
					//map.put("memberSq", login.getMemberSq());
					
					categoryService.updateCg1(map);
			}catch(Exception ex){
				jsonResult.setMsg(ex.getMessage());
				jsonResult.setSuccess(false);	
			}
			
			return jsonResult;
		}
		
		@RequestMapping(value="/cg1",method = RequestMethod.POST , produces="application/json; charset=utf-8")
		@ResponseBody
		public Object cg1Save(@RequestBody Map<String,Object> map,HttpServletRequest request) {
			JsonResult<String> jsonResult = new JsonResult<String>();
			try{
				//Member login = (Member)request.getSession().getAttribute("userInfo");
				//map.put("memberSq", login.getMemberSq());
				categoryService.upCg1(map);
				categoryService.addCg1(map);
				
			}catch(Exception ex){
				ex.printStackTrace();
				jsonResult.setMsg(ex.getMessage());
				jsonResult.setSuccess(false);	
			}
			return jsonResult;
		}
		
/////////// cg2//////////////////
		
	//start=0&draw=4&length=1
		@RequestMapping(value="/cg2",method = RequestMethod.GET , produces="application/json; charset=utf-8")
		@ResponseBody
		public Object cg2List( @RequestParam Map<String,Object> map,HttpServletRequest request) {
			
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
				
				Integer total = categoryService.getTotalCg2(map);
				Map res = new HashMap();
				res.put("draw", map.get("draw"));
				res.put("recordsTotal", total);
				res.put("recordsFiltered", total);
				res.put("data", categoryService.getAllCg2(map));
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
		@RequestMapping(value="/cg2/{cg2Sq}",method = RequestMethod.GET , produces="application/json; charset=utf-8")
		@ResponseBody
		public Object cg2Select(@PathVariable("cg2Sq") Integer cg2Sq ,HttpServletRequest request) {
			
			JsonResult jsonResult = new JsonResult();
			
			try{
				Map map = new HashMap<String,Object>();
				map.put("cg2Sq", cg2Sq);
				
				map = categoryService.getCg2(map);
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
		
		@RequestMapping(value="/cg2/{cg2Sq}",method = RequestMethod.DELETE, produces="application/json")
		@ResponseBody
		public Object cg2Delete(@PathVariable("cg2Sq") Integer cg2Sq,HttpServletRequest request) {
			//logger.info("goodDelete");
			JsonResult jsonResult = new JsonResult();
			
			try{
				Map map = new HashMap<String,Object>();
				map.put("cg2Sq", cg2Sq);
				
				categoryService.deleteCg2(map);
			}catch(Exception ex){
				jsonResult.setMsg(ex.getMessage());
				jsonResult.setSuccess(false);	
			}
			
			return jsonResult;
		}
		
		@RequestMapping(value="/cg2/{cg2Sq}",method = RequestMethod.PUT , produces="application/json")
		@ResponseBody
		public Object cg2Update(@PathVariable("cg2Sq") Integer cg2Sq, @RequestBody Map  map,HttpServletRequest request) {
			
			
			
				JsonResult jsonResult = new JsonResult();
				//Integer member_code=0;
				try{
					//Member login = (Member)request.getSession().getAttribute("userInfo");
					//map.put("memberSq", login.getMemberSq());
					
					categoryService.updateCg2(map);
			}catch(Exception ex){
				jsonResult.setMsg(ex.getMessage());
				jsonResult.setSuccess(false);	
			}
			
			return jsonResult;
		}
		
		@RequestMapping(value="/cg2",method = RequestMethod.POST , produces="application/json; charset=utf-8")
		@ResponseBody
		public Object cg2Save(@RequestBody Map<String,Object> map,HttpServletRequest request) {
			JsonResult<String> jsonResult = new JsonResult<String>();
			try{
				//Member login = (Member)request.getSession().getAttribute("userInfo");
				//map.put("memberSq", login.getMemberSq());
				categoryService.upCg2(map);
				categoryService.addCg2(map);
			}catch(Exception ex){
				ex.printStackTrace();
				jsonResult.setMsg(ex.getMessage());
				jsonResult.setSuccess(false);	
			}
			return jsonResult;
		}
		
		////////////////////////// keyword///////////////////////////////
		
		@RequestMapping(value="/keyword",method = RequestMethod.GET , produces="application/json; charset=utf-8")
		@ResponseBody
		public Object keyword(@RequestParam(value = "cg2Sq", required = true) Integer cg2Sq, @RequestParam Map<String,Object> map) {
			
			
			
			JsonResult jsonResult = new JsonResult();
			List list = new ArrayList();
			try{
				//System.out.print(request.getQueryString());
				
				List<Map> cg1List = keywordService.getAllKw1(map);
				
				
				for(Map kw1:cg1List){
					
					Map item = new HashMap();
					item.put("text", kw1.get("name"));
					item.put("data", kw1);
					
					List nodes = new ArrayList();
					List<Map> cg2List = keywordService.getAllKw2((Integer)kw1.get("kw1Sq"));
					System.out.println(cg2List.size());
					System.err.println(kw1);;
					for(Map kw2:cg2List){
						
						//if(kw1.get("cg1Sq").equals(cg2.get("cg1Sq"))){
							Map child = new HashMap();
							child.put("text",kw2.get("name"));
							child.put("data", kw2);
							nodes.add(child);
						//}
					}
					List countTag = new ArrayList();
					countTag.add(cg2List.size());
					item.put("tags", countTag);
					if(nodes.size()>0){
						item.put("nodes",nodes);
					}
					list.add(item);
					
					//System.err.println(item);
				}
				//System.err.println(list);
				//list.add(list);
				jsonResult.setData(list);
			}catch(Exception ex){
				ex.printStackTrace();
				jsonResult.setMsg(ex.getMessage());
				jsonResult.setSuccess(false);
			}
			return jsonResult;
			//return codeTblService.getAll("","");
		}
		/////////// kw1//////////////////
		
	//start=0&draw=4&length=1
		@RequestMapping(value="/kw1",method = RequestMethod.GET , produces="application/json; charset=utf-8")
		@ResponseBody
		public Object kw1List( @RequestParam Map<String,Object> map,HttpServletRequest request) {
			
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
				
				Integer total = keywordService.getTotalKw1(map);
				Map res = new HashMap();
				res.put("draw", map.get("draw"));
				res.put("recordsTotal", total);
				res.put("recordsFiltered", total);
				res.put("data", keywordService.getAllKw1(map));
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
		@RequestMapping(value="/kw1/{kw1Sq}",method = RequestMethod.GET , produces="application/json; charset=utf-8")
		@ResponseBody
		public Object kw1Select(@PathVariable("kw1Sq") Integer kw1Sq ,HttpServletRequest request) {
			
			JsonResult jsonResult = new JsonResult();
			
			try{
				Map map = new HashMap<String,Object>();
				map.put("kw1Sq", kw1Sq);
				
				map = keywordService.getKw1(map);
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
		
		@RequestMapping(value="/kw1/{kw1Sq}",method = RequestMethod.DELETE, produces="application/json")
		@ResponseBody
		public Object kw1Delete(@PathVariable("kw1Sq") Integer kw1Sq,HttpServletRequest request) {
			//logger.info("goodDelete");
			JsonResult jsonResult = new JsonResult();
			
			try{
				Map map = new HashMap<String,Object>();
				map.put("kw1Sq", kw1Sq);
				
				keywordService.deleteKw1(map);
			}catch(Exception ex){
				jsonResult.setMsg(ex.getMessage());
				jsonResult.setSuccess(false);	
			}
			
			return jsonResult;
		}
		
		@RequestMapping(value="/kw1/{kw1Sq}",method = RequestMethod.PUT , produces="application/json")
		@ResponseBody
		public Object kw1Update(@PathVariable("kw1Sq") Integer kw1Sq, @RequestBody Map  map,HttpServletRequest request) {
			
			
			
				JsonResult jsonResult = new JsonResult();
				//Integer member_code=0;
				try{
					//Member login = (Member)request.getSession().getAttribute("userInfo");
					//map.put("memberSq", login.getMemberSq());
					
					keywordService.updateKw1(map);
			}catch(Exception ex){
				jsonResult.setMsg(ex.getMessage());
				jsonResult.setSuccess(false);	
			}
			
			return jsonResult;
		}
		
		@RequestMapping(value="/kw1",method = RequestMethod.POST , produces="application/json; charset=utf-8")
		@ResponseBody
		public Object kw1Save(@RequestBody Map<String,Object> map,HttpServletRequest request) {
			JsonResult<String> jsonResult = new JsonResult<String>();
			try{
				//Member login = (Member)request.getSession().getAttribute("userInfo");
				//map.put("memberSq", login.getMemberSq());
				keywordService.upKw1(map);
				keywordService.addKw1(map);
				
			}catch(Exception ex){
				ex.printStackTrace();
				jsonResult.setMsg(ex.getMessage());
				jsonResult.setSuccess(false);	
			}
			return jsonResult;
		}
		
/////////// kw2//////////////////
		
	//start=0&draw=4&length=1 
		@RequestMapping(value="/kw2",method = RequestMethod.GET , produces="application/json; charset=utf-8")
		@ResponseBody
		public Object kw2List( @RequestParam Map<String,Object> map,HttpServletRequest request) {
			
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
				
				Integer total = keywordService.getTotalKw2(map);
				Map res = new HashMap();
				res.put("draw", map.get("draw"));
				res.put("recordsTotal", total);
				res.put("recordsFiltered", total);
				res.put("data", keywordService.getAllKw2(map));
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
		@RequestMapping(value="/kw2/{kw2Sq}",method = RequestMethod.GET , produces="application/json; charset=utf-8")
		@ResponseBody
		public Object kw2Select(@PathVariable("kw2Sq") Integer kw2Sq ,HttpServletRequest request) {
			
			JsonResult jsonResult = new JsonResult();
			
			try{
				Map map = new HashMap<String,Object>();
				map.put("kw2Sq", kw2Sq);
				
				map = keywordService.getKw2(map);
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
		
		@RequestMapping(value="/kw2/{kw2Sq}",method = RequestMethod.DELETE, produces="application/json")
		@ResponseBody
		public Object kw2Delete(@PathVariable("kw2Sq") Integer kw2Sq,HttpServletRequest request) {
			//logger.info("goodDelete");
			JsonResult jsonResult = new JsonResult();
			
			try{
				Map map = new HashMap<String,Object>();
				map.put("kw2Sq", kw2Sq);
				
				keywordService.deleteKw2(map);
			}catch(Exception ex){
				jsonResult.setMsg(ex.getMessage());
				jsonResult.setSuccess(false);	
			}
			
			return jsonResult;
		}
		
		@RequestMapping(value="/kw2/{kw2Sq}",method = RequestMethod.PUT , produces="application/json")
		@ResponseBody
		public Object kw2Update(@PathVariable("kw2Sq") Integer kw2Sq, @RequestBody Map  map,HttpServletRequest request) {
			
			
			
				JsonResult jsonResult = new JsonResult();
				//Integer member_code=0;
				try{
					//Member login = (Member)request.getSession().getAttribute("userInfo");
					//map.put("memberSq", login.getMemberSq());
					
					keywordService.updateKw2(map);
			}catch(Exception ex){
				jsonResult.setMsg(ex.getMessage());
				jsonResult.setSuccess(false);	
			}
			
			return jsonResult;
		}
		
		@RequestMapping(value="/kw2",method = RequestMethod.POST , produces="application/json; charset=utf-8")
		@ResponseBody
		public Object kw2Save(@RequestBody Map<String,Object> map,HttpServletRequest request) {
			JsonResult<String> jsonResult = new JsonResult<String>();
			try{
				//Member login = (Member)request.getSession().getAttribute("userInfo");
				//map.put("memberSq", login.getMemberSq());
				keywordService.upKw2(map);
				keywordService.addKw2(map);
			}catch(Exception ex){
				ex.printStackTrace();
				jsonResult.setMsg(ex.getMessage());
				jsonResult.setSuccess(false);	
			}
			return jsonResult;
		}
	
}
