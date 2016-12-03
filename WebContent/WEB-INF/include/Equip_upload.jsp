<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="core.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Insert title here</title>
<style>
.button{
	margin-left:500px;
}
</style>
</head>

<%
	request.setCharacterEncoding("UTF-8");
	ArrayList<Department> dept = DepartmentDAO.selectAll();
	Equip equip = null;
	String error=null;
	String z=request.getParameter("top_value");
	if("POST".equals(request.getMethod())){
		equip=UserService.makeEquip(request);
		error=UserService.beforeInsert(equip);
		if(error==null){
			EquipDAO.insert(equip);
			response.sendRedirect("../view/equip_list.jsp?side_value=4&top_value=5");
			return;
		}
	}else{
		equip=UserService.makeEquip();
	}
%>
<body>
<div id="content1">
	<div id="user">기자재 등록</div>
	
	<form class="user_form" method="post">
		<div>
        	<table>
				<tr>
					<td class="user_table">
					<label id="user_label" for="id">기자재명</label>
					</td>
					<td class="user_table">
					<input type="text" name="name"  value="<%=equip.getName() %>" placeholder="기자재명" /><br /> <%if(error!=null && "기자재명을 입력하세요".equals(error)) { %><span style="color:red;"><%=error %> <%} %></span>
					</td>
				</tr>
				<tr>
					<td class="user_table">
					<label id="user_label" for="id">메모리</label>
					</td>
					<td class="user_table">
					<input type="text" name="memory" value="<%=equip.getMemory() %>" placeholder="메모리" /><br /> <%if(error!=null && "메모리를 입력하세요".equals(error)) { %><span style="color:red;"><%=error %> <%} %></span>
					</td>
				</tr>
				<tr>
					<td class="user_table">
					<label id="user_label" for="id">CPU</label>
					</td>
					<td class="user_table">
					<input type="text" name="cpu" value="<%=equip.getCpu() %>" placeholder="CPU" /><br /> <%if(error!=null && "cpu를 입력하세요".equals(error)) { %><span style="color:red;"><%=error %> <%} %></span>
					</td>
				</tr>
				<tr>
					<td class="user_table">
					<label id="user_label" for="id">OS</label>
					</td>
					<td class="user_table">
					<input type="text" name="OS"  value="<%=equip.getOs() %>" placeholder="OS" /><br /> <%if(error!=null && "os를 입력하세요".equals(error)) { %><span style="color:red;"><%=error %> <%} %></span>
					</td>
				</tr>
				<tr>
					<td class="user_table">
					<label id="user_label" for="id">수량</label>
					</td>
					<td class="user_table">
					<input type="text" name="count" value="<%=equip.getCount() %>" placeholder="수량" /><br /><%if(error!=null && "수량을 입력하세요".equals(error)) { %><span style="color:red;"><%=error %> <%} %></span>
					</td>
				</tr>
				<tr>
				<td class="user_table">
					<label id="user_label" for="id">학과</label>
					</td>
				<td>
				 <select name="department_id">
					<%for(Department department : dept) {%>
					<%if(department.getId()!=0 && department.getId()!=1 && department.getId()!=6 && department.getId()!=7  ) {%>
					<option value="<%=department.getId() %>"><%=department.getName() %></option>
					<%} %>
					<%} %>
				</select><br /> 
				</td>
				</tr>
				<tr>
				</tr>
				<tr>
					<td>
						
					</td>
				</tr>
		</table>
		</div>
		<div class="button">
			<button type="submit" name="cmd" class="btn btn-warning">등록</button>
		</div>
		<%if(error!=null) {%>
			<span style="color:red;"><%=error %></span>
		<%} %>
	</form>
	
</body>
</html>