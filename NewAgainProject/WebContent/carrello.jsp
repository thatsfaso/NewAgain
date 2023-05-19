<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.Base64" %>

<%
	Cart cart = (Cart) request.getAttribute("cart");
%>

<!DOCTYPE html>
<html lang="it">
<%@ page contentType="text/html; charset=UTF-8" import="java.util.*,it.unisa.model.*"%>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="CartStyle.css" rel="stylesheet" type="text/css">
	<title>Cart</title>
	<style>

* {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

html, body {
  width: 100%;
  background-color: #f5f5f7;
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
  height: 220vh;
  padding: 20px;
}

.right-column {
  flex: 1;
  display: flex;
  flex-direction: column;
  justify-content: flex-start;
  align-items: flex-start;
  background-color: #FF6848;
  height: 220vh;
  padding: 20px;
}

.logo-container {
  display: flex;
  justify-content: center;
  align-items: center;
  /*! margin-top: 20px; */
}

h2 {
  color: #333;
  font-size: 24px;
  margin-bottom: 20px;
}

table {
  width: 100%;
  border-collapse: collapse;
  margin-bottom: 20px;
  border-radius: 20px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
}

th, td {
  padding: 10px;
  text-align: left;
}

th {
  padding: 10px;
  background-color: #333;
  color: #1B1B1B;
}

input[type="radio"] {
  margin-right: 5px;
}

form {
  margin-top: 20px;
}

label {

  display: block;
  margin-bottom: 5px;
}

input[type="text"] {
  width: 100%;
  padding: 5px;
  margin-bottom: 10px;
}

input[type="submit"] {
  background-color: #333;
  color: #fff;
  border: none;
  padding: 10px 20px;
  cursor: pointer;
  transition: all 0.3s ease-in-out;
}

input[type="submit"]:hover {
  background-color: #FF6848;
  border-radius: 14px;
}

.total-price {
  margin-top: 20px;
}

.total-price h3 {
  color: #fff;
  font-size: 18px;
}

@media (max-width: 768px) {
  .container {
    flex-direction: column;
  }

  .left-column,
  .right-column {
    width: 100%;
  }
}

	</style>
</head>

<body>

<div class="container">
<div class="left-column">
    <div class="logo-container">
        <a href="Home.jsp"><img src="nuovologo.png" width="130px"></a>
    </div>
    <br><br>
    <h2>Tipo di Consegna</h2>

    <table>
        <% if((session.getAttribute("indirizzo") != null) &&
            (session.getAttribute("citta") != null) &&
            (session.getAttribute("provincia") != null) &&
            (session.getAttribute("cap") != null)) { %>
            <tr id="address-form-row">
                <td>
                    <input type="radio" name="delivery-option" id="existing-address-option" value="existing-address" onclick="hideAddressForm()">  
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
                <label for="delivery-option">Altro indirizzo</label>
            </td>
            <td>
                Seleziona questa opzione se desideri ricevere la consegna ad un altro indirizzo
            </td>
        </tr>
        <tr>
            <td>
                <input type="radio" name="delivery-option" id="pickup-option" value="pickup" onclick="hideAddressForm()">
                <label for="pickup-option">Punto di Ritiro</label>
            </td>
            <td>
                Seleziona questa opzione se desideri ritirare il prodotto presso un punto di ritiro.
            </td>
        </tr>
    </table>

   <div id="address-form" style="display: none; margin: 0 auto; width: 80%;">
        <br>

        <form>
            <input type="text" id="address" name="address" placeholder="Indirizzo"><br>
            <input type="text" id="citta" name="citta" placeholder="Città"><br>
            <input type="text" id="cap" name="cap" placeholder="CAP" maxlength="5"><br>
            <input type="text" id="provincia" name="provincia" placeholder="Provincia" maxlength="2"><br>

            <input type="submit" value="Conferma">
        </form>
        <br><br>
    </div>
    <br>
    <h2>Metodo di Pagamento</h2>
     <table>
    <tr>
        <td>
            <input type="radio" name="Pagamento" id="CartaDiCredito" value="Carta di credito" onclick="mostraFormCarta()">
            <label for="CartaDiCredito">Carta di Credito</label>
        </td>
        <td style="text-align: right;">
          <img alt="" src="https://cdn.shopify.com/shopifycloud/checkout-web/assets/0169695890db3db16bfe.svg" role="img" width="48" height="34">
            <img alt="" src="https://cdn.shopify.com/shopifycloud/checkout-web/assets/ae9ceec48b1dc489596c.svg" role="img" width="48" height="34">
            <img alt="" src="https://cdn.shopify.com/shopifycloud/checkout-web/assets/37fc65d0d7ac30da3b0c.svg" role="img" width="48" height="34">
        </td>
    </tr>
    <tr>
        <td>
            <input type="radio" name="Pagamento" id="Paypal" value="Paypal" onclick="nascondiFormCarta()">
            <label for="Paypal">Paypal</label>
        </td>
        <td style="text-align: right;">
            <img alt="" src="https://cdn.pixabay.com/photo/2015/05/26/09/37/paypal-784404_1280.png" role="img" width="90" height="50">
        </td>
    </tr>
    <tr>
        <td>
            <input type="radio" name="Pagamento" id="ApplePay" value="ApplePay" onclick="nascondiFormCarta()">
            <label for="ApplePay">Apple Pay</label>
        </td>
        <td style="text-align: right;">
            <img alt="" src="https://upload.wikimedia.org/wikipedia/commons/thumb/b/b0/Apple_Pay_logo.svg/1024px-Apple_Pay_logo.svg.png?20170518220303" role="img" width="75" height="30">
        </td>
    </tr>
</table>
<form id="formCarta" style="display: none;">
              <input type="text" id="card-number" name="card-number" placeholder="Numero carta" maxlength="16" required>
              <br>
              <input type="text" id="card-holder" name="card-holder" placeholder="Nome titolare" maxlength="255" required>
              <br>
              <input type="text" id="expiration-date" name="expiration-date" placeholder="MM/AA" maxlength="5" required>
  			  <br>
              <input type="text" id="cvv" name="cvv" placeholder="CVV" maxlength="3" required>
              <br><br>
              <input type="submit" value="Conferma">
            </form>
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
 // Aggiungi automaticamente il carattere "/" nel campo "Data scadenza" dopo i due cifre del mese (MM)
    document.getElementById('expiration-date').addEventListener('input', function () {
      const input = this.value.replace(/\D/g, ''); // Rimuovi tutti i caratteri non numerici
      const month = input.slice(0, 2);
      const year = input.slice(2, 4);
      this.value = `${month}/${year}`;

      // Controllo se il mese è valido (inferiore a 12)
      if (parseInt(month) > 12) {
        this.setCustomValidity('Il mese inserito non è valido');
      } else {
        this.setCustomValidity('');
      }
      // Controllo se l'anno è valido (>23 & <30)
      if (parseInt(year) < 23 || parseInt(year) > 30) {
        this.setCustomValidity('L\'anno inserito non è valido');
    this.setCustomValidity('');
  }
    });

    // Limita il numero di cifre nel campo "Numero carta" a 16
    document.getElementById('card-number').addEventListener('input', function () {
      if (this.value.length > 16) {
        this.value = this.value.slice(0, 16);
      }
    });

    // Limita il numero di cifre nel campo "CVV" a 3
    document.getElementById('cvv').addEventListener('input', function () {
      if (this.value.length > 3) {
        this.value = this.value.slice(0, 3);
      }
    });

    function mostraFormCarta() {
      var formCarta = document.getElementById("formCarta");
      formCarta.style.display = "block";
    }

    function nascondiFormCarta() {
      var formCarta = document.getElementById("formCarta");
      formCarta.style.display = "none";
    }
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