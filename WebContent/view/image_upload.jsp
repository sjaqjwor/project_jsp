<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="core.*"%>
<%@ page
	import="com.oreilly.servlet.MultipartRequest,com.oreilly.servlet.multipart.DefaultFileRenamePolicy,java.util.*,java.io.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../WEB-INF/include/header.jsp" %>
<link href="../resource/css/layout.css" rel="stylesheet" media="screen">
<link href="../resource/css/login.css" rel="stylesheet" media="screen">
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
	String s1=request.getParameter("value");
	int id = Integer.parseInt(s1);
	Equip equip = EquipDAO.selectById(id);
	String z=request.getParameter("top_value");
	
	if("POST".equals(request.getMethod())){
		MultipartRequest multi=null;
		String realFolder = "";
		String filename = "";
		int maxSize = 1024*1024*5;
		String encType="UTF-8";
		String savefile = "img";
		ServletContext scontext = getServletContext();
		realFolder = "C://Users//승기//Documents//카카오톡 받은 파일//workspace (1)//Equipment//WebContent//resource//images";
		
		try{
			multi=new MultipartRequest(request, realFolder, maxSize, "UTF-8",new DefaultFileRenamePolicy());
			Enumeration<?> files = multi.getFileNames();
			String file1 = (String)files.nextElement();
			filename = multi.getFilesystemName(file1);
		}catch(Exception e){
			e.printStackTrace();
		}
		EquipDAO.update(filename,equip.getId());
		String fullpath = realFolder + "\\" + filename;
		response.sendRedirect("../view/equip_list.jsp?side_value=4&top_value=5");
	}
%>
<body>
<%@include file="/WEB-INF/include/login_top.jsp" %>
	<div id="container-wrap">
		<div id="container" class="container">
			<%@include file="/WEB-INF/include/management_left_bar.jsp" %>
<div id="content1">
	<div id="user">기자재 등록</div>
	
	<form class="user_form" method="post" enctype="multipart/form-data">
		<div>
        	<table>
				<tr>
					<td class="user_table">
					<label id="user_label" for="id">기자재명</label>
					</td>
					<td class="user_table">
					<input type="text" name="name" value="<%=equip.getName()%>" readonly><br />
					</td>
				</tr>
				<tr>
					<td class="user_table">
					<label id="user_label" for="id">메모리</label>
					</td>
					<td class="user_table">
					<input type="text" name="memory" value="<%=equip.getMemory()%>" readonly><br />
					</td>
				</tr>
				<tr>
					<td class="user_table">
					<label id="user_label" for="id">CPU</label>
					</td>
					<td class="user_table">
					<input type="text" name="cpu" value="<%=equip.getCpu()%>" readonly /><br />
					</td>
				</tr>
				<tr>
					<td class="user_table">
					<label id="user_label" for="id">OS</label>
					</td>
					<td class="user_table">
					<input type="text" name="OS" value="<%=equip.getOs() %>" readonly /><br />
					</td>
				</tr>
				<tr>
					<td class="user_table">
					<label id="user_label" for="id">수량</label>
					</td>
					<td class="user_table">
					<input type="text" name="count" value="<%=equip.getCount() %>" readonly /><br />
					</td>
				</tr>
				<tr>
					<td class="user_table">
					<label id="user_label" for="id">학과</label>
					</td>
					<td class="user_table">
					<input type="text" name="department" value="<%=DepartmentDAO.selectById(equip.getDepartment_id()).getName() %>"readonly /><br />
					</td>
				</tr>
				<tr>
				<td class="user_table">
					<label id="user_label" for="id">이미지</label>
					</td>
				<td>
					<input type="file" name="filename" size=40/>
					
				</td>
				</tr>
				<tr>
					<td>
						
					</td>
				</tr>
		</table>
		</div>
		<div class="button">
			<button type="submit" class="btn btn-warning">등록</button>
		</div>
	</form>
	</div>
	</div>
	</div>
</body>
</html>