<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="core.*,util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../WEB-INF/include/header.jsp" %>
<link href="../resource/css/layout.css" rel="stylesheet" media="screen">
<link href="../resource/css/login.css" rel="stylesheet" media="screen">
</head>
<%
    request.setCharacterEncoding("UTF-8");
    String loginId = request.getParameter("id");
    String email = request.getParameter("email");
    String birth = request.getParameter("birth");
    String name = request.getParameter("name");
    String errMsg = null, infoMsg = null;

    if (loginId == null) loginId = "아이디를 입력하세요";
    if (email == null) email = "등록된 이메일을 입력하세요";

    if (request.getMethod().equals("POST")) {
        User user = UserDAO.selectById(loginId);
        if (user != null) {
            if (user.getEmail().equals(email)) {
            	if(user.getBirth().equals(birth)){
            		if(user.getName().equals(name)){
		                String passwd = UserService.makeTempPassword();
		                UserDAO.updatePasswd(user.getId(), UserService.encryptPasswd(passwd));
		                String url = UrlUtil.getFullURL(request);
		                SMTP.sendGMail(email, "임시 비밀번호 전송", url + " 임시 비밀번호: " + passwd);
		                infoMsg = "임시 비밀번호를 이메일로 전송하였습니다";
            		}
            		else errMsg = "이름이 일치하지 않습니다.";
            	}
            	else errMsg = "생년월일이 일치하지 않습니다.";
            }
            else errMsg = "이메일이 일치하지 않습니다";
        }
        else errMsg = "로그인 아이디가 잘못되었습니다";
    }
%>

<body>
<%@include file="/WEB-INF/include/login_top.jsp" %>
		<div id="container-wrap">
		<div id="container" class="container">
			<%@include file="/WEB-INF/include/login_left_bar.jsp" %>
			<div id="content">
				<%@include file="../WEB-INF/include/search.jsp"%>
				<% if (errMsg != null) { %>
       				 <div class="alert alert-error"><%= errMsg %></div>
    			<% } %>
    			<% if (infoMsg != null) { %>
        			<div class="alert alert-info"><%= infoMsg %></div>
    			<% } %>
				
			</div>
		</div>
	</div>
	<%@include file="/WEB-INF/include/main_foot.jsp"%>
</body>
</html>