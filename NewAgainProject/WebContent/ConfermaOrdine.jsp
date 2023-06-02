<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
	Cart cart = (Cart) request.getAttribute("cart");
%>
<%@ page contentType="text/html; charset=UTF-8" import="java.util.*,it.unisa.model.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Risultato</title>
</head>
<body>
    <h2>Risultato</h2>
    <p>Metodo di Pagamento: <%= request.getAttribute("Pagamento") %></p>
    <p>Numero Carta: <%= request.getAttribute("numeroCarta") %></p>
    <p>Titolare Carta: <%= request.getAttribute("card-holder") %></p>
    <p>Scadenza Carta: <%= request.getAttribute("scadenzaCarta") %></p>
    <p>CVV: <%= request.getAttribute("cvv") %></p>
    <%if(cart != null) { %>
		
		<table class="cart-table" border="1" id="table1">
  <%  	
     for(Prodotto p: cart.getProducts()){
       byte[] imageB = p.getImg();
       String base64img = "";
       if(imageB != null){
          base64img = Base64.getEncoder().encodeToString(imageB);
       }
  %>
  <tr data-product-id="<%=p.getID()%>">
    <td><img src="data:image/jpg;base64, <%=base64img%>"  width="100" height="100"></td>
    <td><%= p.getNome() %></td>
	<td><span id="totalPrice_<%=p.getID()%>"><%=p.getPrezzo()%></span></td>

  </tr>
  <%} }%>
  
</table>


<div class="total-price">
  <h3>Total: <span id="cartTotal"></span></h3>
</div>
</body>
</html>

