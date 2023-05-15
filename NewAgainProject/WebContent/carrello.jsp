<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.Base64" %>

<%
	Cart cart = (Cart) request.getAttribute("cart");
%>

<!DOCTYPE html>
<html>
<%@ page contentType="text/html; charset=UTF-8" import="java.util.*,it.unisa.model.*"%>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="ProductStyle.css" rel="stylesheet" type="text/css">
	<title>Cart</title>
	<style>
	footer {
  text-align: center;
  padding: 3px;
  background-color: DarkSalmon;
  color: white;
}
	
	</style>
</head>

<body>
	<% if(cart != null) { %>
		<h2>Cart</h2>
		<table border="1">
		<tr>
			<th>Foto</th>
			<th>ID</th>
			<th>Descrizione</th>
			<th>Azione</th>
		</tr>
		<%  	
		   for(Prodotto p: cart.getProducts()){
			   byte[] imageB = p.getImg();
			   String base64img = "";
			   if(imageB != null){
			      base64img = Base64.getEncoder().encodeToString(imageB);
			   }
		%>
		<tr>
			<td><img src="data:image/jpg;base64, <%=base64img%>"  width="200" height="200"></td>
			<td><%= p.getID() %></td>
			<td><%=p.getDescrizione()%></td>
			<td><a href="product?action=deleteC&id=<%=p.getID()%>">Delete from cart</a></td>
		</tr>
		<%} %>
	</table>		
	<% 
	} 
	%>	
	<a href="Home.jsp">Back</a>
	<br><br><br>
	<jsp:include page="footer.jsp"/>
</body>
</html>