<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page errorPage="../exception/exceptionNoProductId.jsp"%>
<jsp:useBean id="productDAO" class="dao.ProductRepository" scope="session"/>
<html>
<head>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/bootstrap.min.css" />
  <meta charset="UTF-8">
  <title>상품 상세 정보</title>

  <!-- 장바구니 추가를 위한 핸들러 함수 -->
  <script type="text/javascript">
    function addToCart() {
      if(confirm("해당 상품을 장바구니에 추가 하시겠습니까?")){
        document.addForm.submit();
      } else {
        document.addForm.reset();
      }
    }
  </script>

</head>
<body>
<jsp:include page="../layout/menu.jsp" />
<div class="jumbotron">
  <div class="container">
    <h1 class="display-3">상품 정보</h1>
  </div>
</div>
<%-- <%
    /* //얻어온 상품 ID값을 얻어낸다.
    String id = request.getParameter("id");
    ProductRepository dao = ProductRepository.getInstance();
    //얻어온 상품 ID값을 이용해서 해당하는 Product객체를 얻는다.
    Product product = dao.getProductById(id); */
%> --%>
<%@include file="../dbconn.jsp" %>
<%
  //상품id값을 받아온다.
  String productId = request.getParameter("id");

  PreparedStatement pstmt = null;
  ResultSet rs = null;

  String sql = "select * from product where p_id = ?";
  pstmt = conn.prepareStatement(sql);
  pstmt.setString(1, productId);
  rs = pstmt.executeQuery();
  if(rs.next()){
%>
<div class="container">
  <div class="row">
    <div class="col-md-5">
      <img src="${pageContext.request.contextPath}/resource/upload/<%= rs.getString("p_fileName") %>"
           style="width: 100%">
    </div>

    <div class="col-md-6">
      <h3><%= rs.getString("p_name") %></h3>
      <p><%= rs.getString("p_description") %></p>
      <p><b>상품 코드 : </b><span class="badge badge-danger"><%= rs.getString("p_id") %></span></p>
      <p><b>제조사 : </b><%= rs.getString("p_manufacturer") %></p>
      <p><b>분류 : </b><%= rs.getString("p_category") %></p>
      <p><b>재고 수량 : </b><%= rs.getString("p_unitsInStock") %></p>
      <h4><%= rs.getString("p_unitPrice") %>원</h4>

      <p><form name="addForm" action="../cart/addCart.jsp?id=<%= rs.getString("p_id") %>"
               method="POST">
      <a href="#" class="btn btn-info" onclick="addToCart()">상품 주문&raquo;</a>
      <a href="../cart/cart.jsp" class="btn btn-warning">장바구니&raquo;</a>
      <a href="../products.jsp" class="btn btn-secondary">상품 목록&raquo;</a>
    </form>
    </div>
    <%
      }
      if(rs != null) rs.close();
      if(pstmt != null) pstmt.close();
      if(conn != null) conn.close();
    %>
  </div>
  <hr>
</div>
<jsp:include page="../layout/footer.jsp" />
</body>
</html>