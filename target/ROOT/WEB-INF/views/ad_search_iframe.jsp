<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!doctype html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<link rel="stylesheet" type="text/css" href="/ad/api/ad.css"> 
	<script type="text/javascript">
	    brandboxAdClient = "1234";
	    brandboxAdUnit = "${param.adUnitSq}";
	    brandboxAdWidth = ${param.adWidth};
	    brandboxAdHeight = ${param.adHeight};
	    brandboxKeyword="${param.query}";
	</script>
	
</head>


<body>
	<div id="brandbox_area"></div>
	<script src="/ad/api/adSearch.js?query=${param.query}&adUnitSq=${param.adUnitSq}&requestSq=${param.requestSq}"></script>
</body>
</html>
