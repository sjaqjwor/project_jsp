<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="core.*"%>
<%@ page import="util.*"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="../resource/css/login.css" rel="stylesheet" media="screen">
<script>
	$(function a5() { 
	    $("button").click(function() { 
	    	alert("기자재 신청이 완료되었습니다.");
	        location.href = "../view/equip_rent.jsp?value=" + $(this).attr("data-id"); 
	    }); 
	});
</script>
</head>
<%
	request.setCharacterEncoding("UTF-8");
	String a = request.getParameter("value");
	String t = request.getParameter("pg");
	int dept_id5 = (a==null) ? 2: Integer.parseInt(a);
	int currentPage = (t==null) ? 1: Integer.parseInt(t);
	int pageSize = 9;
	int recordCount = EquipDAO.getRecordCount(dept_id5);
	int pageCount = (recordCount + pageSize - 1) / pageSize;
	int basePage = ((currentPage - 1) / 9) *9;
	ArrayList<Equip> equip_list = EquipDAO.selectPage(currentPage, pageSize, dept_id5);
	User user = UserService.getCurrentUser(session);
	Department department = DepartmentDAO.selectById(dept_id5);
%>
<body>
	<div id="content">
		<div class="title">
			<span class="square"></span>
			<h3>기자재 소개</h3>
			<ol class="location">
				<li><a href="../view/main.jsp">Home</a></li>
				<li>></li>
				<li><a href="/">기자재소개</a></li>
			</ol>
		</div>
<style type="text/css">
.caption {
	margin-left: 5px;
}
</style>
		<div class="content-body">
				<h5><%=department.getName() %></h5>
				<p class="pl13">
					<strong>기자재</strong>
				</p>
				<div class="row">
				<%for(Equip equip : equip_list) {%>
						<div class="col-sm-6 col-md-4">
							<div class="thumbnail no-border">
								<img src="../resource/images/<%=equip.getImage() %>"alt="<%=equip.getName()%>" id="image">
								<div class="caption">
									<strong><%=equip.getName() %></strong>
									<p>
										OS:<%=equip.getOs() %><br /> Memory:<%=equip.getMemory() %><br />
										CPU:<%=equip.getCpu() %><br/>
										수량:<%=equip.getCount() %>
									</p>
									<%if(UserService.getCurrentUser(session)==null){%>
										<p>로그인후 이용해주세요</p>
									<%}else if(user.getDepartment_id()!=department.getId()) {%>
										<p>타과 기자재는 신청 불가능 합니다.</p>
									<%}else if(equip.getCount()!=Equip_rent_DAO.countByEquip_id(equip.getId()) && UserService.getCurrentUser(session).getEquip_rent_state()==4) {%>
										<button data-id="<%=equip.getId() %>" type="button" class="btn btn-warning">대여</button>
									<%}else if(equip.getCount()==Equip_rent_DAO.countByEquip_id(equip.getId())) {%>
										<p>수량부족</p>
									<%}%>
									
										
								</div>
							</div>
						</div>
				<%} %>
			</div>
		</div>
	</div>
	
	<div class="pagination pagination-small pagination-centered">
		<ul>
			<%if(basePage>0) {%>
				<li><a href="Equipment.jsp?pg=<%=basePage %>&values=<%=department.getId()%>&value=<%=department.getId()%>">Prev</a></li>
			<%} %>
			<%for(int i=1; i<=10 && basePage +i<=pageCount; ++i) {%>
				<li class="<%=basePage+i==currentPage ?  "active" : ""%>">
					<a href="Equipment.jsp?pg=<%=basePage+i %>&values=<%=department.getId()%>&value=<%=department.getId()%>"><%=basePage+i %></a>
				</li>
			<%} %>
			<%if(basePage+11<=pageCount) {%>
				<li><a href="Equipment.jsp?pg=<%=basePage+11 %>&values=<%=department.getId()%>&value=<%=department.getId()%>">NEXT</a></li>
			<%} %>
		</ul>
	</div>

</body>
</html>