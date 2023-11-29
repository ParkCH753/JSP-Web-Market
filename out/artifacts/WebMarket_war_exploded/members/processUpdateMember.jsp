<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	String name = request.getParameter("name");
	String gender = request.getParameter("gender");
	
	String year = request.getParameter("birthyy");
	String month = request.getParameterValues("birthmm")[0];
	String day = request.getParameter("birthdd");
	String birth = year + "/" + month + "/" + day;
	
	String mail1 = request.getParameter("mail1");
	String mail2 = request.getParameterValues("mail2")[0];
	String mail = mail1 + "@" + mail2;
	
	String phone = request.getParameter("phone");
	String address = request.getParameter("address");
	
/* 	SimpleDateFormat sDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String regist_day = sDateFormat.format(new Date()); */
	
%>
<!-- jstl태그라이브러리의 sql태그를 이용하여 DB에 접속한다. -->
<sql:setDataSource var="dataSource" 
	url="jdbc:mysql://localhost:3306/webmarketdb"
	driver="com.mysql.jdbc.Driver"
	user="root" password="1234" />
	
<!-- jstl태그라이브러리의 sql태그를 이용하여 DB에 데이터를 수정하는 코드 update는 수정,삽입, 삭제 가능하다. -->
<sql:update dataSource="${dataSource}" var="resultSet">
	update members set password = ?, name=?, gender=?, birth=?, mail=?, phone=?, address=? where id=?;
	<sql:param value="<%= password %>"/>
	<sql:param value="<%= name %>"/>
	<sql:param value="<%= gender %>"/>
	<sql:param value="<%= birth %>"/>
	<sql:param value="<%= mail %>"/>
	<sql:param value="<%= phone %>"/>
	<sql:param value="<%= address %>"/>
	<sql:param value="<%= id %>"/>
</sql:update>

<c:if test="${resultSet >= 1 }">
	<c:redirect url="resultMember.jsp?msg=0" />
</c:if>