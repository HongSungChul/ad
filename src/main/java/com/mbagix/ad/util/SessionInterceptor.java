package com.mbagix.ad.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.mbagix.ad.model.Member;

/**
 * 섹션 인터셉터
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
public class SessionInterceptor extends HandlerInterceptorAdapter {
 
 @Override
 public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

  System.out.println("Interceptor : PreHandle");
  
  // Session userid check
  HttpSession session = request.getSession();   
  Member userInfo = (Member) session.getAttribute("userInfo");

  // Login false
  if(null==userInfo) {
   System.out.println("Interceptor : Session Check Fail");
   // main page 로 이동
   response.sendRedirect("/ad/login");
   return false;
  } 
  // Login true
  else { 
   System.out.println("Interceptor : Session Check true");
   return super.preHandle(request, response, handler);
  }
 }
}
