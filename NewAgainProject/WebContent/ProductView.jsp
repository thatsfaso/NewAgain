<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Base64" %>
<%@ page import="it.unisa.model.Prodotto" %>
<%@ page import="it.unisa.model.Cart" %>
<%@ page import="java.util.Collection" %>
<%@ page import="java.util.Iterator" %>

<%
    Collection<?> products = (Collection<?>) request.getAttribute("products");
    if (products == null) {
        response.sendRedirect("./product");
        return;
    }

    Cart cart = (Cart) session.getAttribute("cart");
%>

<!DOCTYPE html>
<html lang="it">

<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <link href="ProductStyle.css" rel="stylesheet" type="text/css">
  <title>New Again</title>
<style>
			body{
			margin:0;
			}
			
			header {
			  width: 100%;
			}
			
			.banner {
				background-color: rgba(235, 235, 240, 0.66);
				position: relative;
				display: flex;
				height: 115px;
			}
			
			#image {
				position: absolute;
				left: 10px;
				z-index: 1;
				width: 125px;
				height: 125px;
			}
			
			.dx {
				position: absolute;
				top: 50px;
				right: 5px;
				z-index: 1;
			}
			
			.dx img {
				width: 40px;
				height: 40px;
				margin-left: 15px;
				margin-right: 15px;
			}
		
		/* Stile per la visualizzazione dei prodotti */

		.product:hover {
		  transform: translateY(-5px);
		  box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
		}
		
		.product h3 {
		  margin-top: 10px;
		  margin-bottom: 5px;
		  font-size: 24px;
		  font-weight: bold;
		  color: #000;
		  text-decoration: none;
		}
		
		.product button {
		  background-color: #ffa500;
		  color: #fff;
		  padding: 10px 20px;
		  border: none;
		  border-radius: 4px;
		  cursor: pointer;
		  font-size: 16px;
		  transition: all 0.3s ease-in-out;
		}
		
		.product button:hover {
		  background-color: #ff8c00;
		}
		
		.product p {
			margin-bottom: 10px;
			font-size: 18px;
		  	color: #666;
		  	text-decoration: none;
		}
		
		.product a {
			margin-right: 10px;
			text-decoration: none;
		}
		
		.product-container {
		  display: flex;
		  flex-direction: column; 
		  align-items: center; 
		  margin: 20px;
		}
		
		.product-row {
		  display: flex;
		  justify-content: center;
		  margin-bottom: 20px;
		  width: 100%;
		  flex-wrap: wrap;
		}
		
		.product {
		  margin-right: 20px;
		  margin-bottom: 20px;
		  transition: all 0.3s ease-in-out;
		  width: 250px;
		  padding: 10px;
		  background-color: #F5F5F7;
		  border: 1px solid #ccc;
		  border-radius: 5px;
		  box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
		}

		.product img {
		  display: block;
		  margin: auto;
		  width: 100%;
		  height: 200px;
		  object-fit: contain;
		  margin-bottom: 10px;
		  border-radius: 5px;
		}
		
			
		nav {
		  text-align: center;
		  background-color: #ff6848;
		}
		
		nav a {
		  display: inline-block;
		  color: #f2f2f2;
		  text-align: center;
		  padding: 14px 16px;
		  font-size: 17px;
		  text-decoration: none;
		}
		
		nav a:hover {
		  background-color: rgba(235, 235, 240, 0.66);
		  color: #1d1d1f;
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
</style>
</head>
<body>
<header>
	<div class="banner"> 
	<a href="Home.jsp"><img src="./nuovologo.png" id="image"></a>
	<div class="dx">
    <% if (session.getAttribute("email") == null) { %>
        <a href="http://www.google.com"><img src="cerca.png"></a>
        <a href="Accedi.jsp"><img src="utente.png"></a>
        <a href="product?action=viewC"><img src="cart.png"></a>
    <% } else { %>
        <a href="http://www.google.com"><img src="cerca.png"></a>
        <a href="ordine?action=ViewOrdini&email=<%=session.getAttribute("email") %>"><img src="utente.png"></a>
        <a href="registration?action=logout"><img src="logout.png"></a>
        <a href="product?action=viewC"><img src="cart.png"></a>
    <% } %>
	</div>
	 
	</div>
</header>
	  <br>
	  <br>
  <nav>
    <a href="product?action=dettaglio&sesso=M">Uomo</a>
    <a href="product?action=dettaglio&sesso=F">Donna</a>
    <a href="/product">Accessori</a>
    <a href="product?action=all">All</a>
  </nav>

  <br><br>
  <h2>Prodotti</h2>
<div>
    <div class="product-container">
        <div class="product-list">
            <% if (products != null && products.size() != 0) {
                Iterator<?> it = products.iterator();
                int count = 0;
                while (it.hasNext()) {
                    if (count % 4 == 0) { %>
                        <div class="product-row">
                    <% }
                    Prodotto bean = (Prodotto) it.next();
                    byte[] imageB = bean.getImg();
                    String base64img = Base64.getEncoder().encodeToString(imageB);
                    %>
                    <div class="product">
    <a href="product?action=read&id=<%=bean.getID()%>">
        <img src="data:image/jpg;base64, <%=base64img%>" width="300" height="300">
        <p align="center"><%=bean.getNome()%></p>
        <p align="center"><%=bean.getPrezzo()%>€</p>
        <% if (bean.getQuantita() == 1) { %>
        	<br>
            <p style="text-align: center;">Non disponibile</p>
        <% } else if (cart != null && !cart.presente(bean.getID())) { %>
            <a href="product?action=addC&id=<%=bean.getID()%>" id="carrello">
                <input type="submit" value="Aggiungi al carrello">
            </a>
        <% } else { %>
            <p>Prodotto già nel carrello</p>
        <% } %>
    </a>
</div>
<% count++;
if (count % 4 == 0) { %>
    </div>
<% }
}
if (count % 4 != 0) { %>
    </div>
<% }
} else { %>
    <p>Non ci sono prodotti disponibili</p>
<% } %>
    </div>
  </div>
</body>
</html>