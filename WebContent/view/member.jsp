<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import=" java.util.*,core.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="../WEB-INF/include/header.jsp"%>
<link href="../resource/css/layout.css" rel="stylesheet" media="screen">
<link href="../resource/css/login.css" rel="stylesheet" media="screen">


</head>
<% 
   request.setCharacterEncoding("UTF-8");
   String error = null;
   String error2=null;
   User user=null;
   String cmd=request.getParameter("cmd");
   String amd= request.getParameter("amd");
   
   String state=request.getParameter("state_id");
   if(state==null){
      state="";
   }
  
  
   
   if("GET".equals(request.getMethod())){

      user=UserService.makeUser();
   }
   if("ct".equals(amd)){
      
         user=UserService.makeUser(request);
         error2=UserService.Overlap(user);
         
      }
   else if("ct2".equals(cmd)){
      
   if("POST".equals(request.getMethod())){
      user=UserService.makeUser(request);
      error=UserService.BeforeInsert(user);
      error2=UserService.Overlap(user);
      if(error == null&&"사용가능합니다.".equals(error2)){
         UserDAO.insert(user);
        // UserService.login(session, user);
         //User user1 = UserDAO.selectById(user.getId());
         //UserService.resotre(session,user1);
           String returnUrl=(String)session.getAttribute("returnUrl");
            if (returnUrl == null) 
                returnUrl = "../view/main.jsp";
            response.sendRedirect(returnUrl);
            return ;
      }
   }
   }
   List<Department> list = DepartmentDAO.selectAll();

%>
<body>
   <%@include file="../WEB-INF/include/login_top.jsp"%>
   <div id="container-wrap">
      <div id="container" class="container">
         <%@include file="../WEB-INF/include/login_left_bar.jsp"%>
         <div id="content1">
            <div id="user">회원 가입</div>
            <div id="all">모든항목을 입력하셔야 합니다</div>
            <form class="user_form" method="post" name="userinput">
               <div>
                  <table>
                     <tr>
                        <td class="user_table"><label id="user_label" for="id">아이디</label>
                        </td>
                        <td class="user_table"><input class="inaput" type="text"
                           name="id" value="<%=user.getId()%>" placeholder="아이디 4~10자리" pattern="[A-Za-z0-9]{4,10}"/><br/><%if(error!=null&&"아이디를 입력하세요".equals(error)||error!=null&&"중복검사하세요".equals(error)) { %><span style="color:red;"><%=error %></span>
                           <%} %> <%if(error2!=null) { %><span style="color:red;"><%=error2 %> <%} %></span></td>
                           <td><button class="btn btn-warning" style="margin-bottom:30px;"type="submit" name="amd" value="ct">중복확인</button></td>
                         
                     </tr>
                     <tr>
                        <td class="user_table"><label id="user_label"
                           for="password">비밀번호</label></td>
                        <td class="user_table"><input type="password"
                           name="password" value="<%=user.getPassword()%>"
                           placeholder="비밀번호"  pattern="[A-Za-z0-9]{4,10}"/> <%if(error!=null&&"비밀번호을 입력하세요".equals(error)) { %><span style="color:red;"><%=error %> <%} %></span></td>
                     </tr>
                     <tr>
                        <td class="user_table"><label id="user_label" for="name">이름</label>
                        </td>
                        <td class="user_table"><input type="text" name="name"
                           value="<%=user.getName()%>" placeholder="이름" /> <%if(error!=null&&"이름을 입력하세요".equals(error)) { %><span style="color:red;"><%=error %> <%} %></span></td>
                     </tr>
                     <tr>
                        <td class="user_table"><label id="user_label" for="birth">생일</label>
                        </td>
                        <td class="user_table"><input type="text" name="birth"
                           value="<%=user.getBirth()%>" placeholder="생일 ex)930930" pattern="[0-9]{6}"/> <%if(error!=null&&"생일을 입력하세요".equals(error)) { %><span style="color:red;"><%=error %> <%} %></span></td>
                     </tr>
                     <tr>
                        <td class="user_table"><label id="user_label"
                           for="phoneNumber">연락처</label></td>
                        <td class="user_table"><input type="text"
                           name="phoneNumber" value="<%=user.getPhoneNumber()%>"
                           placeholder="전화번호 ex)010xxxxxxxx" pattern="[0-9]{3}{1}[0-9]{4}{1}[0-9]{4}"/> <%if(error!=null&&"연락처를 입력하세요".equals(error)) { %><span style="color:red;"><%=error %> <%} %></span></td>
                     </tr>
                     <tr>
                        <td class="user_table"><label id="user_label"
                           for="department_id">학과</label></td>
                        <td class="user_table"><select name="department_id">
                              <% for (Department department : list) { %>
                              <option value="<%= department.getId() %>">
                                 <%= department.getName() %>
                              </option>
                              <% } %>
                        </select></td>
                     </tr>
                     <tr>
                        <td class="user_table"><label id="user_label" for="state">상태</label>
                        </td>
                        <td class="user_table">
                        <input type="text" name="state_id" placeholder="재학생 or 휴학생" value=<%=state %>><%if(error!=null&&"상태를 기입하세요".equals(error)||error!=null&&"잘못기입하셨습니다.".equals(error)) { %><span style="color:red;"><%=error %> <%} %></span></td> 
                     </tr>
                     <tr>
                        <td class="user_table"><label id="user_label"
                           for="email">이메일</label></td>
                        <td class="user_table"><input type="email"
                           name="email" value="<%=user.getEmail()%>"
                           placeholder="이메일" /> <%if(error!=null&&"이메일을 입력하세요".equals(error)) { %><span style="color:red;"><%=error %> <%} %></span></td>
                     </tr>
                  </table>
                  <div id="user_register">
                  <%if(error2!=null){ %>
                     <button class="register btn btn-warning" type="submit" name="cmd" value="ct2"
                        >회원 가입</button>
                  </div>
                  <%} %>
               </div>
            </form>

         </div>
      </div>

   </div>
</body>
</html>