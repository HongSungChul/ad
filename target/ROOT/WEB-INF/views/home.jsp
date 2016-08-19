<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" contentType="text/html; charset=utf-8"%>
<html>
<head>
	<title>Home</title>
	<link href="/ad/css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="/ad/css/bootstrap-monthpicker.css" />
	<script src="//code.jquery.com/jquery-2.1.0.min.js"></script>
	<script src="/ad/js/bootstrap-monthpicker.js"></script>
	<script>
		$(function() {
			$('input').bootstrapMonthpicker({
		          //from: '2013-05',
		          //to: '2013-11'
		        });
		});
	</script>
</head>
<body>
<h1>
</h1>

<a href='admin'>관리자페이지</a><br><br><br>
<a href='media'>매체관리자페이지</a><br><br><br>
<a href='advertiser'>광고주관리자페이지</a><br><br><br>
<br>
<br>

<a href='media/member.jsp?#/new'>매체가입</a><br><br><br>
<a href='advertiser/member.jsp?#/new'>광고주가입</a><br><br><br>

</body>
</html>
