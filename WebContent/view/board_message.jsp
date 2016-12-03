<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import=" java.util.*,core.*"%>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="../smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>
<link href="../resource/css/login.css" rel="stylesheet" media="screen">
<link href="../resource/css/layout.css" rel="stylesheet" media="screen">
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
            bUseModeChanger : true,
         }
      });

      $("button").click(function() {
         editor_object.getById["smt"].exec("UPDATE_CONTENTS_FIELD",[]);
         $("#board_message").submit();
      })
   
   })
</script>
<title></title>
<%@include file="/WEB-INF/include/header.jsp"%>

</head>
<%

User user = null;
Board board = null;
request.setCharacterEncoding("UTF-8");
String s = request.getParameter("id");
if ("GET".equals(request.getMethod())) {
   user=UserService.getCurrentUser(session);
   board=boardService.makeBoard();
}

String error=null;
if("POST".equals(request.getMethod())){
   
   user=UserService.getCurrentUser(session);
   board = boardService.makeBoard(request,request.getParameter("smt"));
   if(error==null){
            BoardDAO.insert(board);
               String returnUrl=(String)session.getAttribute("returnUrl");
               if (returnUrl == null) 
                   returnUrl = "../view/board.jsp?top_value=3";
               response.sendRedirect(returnUrl);
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
            <form method="post" id="board_message" style="width:800px;">
               <table class="board_table" style="width:800px !important; ">
                  <tr>
                  <th scope="row" class="board_top">
                     <label>작성자</label>
                  </th>
                  <td class="board_top"><%=user.getName() %><input type="hidden"class="write1" value="<%=user.getId()%>" name="name" readonly="readonly">
                  </td>
                  </tr>
                  <tr>
                     <th scope="row">
                     <label>제목</label>
                     </th>
                  <td >
                     <input type="text"class="write2" value="<%=board.getTitle()%>" name="title" maxlength="60">
                  </td>                  
                  </tr>
                  <tr>
                  <td  colspan="4"><textarea rows="10" cols="100" style="width:80px; height:80px; overhidden:scroll;"name="smt" id="smt"><%=board.getBoard_message()%></textarea>
                  </td>
                  
                  </tr>
               </table>
                  <button type="submit" id="write4"class="btn btn-warning" >저장</button>
         </form>
         </div>
      </div>
   </div>
</body>
</html>