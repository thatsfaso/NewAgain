<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
	Cart cart = (Cart) request.getAttribute("cart");
%>
<%@ page contentType="text/html; charset=UTF-8" import="java.util.*,it.unisa.model.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Conferma</title>
</head>
<body>
	<form action="acquista" method="post">
    <input type="hidden" name="action" value="completa">
    <input type="hidden" name="email" value="<%= session.getAttribute("email") %>">
    <h2>Conferma ordine</h2>
    <input type="hidden" name="Tipocons" value="<%= request.getAttribute("TipoC") %>">
    <p>Tipo di consegna: <%= request.getAttribute("TipoC") %></p>
    <%
    String tipoc = (String) request.getAttribute("TipoC");
    if(tipoc.equals("Consegna a casa")) {%>
    <label>Indirizzo:</label>
    				<input type="hidden" name="indirizzo" value="<%= session.getAttribute("indirizzo") %>">
   					<%= session.getAttribute("indirizzo") %>
   					<input type="hidden" name="citta" value="<%= session.getAttribute("citta") %>">
                    <%= session.getAttribute("citta") %>
                    <input type="hidden" name="provincia" value="<%= session.getAttribute("provincia") %>">
                    <%= session.getAttribute("provincia") %>
                    <input type="hidden" name="cap" value="<%= session.getAttribute("cap") %>">
                    <%= session.getAttribute("cap") %>
    <%}
    else if(tipoc.equals("Altro indirizzo")){ %>
    				<input type="hidden" name="indirizzo" value="<%= request.getAttribute("indirizzo") %>">
   				    <%= request.getAttribute("indirizzo") %>
   				    <input type="hidden" name="citta" value="<%= request.getAttribute("citta") %>">
                    <%= request.getAttribute("citta") %>
                    <input type="hidden" name="provincia" value="<%= request.getAttribute("provincia") %>">
                    <%= request.getAttribute("provincia") %>
                    <input type="hidden" name="cap" value="<%= request.getAttribute("cap") %>">
                    <%= request.getAttribute("cap") %>    	
    <% }
    %>
    
    <input type="hidden" name="Pagamento" value="<%= request.getAttribute("Pagamento") %>">
    Metodo di Pagamento: <%= request.getAttribute("Pagamento") %>
    <%
    String pagamento = (String) request.getAttribute("Pagamento");
    if(pagamento.equals("Carta di credito")) {%>
    <input type="hidden" name="NumeroC" value="<%= request.getAttribute("numeroCarta") %>">
    <p>Numero Carta: <%= request.getAttribute("numeroCarta") %></p>
    <input type="hidden" name="TitolareC" value="<%= request.getAttribute("card-holder") %>">
    <p>Titolare Carta: <%= request.getAttribute("card-holder") %></p>
    <input type="hidden" name="ScadenzaC" value="<%= request.getAttribute("scadenzaCarta") %>">
    <p>Scadenza Carta: <%= request.getAttribute("scadenzaCarta") %></p>
    <input type="hidden" name="cvv" value="<%= request.getAttribute("cvv") %>">
    <p>CVV: <%= request.getAttribute("cvv") %></p>
    <%} %>
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
<input type="submit" value="Invia">
</form>
</body>
</html>

