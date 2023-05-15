<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "java.util.Base64" %>
<%
	Collection<?> products = (Collection<?>) request.getAttribute("products");
	if(products == null) {
		response.sendRedirect("./product");	
		return;
	}
	
	Prodotto product = (Prodotto) request.getAttribute("product");
	
	/*Cart cart = (Cart) request.getAttribute("cart");*/
%>

<!DOCTYPE html>
<html>
<%@ page contentType="text/html; charset=UTF-8" import="java.util.*,it.unisa.model.*, it.unisa.control.*"%>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="ProductStyle.css" rel="stylesheet" type="text/css">
	<title>New Again</title>
	<style>
	
		body{
		margin: 0;
		width: 100%;
		}
		
		.banner {
			background-color: rgba(235, 235, 240, 0.66); 
			position: relative; 
			height: 90px;
			width: 100%;
		}
		
		#image {
			position: absolute; 
			top: 5px; 
			left: 10px;
			z-index: 1; 
			width: 80px;
			height: 80px;
		}
		
		.dx{
			position: absolute; 
			top: 20px; 
			right: 5px; 
			z-index: 1;
		}
		
		.dx img{
			width: 40px;
			height: 40px;
			margin-left: 15px;
			margin-right: 15px;
		}
		
		nav {
		  width: 100%;
		  height: 30px;
		  text-align: center;
		  background-color: DarkSalmon;
		  overflow: hidden;
		}
		
		nav a {
		  color: #f2f2f2;
		  text-align: center;
		  padding: 14px 16px;
		  font-size: 25px;
		  text-decoration: none;
		}
		
		nav a:hover {
		  background-color: rgba(235, 235, 240, 0.66);
		  color: #1d1d1f;
		}
		
		.all {
		padding: 0;
		margin: 0;
		text-align: center;
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
		}
		
		.product a {
			margin-right: 10px;
		}
		
		.product-container {
		  display: flex;
		  flex-wrap: wrap;
		  justify-content: center;
		  align-items: center;
		  margin-top: 20px;
		  margin-bottom: 20px;
		}
		
		.product-row {
		  display: flex;
		  flex-wrap: wrap;
		  justify-content: center;
		  align-items: center;
		  margin-bottom: 20px;
		}
		
		.product {
		  margin-right: -15px;
		  margin-left: 20px;
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
		
		.prev-button, .next-button {
		  border: none;
		  background-color: #eee;
		  color: #555;
		  font-size: 20px;
		  padding: 10px 15px;
		  margin-top: 20px;
		  cursor: pointer;
		}
		
		.prev-button:hover, .next-button:hover {
		  background-color: #ddd;
		}
		
		.active {
		  background-color: #4CAF50;
		  color: white;
		}
	</style>
</head>

<body>
<div class="all">
	<div class="banner"> 
	<a href="Home.jsp"><img src="logo.png" id="image"></a>
	<div class="dx">
    <% if (session.getAttribute("email") == null) { %>
        <a href="http://www.google.com"><img src="cerca.png"></a>
        <a href="Accedi.jsp"><img src="utente.png"></a>
        <a href="product?action=viewC"><img src="cart.png"></a>
    <% } else { %>
        <a href="http://www.google.com"><img src="cerca.png"></a>
        <a href="Profilo.jsp"><img src="utente.png"></a>
        <a href="registration?action=logout"><img src="logout.png"></a>
        <a href="product?action=viewC"><img src="cart.png"></a>
    <% } %>
	</div>
	  </div>
<nav>
  <a href="product?action=dettaglio&sesso=M">Uomo</a>
  <a href="product?action=dettaglio&sesso=F">Donna</a>
  <a href="/product">Accessori</a>
  <a href="/product">All</a> 
</nav>
	<br><br>
	<h2>Prodotti</h2>
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
      String base64img = Base64.getEncoder().encodeToString(imageB); %>
      <div class="product">
        <img src="data:image/jpg;base64, <%=base64img%>" width="300" height="300">
        <p><%=bean.getNome()%></p>
        <a href="product?action=read&id=<%=bean.getID()%>">Dettagli</a>
        <a href="product?action=addC&id=<%=bean.getID()%>">Aggiungi al carrello</a>
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

  <button class="prev-button">&#8249;</button>
  <button class="next-button">&#8250;</button>
</div>
</div>
		<br>
	<h2>Insert</h2>
	<form action="product" method="post" enctype="multipart/form-data">
		<input type="hidden" name="action" value="insert"> 
		
		<label for="descrizione">descrizione:</label><br>
		<textarea name="descrizione" maxlength="100" rows="3" required placeholder="inserisci descrizione"></textarea><br>
		
		<label for="prezzo">prezzo:</label><br> 
		<input name="prezzo" type="number" min="0" value="0" step="0.01" required><br>

		<label for="quantita">quantita:</label><br> 
		<input name="quantita" type="number" min="1" value="1" required><br>
		
		<label for="foto">foto:</label><br> 
		<input type="file" name="foto" accept="image/*" ><br>

		<input type="submit" value="Add"><input type="reset" value="Reset">
	</form>

	<br><br><br>	
	<jsp:include page="footer.jsp"/>
	
</body>
</html>