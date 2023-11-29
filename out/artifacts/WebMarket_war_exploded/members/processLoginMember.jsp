<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8"%>
   <!-- 태그 라이브러리 선언 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%
	//로그인 정보 가져오기
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	String password = request.getParameter("password");
%>

<!-- jstl태그 라이브러리의 sql태그를 이용하여 DB접속 -->
<sql:setDataSource var="dataSource" 
	url="jdbc:mysql://localhost:3306/webmarketdb"
	driver="com.mysql.jdbc.Driver"
	user="root" password="1234" />
	
<!-- sql쿼리문을 실행하는 코드, executeQuery()역할을 한다 -->
<sql:query dataSource="${dataSource}" var="resultSet">
	select * from members where id =? and password =?
	<sql:param value="<%= id %>" />
	<sql:param value="<%= password %>" />
</sql:query>

<c:forEach var="row" items="${resultSet.rows}">
	<%
		session.setAttribute("sessionId", id);
	%>
	<c:redirect url="resultMember.jsp?msg=2" />
</c:forEach>

<c:redirect url="loginMember.jsp?error=1" />