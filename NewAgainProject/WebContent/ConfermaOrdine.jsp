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
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f6f5f7;
            text-align:center;
        }

        h2 {
            color: #333;
        }

		#conf {
		            display: flex;
		            align-items: center;
					text-align: center;
					justify-content: center;
		            width: 30vw;
					min-width: 400px;
		            margin: 0 auto;
		            padding: 20px;
		            background-color: #ff6848;
		            border: 1px solid #ddd;
		            border-radius: 5px;
					font-family: Arial, Sans-Serif;
		        }
		
		
		#tab th, td {
		    padding: 5px;
			vertical-align: top;
		  }
		  
		  #tab td:first-child {
		    text-align: left;
			
		  }
		  
		  #tab td:last-child {
		    text-align: right;
		  }

		table.cart-table {
		    width: 100%;
		    text-align:center;
		    vertical-align: middle;
		    border-color: #f6f5f7; 
		    border-collapse: collapse;
		    margin-top: 20px;
		    transition: transform 0.3s ease-in-out;
		}
		table.cart-table:hover {
		    transform: scale(1.05);
		}
		
		#table1 td{ 
		align-items: center; 
		justify-content: center; 
		vertical-align:middle;
		}
		
		input[type="submit"]:hover {
		  background-color: #FF6848;
		  border: 1px solid #f6f5f7;
		  border-radius: 14px;
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
	       #image{
	       width: 10vw;
	       height: 10vw;
	       }
    </style>
</head>
<body>
<img src="./nuovologo.png" id="image">
<div id="conf">
	<form action="acquista" method="post">
		<input type="hidden" name="action" value="completa">
		<input type="hidden" name="email" value="">

		<h2>Conferma ordine</h2>
		<table id="tab">
		
		<tr>
		<td>Tipo di consegna</td>
		<td><%= request.getAttribute("TipoC") %></td>
		<% String tipoc = (String) request.getAttribute("TipoC");
		            if (tipoc.equals("Consegna a casa")) { %>
		</tr>
		<tr>
		<td>Indirizzo</td>
		<td><%= session.getAttribute("indirizzo") %> <%= session.getAttribute("citta") %> <%= session.getAttribute("provincia") %> <%= session.getAttribute("cap") %></p>
			<% } else if (tipoc.equals("Altro indirizzo")) { %>
				<p><strong>Indirizzo:</strong> <%= request.getAttribute("indirizzo") %> <%= request.getAttribute("citta") %> <%= request.getAttribute("provincia") %> <%= request.getAttribute("cap") %></p>
			<% } %></tr>
		<tr>
		<td></td>
		<td></td>
		</tr>
		<tr>
		<td></td>
		<td></td>
		</tr>
		<tr>
		<td></td>
		<td></td>
		</tr>
		<tr>
		<td>Pagamento</td>
		<td><%= request.getAttribute("Pagamento") %></td>
		<% String pagamento = (String) request.getAttribute("Pagamento");
		            if (pagamento.equals("Carta di credito")) { %>
		</tr>
		<tr>
		<td>Numero Carta</td>
		<td><%= request.getAttribute("numeroCarta") %></td>
		</tr>
		<tr>
		<td>Titolare Carta</td>
		<td><%= request.getAttribute("card-holder") %></td>
		</tr>
		<tr>
		<td>Scadenza Carta</td>
		<td><%= request.getAttribute("scadenzaCarta") %></td>
		</tr>
		<tr>
		<td>CVV</td>
		<td><%= request.getAttribute("cvv") %></td>
		</tr>
		<% } %>
		</table>
		<% if (cart != null) { %>
			<table class="cart-table" border="1" id="table1">
				<% for (Prodotto p : cart.getProducts()) {
					byte[] imageB = p.getImg();
					String base64img = "";
					if (imageB != null) {
						base64img = Base64.getEncoder().encodeToString(imageB);
					}
				%>
					<tr data-product-id="<%= p.getID() %>">
						<td><img src="data:image/jpg;base64, <%= base64img %>" width="100" height="100"></td>
						<td><%= p.getNome() %></td>
						<td><span id="totalPrice_<%= p.getID() %>"><%= p.getPrezzo() %></span></td>
					</tr>
				<% } %>
			</table>
		<% } %>
						<input type="submit" value="Acquista Ora">
			</form>
</div>
</body>
</html>
