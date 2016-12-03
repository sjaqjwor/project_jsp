<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "core.*" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style>
#search select{
	width:80px !important;
}
#search input{
	width:150px !important;
}
#search button{
	width:70px !important;
	height:30px;
	margin-bottom:10px;

}

</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="../resource/css/layout.css" rel="stylesheet" media="screen">
<link href="../resource/css/login.css" rel="stylesheet" media="screen">
</head>
<%
	request.setCharacterEncoding("UTF-8");
	String w= request.getParameter("black_select");
	String q= request.getParameter("black_type");
	ArrayList<User> user_list=null;
	String m=request.getParameter("side_value");
	String z=request.getParameter("top_value");
	int top_id=Util.parseInt(z,5);
	int management_id=Util.parseInt(m,1);
	String p= request.getParameter("pg");
	int currentPage=(p==null) ? 1: Integer.parseInt(p);
	int pageSize=9;
	int recordCount = 0;
	int pageCount=0;
	int basePage = 0;
	
	if(q==null){
		recordCount = UserDAO.getRecordCount();
		pageCount = (recordCount + pageSize -1) / pageSize;
		basePage = ((currentPage -1 ) / 9 ) *9;
		user_list = UserDAO.selectPage(currentPage,pageSize);
	}
	if("POST".equals(request.getMethod())){
		w = request.getParameter("black_select");
		q = request.getParameter("black_type");
		currentPage=1;
		if("id".equals(q)){
			recordCount = UserDAO.getRecordCountById(w);
			pageCount = (recordCount + pageSize -1) / pageSize;
			basePage = ((currentPage-1) / 9) *9;
			user_list = UserDAO.selectUserAll(currentPage,pageSize,w);
		}else if("name".equals(q)){
			recordCount = UserDAO.getRecordCountByName(w);
			pageCount = (recordCount + pageSize -1) / pageSize;
			basePage = ((currentPage -1 ) / 9) *9;
			user_list = UserDAO.selectUserName(currentPage,pageSize,w);
		}else{
			recordCount = UserDAO.getRecordCountByDepartment(w);
			pageCount = (recordCount + pageSize -1) / pageSize;
			basePage = ((currentPage - 1 ) / 9 ) * 9;
			user_list = UserDAO.selectUserDepartment(currentPage,pageSize,w);
		}
	}else if(q!=null){
		q=request.getParameter("black_type");
		w=request.getParameter("black_select");
		currentPage=1;
		if("id".equals(q)){
			recordCount = UserDAO.getRecordCountById(w);
			pageCount = (recordCount + pageSize -1) / pageSize;
			basePage = ((currentPage-1) / 9) *9;
			user_list = UserDAO.selectUserAll(currentPage,pageSize,w);
		}else if("name".equals(q)){
			recordCount = UserDAO.getRecordCountByName(w);
			pageCount = (recordCount + pageSize -1) / pageSize;
			basePage = ((currentPage -1 ) / 9) *9;
			user_list = UserDAO.selectUserName(currentPage,pageSize,w);
		}else{
			recordCount = UserDAO.getRecordCountByDepartment(w);
			pageCount = (recordCount + pageSize -1) / pageSize;
			basePage = ((currentPage - 1 ) / 9 ) * 9;
			user_list = UserDAO.selectUserDepartment(currentPage,pageSize,w);
		}
	}
	
%>
<script>
	$(function() { 
	    $("[name=black_approve]").click(function() { 
	        location.href ="../view/blackList_approve.jsp?value=" + $(this).attr("data-id"); 
	    }); 
	});
	$(function() { 
	    $("[name=black_refuse]").click(function() { 
	        location.href ="../view/blackList_cancel.jsp?value=" + $(this).attr("data-id"); 
	    }); 
	});
</script>
<body>
	<div id="content">
	<div class="title">
		<span class="square"></span>
			<h3>블랙리스트</h3>
			<ol class="location">
				<li><a href="../view/main.jsp">Home</a></li>
				<li>></li>
				<li><a href="/">블랙리스트 관리</a></li>
			</ol>
			
	</div>
		<style type="text/css">
			.caption {
				margin-left: 5px;
			}
		</style>
		<div class="content-body">
		<h5>블랙리스트</h5>
		<p class="p113">
			<strong>블랙리스트 관리</strong>
		</p>

			<div class="row">
				<%for(User user : user_list) {%>
					<div class="col-sm-6 col-md-4">
						<div class="thumbnail no-border">
							<div class="cation">
								<p>
									이름:<%=user.getName() %><br/>
									학번:<%=user.getId() %><br/>
									구분:<%=DepartmentDAO.selectById(user.getDepartment_id()).getName() %><br/>
							
									블랙리스트 여부:<%=user.getEquip_rent_state()==3 ? "O" :"X" %>
								</p>
								<button data-id="<%=user.getId()%>" type="button" class="btn btn-warning" name="black_approve">추가</button>
								<button data-id="<%=user.getId()%>" type="button" class="btn btn-warning" name="black_refuse">해제</button>
							</div>
						</div>
						
					</div>
				<%} %>
			</div>
		</div>
	</div>
	<div class="pagination pagination-small pagination-centered">
	<%if(q==null){ %>
		<ul>
			<%if(basePage>0) {%>
				<li><a href="blackList.jsp?pg=<%=basePage %>&side_value=<%=management_id%>&top_value=<%=top_id%>">Prev</a></li>
			<%} %>
			<%for(int i=1; i<=10 && basePage +i<=pageCount; ++i) {%>
				<li class="<%=basePage+i==currentPage ?  "active" : ""%>">
					<a href="blackList.jsp?pg=<%=basePage+i %>&side_value=<%=management_id%>&top_value=<%=top_id%>"><%=basePage+i %></a>
				</li>
			<%} %>
			<%if(basePage+11<=pageCount) {%>
				<li><a href="blackList.jsp?pg=<%=basePage+11 %>&side_value=<%=management_id%>&top_value=<%=top_id%>">NEXT</a></li>
			<%} %>
		</ul>
	<%} %>
	<%if(q!=null) {%>
		<ul>
			<%if(basePage>0) {%>
				<li><a href="blackList.jsp?pg=<%=basePage %>&side_value=<%=management_id%>&black_type=<%=q%>&black_select=<%=w%>&top_value=<%=top_id%>">Prev</a></li>
			<%} %>
			<%for(int i=1; i<=10 && basePage +i<=pageCount; ++i) {%>
				<li class="<%=basePage+i==currentPage ?  "active" : ""%>">
					<a href="blackList.jsp?pg=<%=basePage+i %>&side_value=<%=management_id%>&black_type=<%=q%>&black_select=<%=w%>&top_value=<%=top_id%>"><%=basePage+i %></a>
				</li>
			<%} %>
			<%if(basePage+11<=pageCount) {%>
				<li><a href="blackList.jsp?pg=<%=basePage+11 %>&side_value=<%=management_id%>&black_type=<%=q%>&black_select=<%=w%>&top_value=<%=top_id%>">NEXT</a></li>
			<%} %>
		</ul>
	<%} %>
		<form name="black_search" method="post" style="padding-left:270px">
			<table id="search">
			<tr>
				<td><select name="black_type">
					<option value="0">선택</option>
					<option value="id">아이디</option>
					<option value="name">이름</option>
					<option value="department">학과</option>
				</select></td>
				<td><input type="text" name="black_select"></td>
				<td><button type="submit" class="btn btn-warning">검색</button></td>
		</tr>
		</table>
		</form>
		
	</div>

	
</body>
</html>