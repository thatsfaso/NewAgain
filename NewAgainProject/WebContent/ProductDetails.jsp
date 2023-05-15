<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Base64" %>

<%
    Prodotto product = (Prodotto) request.getAttribute("product");
%>

<!DOCTYPE html>
<html>
<%@ page contentType="text/html; charset=UTF-8" import="java.util.*,it.unisa.model.Prodotto,it.unisa.model.Cart,it.unisa.model.immagine"%>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <title>Dettagli prodotto</title>
    <link rel="stylesheet" type="text/css" href="styledetails.css">
</head>
<body>
<%
    if (product != null) {
        byte[] imageB = product.getImg();
        String base64img = "";
        if (imageB != null) {
            base64img = Base64.getEncoder().encodeToString(imageB);
        }
%>
<div class="container">
<div class="row">
	    <div class="col-md-4">
	        <img src="data:image/jpg;base64, <%=base64img%>" width="400px" id="ProductImg">
	        <div class="small-imgs">
	            <% if (product.getAllimg() != null) {
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
	                <img src="data:image/jpg;base64, <%=base64foto%>" class="small-img" width="80px">
	            </a>
	            <%          
	                    }
	                }
	            %>
	        </div>
	    </div>
	    <div class="col-md-6">
	        <div class="product-info">
	            <h1 class="product-title"><%= product.getNome() %></h1>
	            <div class="reviews">
	                <i class="fas fa-star"></i>
	                <i class="fas fa-star"></i>
	                <i class="fas fa-star"></i>
	                <i class="fas fa-star-half-alt"></i>
	                <i class="far fa-star"></i>
	                <p>240 recensioni</p>
	            </div>
	            <div class="price">
	               € <%=product.getPrezzo()%>
	            </div>
	            
	           <%int q = product.getQuantita();%>
	           
<div class="product-details-row">
  <div class="col-md-6">
    <h5>Quantità</h5>
    <select class="quantity custom-select">
      <% for(int i=1; i<=q; i++) { %>
        <option><%= i %></option>
      <% } %>
    </select>
  </div>
  <div class="col-md-6">
    <div class="product-inf">
      <ul>
        <li class="active">Descrizione</li>
      </ul><br>
      <div class="tabs-content">
        <div id="Description">
          <p class="small-description"><%= product.getDescrizione() %></p>
        </div>
      </div>
    </div>
  </div>
      <div class="buttons">
      <div class="row">
        <div class="col-md-6">
          <a href="product?action=addC&id=<%=product.getID()%>" class="custom-btn">Aggiungi al carrello<i class="fas fa-angle-right"></i></a>
        </div>
      </div>
    </div>
</div>


	<% } %>
	</div>
	 </div>
	</div>
	</div>
	
	<br><br><br>
	<jsp:include page="footer.jsp"/>
</body>
</html>
