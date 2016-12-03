<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../WEB-INF/include/header.jsp" %>
<link href="../resource/css/layout.css" rel="stylesheet" media="screen">
<link href="../resource/css/layout.css" rel="stylesheet" media="screen">
<link href="../resource/css/login.css" rel="stylesheet" media="screen">
<title>SKHU</title>
</head>
<body>
	<%@include file="/WEB-INF/include/login_top.jsp" %>
	<div id="container-wrap">
		<div id="container" class="container">
			<%@include file="/WEB-INF/include/management_left_bar.jsp" %>
			<%@include file="/WEB-INF/include/equip_list.jsp"%>
		</div>
	</div>
	
</body>
</html>