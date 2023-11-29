<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: qpwoe
  Date: 2023-11-29
  Time: 오후 3:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../dbconn.jsp" %>
<%
  //어떤 제품을 편집할지의 상품id값을 받아온다.
  String productId = request.getParameter("id");

  PreparedStatement pstmt = null;
  ResultSet rs = null;

  String sql = "select * from product";
  //Connection객체로 부터 쿼리문을 주고 PreparedStatement를 얻고 있다.
  pstmt = conn.prepareStatement(sql);
  //쿼리문 결과 받아온다.
  rs = pstmt.executeQuery();

  //가져온 결과가 있다면..
  if(rs.next()){
    sql = "delete from product where p_id=?";
    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, productId);
    pstmt.executeUpdate();
  }
  //없을 시
  else {
    out.println("일치하는 상품이 없습니다.");
  }
  if(rs != null) rs.close();
  if(pstmt != null) pstmt.close();
  if(conn != null) conn.close();

  response.sendRedirect("editProduct.jsp?edit=delete");
%>