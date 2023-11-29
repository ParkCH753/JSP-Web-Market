<%@ page import="dto.Product" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dao.ProductRepository" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<jsp:useBean id="productDAO" class ="dao.ProductRepository" scope="session"/>
<html>
<head>
  <link rel="stylesheet" href="./resource/css/bootstrap.min.css"/>
    <title>상품 목록</title>
</head>
<body>
    <jsp:include page="layout/menu.jsp"/>
    <div class="jumbotron">
      <div class="container">
        <h1 class="display-3">상품 목록</h1>
      </div>
    </div>
    <%
        ProductRepository dao = ProductRepository.getInstance();
        ArrayList<Product> listOfProducts = dao.getAllProducts();
    %>
    <div class = "container">
        <div class="row" align="center" >
            <!-- db연동 -->
            <%@include file="dbconn.jsp" %>
            <%
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                String sql = "select * from product";
                pstmt = conn.prepareStatement(sql);
                //쿼리문 결과 받아온다.
                rs = pstmt.executeQuery();

                while(rs.next()){

            %>
            <div class="col-md-4">
                <%-- <img src="c:/upload/<%= rs.getString("p_fileName") %>" style="width: 100%" /> --%>
                <img src="${pageContext.request.contextPath}/resource/upload/<%= rs.getString("p_fileName") %>" style="width: 100%">
                <h3><%= rs.getString("p_name") %></h3>
                <p><%= rs.getString("p_description") %></p>
                <p><%= rs.getString("p_UnitPrice") %>원</p>

                <!-- 상품의 ID에 대한 상세정보 페이지를 연결 -->
                <p><a href="./product/product.jsp?id=<%= rs.getString("p_id") %>"
                      class="btn btn-secondary" role="button">상세 정보 &raquo;</a></p>
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
    <jsp:include page="layout/footer.jsp"/>
</body>
</html>
