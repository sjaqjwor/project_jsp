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
   User user = null;

   
   request.setCharacterEncoding("UTF-8");
   
   if ("GET".equals(request.getMethod())) {
      user=UserService.getCurrentUser(session);
      user = UserDAO.selectById(user.getId());
      System.out.println(user.getEquip_request_day());
   }
   
%>

<body>
   <%@include file="../WEB-INF/include/login_top.jsp"%>
   <div id="container-wrap">
      <div id="container" class="container">
         <%@include file="../WEB-INF/include/login_left_bar.jsp"%>
         <div id="content1">
         	
            <div id="user">Mypage</div>
               <div class="user_form">
                  <table>
                  <tr>
                        <td class="user_table">
                        <label id="user_label" for="id">아이디</label>
                        </td>
                        <td class="user_table">
                        <input type="text" name="id" readonly value=<%=user.getId() %> >
                        </td>
                     </tr>
                     <tr>
                        <td class="user_table">
                        <label id="user_label" for="name">이름</label>
                        </td>
                        <td class="user_table">
                        <input type="text" name="name" readonly value=<%=user.getName() %> >
                        </td>
                     </tr>
                     <tr>
                        <td class="user_table"><label id="user_label"
                           for="phoneNumber">연락처</label></td>
                        <td class="user_table"><input type="text"
                           name="phoneNumber" readonly value="<%=user.getPhoneNumber() %>"
                           ></td>
                     </tr>
                     <tr>
                        <td class="user_table"><label id="user_label"
                           for="department_id">학과</label></td>
                       <td class="user_table"><input type="text"
                           name="department_id" readonly value="<%=DepartmentDAO.selectById(user.getDepartment_id()).getName() %>"
                           ></td>
                     </tr>
                     <tr>
                        <td class="user_table"><label id="user_label" for="state">상태</label>
                        </td>
                        <td class="user_table"><input type="text"
                           name="state" readonly value="<%=StateDAO.selectById(user.getState_id()).getName() %>"
                           ></td>
                     </tr>
                     <tr>
                        <td class="user_table">
                        <label id="user_label" for="email">이메일</label>
                        </td>
                        <td class="user_table"><input class="inaput" type="text"
                           name="email"  readonly value="<%=user.getEmail()%>" ></td>
                     </tr>

                     <%if(user.getEquip_rent_state()==1) {%>
                      <tr>
                        <td class="user_table">
                        <label id="user_label" for="email">대여아이디</label>
                        </td>
                        <td class="user_table"><input class="inaput" type="text"
                           name="email"  readonly value="<%=user.getEquip_rent_id()%>" ></td>
                     </tr>
                     <tr>
                        <td class="user_table">
                        <label id="user_label" for="email">대여 상태</label>
                        </td>
                        <td class="user_table"><input class="inaput" type="text"
                           name="email"  readonly value="<%=user.getEquip_rent_state()%>" ></td>
                     </tr>
                     <tr>
                        <td class="user_table">
                        <label id="user_label" for="email">대여날짜</label>
                        </td>
                        <td class="user_table"><input class="inaput" type="text"
                           name="email"  readonly value="<%=Equip_rent_DAO.selectByUser_id(user.getId()).getEquip_rent_day()%>" ></td>
                     </tr>
                     <tr>
                        <td class="user_table">
                        <label id="user_label" for="email">반납날짜</label>
                        </td>
                        <td class="user_table"><input class="inaput" type="text"
                           name="email"  readonly value="<%=Equip_rent_DAO.selectByUser_id(user.getId()).getEquip_return_day()%>" ></td>
                     </tr>
                     <tr>
                        <td class="user_table">
                        <label id="user_label" for="email">신청날짜</label>
                        </td>
                        <td class="user_table"><input class="inaput" type="text"
                           name="email"  readonly value="<%=user.getEquip_request_day()%>" ></td>
                     </tr>
                     <%} %>
                  </table>
                    <div id="user_register">
                </div>
              
            </div>
         </div>
      </div>
   </div>
</body>
</html>