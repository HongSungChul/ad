<%@page import="org.codehaus.jackson.map.ObjectMapper"%>
<%@page import="com.fasterxml.jackson.databind.jsonFormatVisitors.JsonObjectFormatVisitor"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>BRANDBOX</title>

    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="font-awesome/css/font-awesome.css" rel="stylesheet">

    <link href="css/animate.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">

</head>

<body class="gray-bg">

    <div class="middle-box text-center loginscreen  animated fadeInDown">
    <div>
    <!-- 
        <div>
            <h1 class="logo-name">BRANDBOX+</h1>
        </div>
         -->
        <h3 style="color: #e6e6e6;font-size: 100px;margin-left:-100px;">BRANDBOX+</h3>
        <h3>브랜드박스에 오신걸 환영합니다.</h3>
        <p>관리자 권한으로 서비스를 이용하려면
        </p>
        <p>로긴하여 주세요.</p>
        <form class="m-t" role="form" method="post" action="/ad/login/loginProcess">
            <div class="form-group">
                <input type="text" name="userid" class="form-control" placeholder="사용자아이디" required="" autofocus>
            </div>
            <div class="form-group">
                <input type="password" name="passwd" class="form-control" placeholder="패스워드" required="">
            </div>
            <button type="submit" class="btn btn-primary block full-width m-b">로그인</button>

            <a ui-sref="forgot_password"><small>패스워드를 잃어버렸습니까?</small></a>
            <p class="text-muted text-center"><small>계정이 있습니까?</small></p>
            <a class="btn btn-sm btn-white btn-block" href="../advertiser/member.jsp?#/new">광고주계정 만들기</a>
             <a class="btn btn-sm btn-white btn-block" href="../media/member.jsp?#/new">매체계정 만들기</a>
        </form>
        <p class="m-t"> <small>브랜드박스 &copy; 2015</small> </p>
    </div>
</div>

    <!-- Mainly scripts -->
<script src="//code.jquery.com/jquery-2.1.0.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
    

</body>

</html>
