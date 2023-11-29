<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ include file="/dbconn.jsp"%>

<%
    request.setCharacterEncoding("UTF-8");

    String filename="";
    String realFolder = "C:\\Users\\qpwoe\\Desktop\\jsp-project\\WebMarket\\web\\resource\\upload"; //웹 어플리케이션 상의 절대 경로
    int maxSize = 5*1024*1024; // 최대 업로드 될 파일의 크기
    String encType="utf-8"; //인코딩 유형

    MultipartRequest multi = new MultipartRequest(request, realFolder,
            maxSize, encType, new DefaultFileRenamePolicy());

    String productId = multi.getParameter("productId");
    String name = multi.getParameter("name");
    String unitPrice = multi.getParameter("unitPrice");
    String description = multi.getParameter("description");
    String manufacturer = multi.getParameter("manufacturer");
    String category = multi.getParameter("category");
    String unitsInStock = multi.getParameter("unitsInStock");
    String condition = multi.getParameter("condition");

    Integer price;

    if (unitPrice.isEmpty())
        price=  0;
    else
        price = Integer.valueOf(unitPrice);

    long stock;

    if(unitsInStock.isEmpty())
        stock=0;
    else
        stock=Long.valueOf(unitsInStock);

    Enumeration files = multi.getFileNames();
    String fname = (String) files.nextElement();
    String fileName = multi.getFilesystemName(fname);

//db연동
    PreparedStatement pstmt = null;
    String sql = "insert into product value(?,?,?,?,?,?,?,?,?)";
    pstmt = conn.prepareStatement(sql);

    //아래 9개의 사용자로부터 입력받은 데이터를 DB에 저장을 하고 있다.
    pstmt.setString(1, productId);
    pstmt.setString(2, name);
    pstmt.setInt(3, price);
    pstmt.setString(4, description);
    pstmt.setString(5, manufacturer);
    pstmt.setString(6, category);
    pstmt.setLong(7, stock);
    pstmt.setString(8, condition);
    pstmt.setString(9, fileName);

    pstmt.executeUpdate();
    // 동일한 pid가 들어올 시 예외처리 필요


    System.out.println("상품등록완료");

    //자원해제
    if(pstmt != null) pstmt.close();
    if(conn != null) conn.close();

    response.sendRedirect("../products.jsp");
%>
