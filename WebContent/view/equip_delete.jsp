<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="core.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<%
	request.setCharacterEncoding("UTF-8");
	String number = request.getParameter("value");
	int equip_id = Integer.parseInt(number);
	EquipDAO.delete(equip_id);
	response.sendRedirect("../view/equip_list.jsp?top_value=5&side_value=4");
%>
<body>

</body>
</html>