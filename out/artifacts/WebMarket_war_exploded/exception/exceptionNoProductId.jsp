<%--
  Created by IntelliJ IDEA.
  User: qpwoe
  Date: 2023-11-10
  Time: 오전 10:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="../resource/css/bootstrap.min.css"/>
    <title>상품 아이디 오류</title>

</head>
<body>
    <jsp:include page="../layout/menu.jsp"/>
    <div class="jumbotron">
        <div class="container">
            <h2 class = "alert alert-danger">해당 상품이 존재하지 않습니다.</h2>
        </div>
    </div>
    <div class="container">
        <p><%=request.getRequestURL()%>?<%=request.getQueryString()%></p>
        <p> <a href="../products.jsp" class = "btn btn-secondary"> 상품목록 &raquo;</a></p>
    </div>

</body>
</html>
