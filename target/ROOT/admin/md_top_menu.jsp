<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String uri = request.getRequestURI();
%>
<div style='float:right'></div>
<ul class="nav nav-tabs">
		  <li role="presentation" <%=uri.indexOf("md_member")>-1?"class='active'":"" %>><a href="md_member.jsp?#/member/<%=request.getParameter("member_code") %>/view">회원정보</a></li>
          <li role="presentation" <%=uri.indexOf("md_ad_unit")>-1?"class='active'":"" %>><a href="md_ad_unit.jsp?member_code=<%=request.getParameter("member_code") %>">광고코드</a></li>
          <li role="presentation" <%=uri.indexOf("md_daily_mc")>-1?"class='active'":"" %>><a href="mmd_daily_mc.jsp?member_code=<%=request.getParameter("member_code") %>">광고매출</a></li>
</ul>

		