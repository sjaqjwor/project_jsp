<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import=" java.util.*" %>
<%@ page import="core.*" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>lecture1</title>
<link href="http://netdna.bootstrapcdn.com/bootstrap/2.3.2/css/bootstrap.min.css" rel="stylesheet"> 
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script> 
<script src="http://netdna.bootstrapcdn.com/bootstrap/2.3.2/js/bootstrap.min.js"></script>
<link href="../layout.css" rel="stylesheet" media="screen">
<script type="text/javascript">
function checkFrm() {
	var sid=document.userinput.id.value
	if(sid=="")alert("입려된 아이디 없다")
	else
		window.open("checkid.jsp?id="+sid,"")
}
</script>

</head>
<% 
	String error = null;
	User user=null;
	
	if("GET".equals(request.getMethod())){
		user=UserDAO.makeUser();
	}
	if("POST".equals(request.getMethod())){
		user=UserService.makeUser(request);
		error=UserService.BeforeInsert(user);
		if(error == null){
			UserDAO.insert(user);
			response.sendRedirect("main.jsp");
			return;
		}
	}
	ArrayList<Department> list = DepartmentDAO.selectAll();
	ArrayList<State> list1 = StateDAO.selectAll();
		
%>
<body>
<%@include file="/WEB-INF/include/login_top.jsp" %>
	<div id="container-wrap">
		<div id="container" class="container">
			<%@include file="/WEB-INF/include/login_left_bar.jsp" %>
			<div id="content1">
				<div id="member">회원 가입</div>

				<form method="post" name="userinput">
					<table id="table">
					<tr>
					<td>아이디
		    		<input type="text" name="id" value="<%=user.getId()%>" placeholder="학번을 입력하세요"/>
					<button type="button" onclick="checkFrm()">중복확인</button>
					</td>
					</tr>
					<tr>
		    		<td>비밀번호
		    		<input type="text" name="password" value="<%=user.getPassword()%>"/>
					</td>
					</tr>
					<tr>
					<td>이름
		    		<input type="text" name="name" value="<%=user.getName()%>"/>
		    		</td>
		    		</tr>
		    		<tr>
					<td>생일
		    		<input type="text" name="birth" value="<%=user.getBirth()%>"placeholder="ex)930930"/>
		    		</td>
		    		</tr>
		    		<tr>
		   			<td>전화번호
		    		<input type="text" name="phoneNumber" value="<%=user.getPhoneNumber()%>"placeholder="ex)010-xxxx-xxxx"/>
		    		</td>
		    		</tr>
		    		<tr>
		    		<td>학과
		    		<select name="department_id">
					<% for (Department department : list) { %> 
					<option value="<%= department.getId() %>"> 
					<%= department.getName() %> </option> <% } %> </select>
					</td>
					</tr>
					<tr>
		    		<td>상태
		    		<select name="state_id">
		    		<% for (State state : list1) { %> 
					<option value="<%= state.getId() %>"> 
					<%= state.getName() %> </option> <% } %> </select>
					</td>
					</tr>
		    		</table>
				    <div>
				        <button type="submit">
				         		  회원 가입
				        </button>
				    </div>
				</form>
				<%if(error!=null) { %>
					<div><%=error %></div>
					<%} %>
		</div>
		</div>
		
	</div>
</body>
</html>