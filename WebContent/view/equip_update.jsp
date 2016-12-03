<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="core.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../WEB-INF/include/header.jsp" %>
<link href="../resource/css/layout.css" rel="stylesheet" media="screen">
<script>
$(function() { 
    $("[name=image]").click(function() { 
        location.href ="../view/image_upload.jsp?top_value=5&side_value=4&value=" + $(this).attr("data-id"); 
    }); 
});
</script>
</head>
<%
	request.setCharacterEncoding("UTF-8");
	String equip_number = request.getParameter("value");
	int equip_id=Integer.parseInt(equip_number);
	Equip equip = EquipDAO.selectById(equip_id);
	ArrayList<Department> list = DepartmentDAO.selectAll();
	
	if("POST".equals(request.getMethod())){
		 String equip_name = request.getParameter("name");
		 String dept_id = request.getParameter("department_id");
		 int department_id = Integer.parseInt(dept_id);
		 String dcount= request.getParameter("count");
		 int count = Integer.parseInt(dcount);
		 String os = request.getParameter("os");
		 String memory = request.getParameter("memory");
		 String cpu = request.getParameter("cpu");
	     EquipDAO.update(equip_name,department_id,count,os,memory,cpu,equip.getId());
	     response.sendRedirect("../view/equip_list.jsp?side_value=4&top_value=5");
	     return;
	}
%>

</head>
<body>
<%@include file="/WEB-INF/include/login_top.jsp" %>
	<div id="container-wrap">
      <div id="container" class="container">
         <%@include file="../WEB-INF/include/management_left_bar.jsp"%>
         <div id="content1">
            <div id="user">기자재 수정</div>
            <div id="all">모든항목을 입력하셔야 합니다</div>
            <form class="user_form" method="post">
               <div>
                  <table>
                     <tr>
                        <td class="user_table"><label id="user_label" for="name">기자재명</label>
                        </td>
                        <td class="user_table"><input class="inaput" type="text"
                           name="name" value="<%=equip.getName()%>" placeholder="기자재명"/>
                     </tr>
                     <tr>
                        <td class="user_table"><label id="user_label" for="count">수량</label>
                        </td>
                        <td class="user_table"><input class="inaput" type="text"
                           name="count" value="<%=equip.getCount()%>" placeholder="수량"/>
                     </tr>
                     <tr>
                        <td class="user_table"><label id="user_label" for="os">OS</label>
                        </td>
                        <td class="user_table"><input class="inaput" type="text"
                           name="os" value="<%=equip.getOs()%>" placeholder="OS"/>
                     </tr>
                     <tr>
                        <td class="user_table"><label id="user_label" for="memory">memory</label>
                        </td>
                        <td class="user_table"><input class="inaput" type="text"
                           name="memory" value="<%=equip.getMemory()%>" placeholder="memory"/>
                     </tr>
                     <tr>
                        <td class="user_table"><label id="user_label" for="cpu">CPU</label>
                        </td>
                        <td class="user_table"><input class="inaput" type="text"
                           name="cpu" value="<%=equip.getCpu()%>" placeholder="CPU"/>
                     </tr>
                     <tr>
                        <td class="user_table"><label id="user_label"
                           for="department_id">학과</label></td>
                        <td class="user_table"><select name="department_id">
                              <% for (Department department : list) { %>
                              	<%if(department.getId()!=1 && department.getId()!=6 && department.getId()!=7) {%>
		                              <option value="<%= department.getId() %>">
		                                 <%= department.getName() %>
		                              </option>
		                         <%} %>
                              <% } %>
                        </select></td>
                     </tr>
                     </table>
                  <div id="user_register">
                     <button class="register" type="submit"
                        style="background: url(../resource/images/yellow.png)">수정완료</button>
                  </div>
                  
               </div>
            </form>
<div id="user_regiser">
                  	 <button class="register" style="background: url(../resource/images/yellow.png); margin-left:510px;" name="image" data-id="<%=equip.getId() %>">이미지 수정</button>
                  </div>
         </div>
      </div>

   </div>
</body>
</html>