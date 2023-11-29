<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	//모든 세션 삭제를 하면 로그아웃이 된다.
	session.invalidate();

	response.sendRedirect("./resultMember.jsp?msg=3");
%>