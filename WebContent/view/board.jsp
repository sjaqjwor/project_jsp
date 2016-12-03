<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@page import="java.util.*,core.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<%@include file="/WEB-INF/include/header.jsp"%>
<link href="../resource/css/layout.css" rel="stylesheet" media="screen">
<link href="../resource/css/login.css" rel="stylesheet" media="screen">
<script>
   $(function a5() {
      $("[name=button]").click(
            function() {
               location.href = "../view/board_message.jsp?top_value=3&act="
                     + $(this).attr("data-id");
            });
   });
</script>
<script>
   $(function a5() {
      $("#board1 td:nth-child(2)").click(
            function() {
               
                  location.href=$(this).attr("data-url");
            });
   });
</script>

</head>
<%
   User user = null;
   ArrayList<Board> list = null;
   ArrayList<Board> list1 = null;
   
   if("GET".equals(request.getMethod())){
      user=UserService.getCurrentUser(session);
   }
   

   request.setCharacterEncoding("UTF-8");
   String s = request.getParameter("pg");
   String s1=request.getParameter("sea1");
   String s2=request.getParameter("search_2");
   
   
   int currentPage = (s == null) ? 1 : Integer.parseInt(s);
   int pageSize = 8;
   int recordCount = 0;
   int pageCount = 0;
   int basePage = 0;
   if(s1==null){
       recordCount = BoardDAO.getRecordCount();
       pageCount = (recordCount + pageSize - 1) / pageSize;
      basePage = ((currentPage - 1) / 10) * 10;
      list = BoardDAO.selectPage(currentPage, pageSize);
      list1= BoardDAO.selectState();
   }
   if("POST".equals(request.getMethod())){
       s1 = request.getParameter("sea");
       s2 = request.getParameter("search_1");
       currentPage =1;
      if("1".equals(s1)){
         recordCount = BoardDAO.getRecordCountBy(s2); 
         pageCount = (recordCount + pageSize - 1) / pageSize;
         basePage = ((currentPage - 1) / 10) * 10;
         list=BoardDAO.title_search(s2, currentPage, pageSize);
         list1= BoardDAO.selectState();
      }else
      {   
         
         recordCount = BoardDAO.getRecordCountById(s2); 
         pageCount = (recordCount + pageSize - 1) / pageSize;
         basePage = ((currentPage - 1) / 10) * 10;
         list=BoardDAO.id_search(s2, currentPage, pageSize);
         list1= BoardDAO.selectState();
      }
      
         
      }
   else if(s1!=null){
      s1 = request.getParameter("sea1");
       s2 = request.getParameter("search_2");
      if("1".equals(s1)){
         recordCount = BoardDAO.getRecordCountBy(s2); 
         pageCount = (recordCount + pageSize - 1) / pageSize;
         basePage = ((currentPage - 1) / 10) * 10;
         list=BoardDAO.title_search(s2, currentPage, pageSize);
         list1= BoardDAO.selectState();
      }else 
      {   
         
         recordCount = BoardDAO.getRecordCountById(s2); 
         pageCount = (recordCount + pageSize - 1) / pageSize;
         basePage = ((currentPage - 1) / 10) * 10;
         list=BoardDAO.id_search(s2, currentPage, pageSize);
         list1= BoardDAO.selectState();
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
         <div id="content">
            <div class="title">
               <span class="square"></span>
                  <h3>공지사항</h3>
                  <ol class="location">
                     <li><a href="../view/main.jsp">Home</a></li>
                     <li>></li>
                     <li><a href="../view/board.jsp">공지사항</a></li>
                  </ol>
            </div>

            <table class="board_table"style="TABLE-layout: fixed">
               <tr class="board">
                  <td>게시 번호</td>
                  <td>제목</td>
                  <td>아이디</td>
                  <td>작성일</td>
                  <td>조회수</td>
               </tr>
               <%
                  for (Board board : list1) {
               %>
               <tr id="board1" class="board" style="background-color:#f6fa7e;">
                  <td><%=board.getBoard_id()%></td>
                  <td style="text-overflow: ellipsis; overflow: hidden;"
               data-url="../view/board_content.jsp?board_id=<%=board.getBoard_id()%>&pg=<%=currentPage%>&top_value=3"><span style="color:red; font-weight:bold;">[공지]</span><nobr>
                     <%=board.getTitle()%></nobr></td>
                  <td>관리자</td>
                  <td><%=board.getDate()%></td>
                  <td><%=board.getCount()%></td>
               </tr>
               <%
                  }
               %>
               <%
                  for (Board board : list) {
               %>
               <tr id="board1" class="board" >
                  <td><%=board.getBoard_id()%></td>
                  <td style="text-overflow: ellipsis; overflow: hidden;"
               data-url="../view/board_content.jsp?board_id=<%=board.getBoard_id()%>&pg=<%=currentPage%>&top_value=3"><nobr>
                     <%=board.getTitle()%></nobr></td>
                  <td><%=board.getUser_id()%></td>
                  <td><%=board.getDate()%></td>
                  <td><%=board.getCount()%></td>
               </tr>
               <%
                  }
               %>

            </table>
            <%
               if (user != null) {
            %>
            
            <%
               }
            %>
            <%if(s1==null) {%>
            <div class="pagination pagination-small pagination-centered">
               <ul>
                  <%
                     if (basePage > 0) {
                  %>
                  <li><a href="board.jsp?pg=<%=basePage%>&act=4&top_value=3>">Prev</a></li>
                  <%
                     }
                  %>
                  <%
                     for (int i = 1; i <= 10 && basePage + i <= pageCount; ++i) {
                  %>
                  <li class='<%=basePage + i == currentPage ? "active" : ""%>'><a
                     href="board.jsp?pg=<%=basePage + i%>&act=4&top_value=3" ><%=basePage + i%></a>
                  </li>
                  <%
                     }
                  %>
                  <%
                     if (basePage + 11 <= pageCount) {
                  %>
                  <li><a href="board.jsp?pg=<%=basePage + 11%>&act=4&top_value=3" >Next</a></li>
                  <%
                     }
                  %>
               </ul>
            </div>
            <%} %>
            <%if(s1!=null){ %>
            <div class="pagination pagination-small pagination-centered">
               <ul>
                  <%
                     if (basePage > 0) {
                  %>
                  <li><a href="board.jsp?pg=<%=basePage%>&act=4&sea1=<%=s1%>
                  &search_2=<%=s2%>&top_value=3">Prev</a></li>
                  <%
                     }
                  %>
                  <%
                     for (int i = 1; i <= 10 && basePage + i <= pageCount; ++i) {
                  %>
                  <li class='<%=basePage + i == currentPage ? "active" : ""%>'><a
                     href="board.jsp?pg=<%=basePage + i%>&act=4&sea1=<%=s1%>
                     &search_2=<%=s2%>&top_value=3" ><%=basePage + i%></a>
                  </li>
                  <%
                     }
                  %>
                  <%
                     if (basePage + 11 <= pageCount) {
                  %>
                  <li><a href="board.jsp?pg=<%=basePage + 11%>&act=4&sea1=<%=s1%>
                  &search_2=<%=s2%>&top_value=3" >Next</a></li>
                  <%
                     }
                  %>
               </ul>
            </div>
            <%} %>
            <%
               if (user != null) {
            %>
            <button id="write" data-id="4" class="btn btn-warning" name="button">글쓰기</button>
            
            <%
               }
            %>
         
            <form method="post">
               <table id="search1">
                  <tr>
                     <td><select name="sea">
                           <option value="1">제목</option>
                           <option value="2">글쓴이</option>
                     </select></td>
                     <td><input type="text" name="search_1" value=""></td>
                     <td>
                        <button type="submit" class="btn btn-warning">검색</button>
                     </td>
                  </tr>
               </table>
            </form>
            
         </div>
      </div>
   </div>
</body>
</html>