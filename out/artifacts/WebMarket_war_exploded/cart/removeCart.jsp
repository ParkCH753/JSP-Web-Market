<%@ page import="dao.ProductRepository" %>
<%@ page import="dto.Product" %>
<%@ page import="java.util.ArrayList" %>
<%
  String id = request.getParameter("id");
  if (id == null || id.trim().equals("")) {
    response.sendRedirect("products.jsp");
    return;
  }

  ProductRepository dao = ProductRepository.getInstance();

  Product product = dao.getProductById(id);
  if (product == null) {
    response.sendRedirect("exceptionNoProductId.jsp");
  }

  ArrayList<Product> cartList = (ArrayList<Product>) session.getAttribute("cartlist");
  Product goodsQnt = new Product();
  for (int i=0;i<cartList.size(); i++) {
    goodsQnt = cartList.get(i);
    if (goodsQnt.getProductId().equals(id)) {
      cartList.remove(goodsQnt);
    }
  }

  response.sendRedirect("cart.jsp");
%>