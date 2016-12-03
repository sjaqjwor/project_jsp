<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="core.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="../resource/css/foot.css" type="text/css" rel="stylesheet">
</head><script> 
var imgObj = new Image(); 
function showImgWin(imgName) { 
  imgObj.src = imgName; 
  setTimeout("createImgWin(imgObj)", 100); 
} 
function createImgWin(imgObj) { 
  if (! imgObj.complete) { 
    setTimeout("createImgWin(imgObj)", 100); 
    return; 
  } 
  imageWin = window.open("", "imageWin", 
    "width=" + imgObj.width + ",height=" + imgObj.height); 
  imageWin.document.write("<html><body style='margin:0'>"); 
  imageWin.document.write("<a href=javascript:window.close()><img src='" + imgObj.src + "' border=0></a>"); 
  imageWin.document.write("</body><html>"); 
  imageWin.document.title = imgObj.src; 
} 

<script>
$(function() { 
    $(".a").click(function() { 

        location.href = "Home_login.jsp?value=" + $(this).attr("data-id"); 
    }); 

});

</script>
<body style="width:100%;">
<div id="footer-wrapper" class="clear">
   <div id="footer">
      <img id="img1" src="../resource/images/sungkong.jpg" alt="성공회대학교" class="logo-footer">
      <h2 class="blind">보조 메뉴 목록</h2>
   <div class="right">
      <ul class="line pull-left sub-menu">
      <%if(UserService.isCurrentUserLoggedIn(session)==false) {%>
         <li><a class="a" data-id="1">LOGIN</a></li>
         <%}else{ %>
            <li><a class="a" ><%=UserService.getCurrentUserName(session) %></a></li>
      
         <%} %>
         <li><a href="http://skhu.ac.kr/main.aspx">SITEMAP</a></li>
         <li><a href="javascript:showImgWin('../resource/images/sitemap2.jpg')">CAMPUSMAP</a></li>
      </ul>
   </div>
   <h2 class="blind">정책 메뉴 안내</h2>
      <ul id="footer-menu" class="line utill-menu">
         <li><a>개인정보처리방침</a></li>
         <li><a>이메일무단수집거부</a></li>
         <li><a>예결산 공고</a></li>
         <li><a>대학정보 알리미 서비스</a></li>
         <li><a>자체 평가 홈페이지</a></li>
   </ul>
   <address>
      <h2 class="blind">주소 및 연락처 안내</h2>
      <ul class="utill-menu">
         <li><a>서울특별시 구로구 연동로 320</a></li>
         <li>대표 전화<a>02-2610-4114</a></li>
      </ul>   
   </address>
   <p class="copyright">copyright by skhu institute of technology all rights reserved</p>
   </div>
   </div>
</body>
</html>