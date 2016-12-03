<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "core.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<%
	request.setCharacterEncoding("UTF-8");
	String r = request.getParameter("value");
	User user = UserDAO.selectById(r);
	UserDAO.turn_in(r);
	Equip_rent_DAO.delete(r);
	response.sendRedirect("../view/equip_return_management.jsp?side_value=2&top_value=5");
%>
<body>

</body>
</html>