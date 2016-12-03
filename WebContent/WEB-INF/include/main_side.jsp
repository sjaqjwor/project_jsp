<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="core.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<%
	User user = null;
	user = UserService.getCurrentUser(session);
%>
<script>
	$(function(){
		$("[name=Equipment_introduce]").click(function(){
			location.href = "../view/equip_rule.jsp?top_value=" +$(this).attr("data-id");
		});
		$("[name=notice]").click(function(){
			location.href="../view/board.jsp?top_value=" +$(this).attr("data-id");
		});
		$("[name=Equip_rent]").click(function(){
			location.href="../view/Equipment.jsp?top_value=" +$(this).attr("data-id");
		});
		$("[name=equip_management]").click(function(){
			location.href="../view/equip_management.jsp?top_value=" +$(this).attr("data-id");
		});
	});
</script>
<body>


	<ul id="nav">
		<li>
			<a name="Equipment_introduce" data-id="1">기자재대여교칙</a>
		</li>
		<li>
			<a name="notice" data-id="3">공지사항</a>
		</li>
		<li>
			<a name="Equip_rent" data-id="4">기자재 대여</a>
		</li>
		<%if(UserService.isCurrentUserLoggedIn(session)==true && (UserService.getCurrentUser(session)).getState_id()==4) {%>
		<li>
			<a name="equip_management" data-id="5">기자재 관리</a>
		</li>
		<%} %>
	</ul>
</body>
</html>