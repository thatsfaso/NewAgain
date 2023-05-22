<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" import="java.util.*,it.unisa.control.*,it.unisa.model.*"%>
<%
	List<Ordine> ordini = (List <Ordine>) request.getAttribute("ordini");
	
	/*Cart cart = (Cart) request.getAttribute("cart");*/
%>
<html>
<head>
<style>
.order-form {
  display: none;
}

	.banner {
	background-color: rgba(235, 235, 240, 0.66);
	position: relative;
	height: 90px;
	width: 100%;
}

#image {
	position: absolute;
	top: -18px;
	left: 10px;
	z-index: 1;
	width: 125px;
	height: auto;
}

.dx {
	position: absolute;
	top: 20px;
	right: 5px;
	z-index: 1;
}

.dx img {
	width: 40px;
	height: 40px;
	margin-left: 15px;
	margin-right: 15px;
}
</style>
   <link href="styleAreautente.css" rel="stylesheet" type="text/css">
</head>

<body>
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
<div class="s-layout">
<!-- Sidebar -->
<div class="s-layout__sidebar">
  <a class="s-sidebar__trigger" href="#0">
     <i class="fa fa-bars"></i>
  </a>

  <nav class="s-sidebar__nav">
     <ul>
        <li>
           <a class="s-sidebar__nav-link" href="#0" id="areaUtenteLink">
              <i class="fa fa-home"></i><em>I miei dati</em>
           </a>
        </li>
        <li>
           <a class="s-sidebar__nav-link" href="#0" id="mieiOrdiniLink">
             <i class="fa fa-user"></i><em>I miei ordini</em>
           </a>
        </li>
        <li>
           <a class="s-sidebar__nav-link" href="#0">
              <i class="fa fa-camera"></i><em>Logout</em>
           </a>
        </li>
     </ul>
  </nav>
</div>

<!-- Content -->
<main class="s-layout__content">
  
  <div class="profile-form">
   <h1>Profilo utente</h1>
    <form action="modifica" method="post">
      <label>Nome:</label>
      <input type="text" name="nome" value="<%=session.getAttribute("nome") %>"><br>
    <label>Cognome:</label>
    <input type="text" name="cognome" value="<%= session.getAttribute("cognome") %>"><br>
    
    <label>Indirizzo:</label>
    <input type="text" name="indirizzo" value="<%=session.getAttribute("indirizzo") %>"><br>
    
    <label>Email:</label>
    <input type="text" name="email" value="<%=session.getAttribute("email") %>"><br>
    
    <label>Città:</label>
    <input type="text" name="citta" value="<%=session.getAttribute("citta") %>"><br>
    
    <label>Provincia:</label>
    <input type="text" name="provincia" value="<%=session.getAttribute("provincia") %>"><br>
    
    <label>CAP:</label>
    <input type="text" name="cap" value="<%=session.getAttribute("cap") %>"><br>
    
    <label>Password:</label>
    <input type="password" name="pass"><br>
      
      <input type="submit" value="Salva modifiche">
    </form>
  </div>
  <br>
  <div class="order-form">
  <h2>I tuoi ordini</h2>
  <table class="order-table">
    <tr>
      <th>Numero ordine</th>
      <th>Data</th>
      <th>Totale</th>
      <th>Stato</th>
    </tr>
    
    <% 
    if (ordini != null && !ordini.isEmpty()) {
      for (Ordine ordine : ordini) { %>
        <tr>
          <td><%= ordine.getNumeroOrdine() %></td>
          <td><%= ordine.getData() %></td>
          <td><%= ordine.getTotale() %></td>
          <td><%= ordine.getStato() %></td>
        </tr>
      <% }
    }
    %>
  </table>
</div>
</main>
</div>
<jsp:include page="footer.jsp"/>
<script>
  var areaUtenteLink = document.getElementById("areaUtenteLink");
  var mieiOrdiniLink = document.getElementById("mieiOrdiniLink");

  areaUtenteLink.addEventListener("click", function(event) {
    event.preventDefault();
    var ordiniSection = document.querySelector(".order-form");
    ordiniSection.style.display = "none";
    var profiloUtenteSection = document.querySelector(".profile-form");
    profiloUtenteSection.style.display = "block";
  });

  mieiOrdiniLink.addEventListener("click", function(event) {
    event.preventDefault();
    var profiloUtenteSection = document.querySelector(".profile-form");
    profiloUtenteSection.style.display = "none";
    var ordiniSection = document.querySelector(".order-form");
    ordiniSection.style.display = "block";
  });
</script>
</body>
</html>