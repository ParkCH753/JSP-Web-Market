<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../resource/css/bootstrap.min.css" />
<meta charset="UTF-8">
<title>회원 정보</title>
</head>
<body>
	<jsp:include page="../layout/menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">회원 정보</h1>
		</div>
	</div>
	<div class="container">
		<%
			String msg = request.getParameter("msg");
			if(msg != null){
				if(msg.equals("0")){
					out.println("<h2 class='alert alert-danger'>회원정보가 수정되었습니다.</h2>");
				} 
				//1일때는 회원가입을 했다로 인식
				else if (msg.equals("1")){
					out.println("<h2 class='alert alert-danger'>회원가입을 축하드립니다. 로그인해주세요.</h2>");
				}
				//msg가 2로 넘어오면 로그인이 되었다로 인식
				else if (msg.equals("2")){
					String loginId = (String)session.getAttribute("sessionId");
					out.println("<h2 class='alert alert-danger'>"+loginId+"님 환영합니다.</h2>");
				}
				else if (msg.equals("3")){
					out.println("<h2 class='alert alert-danger'>로그아웃 되었습니다.</h2>");
				}
			}
			else {
				out.println("<h2 class='alert alert-danger'>회원정보가 삭제되었습니다.</h2>");
			}
		%>
	</div>
</body>
</html>