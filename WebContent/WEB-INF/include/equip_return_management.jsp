<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "core.*" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<%
	request.setCharacterEncoding("UTF-8");
	String w=request.getParameter("select");
	String q=request.getParameter("equip_type");
	ArrayList<User> user_list=null;
	String m=request.getParameter("side_value");
	String z=request.getParameter("top_value");
	int top_id=Util.parseInt(z,5);
	int management_id=Util.parseInt(m,1);
	String p= request.getParameter("pg");
	int currentPage=(p==null) ? 1: Integer.parseInt(p);
	int pageSize=9;
	int recordCount =0;
	int pageCount=0;
	int basePage = 0;
	
	if(q==null){
		recordCount = UserDAO.getRecordCount();
		pageCount = (recordCount + pageSize -1) / pageSize;
		basePage = ((currentPage -1 ) / 9) *9;
		user_list = UserDAO.selectPage(currentPage,pageSize,1);
	}
	if("POST".equals(request.getMethod())){
		w=request.getParameter("select");
		q=request.getParameter("equip_type");
		currentPage=1;
		if("id".equals(q)){
			recordCount=UserDAO.getReocrdCountByEquip_state_id(1,w);
			pageCount = (recordCount + pageSize -1) / pageSize;
			basePage = ((currentPage -1 ) / 9) * 9;
			user_list = UserDAO.selectpage_id(currentPage,pageSize,w,1);
		}else if("name".equals(q)){
			recordCount = UserDAO.getRecordCountByEquip_state_name(1,w);
			pageCount = (recordCount + pageSize -1) / pageSize;
			basePage = ((currentPage -1 ) / 9 ) *9;
			user_list = UserDAO.selectpage_name(currentPage,pageSize,w,1);
		}else{
			recordCount = UserDAO.getRecordCountByEquip_state_department(1,w);
			pageCount = (recordCount + pageSize -1 ) / pageSize;
			basePage = ((currentPage -1 ) /9 ) * 9;
			user_list = UserDAO.selectpage_department(currentPage,pageSize,w,1);
		}
	}else if(q!=null){
		w=request.getParameter("select");
		q=request.getParameter("equip_type");
		if("id".equals(q)){
			recordCount=UserDAO.getReocrdCountByEquip_state_id(1,w);
			pageCount = (recordCount + pageSize -1) / pageSize;
			basePage = ((currentPage -1 ) / 9) * 9;
			user_list = UserDAO.selectpage_id(currentPage,pageSize,w,1);
		}else if("name".equals(q)){
			recordCount = UserDAO.getRecordCountByEquip_state_name(1,w);
			pageCount = (recordCount + pageSize -1) / pageSize;
			basePage = ((currentPage -1 ) / 9 ) *9;
			user_list = UserDAO.selectpage_name(currentPage,pageSize,w,1);
		}else{
			recordCount = UserDAO.getRecordCountByEquip_state_department(1,w);
			pageCount = (recordCount + pageSize -1 ) / pageSize;
			basePage = ((currentPage -1 ) /9 ) * 9;
			user_list = UserDAO.selectpage_department(currentPage,pageSize,w,1);
		}
	}
%>
<script>
	$(function() { 
	    $("[name=refuse]").click(function() { 
	        location.href ="../view/equip_return.jsp?value=" + $(this).attr("data-id"); 
	    }); 
	});
</script>
<body>
<div id="content">
	<div class="title">
		<span class="square"></span>
			<h3>기자재 반납 관리</h3>
			<ol class="location">
				<li><a href="../view/main.jsp">Home</a></li>
				<li>></li>
				<li><a href="/">기자재 반납 관리</a></li>
			</ol>
	</div>
		<style type="text/css">
			.caption {
				margin-left: 5px;
			}
		</style>
		<div class="content-body">
		<h5>기자재 반납 관리</h5>
		<p class="p113">
			<strong>기자재 관리</strong>
		</p>
			<div class="row">
				<%for(User user : user_list) {%>
					<div class="col-sm-6 col-md-4">
						<div class="thumbnail no-border">
							<div class="cation">
								<p>
									이름:<%=user.getName() %><br/>
									학번:<%=user.getId() %><br/>
									학과:<%=DepartmentDAO.selectById(user.getDepartment_id()).getName() %><br/>
									대여 기자재명:<%=EquipDAO.selectById(user.getEquip_rent_id()).getName()%><br/>
									기자재 반납 날짜:<%=Equip_rent_DAO.selectByUser_id(user.getId()).getEquip_return_day() %><br/>
								</p>
								<button data-id="<%=user.getId()%>" type="button" class="btn btn-warning" name="refuse">반납확인</button>
							</div>
						</div>
					</div>
				<%} %>
			</div>
		</div>
	</div>
	<div class="pagination pagination-small pagination-centered">
	<%if(q==null) {%>
		<ul>
			<%if(basePage>0) {%>
				<li><a href="equip_return_management.jsp?pg=<%=basePage %>&side_value=<%=management_id%>&top_value=<%=top_id%>">Prev</a></li>
			<%} %>
			<%for(int i=1; i<=10 && basePage +i<=pageCount; ++i) {%>
				<li class="<%=basePage+i==currentPage ?  "active" : ""%>">
					<a href="equip_return_management.jsp?pg=<%=basePage+i %>&side_value=<%=management_id%>&top_value=<%=top_id%>"><%=basePage+i %></a>
				</li>
			<%} %>
			<%if(basePage+11<=pageCount) {%>
				<li><a href="equip_return_management.jsp?pg=<%=basePage+11 %>&side_value=<%=management_id%>&top_value=<%=top_id%>">NEXT</a></li>
			<%} %>
		</ul>
		<%} %>
		<%if(q!=null) {%>
		<ul>
			<%if(basePage>0) {%>
				<li><a href="equip_return_management.jsp?pg=<%=basePage %>&side_value=<%=management_id%>&equip_type=<%=q%>&select=<%=w%>&top_value=<%=top_id%>">Prev</a></li>
			<%} %>
			<%for(int i=1; i<=10 && basePage +i<=pageCount; ++i) {%>
				<li class="<%=basePage+i==currentPage ?  "active" : ""%>">
					<a href="equip_return_management.jsp?pg=<%=basePage+i %>&side_value=<%=management_id%>&equip_type=<%=q%>&select=<%=w%>&top_value=<%=top_id%>"><%=basePage+i %></a>
				</li>
			<%} %>
			<%if(basePage+11<=pageCount) {%>
				<li><a href="equip_return_management.jsp?pg=<%=basePage+11 %>&side_value=<%=management_id%>&equip_type=<%=q%>&select=<%=w%>&top_value=<%=top_id%>">NEXT</a></li>
			<%} %>
		</ul>
		<%} %>
		<form name="search" method="post" style="padding-left:340px;">
		<table id="search">
			<tr>
				
			
			<td><select name="equip_type">
				<option value="0">선택</option>
				<option value="id">아이디</option>
				<option value="name">이름</option>
				<option value="department">학과</option>
			</select></td>
			<td><input type="text" name="select"></td>
			<td><button type="submit" class="btn btn-warning">검색</button></td>
			</tr>
			</table>
		</form>
	</div>
</body>
</html>