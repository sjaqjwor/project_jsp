<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import=" java.util.*,core.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript"
	src="//code.jquery.com/jquery-1.11.0.min.js"></script>
	<link href="../resource/css/layout.css" rel="stylesheet" media="screen">
<script type="text/javascript" src="../smarteditor/js/HuskyEZCreator.js"
	charset="utf-8"></script>

<script type="text/javascript">
	$(function() {
		var editor_object = [];

		nhn.husky.EZCreator.createInIFrame({
			oAppRef : editor_object,
			elPlaceHolder : "smt",
			sSkinURI : "../smarteditor/SmartEditor2Skin.html",
			htParams : {
				bUseToolbar : true,
				bUseVerticalResizer : false,
				bUseModeChanger : false,
			}
		});

		$("button").click(function() {
			editor_object.getById["smt"].exec("UPDATE_CONTENTS_FIELD", []);
			$("#board_message").submit();
		})
	})
</script>
<title>Insert title here</title>
<%
	request.setCharacterEncoding("UTF-8");
	User user1 = null;
	Board board = null;
	Board board1 = null;
	board1 = board = boardService.makeBoard();
	String s = request.getParameter("board_id");
	if ("GET".equals(request.getMethod())) {
		user1 = UserService.getCurrentUser(session);
		int id = Integer.parseInt(s);
		board = BoardDAO.selectById(id);
		BoardDAO.updateCount(board.getBoard_id());
	} else if ("POST".equals(request.getMethod())) {
		BoardDAO.update(s, request.getParameter("smt"));

		String returnUrl = (String) session.getAttribute("returnUrl");
		if (returnUrl == null)
			returnUrl = "../view/board_content.jsp?top_value=3&board_id=" + s;
		response.sendRedirect(returnUrl);
	}
%>
</head>
<%@include file="/WEB-INF/include/header.jsp"%>
<body>
	<%
		if (user1 != null) {
	%>
	<%@include file="../WEB-INF/include/login_top.jsp"%>
	<div id="container-wrap">
		<div id="container" class="container">
			<div id="local-navigation">
          <div id="nav">
               </div>
          </div>
			<div id="content3">
				<form method="post" id="board_message" style="width: 800px;">
					<table class="board_table" style="width: 800px !important;">
						<tr>
							<th scope="row" class="board_top"><label>작성자</label></th>
							<td class="board_top"><%=user1.getName()%><input
								type="hidden" class="write1" value="<%=user1.getId()%>"
								name="name" readonly="readonly"></td>
						</tr>
						<tr>
							<th scope="row"><label>제목</label></th>
							<td><input type="text" class="write2"
								value="<%=board.getTitle()%>" name="title" maxlength="60">
							</td>
						</tr>
						<tr>
							<td colspan="4"><textarea
									value="<%=board1.getBoard_message()%>" rows="10" cols="100"
									style="width: auto; height: auto;" name="smt" id="smt"><%=board.getBoard_message()%></textarea>
							</td>


						</tr>
					</table>
					<button type="submit" id="write4" class="btn btn-warning">저장</button>
					<%
						}
					%>

				</form>
			</div>
		</div>
	</div>
</body>
</html>