package com.mbagix.ad.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.ModelAndView;


import com.mbagix.ad.model.Member;
import com.mbagix.ad.service.MemberService;
/**
 * 인증 컨트롤러  
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

@RequestMapping("/login")
@Controller(value = "loginController")
@SessionAttributes("userInfo")
public class LoginController {
    @Autowired
    private MemberService memberService;
    // 세션사용 화면
    @RequestMapping("page1")
    public String page1() {
        return "page1";
    }
    // 세션 사용 안하는 화면
    @RequestMapping("page2")
    public String page2() {
        return "page2";
    }
    // 로그인 화면
    @RequestMapping("login")
    public String login(@ModelAttribute Member member) {
        return "login";
    }
    // 로그아웃
    @RequestMapping("logout")
    public String logout(WebRequest request,SessionStatus status) {
        //session.setAttribute("userInfo", null);
        //request.getSession().removeAttribute("userInfo");
    	status.setComplete();
        request.removeAttribute("user", WebRequest.SCOPE_SESSION);
        return "redirect:/";
    }
    // 로그인 처리
    @RequestMapping(value="loginProcess", method = RequestMethod.POST)
    public ModelAndView loginProcess(@RequestParam(value="userid", required=true) String userid,
    		@RequestParam(value="passwd", required=true) String passwd,
    		 HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        
        	
       // System.out.println(member);
        Member loginUser = memberService.findByUserid(userid);
 
        if(loginUser != null && loginUser.getPasswd().equals(passwd)){
        	request.getSession().setAttribute("userInfo", loginUser);
        	mav.addObject("userInfo",loginUser);
        	if(loginUser.getKind().equals("A")){
        		mav.setViewName("redirect:/advertiser/index.jsp");
        	}else if(loginUser.getKind().equals("B")){
        		mav.setViewName("redirect:/media/index.jsp");
        	}else if(loginUser.getKind().equals("C")){ // 슈펴유저
        		mav.setViewName("redirect:/admin/index.jsp");
        	}
        	//return mav;
        }else{
        	System.err.println(request.getHeader("referer"));
        	mav.addObject("message", "login error");
        	mav.setViewName("redirect:/admin/login.jsp");
        	
        }
        return mav;
    }
}
