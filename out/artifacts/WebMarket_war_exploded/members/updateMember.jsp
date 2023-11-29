<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %> 
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../resource/css/bootstrap.min.css" />

<%
	String sessionId = (String)session.getAttribute("sessionId");
%>

<sql:setDataSource var="dataSource" 
	url="jdbc:mysql://localhost:3306/webmarketdb"
	driver="com.mysql.jdbc.Driver"
	user="root" password="1234" />
	
<!-- sql쿼리문을 실행하는 코드, executeQuery()역할을 한다 -->
<sql:query dataSource="${dataSource}" var="resultSet">
	select * from members where id =?
	<sql:param value="<%= sessionId %>" />
</sql:query>

<meta charset="UTF-8">
<title>회원 정보 수정</title>
</head>
<body onload="init()">
<jsp:include page="../layout/menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">정보 수정</h1>
		</div>
	</div>
	
	<!-- 메일을 가져와서 String타입으로 되어 있어 @를 기준으로 split을 하고 있다.split()은 String[]타입으로 리턴한다. -->
	<c:forEach var="row" items="${resultSet.rows}">
		<c:set var="mail" value="${row.mail}" />
		<c:set var="mail1" value="${mail.split('@')[0]}" />
		<c:set var="mail2" value="${mail.split('@')[1]}" />
		
		<c:set var="birth" value="${row.birth}" />
		<c:set var="year" value="${birth.split('/')[0]}" />
		<c:set var="month" value="${birth.split('/')[1]}" />
		<c:set var="day" value="${birth.split('/')[2]}" />
		
		<c:set var="gender" value="${row.gender}" />
	
		
		<div class="container">
			<form name="newMember" action="processUpdateMember.jsp" class="form-horizontal" method="POST" 
					onsubmit="return checkForm()">
				<div class="form-group row">
					<label class="col-sm-2">아이디</label>
					<div class="col-sm-3">
						<input name="id" type="text" class="form-control" placeholder="아이디" 
								value="<c:out value='${row.id}'/>" readonly>
					</div>
				</div>
				
				<div class="form-group row">
					<label class="col-sm-2">비밀번호</label>
					<div class="col-sm-3">
						<input name="password" type="password" class="form-control" placeholder="비밀번호"
								value="<c:out value='${row.password}'/>">
					</div>
				</div>
				
				<div class="form-group row">
					<label class="col-sm-2">비밀번호 확인</label>
					<div class="col-sm-3">
						<input name="password_confirm" type="password" class="form-control" placeholder="비밀번호 확인">
					</div>
				</div>
				
				<div class="form-group row">
					<label class="col-sm-2">이름</label>
					<div class="col-sm-3">
						<input name="name" type="text" class="form-control" placeholder="이름"
								value="<c:out value='${row.name}'/>">
					</div>
				</div>
				
				<div class="form-group row">
					<label class="col-sm-2">성별</label>
					<div class="col-sm-10">
						<input name="gender" type="radio" value="남" 
							<c:if test="${gender.equals('남')}" > <c:out value="checked" /></c:if>>남
						<input name="gender" type="radio" value="여" 
							<c:if test="${gender.equals('여')}" > <c:out value="checked" /></c:if>>여
					</div>
				</div>
				
				<div class="form-group row">
					<label class="col-sm-2">생년월일</label>
					<div class="col-sm-4">
						<input name="birthyy" type="text" maxlength="4" placeholder="년도(4자리)" size="6" 
								value="${year}" />
						<select name="birthmm" id="birthmm">
							<option value="">월</option>
							<option value="01">1</option>
							<option value="02">2</option>
							<option value="03">3</option>
							<option value="04">4</option>
							<option value="05">5</option>
							<option value="06">6</option>
							<option value="07">7</option>
							<option value="08">8</option>
							<option value="09">9</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
						</select>
						<input type="text" name="birthdd" maxlength="2" placeholder="일" size="4" 
								value="${day}"/>
					</div>
				</div>
				
				
				<div class="form-group row">
					<label class="col-sm-2">이메일</label>
					<div class="col-sm-10">
						<input name="mail1" type="text" maxlength="50" value="${mail1}">@
						<select name="mail2" id="mail2" >
							<option>naver.com</option>
							<option>gmail.com</option>
							<option>daum.net</option>
							<option>nate.com</option>
							</select>
						</div>
					</div>
					
				<div class="form-group row">
					<label class="col-sm-2">전화번호</label>
					<div class="col-sm-3">
						<input name="phone" type="text" class="form-control" placeholder="전화번호-(생략)"
								value="${row.phone}">
					</div>
				</div>
				
				<div class="form-group row">
					<label class="col-sm-2">주소</label>
					<div class="col-sm-3">
						<input name="address" type="text" class="form-control" placeholder="시/도/구"
								value="${row.address}">
					</div>
				</div>
				
				<div class="form-group row">
					<div class="col-sm-offset-2 col-sm-10">
						<input type="submit" class="btn btn-primary" value="수정 완료">
						<input type="button" class="btn btn-danger" value="회원 탈퇴" onclick="return delete_member()">
						<!-- <a href="deleteMember.jsp" class="btn btn-danger">회원탈퇴</a> -->
					</div>
				</div>
			</form>
		</div>
	</c:forEach>
</body>
<script type="text/javascript">
	
	function init() {
		setComboMailValue("${mail2}");
		setComboBirthValue("${month}");
	}
	/* select태그에서 선택한 option의 value를 가져오기 */
	function setComboMailValue(val) {
		var selectMail = document.getElementById('mail2');
		for(var i=0, j=selectMail.length; i<j; i++){
			/* 매개변수로 넘어온 val이라는 값과 select태그의 값이 동일하다면
			그 부분이 select되었다고 true로 설정하고 빠져나온다. */
			if(selectMail.options[i].value == val){
				selectMail.options[i].selected = true;
				break;			
			}
		}		
	}
	/* select태그에서 선택한 option의 value를 가져오기 */
	function setComboBirthValue(val) {
		var selectBirth = document.getElementById('birthmm');
		for(var i=0, j=selectBirth.length; i<j; i++){
			/* 매개변수로 넘어온 val이라는 값과 select태그의 값이 동일하다면
			그 부분이 select되었다고 true로 설정하고 빠져나온다. */
			if(selectBirth.options[i].value == val){
				selectBirth.options[i].selected = true;
				break;			
			}
		}		
	}
	
	function checkForm() {
		if(!document.newMember.id.value){
			alert("id를 입력하세요.");
			return false;
		}
		
		if(!document.newMember.password.value){
			alert("비밀번호를 입력하세요.");
			return false;
		}
		if(!document.newMember.password.value != !document.newMember.password_confirm.value ){
			alert("비밀번호를 동일하게 입력하세요!");
			return false;
		}
	}
	

	function delete_member() {
		var result = confirm("정말 회원탈퇴를 하시겠습니까?");
		if(result){
			location.href="deleteMember.jsp";
			alert("탈퇴되었습니다.");
		}
		else {
			alert("취소되었습니다.");
			return;
		}
	}
</script>
</html>


