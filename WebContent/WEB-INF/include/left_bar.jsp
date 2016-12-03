<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import=" java.util.*,core.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<script>
	    $(function() {
	        $("ul>li>a").click(function() {
	            location.href = "../view/Equipment.jsp?top_value=4&value=" + $(this).attr("data-id");
	        });
	    });
	</script>
</head>
<%
	request.setCharacterEncoding("UTF-8");
	ArrayList<Department> list = DepartmentDAO.selectAll();
	String s=request.getParameter("value");
	int dept_id=Util.parseInt(s,2 );
%>
<body>
	<div id="local-navigation">
			<h2 class="blind">기가재 소개</h2>
			<h2>기자재 소개</h2>
			<div id="nav">
				<ul class="nav">
					<%for(Department department : list){ %>
						<%if(department.getId()!=1 && department.getId()!=6 && department.getId()!=7) {%>
							<li class="<%=dept_id == department.getId() ? "active" : " " %>" id="<%=department.getId()%>">
								<a title=<%=department.getName() %> target="_balnk" data-id="<%=department.getId()%>"><%=department.getName() %></a>
							</li>
						<%} %>
					<%} %>
				</ul>
			</div>
	</div>
</body>
</html>