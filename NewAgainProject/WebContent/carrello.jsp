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
	html, body{
		width: 100%;
		background-color: #f6f5f7;
	}
	footer {
  text-align: center;
  padding: 3px;
  background-color: DarkSalmon;
  color: white;
}
 .container {
        display: flex;
        width: 100%;
    }

    .left-column {
        width: 50%;
        display: flex;
        flex-wrap: wrap;
        align-items: flex-start;
        background-color: #f6f5f7;
        flex-direction: column;
        text-align: center;
        height: 200vh;
    }

    .right-column {
        flex: 1;
        display: flex;
        flex-direction: column;
        justify-content: flex-start;
        align-items: flex-start;
        background-color: #FF4B2B;
        height: 200vh;
    }
        #address-form {
            flex-grow: 1;
        }
	
	.cart-table {
        border-collapse: separate;
        border-spacing: 0;
        border: none;
    }
    .cart-table td,
    .cart-table th {
        border: none; /* Rimuove i bordi dalle celle */
        padding: 10px;
    }
    .logo-container {
    display: flex;
    justify-content: center;
    align-items: center; 
    margin-top: 20px;
}

	</style>
</head>

<body>

<div class="container">
<div class="left-column">
<div class="logo-container">
    <a href="Home.jsp"><img src="logo.png" width=50px></a>
    </div>
    <br><br>
    <!-- se è registrato, non richiedere il login -->
    <h2>Scelta Consegna</h2>

    <table>
  <tr>
    <th>Opzione</th>
    <th>Descrizione</th>
  </tr>
  <% if((session.getAttribute("indirizzo") != null) &&
        (session.getAttribute("citta") != null) &&
        (session.getAttribute("provincia") != null) &&
        (session.getAttribute("cap") != null)) { %>
  <tr id="address-form-row">
    <td>
      <input type="radio" name="delivery-option" id="existing-address-option" value="existing-address" onclick="hideAddressForm()">
      <br>
      <label for="existing-address-option">Consegna a Casa</label>
    </td>
    <td>
      <%= session.getAttribute("indirizzo") %>
      <%= session.getAttribute("citta") %>
      <%= session.getAttribute("provincia") %>
      <%= session.getAttribute("cap") %>
    </td>
  </tr>
  <% } %>
  <tr>
    <td>
      <input type="radio" name="delivery-option" id="delivery-option" value="home" onclick="showAddressForm()"><br>
      <label for="delivery-option">Consegna a un altro indirizzo</label>
    </td>
    <td>
      Seleziona questa opzione se desideri ricevere la consegna a un altro indirizzo
    </td>
  </tr>
  <tr>
    <td>
      <input type="radio" name="delivery-option" id="pickup-option" value="pickup" onclick="hideAddressForm()">
      <br>
      <label for="pickup-option">Punto di Ritiro</label>
    </td>
    <td>
      Seleziona questa opzione se desideri ritirare il prodotto presso un punto di ritiro.
    </td>
  </tr>
</table>

    <div id="address-form">
    <br><br><br><br>
      <h3>Inserisci i Recapiti per la Consegna</h3>

      <form>
        <label for="citta">Citta:</label>
        <input type="text" id="citta" name="citta"><br>
		<label for="cap">CAP:</label>
        <input type="text" id="cap" name="cap"><br>
        <label for="provincia">Provincia:</label>
        <input type="text" id="provincia" name="provincia"><br>
        <label for="address">Indirizzo:</label>
        <input type="text" id="address" name="address"><br>
        <input type="submit" value="Conferma Consegna">
      </form>
    </div>
  </div>
<div class="right-column">
	<% double prezzotot=0;
	if(cart != null) { %>
		
		<table class="cart-table" border="1">
  <%  	
     for(Prodotto p: cart.getProducts()){
       byte[] imageB = p.getImg();
       String base64img = "";
       if(imageB != null){
          base64img = Base64.getEncoder().encodeToString(imageB);
       }
       int quantity = 1;
       int maxQuantity = p.getQuantita(); // Ottieni il valore massimo
  %>
  <tr data-product-id="<%=p.getID()%>">
    <td><img src="data:image/jpg;base64, <%=base64img%>"  width="100" height="100"></td>
    <td><%= p.getNome() %></td>
    <td>
      <select class="quantity custom-select" onchange="updateTotal(this, <%=p.getPrezzo()%>)">
        <% for(int i=1; i<=p.getQuantita(); i++) { %>
        <option value="<%= i %>"><%= i %></option>
        <% } %>
      </select>
    </td>
    <td><span id="totalPrice_<%=p.getID()%>"><%=p.getPrezzo()%></span></td>
  </tr>
  <%} %>
</table>

<% 
  if(cart != null) {
%>
<div class="total-price">
  <h3>Total: <span id="cartTotal"></span></h3>
</div>

<%}} %>	
	</div></div>	
	<br><br><br>
	<jsp:include page="footer.jsp"/>
    <script>
  		function showAddressForm() {
    		var addressForm = document.getElementById("address-form");
    		addressForm.style.display = "block";
  			}

  		function hideAddressForm() {
    		var addressForm = document.getElementById("address-form");
    		addressForm.style.display = "none";
  		}

       function calculateTotal() {
         var totalPriceElements = document.querySelectorAll("[id^='totalPrice_']");
         var total = 0;

         totalPriceElements.forEach(function(element) {
           var price = parseFloat(element.textContent);
           total += price;
         });

         return total.toFixed(2);
       }

       function updateCartTotal() {
         var cartTotalElement = document.getElementById("cartTotal");
         var total = calculateTotal();
         cartTotalElement.textContent = total;
       }

       function updateTotal(selectElement, price) {
         var quantity = parseInt(selectElement.value);
         var totalPriceElement = document.getElementById("totalPrice_" + selectElement.parentNode.parentNode.getAttribute("data-product-id"));
         var totalPrice = quantity * price;
         totalPriceElement.textContent = totalPrice.toFixed(2);
         updateCartTotal(); // Aggiorna il totale del carrello
       }

       // Chiamata iniziale per visualizzare il totale all'avvio della pagina
       updateCartTotal();
     </script>
</body>
</html>