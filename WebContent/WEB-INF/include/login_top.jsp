<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="core.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<%
	request.setCharacterEncoding("UTF-8");
   String v=request.getParameter("top_value");
   int top=Util.parseInt(v,1);
   String[] active = new String[8];
   active[top]="active";
%>


<body>
   <div id="header-wrap">
      <div id="header">
         <a href="../view/main.jsp" title="첫 화면으로 이동 합니다.">
            <h1 class="logo-top text-hide inline pull-left"></h1>
         </a>
         <div id="global-navigation" class="pull-left">
            <h3 class="blind">주 메뉴 목록</h3>
            <ul id="global-navigation-list" class="list-inline">
                <li class="<%=active[1] %>">
                  <a href="../view/equip_rule.jsp" data-id="1" id="1">기자재대여 교칙</a>
               </li>
               <li class="<%=active[3] %>">
                  <a href="../view/board.jsp?top_value=3" data-id="3" id="3">공지사항</a>
               </li>
               <li class="<%=active[4] %>">
                  <a href="../view/Equipment.jsp?top_value=4" data-id="4" id="4">기자재 대여</a>
               </li>
               <%if(UserService.getCurrentUser(session)!=null && UserService.getCurrentUser(session).getState_id()==4){ %>
               <li class="<%=active[5]%>">
                  <a href="../view/equip_management.jsp?top_value=5" data-id="5" id="5">기자재관리</a>
               </li>
               <%} %>
               <%if(UserService.getCurrentUser(session)==null) {%>
               <li class="<%=active[6] %>">
                  <a href="../view/Home_login.jsp?top_value=6&side_value=1" data-id="6" id="6">LOGIN</a>
               </li>
               <%}else{ %>
               <li>
                  <a href="../view/main.jsp" id="7">Home</a>
               </li>
               <%} %>
            </ul>
         </div>
         
      </div>
   </div>
</body>
</html>