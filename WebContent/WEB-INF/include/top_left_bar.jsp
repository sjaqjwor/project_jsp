<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="core.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="../resource/css/layout.css" rel="stylesheet" media="screen">
</head>
<%
	String o=request.getParameter("side_value1");
	int num = Util.parseInt(o,1);
	String[] w = new String[6];
	w[num]="active";
%>
<body>
         <div id="local-navigation">
            <h2>HOME</h2>
            <div id="nav">
               <ul class="nav">
                  <li class="<%=w[1]%>">
                     <a >기자재 대여소개</a>
                  </li>
                  <li class="<%=w[2]%>">
                     <a>기자재 소개</a>
                  </li>
                  <li class="<%=w[3]%>">
                     <a href="../view/Equipment.jsp">기자재대여</a>
                  </li>
                  <li <%if("4".equals(request.getParameter("act"))) {%> class="active"
                  <%} %>>
                     <a > 공지사항</a>
                  </li>
               </ul>
            </div>
         </div>
         </body>

</html>