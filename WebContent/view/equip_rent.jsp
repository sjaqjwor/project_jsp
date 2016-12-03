<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="core.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
</head>
<%
	String s2=request.getParameter("value");
	int equip_id2=Integer.parseInt(s2);
	User user = UserService.getCurrentUser(session);
	UserDAO.rent(user.getId(),equip_id2);
	User user1=UserDAO.selectById(user.getId());
	UserService.resotre(session,user1);
	response.sendRedirect("../view/Equipment.jsp?top_value=4");
%>
<body>

</body>
</html>