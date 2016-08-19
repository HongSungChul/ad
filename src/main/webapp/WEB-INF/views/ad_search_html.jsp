<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title></title>
</head>
<body>
<!-- 브랜드박스 -->
<script type="text/javascript">
	brandboxAdClient = "${param.adClient}";
	brandboxAdUnit = "${param.adUnitSq}";
	brandboxAdWidth = ${param.adWidth};
	brandboxAdHeight = ${param.adHeight};
	brandboxKeyword="${param.query}";
</script>
<script type="text/javascript" src="http://brandbox.kr/ad/api/ad.js"></script>
<!--// 브랜드박스 -->	
</body>	

</html>
