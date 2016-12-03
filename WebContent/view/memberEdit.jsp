<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="java.util.*,core.*"%>
<%request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<%@include file="../WEB-INF/include/header.jsp"%>
<link href="../resource/css/layout.css" rel="stylesheet" media="screen">


</head>
<%
   String error = null;
   String error2 =null;
   User user = null;
   String state=null;
   
   request.setCharacterEncoding("UTF-8");
   
   if ("GET".equals(request.getMethod())) {
      user=UserService.getCurrentUser(session);
      user = UserDAO.selectById(user.getId());
   }
   
   if ("POST".equals(request.getMethod())) {
      error=UserService.Password(request.getParameter("password"),request.getParameter("password2"));
      user=UserService.makeUser(request);
      error2=UserService.BeforeInsert2(user);
      System.out.println(error2);
      if (error == null&&error2==null) {
         UserService.login(session, user);
         UserDAO.update(user);
         User user1 = UserDAO.selectById(user.getId());
         UserService.resotre(session,user1);
            String returnUrl=(String)session.getAttribute("returnUrl");
            if (returnUrl == null) 
                returnUrl = "../view/main.jsp";
            response.sendRedirect(returnUrl);
      }
      
   }
   List<Department> list = DepartmentDAO.selectAll();
   List<State> list1 = StateDAO.selectAll();
%>

<body>
   <%@include file="../WEB-INF/include/login_top.jsp"%>
   <div id="container-wrap">
      <div id="container" class="container">
         <%@include file="../WEB-INF/include/login_left_bar.jsp"%>
         <div id="content1">
            <div id="user">회원 정보수정</div>
            <form class="user_form" method="post" >
               <div>
                  <table>
                  
                  <tr>
                        <td class="user_table">
                        <label id="user_label" for="id">아이디</label>
                        </td>
                        <td class="user_table">
                        <input type="text" name="id"readonly value=<%=user.getId() %> >
                        </td>
                     </tr>
                     <tr>
                        <td class="user_table">
                        <label id="user_label" for="name">이름</label>
                        </td>
                        <td class="user_table">
                        <input type="text" name="name"readonly value=<%=user.getName() %> >
                        </td>
                        <td class="user_table"><input type="hidden" name="birth"
                           value="<%=user.getBirth()%>" >
                           </td>
                     </tr>
               
                     <tr>
                        <td class="user_table"><label id="user_label"
                           for="phoneNumber">연락처</label></td>
                        <td class="user_table"><input type="text"
                           name="phoneNumber" value="<%=user.getPhoneNumber()%>"
                           placeholder="전화번호 ex)010xxxxxxxx" pattern="[0-9]{3}{1}[0-9]{4}{1}[0-9]{4}"/> <%if(error2!=null&&"연락처를 입력하세요".equals(error2)) { %><span style="color:red;"><%=error2 %> <%} %></span></td>
                     </tr>
                     <tr>
                        <td class="user_table"><label id="user_label"
                           for="department_id">학과</label></td>
                        <td class="user_table"><select name="department_id">
                              <%
                                 for (Department department : list) {
                              %>
                              <option value="<%=department.getId()%>">
                                 <%=department.getName()%>
                              </option>
                              <%
                                 }
                              %>
                        </select></td>
                     </tr>
                     <tr>
                        <td class="user_table"><label id="user_label" for="state">상태</label>
                        </td>
                        <td class="user_table">
                        <input type="text" name="state_id" value="<%=StateDAO.selectById(user.getState_id()).getName() %>" placeholder="재학생/휴학생/교수/교직원번호" ><%if(error2!=null&&"상태를 기입하세요".equals(error2)||error2!=null&&"잘못기입하셨습니다.".equals(error2)) { %><span style="color:red;"><%=error2 %> <%} %></span></td> 
                     </tr>
                      <tr>
                        <td class="user_table"><label id="user_label"
                           for="email">이메일</label></td>
                        <td class="user_table"><input type="email"
                           name="email" value="<%=user.getEmail()%>"
                           placeholder="이메일" /> <%if(error2!=null&&"이메일을 입력하세요".equals(error2)) { %><span style="color:red;"><%=error2 %> <%} %></span></td>
                     </tr>
                     <tr>
                        <td class="user_table">
                        <label id="user_label"
                           for="password">비밀번호</label>
                           </td>
                        <td class="user_table">
                        <input type="password" name="password" value=<%=user.getPassword() %>
                            placeholder="비밀번호"  />
                        </tr>
                           <tr>
                        <td class="user_table">
                        <label id="user_label"
                           for="password2">비밀번호</label>
                           </td>
                        <td class="user_table">
                        <input type="password" name="password2" value=<%=user.getPassword() %>
                            placeholder="비밀번호"/>
                           <%if(error!=null) {%>
                              <%=error %>
                           <%} %>
                        </tr>
                        
                  </table>
                    <div id="user_register">
                    <button class="register" type="submit" 
                     style="background: url(../resource/images/yellow.png) " onclick="return confirm('변경하시겠습니까?')">
                            정보변경
                    </button>
                </div>
               </div>
            </form>
         </div>
      </div>
   </div>
</body>
</html>