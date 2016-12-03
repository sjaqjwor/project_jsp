<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.util.*" %>
<%@ page import ="core.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
.button{
	margin-left:800px;
	margin-right:0px;
}
</style>
</head>
<%
	request.setCharacterEncoding("UTF-8");
	String w =request.getParameter("select");
	String m=request.getParameter("side_value");
	String q=request.getParameter("search_type");
	String z=request.getParameter("top_value");
	int top_id=Util.parseInt(z,5);
	int management_id=Util.parseInt(m,1);
	String p= request.getParameter("pg");
	int currentPage=(p==null) ? 1: Integer.parseInt(p);
	int pageSize=9;
	int recordCount = EquipDAO.getRecordCount();
	int pageCount= (recordCount + pageSize -1) /pageSize;;
	int basePage = ((currentPage - 1) / 9) *9;;
	ArrayList<Equip> equip_list=EquipDAO.selectAll(currentPage, pageSize);
	
	if(q==null){
		recordCount = EquipDAO.getRecordCount();
		pageCount = (recordCount + pageSize -1) / pageSize;
		basePage = ((currentPage -1 ) / 9) *9;
		equip_list = EquipDAO.selectAll(currentPage,pageSize);
	}
	
	if("POST".equals(request.getMethod())){
		q=request.getParameter("search_type");
		w=request.getParameter("select");
		currentPage=1;
		if("name".equals(q)){
			recordCount = EquipDAO.getRecordCountByName(w);
			pageCount = (recordCount + pageSize -1) / pageSize;
			basePage = ((currentPage -1) / 9 ) *9;
			equip_list = EquipDAO.equipSelectName(currentPage,pageSize,w);
		}else{
			recordCount = EquipDAO.getRecordCountByDepartment(w);
			pageCount = (recordCount + pageSize -1) / pageSize;
			basePage = ((currentPage -1 ) /9) *9;
			equip_list = EquipDAO.equipSelectDepartment(currentPage,pageSize,w);
		}
	}else if(q!=null){
		q=request.getParameter("search_type");
		w=request.getParameter("select");
		if("name".equals(q)){
			recordCount = EquipDAO.getRecordCountByName(w);
			pageCount = (recordCount + pageSize -1) / pageSize;
			basePage = ((currentPage -1) / 9 ) *9;
			equip_list = EquipDAO.equipSelectName(currentPage,pageSize,w);
		}else{
			recordCount = EquipDAO.getRecordCountByDepartment(w);
			pageCount = (recordCount + pageSize -1) / pageSize;
			basePage = ((currentPage -1 ) /9) *9;
			equip_list = EquipDAO.equipSelectDepartment(currentPage,pageSize,w);
		}
	}
%>
<script>
	$(function() { 
	    $("[name=update]").click(function() { 
	        location.href ="../view/equip_update.jsp?top_value=5&side_value=4&value=" + $(this).attr("data-id"); 
	    });
	    $("[name=delete]").click(function() { 
	        location.href ="../view/equip_delete.jsp?side_value=4&top_valut=5&value=" + $(this).attr("data-id"); 
	    }); 
	    $("[name=insert]").click(function() { 
	        location.href ="../view/equip_upload.jsp?top_value=5&side_value=" + $(this).attr("data-id"); 
	    });
	});
</script>
<body>
<div id="content">
	<div class="title">
		<span class="square"></span>
			<h3>기자재 관리</h3>
			<ol class="location">
				<li><a href="../view/main.jsp">Home</a></li>
				<li>></li>
				<li><a href="/">기자재 관리</a></li>
			</ol>
	</div>
		<style type="text/css">
			.caption {
				margin-left: 5px;
			}
		</style>
		<div class="content-body">
		<h5>기자재 관리</h5>
		<p class="p113">
			<strong>기자재 관리</strong>
		</p>
			<div class="row">
				<%for(Equip equip : equip_list) {%>
					<div class="col-sm-6 col-md-4">
						<div class="thumbnail no-border">
							<div class="cation">
								<p>
									기자재명:<%=equip.getName() %><br/>
									구분:<%=DepartmentDAO.selectById(equip.getDepartment_id()).getName() %><br/>
									수량:<%=equip.getCount()%><br/>
									memory:<%=equip.getMemory() %><br/>
									OS:<%=equip.getOs() %><br/>
									CPU:<%=equip.getCpu() %>
								</p>
								<button data-id="<%=equip.getId()%>" type="button" class="btn btn-warning" name="update">수정</button>
								<button data-id="<%=equip.getId() %>" type="button" class="bin btn-warning" name="delete">삭제</button>
							</div>
						</div>
					</div>
				<%} %>
			</div>
		</div>
		<div class="button">
			<button type="button" class="btn btn-warning" name="insert" data-id="4">기자재 추가</button>
		</div>
	<div class="pagination pagination-small pagination-centered">
	<%if(q==null) {%>
			<ul>
				<%if(basePage>0) {%>
					<li><a href="equip_list.jsp?pg=<%=basePage %>&side_value=<%=management_id%>&top_value=<%=top_id%>">Prev</a></li>
				<%} %>
				<%for(int i=1; i<=10 && basePage+i<=pageCount; ++i) {%>
					<li class="<%=basePage+i==currentPage ?  "active" : ""%>">
						<a href="equip_list.jsp?pg=<%=basePage+i %>&side_value=<%=management_id%>&top_value=<%=top_id%>"><%=basePage+i %></a>
					</li>
				<%} %>
				<%if(basePage+11<=pageCount) {%>
					<li><a href="equip_list.jsp?pg=<%=basePage+11 %>&side_value=<%=management_id%>&top_value=<%=top_id%>">NEXT</a></li>
				<%} %>
			</ul>
	<%} %>
	<%if(q!=null) {%>
		<ul>
				<%if(basePage>0) {%>
					<li><a href="equip_list.jsp?pg=<%=basePage %>&side_value=<%=management_id%>&search_type=<%=q%>&select=<%=w%>&top_value=<%=top_id%>">Prev</a></li>
				<%} %>
				<%for(int i=1; i<=10 && basePage+i<=pageCount; ++i) {%>
					<li class="<%=basePage+i==currentPage ?  "active" : ""%>">
						<a href="equip_list.jsp?pg=<%=basePage+i %>&side_value=<%=management_id%>&search_type=<%=q%>&select=<%=w%>&top_value=<%=top_id%>"><%=basePage+i %></a>
					</li>
				<%} %>
				<%if(basePage+11<=pageCount) {%>
					<li><a href="equip_list.jsp?pg=<%=basePage+11 %>&side_value=<%=management_id%>&search_type=<%=q%>&select=<%=w%>&top_value=<%=top_id%>">NEXT</a></li>
				<%} %>
			</ul>
	<%} %>
	</div>
		<form name="search" method="post" style="padding-left:140px">
		<table id="search">
			<tr>
			<td><select name="search_type">
				<option value="0">선택</option>
				<option value="name">이름</option>
				<option value="Department">학과</option>
			</select></td>
			<td><input type="text" name="select" value=""></td>
			<td><button type="submit" class="btn btn-warning">검색</button></td>
			</tr>
			</table>
		</form>
	</div>
</body>
</html>