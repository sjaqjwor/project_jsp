<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import=" java.util.*" %>
<%@ page import="core.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>

<script>
   $(function a1() { 
       $("#a1").click(function() { 
   
           location.href = "../view/Home_login.jsp?top_value=6&value=" + $(this).attr("data-id"); 
   
       }); 
   
   });

   $(function a3() { 
       $("#a3").click(function() { 
   
           location.href = "../view/idSearch.jsp?top_value=6&value=" + $(this).attr("data-id"); 
   
       }); 
   
   });

   $(function a5() { 
       $("#a5").click(function() { 
   
           location.href = "../view/memberEdit.jsp?value=" + $(this).attr("data-id"); 
   
       }); 
   
   });
</script>
<%
   
   String s=request.getParameter("value");
   String s1=request.getParameter("side_value");

   

%>
<body>
<%if("5".equals(s)){ %>
   <div id="local-navigation">
      <h2 class="blind">로그인</h2>
      <h2>HOME</h2>
      <div id="nav">
         <ul class="nav">
         <li <%if("5".equals(s)) {%>
                   class="active"
                  <%} %> > 
                     <a >회원정보 변경</a>
                  </li>
         </ul>
      </div>
   </div>
   <%} %>
   <%if("6".equals(s)){ %>
   <div id="local-navigation">
      <h2 class="blind">로그인</h2>
      <h2>HOME</h2>
      <div id="nav">
         <ul class="nav">
         <li <%if("6".equals(s)) {%>
                   class="active"
                  <%} %> > 
                     <a >MyPage</a>
                  </li>
         </ul>
      </div>
   </div>
   <%} %>
   <%if("2".equals(s)){ %>
   <div id="local-navigation">
      <h2 class="blind">로그인</h2>
      <h2>HOME</h2>
      <div id="nav">
         <ul class="nav">
         <li <%if("2".equals(s)) {%>
                   class="active"
                  <%} %> > 
                     <a>회원가입</a>
                  </li>
         </ul>
      </div>
   </div>
   <%} %>
   <%if("1".equals(s)|"3".equals(s)||"1".equals(s1)||"3".equals(s1)){%>

         <div id="local-navigation">
            <h2 class="blind">로그인</h2>
            <h2>HOME</h2>
            <div id="nav">
               <ul class="nav">
                  <li <%if("1".equals(s)||"1".equals(s1)) {%>
                   class="active"
                  <%} %> >
                     <a id="a1" data-id="1"target="_top">로그인</a>
                  </li>
                 
                  <li <%if("3".equals(s)||"3".equals(s1)) {%>
                   class="active"
                  <%} %> >
                     <a id="a3" data-id="3"target="_top">비밀번호 찾기</a>
                  </li>
 
               </ul>
            </div>
         </div>
         </body>
      <%} %>
   

</html>