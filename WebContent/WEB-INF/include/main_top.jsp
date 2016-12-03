<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="core.*" %>
<% String R78 = request.getContextPath(); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<script> 
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


$(function foo1() { 
    $("#a1").click(function() { 

        location.href = "../view/Home_login.jsp?top_value=6&value=" + $(this).attr("data-id"); 

    }); 

});
$(function foo() { 
    $("#a5").click(function() { 
   
        location.href = "../view/memberEdit.jsp?value=" + $(this).attr("data-id"); 

    }); 
    $(function foo() { 
        $("#a4").click(function() { 
       
            location.href = "../view/Mypage.jsp?top_value=7&value=" + $(this).attr("data-id"); 

        }); 
    });
});
</script>
<body>
<%if(UserService.isCurrentUserLoggedIn(session)==false) {%>
   <div class="right">
      <ul id="top" class="line" style="background: url(../resource/images/black.png) 0 0 repeat;">
      <li>
         <a id="a1" data-id="1">LOGIN</a>
         <a href="http://skhu.ac.kr/main.aspx">SITEMAP</a>
         <a href="javascript:showImgWin('../resource/images/sitemap2.jpg')">CAMPUSMAP</a>
      </ul>
      <div id="tong"></div>
   </div>
<%}else{ %>
   <div class="right1">
      <table id="top1" class="line1" style="background: url(../resource/images/black.png) 0 0 repeat;">
         <tr id="tr1">
         <td id="a4" data-id="6"><%=UserService.getCurrentUserName(session) %></td>
         <td id="a5" data-id="5">회원정보수정</td>
         <td><a href="../view/logout.jsp">로그아웃</a></td>
         </tr>
      </table>
      <div id="tong"></div>
   </div>
<%} %>
</body>
</html>