<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: qpwoe
  Date: 2023-11-29
  Time: 오후 2:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/bootstrap.min.css" />
  <meta charset="UTF-8">
  <title>상품 수정</title>
</head>
<body>
<jsp:include page="../layout/menu.jsp" />
<div class="jumbotron">
  <div class="container">
    <h1 class="display-3">상품 수정</h1>
  </div>
</div>
<%@include file="../dbconn.jsp" %>
<%
  //어떤 제품을 편집할지의 상품id값을 받아온다.
  String productId = request.getParameter("id");

  PreparedStatement pstmt = null;
  ResultSet rs = null;

  String sql = "select * from product where p_id = ?";
  //Connection객체로 부터 쿼리문을 주고 PreparedStatement를 얻고 있다.
  pstmt = conn.prepareStatement(sql);
  pstmt.setString(1, productId);
  //쿼리문 결과 받아온다.
  rs = pstmt.executeQuery();

  if(rs.next()){

%>
<div class="container">
  <div class="row">
    <div class="col-md-5">
      <img src="${pageContext.request.contextPath}/resource/upload/<%= rs.getString("p_fileName") %>" style="width: 100%">
    </div>
    <div class="col-lg-10">
      <form action="./processUpdateProduct.jsp" name="newProduct" class="form-horizontal"
            method="POST" enctype="multipart/form-data">

        <div class="form-group row">
          <label class="col-sm-2">상품 코드</label>
          <div class="col-sm-3">
            <input type="text" id="productId" name="productId" class="form-control"
                   value='<%= rs.getString("p_id") %>'>
          </div>
        </div>

        <div class="form-group row">
          <label class="col-sm-2">상품명</label>
          <div class="col-sm-3">
            <input type="text" id="name" name="name" class="form-control"
                   value='<%= rs.getString("p_name") %>'>
          </div>
        </div>

        <div class="form-group row">
          <label class="col-sm-2">상품 가격</label>
          <div class="col-sm-3">
            <input type="text" id="unitPrice" name="unitPrice" class="form-control"
                   value='<%= rs.getInt("p_unitPrice") %>'>
          </div>
        </div>

        <div class="form-group row">
          <label class="col-sm-2">상품 설명</label>
          <div class="col-sm-3">
            <input type="text" id="description" name="description" class="form-control"
                   value='<%= rs.getString("p_description") %>'>
          </div>
        </div>

        <div class="form-group row">
          <label class="col-sm-2">제조사</label>
          <div class="col-sm-3">
            <input type="text" id="manufacturer" name="manufacturer" class="form-control"
                   value='<%= rs.getString("p_manufacturer") %>'>
          </div>
        </div>

        <div class="form-group row">
          <label class="col-sm-2">분류</label>
          <div class="col-sm-3">
            <input type="text" id="category" name="category" class="form-control"
                   value='<%= rs.getString("p_category") %>'>
          </div>
        </div>

        <div class="form-group row">
          <label class="col-sm-2">재고수</label>
          <div class="col-sm-3">
            <input type="text" id="unitsInStock" name="unitsInStock" class="form-control"
                   value='<%= rs.getLong("p_unitsInStock") %>'>
          </div>
        </div>

        <div class="form-group row">
          <label class="col-sm-2">상태</label>
          <div class="col-sm-5">
            <input type="radio" name="condition" value="New">신규 제품
            <input type="radio" name="condition" value="Old">중고 제품
            <input type="radio" name="condition" value="Refurbished">재생 제품
          </div>
        </div>

        <div class="form-group row">
          <label class="col-sm-2">이미지</label>
          <div class="col-sm-5">
            <input type="file" name="productImage" class="form-control">
          </div>
        </div>

        <div class="form-group row">
          <div class="col-sm-offset-2 col-sm-10">
            <input type="submit" class="btn btn-primary" value="편집완료">
          </div>
        </div>
      </form>
    </div>
  </div>
</div>
<%
  }
  if(rs != null) rs.close();
  if(pstmt != null) pstmt.close();
  if(conn != null) conn.close();
%>
</body>
</html>