<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="core.*" %>
<%@ page import="util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<%
	request.setCharacterEncoding("UTF-8");
	String a=request.getParameter("user_value");
	UserDAO.approve_rent(a);
	Equip_rent equip_rent = UserService.makeEquip_rent();
	User user = UserDAO.selectById(a);
	equip_rent.setEquip_id(user.getEquip_rent_id());
	equip_rent.setUser_id(user.getId());
	Equip_rent_DAO.insert(equip_rent);
	String url = UrlUtil.getFullURL(request);
    SMTP.sendGMail(user.getEmail(), "기자재",url+"기자재 승인이 완료되었습니다.");
	response.sendRedirect("../view/equip_management.jsp?top_value=5");
%>
<body>

</body>
</html>