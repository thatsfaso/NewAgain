<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.Base64" %>

<%
	
	Prodotto product = (Prodotto) request.getAttribute("product");
%>

<!DOCTYPE html>
<html>
<%@ page contentType="text/html; charset=UTF-8" import="java.util.*,it.unisa.model.*"%>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="ProductStyle.css" rel="stylesheet" type="text/css">
	<title>Product Details</title>
	<style>
	
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
		
	
	</style>
</head>

<body>
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
	  <br>
	<h2>Dettagli</h2>
	<%
	if (product != null) {
		   byte[] imageB = product.getImg();
		   String base64img = "";
		   if(imageB != null){
		      base64img = Base64.getEncoder().encodeToString(imageB);
		   }
			
		%>
	
				
	<div style="display: flex;">
  <div style="margin-right: 20px; margin-left: 20px">
    <img src="data:image/jpg;base64, <%=base64img%>" width="400" height="400">
  </div>
  <div style="margin-left: 200px;">
    <h2>Nome: <%=product.getDescrizione()%></h2>
    <h2>Prezzo: <%=product.getPrezzo()%></h2>
    <button  type="submit" value="Crea">Aggiungi al carrello </button>
  </div>
</div>


	<br>

	<%
	if (product.getAllimg() != null) {
		  ArrayList<immagine> a = product.getAllimg();
		  for (int i = 0; i < a.size(); i++) {
		    immagine im = a.get(i);
		    byte[] foto = im.getImg();
		    String base64foto = "";
		    if (foto != null) {
		      base64foto = Base64.getEncoder().encodeToString(foto);
		    }
		    %>
		    
		      <a href="product?action=change&id=<%=im.getId()%>&productid=<%=product.getID()%>">
  			  <img src="data:image/jpg;base64, <%=base64foto%>" width="100" height="100">
			  </a>
		      
		    
		    <%
		  }
		}}
	%>

	<br><br><br>
	<jsp:include page="footer.jsp"/>
</body>
</html>