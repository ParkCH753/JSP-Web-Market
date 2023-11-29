<%--
  Created by IntelliJ IDEA.
  User: qpwoe
  Date: 2023-11-03
  Time: 오후 12:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  session.invalidate();
  response.sendRedirect("addProduct.jsp");

%>