<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
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
	String month = request.getParameter("birthmm");
	String day = request.getParameter("birthdd");
	String birth = year + "/" + month + "/" + day;
	
	String mail1 = request.getParameter("mail1");
	String mail2 = request.getParameter("mail2");
	String mail = mail1 + "@" + mail2;
	
	String phone = request.getParameter("phone");
	String address = request.getParameter("address");
	
	SimpleDateFormat sDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String regist_day = sDateFormat.format(new Date());
	
%>

<sql:setDataSource var="dataSource" 
	url="jdbc:mysql://localhost:3306/webmarketdb"
	driver="com.mysql.jdbc.Driver"
	user="root" password="1234" />
	
<sql:update dataSource="${dataSource}" var="resultSet">
	insert into members values(?,?,?,?,?,?,?,?,?);
	<sql:param value="<%= id %>"/>
	<sql:param value="<%= password %>"/>
	<sql:param value="<%= name %>"/>
	<sql:param value="<%= gender %>"/>
	<sql:param value="<%= birth %>"/>
	<sql:param value="<%= mail %>"/>
	<sql:param value="<%= phone %>"/>
	<sql:param value="<%= address %>"/>
	<sql:param value="<%= regist_day %>"/>
</sql:update>

<c:if test="${resultSet >= 1 }">
	<c:redirect url="resultMember.jsp?msg=1" />
</c:if>