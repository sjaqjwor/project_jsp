<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../WEB-INF/include/header.jsp" %>
<link href="../resource/css/layout.css" rel="stylesheet" media="screen">
</head>
<body>
	<%@include file="/WEB-INF/include/login_top.jsp" %>
	<div id="container-wrap">
		<div id="container" class="container">
			<%@include file="/WEB-INF/include/management_left_bar.jsp" %>
			<%@include file="/WEB-INF/include/blackList.jsp"%>
		</div>
	</div>
	<%@include file="/WEB-INF/include/main_foot.jsp"%>
</body>
</html>