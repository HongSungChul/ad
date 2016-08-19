<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String uri = request.getRequestURI();
%>
<div style='float:right'></div>
<ul class="nav nav-tabs">
	<li role="presentation" <%=uri.indexOf("at_member")>-1?"class='active'":"" %>><a href="at_member.jsp?memberSq=<%=request.getParameter("memberSq") %>#/<%=request.getParameter("memberSq") %>/view">회원정보</a></li>
	<li role="presentation" <%=uri.indexOf("at_point_log")>-1?"class='active'":"" %>><a href="at_point_log.jsp?memberSq=<%=request.getParameter("memberSq") %>#/<%=request.getParameter("memberSq") %>">포인트내역</a></li>
	<li role="presentation" <%=uri.indexOf("at_fill_log")>-1?"class='active'":"" %>><a href="at_fill_log.jsp?memberSq=<%=request.getParameter("memberSq") %>">충전내역</a></li>
	<li role="presentation" <%=uri.indexOf("at_adm")>-1?"class='active'":"" %>><a href="at_adm.jsp?memberSq=<%=request.getParameter("memberSq") %>">광고물</a></li>
	<li role="presentation" <%=uri.indexOf("at_bidding")>-1?"class='active'":"" %>><a href="at_bidding.jsp?memberSq=<%=request.getParameter("memberSq") %>#/a">입찰정보</a></li>
	<li role="presentation" <%=uri.indexOf("at_advertising")>-1?"class='active'":"" %>><a href="at_advertising.jsp?memberSq=<%=request.getParameter("memberSq") %>#/a">집행정보</a></li>
	<li role="presentation" <%=uri.indexOf("at_daily_ac")>-1?"class='active'":"" %>><a href="at_daily_ac.jsp?memberSq=<%=request.getParameter("memberSq") %>#/a">광고현황</a></li>
</ul>
		