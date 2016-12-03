<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="core.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
	<div id="header-wrap">
		<div id="header">
			<a href="../view/main.jsp" title="첫 화면으로 이동 합니다.">
				<h1 class="logo-top text-hide inline pull-left"></h1>
			</a>
			<div id="global-navigation" class="pull-left">
				<h3 class="blind">주 메뉴 목록</h3>
				<ul id="global-navigation-list" class="list-inline">
					<li>
						<a href="" title="기자재 대여 교칙">기자재 대여 교칙</a>
					</li>
					<li>
						<a href="" title="기자재 소개">기자재 소개</a>
					</li>
					<li class="active">
						<a href="" title="공지사항">공지사항</a>
					</li>
					<li>
						<a href="../view/Equipment.jsp" title="기자재 대여">기자재 대여</a>
					</li>
					<li>
						<a href="../view/Home_login.jsp" title="login">LOGIN</a>
					</li>
				</ul>
			</div>
			<div class="search pull-right pt10">
				<h3 class="blind">통합검색</h3>
				<a href="#search" onclick="totalSch();">
					<img src="../resource/images/search-icon-top.gif" alt="검색">
				</a>
			</div>
		</div>
	</div>
</body>
</html>