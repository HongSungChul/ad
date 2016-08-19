<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!doctype html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<link rel="stylesheet" type="text/css" href="/ad/api/ad.css"> 
	<script type="text/javascript">
	    brandboxAdClient = "${param.adClient}";
	    brandboxAdUnit = "${param.adUnitSq}";
	    brandboxAdWidth = ${param.adWidth};
	    brandboxAdHeight = ${param.adHeight};
	</script>
	
</head>
<body>
	<div id="brandbox_area" style="width:${param.adWidth}px; overflow-x:scroll"></div>
	<script src="/ad/api/adMatch.js?adUnitSq=${param.adUnitSq}&requestSq=${param.requestSq}"></script>
</body>
</html>
