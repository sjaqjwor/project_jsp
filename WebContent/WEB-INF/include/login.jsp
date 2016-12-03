<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="core.*,util.*,java.util.*,java.sql.*"%>
<%request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<script>
$(function a1() { 
    $("#a7").click(function() { 

        location.href = "../view/member.jsp?value=" + $(this).attr("data-id"); 

    }); 

});
$(function a1() { 
    $("#a8").click(function() { 

        location.href = "../view/professor.jsp?value=" + $(this).attr("data-id"); 

    }); 

});


</script>
<head>
<% String R78 = request.getContextPath(); %>
<%
	String errMsg = null;
	RequestParameter param = new RequestParameter(request);
	String id = param.getString("id", "");
	
	if (request.getMethod().equals("POST")) {
	    User user = UserDAO.selectById(id);
	    if (user != null) {
	        String password = param.getString("password", "");
	        String encryptedPasswd = UserService.encryptPasswd(password);
	        if (user.getPassword().equals(encryptedPasswd)) {
	                UserService.login(session, user);
	                String returnUrl=(String)session.getAttribute("returnUrl");
	                if (returnUrl == null) 
	                    returnUrl = "../view/main.jsp";
	                response.sendRedirect(returnUrl);
	                return ;
	        
	        }
	        else errMsg = "비밀번호가 잘못되었습니다";
	    }
	    else errMsg = "로그인 아이디가 잘못되었습니다";
	}
%>
</head>
<div id="content">
<form method="POST">
<div class="container main">
<%
	if(session.getAttribute("sessionId")==null){
%>
<div id="integMemContent">
	<section id="loginArea">
		<div class="inner">
			<div class="lft_group">
				<h2 class="title2">로그인</h2>
				<p class="point">로그인을 위해 아이디와 패스워드를 입력해 주세요</p>
				<p class="id" style="width: 65%">
					<input type="text" name="id" style="width: 98%; height: 23px;" placeholder="ID">
				</p>
				<p class="pw" style="width: 65%">
						<input type="password" name="password" style="width: 98%; height: 23px;" placeholder="PASSWORD">
				</p>
				<button type="submit" class="btn btn-warning">
					Login
				</button>
				
				<%if (errMsg!=null){ %>
					<div class="alert alert-eroor"><%=errMsg %></div>
				<%} %>
			</div>
			<div class="rgh_group">
				<h2 class="title2">회원가입</h2>
				<p class="txt">회원 가입시 기자재 대여 시스템을 이용 가능합니다.</p>
				<br>
				<button id="a7"type="button" class="btn btn-warning" data-id="2" style="margin-right: 50px;
			 ">
					학생
				</button>
				<button id="a8" type="button" class="btn btn-warning" data-id="2">
					교수/교직원
				</button>
			</div>
		</div>
		</div>
	</section>

	</div>
	<%}else{ %>
	<h1><%=session.getAttribute("sessionId") %>님 로그인 되었습니다.
	</h1>
	<form method="post" action="logout.jsp">
		<button type="submit" class="btn btn-warning">
			<i class="icon-ok icon-white"></i>
		</button>
		로그아웃

	</form>
	<%} %>

	</form>
</div>
</body>
</html>