<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import=" java.util.*,core.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

</head>
<%
	request.setCharacterEncoding("UTF-8");
	String s=request.getParameter("side_value");
	int num=Util.parseInt(s,1);
	
	String[] a = new String[5];
	a[num]="active";
%>
<body>
	<div id="local-navigation">
			<h2 class="blind">관리</h2>
			<h2>관리</h2>
			<div id="nav">
				<ul class="nav">
					<li class="<%=a[1]%>">
						<a href="../view/equip_management.jsp?top_value=5&side_value=1" >기자재 대출 관리</a>
					</li>
					<li class="<%=a[2]%>">
						<a href="../view/equip_return_management.jsp?top_value=5&side_value=2">기자재 반납 관리</a>
					</li>
					<li class="<%=a[3]%>">
						<a href="../view/blackList.jsp?top_value=5&side_value=3">블랙 리스트 관리</a>
					</li>
					<li class="<%=a[4]%>">
						<a href="../view/equip_list.jsp?top_value=5&side_value=4">기자재 관리</a>
					</li>
				</ul>
			</div>
	</div>
</body>
</html>