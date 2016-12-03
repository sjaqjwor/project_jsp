<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="core.*,util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../WEB-INF/include/header.jsp"%>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="../smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>
<link href="../resource/css/login.css" rel="stylesheet" media="screen">
<link href="../resource/css/layout.css" rel="stylesheet" media="screen">
<title>Insert title here</title>
<style>
p, span {
	line-height: 1em;
}
</style>
</head>

<%
	request.setCharacterEncoding("UTF-8");
	Board board = null;
	User user = null;
	User user1=null;
	
	if("GET".equals(request.getMethod())){
		user1=UserService.getCurrentUser(session);
		String s = request.getParameter("board_id");
		int id = Integer.parseInt(s);
		board=BoardDAO.selectById(id);
		BoardDAO.updateCount(board.getBoard_id());
		user=UserDAO.selectById(board.getUser_id());
		
	}
	
	if ("POST".equals(request.getMethod())) {
		if ("list".equals(request.getParameter("list"))) {
			String returnUrl = (String) session.getAttribute("returnUrl");
			returnUrl = "../view/board.jsp?act=4&top_value=3";
			response.sendRedirect(returnUrl);
		} else {
			String s = request.getParameter("delete");
			if (s==null) {
				String returnUrl = (String) session.getAttribute("returnUrl");
				returnUrl = "../view/board_reference.jsp?top_value=3&board_id="+request.getParameter("ref")+"&act=4";
				response.sendRedirect(returnUrl);
			} else {
				int s1 = Integer.parseInt(request.getParameter("delete"));
				BoardDAO.deleteBoard(s1);
				String returnUrl = (String) session.getAttribute("returnUrl");
				if (returnUrl == null) {
					returnUrl = "../view/board.jsp?top_value=3&act=4";
					response.sendRedirect(returnUrl);
				}
			}
		}

	}
%>
<body>
	<%@include file="../WEB-INF/include/login_top.jsp"%>
	<div id="container-wrap">
		<div id="container" class="container">
			<div id="local-navigation">
          <div id="nav">
               </div>
          </div>
			<div id="content3">
				<%if(board!=null){ %>
				<form method="post">
					<table class="board_table" style="width: 600px;">
						<tr>
							<th scope="row" class="board_top" class="width2"><label>제목</label>
							</th>
							<td class="board_top" colspan="3"><%=board.getTitle()%></td>

						</tr>
						<tr>
							<th scope="row" class="width2"><label>작성자</label></th>
							<td class="name"><%=user.getName()%></td>
							<th scope="row" class="width2"><label>작성일</label></th>
							<td><%=board.getDate()%></td>
						</tr>
						<tr>

							<td colspan='4'
								style='padding-top: 20px; height: 200px; word-break: break-all;'><%=board.getBoard_message()%>
						</tr>
					</table>
					<button type="submit" id="write1" class="btn btn-warning"
						name="list" value="list">목록</button>
					<%if(user1!=null&&board.getUser_id().equals(user1.getId())) {%>
					<button type="submit" id="write1" class="btn btn-warning"
						name="delete" value="<%=board.getBoard_id()%>">삭제</button>
					<button type="submit" id="write1" class="btn btn-warning"
						name="ref" value="<%=board.getBoard_id()%>">수정</button>

					<%} %>
					<%} %>

				</form>
			</div>
		</div>
	</div>
</body>
</html>