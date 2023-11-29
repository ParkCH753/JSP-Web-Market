<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="java.sql.*"%>
<%@ include file="../dbconn.jsp" %>

<%
  String filename="";
  String realFolder = "C:\\Users\\qpwoe\\Desktop\\jsp-project\\WebMarket\\web\\resource\\upload"; //웹 어플리케이션에서 절대경로
  String encType = "utf-8";  //인코딩 유형
  int maxSize = 10 * 1024 * 1024; //최대 업로드 크기(10M)

  MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize,
          encType, new DefaultFileRenamePolicy());

  //updateProduct.jsp에서 사용자가 입력한 부분을 받아서 저장을 하고 있다.
  String productId = multi.getParameter("productId");
  String name = multi.getParameter("name");
  String unitPrice = multi.getParameter("unitPrice");
  String description = multi.getParameter("description");
  String manufacturer = multi.getParameter("manufacturer");
  String category = multi.getParameter("category");
  String unitsInStock = multi.getParameter("unitsInStock");
  String condition = multi.getParameter("condition");

  Integer price;
  //단가(unitPrice)입력창에 미 입력시에
  if(unitPrice.isEmpty()){
    price = 0;
  }
  else{
    //String을 숫자로 변환하고 있다.
    price = Integer.valueOf(unitPrice);
  }

  long stock;

  //재고수량(unitsInStock)입력창에 미 입력시에
  if(unitsInStock.isEmpty()){
    stock = 0; //자동박싱
  }
  else{
    //String을 long타입으로 변환하고 있다.
    stock = Long.valueOf(unitsInStock);
  }

  Enumeration files = multi.getFileNames();
  String fname = (String) files.nextElement();
  String fileName = multi.getFilesystemName(fname);

  //db연동
  PreparedStatement pstmt = null;
  ResultSet rs = null;

  String sql = "select * from product where p_id = ?";
  pstmt = conn.prepareStatement(sql);
  pstmt.setString(1, productId);
  rs = pstmt.executeQuery();

  if(rs.next()){
    //이미지의 변경이 있을 시
    if(fileName != null){
      sql = "update product set p_name=?, p_unitPrice=?, p_description=?, p_manufacturer=?," +
              "p_category=?, p_unitsInStock=?, p_condition=?, p_filename=? where p_id=?";
      pstmt = conn.prepareStatement(sql);
      pstmt.setString(1,name);
      pstmt.setInt(2,price);
      pstmt.setString(3, description);
      pstmt.setString(4, manufacturer);
      pstmt.setString(5, category);
      pstmt.setLong(6, stock);
      pstmt.setString(7, condition);
      pstmt.setString(8, fileName);
      pstmt.setString(9, productId);
      pstmt.executeUpdate();
    }
    //이미지의 변경이 없을 시
    else {
      sql = "update product set p_name=?, p_unitPrice=?, p_description=?, p_manufacturer=?," +
              "p_category=?, p_unitsInStock=?, p_condition=? where p_id=?";
      pstmt = conn.prepareStatement(sql);
      pstmt.setString(1, name);
      pstmt.setInt(2,price);
      pstmt.setString(3, description);
      pstmt.setString(4, manufacturer);
      pstmt.setString(5, category);
      pstmt.setLong(6, stock);
      pstmt.setString(7, condition);
      pstmt.setString(8, productId);

      pstmt.executeUpdate();

    }
  }
  System.out.println("상품수정완료");

  //자원해제
  if(rs != null) rs.close();
  if(pstmt != null) pstmt.close();
  if(conn != null) conn.close();

  response.sendRedirect("editProduct.jsp?edit=update");

%>