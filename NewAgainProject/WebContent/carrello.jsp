<%@ page import = "java.util.Base64" %>
<%
	Cart cart = (Cart) request.getAttribute("cart");
%>
<!DOCTYPE html>
<html lang="it">
<%@ page contentType="text/html; charset=UTF-8" import="java.util.*,it.unisa.model.*"%>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Cart</title>
	<style>
* {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

html, body {
  width: 100%;
  margin-top: 0;
  background-color: #f5f5f7;
  border: none;
  font-family: Arial, sans-serif;
}

.cont {
  display: flex;
  width: 100%;
  height: auto;
  overflow: hidden;
}

.left-column {
margin-top: 0;
  width: 50%;
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  background-color: #f6f5f7;
  flex-direction: column;
  text-align: center;
  padding: 20px;
  height: auto;
}

.right-column {
  flex: 1;
  display: flex;
  flex-direction: column;
  justify-content: flex-start;
  align-items: flex-start;
  background-color: #FF6848;
  height: 130vh;
  padding: 20px;
  border: none;
  height: auto;
}

.logo-container {
  display: flex;
  justify-content: center;
  align-items: center;
}

h2 {
  color: #333;
  font-size: 24px;
  margin-bottom: 20px;
}

table {
  width: 100%;
  border-collapse: collapse;
  border-spacing: 0;
  margin-bottom: 20px;
  border-radius: 20px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
  border-top: none;
  border: none;
  table-layout: fixed;
}

th, td {
  padding: 10px;
  text-align: left;
  border: 1px solid #ccc;
  width: 25%;
}

th {
  padding: 10px;
  background-color: #333;
  color: #1B1B1B;
}

th:first-child,
td:first-child {
  border-left: none;
  border-top: none;
}

th:last-child,
td:last-child {
  border-right: none;
  border-top: none;
}

tr:first-child th {
  border-top: none;
}

tr:last-child td {
  border-bottom: none;
}

input[type="radio"] {
  margin-right: 5px;
}

form {
  max-width: 500px;
  width: 100%;
  margin: auto;
  padding: 20px;
  background-color: #ffffff;
  border: 1px solid #ccc;
  border-radius: 5px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
  margin-top: 2px;
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
  margin: 27px;
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
  .cont {
    flex-direction: column;
  }

  .left-column,
  .right-column {
    width: 100%;
  }
}

table.cart-table {
  border: none !important;
  width: 100%;
}

.delivery-option {
    display: flex;
    align-items: center;
    margin-bottom: 10px;
  }
  
.radio-label {
        display: inline-block;
    }
    .option-label {
        display: inline-block;
        width: 120px;
    }
    
#table1 {
    border-collapse: unset;
    border: unset;
    background-color: unset;
    color: unset;
    border-radius: unset;
    box-shadow: unset;
  }

  #table1 th, #table1 td {
    padding: unset;
    text-align: unset;
    border: unset;
    width: unset;
  }

  #table1 th {
    background-color: unset;
    color: unset;
  }
	</style>
</head>

<body>
<div class="cont">
<div class="left-column">
    <div class="logo-container">
        <a href="Home.jsp"><img src="nuovologo.png" width="130px"></a>
    </div>
<form action="acquista" method="post">
    <input type="hidden" name="action" value="visualizza">	
    <h2>Tipo di Consegna</h2>

    <table>
        <% if((session.getAttribute("indirizzo") != null) &&
            (session.getAttribute("citta") != null) &&
            (session.getAttribute("provincia") != null) &&
            (session.getAttribute("cap") != null)) { %>
            <tr>
                <td>
                    <input type="radio" name="delivery-option" id="existing-address-option"
                        value="existing-address" onclick="hideAddressForm()">
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
                <input type="radio" name="delivery-option" id="delivery-option" value="home"
                    onclick="showAddressForm()">
                <label for="delivery-option" class="radio-label option-label">Altro indirizzo</label>
            </td>
            <td>
                Seleziona questa opzione se desideri ricevere la consegna ad un altro indirizzo
            </td>
        </tr>
        <tr>
            <td>
                <input type="radio" name="delivery-option" id="pickup-option" value="pickup" onclick="hideAddressForm()">
                <label for="pickup-option" class="radio-label option-label">Punto di Ritiro</label>
            </td>
            <td>
                Seleziona questa opzione se desideri ritirare il prodotto presso un punto di ritiro.
            </td>
        </tr>
    </table>

    <div id="address-form" style="display: none;">
        <input type="text" id="address" name="address" placeholder="Indirizzo"><br>
        <input type="text" id="citta" name="citta" placeholder="Città"><br>
        <input type="text" id="cap" name="cap" placeholder="CAP" maxlength="5"><br>
        <input type="text" id="provincia" name="provincia" placeholder="Provincia" maxlength="2"><br>
        <br><br>
    </div>

    <h2>Metodo di Pagamento</h2>
    <table>
        <tr>
            <td>
                <input type="radio" name="Pagamento" id="Pagamento" value="Carta di credito" onclick="showCartaForm()">
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
                <input type="radio" name="Pagamento" id="Pagamento" value="Paypal" onclick="hideCartaForm()">
                <label for="Paypal">Paypal</label>
            </td>
            <td style="text-align: right;">
                <img alt="" src="https://cdn.pixabay.com/photo/2015/05/26/09/37/paypal-784404_1280.png" role="img" width="90" height="50">
            </td>
        </tr>
        <tr>
            <td>
                <input type="radio" name="Pagamento" id="Pagamento" value="ApplePay" onclick="hideCartaForm()">
                <label for="ApplePay">Apple Pay</label>
            </td>
            <td style="text-align: right;">
                <img alt="" src="https://upload.wikimedia.org/wikipedia/commons/thumb/b/b0/Apple_Pay_logo.svg/1024px-Apple_Pay_logo.svg.png?20170518220303" role="img" width="75" height="30">
            </td>
        </tr>
    </table>
    <div id="carta-form" style="display: none;">
        <input type="text" id="card-number" name="card-number" placeholder="Numero carta" maxlength="16">
        <br>
        <input type="text" id="card-holder" name="card-holder" placeholder="Nome titolare" maxlength="255">
        <br>
        <input type="text" id="expiration-date" name="expiration-date" placeholder="MM/AA" maxlength="5">
        <br>
        <input type="text" id="cvv" name="cvv" placeholder="CVV" maxlength="3" >
        <br>
    </div>

    <br><br><br>
    <input type="submit" value="Conferma">
</form>
</div>
  
<div class="right-column">
	<% double prezzotot=0;
	if(cart != null) { %>
		
		<table class="cart-table" border="1" id="table1">
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
	<td><span id="totalPrice_<%=p.getID()%>"><%=p.getPrezzo()%></span></td>
	  <td><a href="product?action=DeleteC&id=<%=p.getID()%>">Rimuovi</a></td>

  </tr>
  <%} %>
</table>

<% 
  if(cart != null) {
%>
<div class="total-price">
  <h3>Total: <span id="cartTotal"></span></h3>
</div>

<a href="product?action=svuotaC">Svuota carello</a>

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

    function showCartaForm() {
    	  var addressForm = document.getElementById("carta-form");
    	  addressForm.style.display = "block";
    	}

    	function hideCartaForm() {
    	  var addressForm = document.getElementById("carta-form");
    	  addressForm.style.display = "none";
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