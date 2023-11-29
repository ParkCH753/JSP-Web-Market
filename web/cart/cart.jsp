<%@ page import="dto.Product" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: qpwoe
  Date: 2023-11-17
  Time: 오전 11:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <link rel="stylesheet" href="../resource/css/bootstrap.min.css"/>
  <%
    String cartId = session.getId();
  %>
  <title>장바구니</title>
</head>
<body>
<jsp:include page="../layout/menu.jsp" />
<div class="jumbotron">
  <div class="container">
    <h1 class="display-3"> 장바구니</h1>
  </div>
</div>
<div class="container">
  <div class="row">
    <table width="100%">
      <tr>
        <td align="left"> <a href="deleteCart.jspartId=<%=cartId%>" class="btn btn-danger">삭제하기</a></td>
        <td align="right"><a href="../shippingInfo.jsp?cartId=<%=cartId%>" class="btn btn-success">주문하기</a></td>
      </tr>
    </table>
  </div>
<div style="padding-top: 50px">
  <table class="table table-hover">
    <tr>
      <th>상품</th>
      <th>가격</th>
      <th>수량</th>
      <th>소계</th>
      <th>비고</th>
    </tr>
    <%
      int sum=0;
      ArrayList<Product> cartList = (ArrayList<Product>) session.getAttribute("cartlist");
      session.getAttribute("cartlist");
      if(cartList == null)
        cartList = new ArrayList<Product>();

      for (int i=0; i<cartList.size();i++) {
        // 상품 리스트 하나씩 출력하기
        Product product = cartList.get(i);
        int total = product.getUnitPrice() * product.getQuantity();
        sum += total;
    %>
    <tr>
      <td><%=product.getProductId()%> - <%=product.getPname()%></td>
      <td><%=product.getUnitPrice()%></td>
      <td><%=product.getQuantity()%></td>
      <td><%=total%></td>
      <td><a href="removeCart.jspd=<%=product.getProductId()%>" class="badge badge-danger">삭제</a></td>
    </tr>
    <%
      }
    %>
    <tr>
      <th></th>
      <th></th>
      <th>총액</th>
      <th><%=sum%></th>
      <th></th>
    </tr>
  </table>
  <a href="../products.jsp" class="btn btn-secondary"> &laquo; 쇼핑 게속하기</a>
</div>
<hr>
</div>
<jsp:include page="../layout/footer.jsp"/>
</body>
</html>
