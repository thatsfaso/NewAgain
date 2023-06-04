<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" import="java.util.*,it.unisa.control.*,it.unisa.model.*"%>
<%
	List<Ordine> ordini = (List <Ordine>) request.getAttribute("ordini");
	List<Prodotto> prodotti =(List <Prodotto>) request.getAttribute("prodotti");
	
	/*Cart cart = (Cart) request.getAttribute("cart");*/
%>
<html>
<head>
<title>Profilo</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<style>

Primary Styles */
*, *::before, *::after {
   box-sizing: border-box;
}

body {
   font-family: sans-serif;
   font-size: 1em;
   color: #333;
}

h1 {
  font-size: 1.4em;
}

em {
   font-style: normal;
}

a {
   text-decoration: none;
   color: inherit;
} 

/* Layout */
.s-layout {
   display: flex;
   width: 100%;
   min-height: 100vh;
}

   .s-layout__content {
   display: flex;
   
   flex: 1;
   margin-left: 0;
   margin-top: 30px;
   position: relative;
   flex-wrap: wrap; /* Aggiungi questa riga */
}

/* Sidebar */
.s-sidebar__trigger {
   z-index: 2;
   position: fixed;
   top: 0;
   left: 0;
   width: 100%;
   height: 4em;
   }

.s-sidebar__trigger > i {
   display: inline-block;
   margin: 1.5em 0 0 1.5em;
   color: #f07ab0;
}

.s-sidebar__nav {
   position: relative;
   top: 0px; /* Aggiungi una margine superiore per allineare la sidebar sotto la navbar */
   left: 0;
   overflow: hidden;
   transition: all .3s ease-in;
   width: 15em;
   height: calc(100% - 245px); /* Calcola l'altezza della sidebar in base alla navbar */
   background: #ff6848;
   color: rgba(255, 255, 255, 0.7);
   z-index: 0;
}

.s-sidebar__nav:hover,
.s-sidebar__nav:focus,
.s-sidebar__trigger:focus + .s-sidebar__nav,
.s-sidebar__trigger:hover + .s-sidebar__nav {
   left: 0;
}

.s-sidebar__nav ul {
   position: absolute;
   top: 4em;
   left: 0;
   margin: 0;
   padding: 0;
   width: 15em;
}

.s-sidebar__nav ul li {
   width: 100%;
}

.s-sidebar__nav-link {
   position: relative;
   display: inline-block;
   width: 100%;
   height: 4em;
}

.s-sidebar__nav-link em {
   position: absolute;
   top: 50%;
   left: 4em;
   transform: translateY(-50%);
}

.s-sidebar__nav-link:hover {
   background: #ff6848;
}

.s-sidebar__nav-link > i {
   position: absolute;
   top: 0;
   left: 0;
   display: inline-block;
   width: 4em;
   height: 4em;
}

.s-sidebar__nav-link > i::before {
   position: absolute;
   top: 50%;
   left: 50%;
   transform: translate(-50%, -50%);
}

@media (min-width: 42em) {
  .s-sidebar__nav {
    width: 4em;
  }

  .s-sidebar__nav:hover,
  .s-sidebar__nav:focus,
  .s-sidebar__trigger:focus + .s-sidebar__nav,
  .s-sidebar__trigger:hover + .s-sidebar__nav {
    width: 15em;
  }
}

@media (min-width: 68em) {
  .s-sidebar__trigger {
    display: none;
  }

  .s-sidebar__nav {
    width: 15em;
  }

  .s-sidebar__nav ul {
    top: 1.3em;
  }
}

@media (max-width: 42em) {
  .s-sidebar__nav {
    width: 0;
  }

  .s-sidebar__nav:hover,
  .s-sidebar__nav:focus,
  .s-sidebar__trigger:focus + .s-sidebar__nav,
  .s-sidebar__trigger:hover + .s-sidebar__nav {
    width: 0;
  }
}

@media (max-width: 68em) {
  .s-sidebar__trigger {
    display: block;
  }

  .s-sidebar__nav {
    width: 0;
  }

  .s-sidebar__nav ul {
    top: 0;
  }
}

@media (max-width: 768px) {
  .profile-form {
    width: 100%;
    margin: 10px;
  }

  @media (min-width: 68em) {
    .s-sidebar__nav {
      width: 15em;
    }
  }
}


  .order-table {
    font-size: 12px;
  }

  .order-table th,
  .order-table td {
    padding: 5px;
  }

  .order-table th:not(:last-child),
  .order-table td:not(:last-child) {
    margin-right: 5px;
  }
}


.order-table th,
.order-table td {
  padding: 8px; /* Aggiungi uno spazio di 8px all'interno delle celle */
}

.order-table th:not(:last-child),
.order-table td:not(:last-child) {
  margin-right: 10px; /* Aggiungi uno spazio di 10px tra le colonne, eccetto l'ultima colonna */
}

.profile-form {
    display: block;
    position: absolute;
    top: 10px;
    left: 20px;
    width: 300px;
    background-color: #f5f5f5;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.profile-form input[type="text"],
.profile-form input[type="password"] {
    margin-bottom: 10px;
}

.profile-form input[type="submit"] {
    margin-top: 10px;
}


.order-form{
	display:none;
	    position: absolute;
    top: 10px;
    left: 20px;
}

.order-table {
  width: 100%;
  border-collapse: collapse;
}

.order-table th,
.order-table td {
  padding: 8px;
}

.order-table th:not(:last-child),
.order-table td:not(:last-child) {
  margin-right: 10px;
}

.order-table th {
  background-color: #f5f5f5;
  text-align: left;
}

.order-table tr:nth-child(even) {
  background-color: #f9f9f9;
}

.order-table tr:hover {
  background-color: #f2f2f2;
}

.order-table a {
  text-decoration: none;
  color: #333;
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
    <form action="registration?action=modifica" method="post">
      <label>Nome:</label>
      <input type="text" name="nome" value="<%=session.getAttribute("nome") %>"><br>
    <label>Cognome:</label>
    <input type="text" name="cognome" value="<%= session.getAttribute("cognome") %>"><br>
    
    <label>Indirizzo:</label>
    <input type="text" name="indirizzo" value="<%=session.getAttribute("indirizzo") %>"><br>
    
    <label>Città:</label>
    <input type="text" name="citta" value="<%=session.getAttribute("citta") %>"><br>
    
    <label>Provincia:</label>
    <input type="text" name="provincia" value="<%=session.getAttribute("provincia") %>"><br>
    
    <label>CAP:</label>
    <input type="text" name="cap" value="<%=session.getAttribute("cap") %>"><br>
    
    <label>Email:</label>
    <input type="text" name="email" value="<%=session.getAttribute("email") %>"><br>
    
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
      <th>Dettagli</th>
    </tr>
    
    <% 
    if (ordini != null && !ordini.isEmpty()) {
      for (Ordine ordine : ordini) { %>
        <tr>
          <td><%= ordine.getNumeroOrdine() %></td>
          <td><%= ordine.getData() %></td>
          <td><%= ordine.getTotale() %>€</td>
          <td><%= ordine.getStato() %></td>
          <td><a href="ordine?action=Dettagli&NumeroOrdine=<%=ordine.getNumeroOrdine()%>&email=<%=session.getAttribute("email")%>">Mostra</a></td>
          
        </tr>
      <% }
    }
    %>
  </table>
 <table>
 
    <%
    if (prodotti != null && !prodotti.isEmpty()) {
    for(Prodotto bean: prodotti) {
      byte[] imageB = bean.getImg();
      String base64img = Base64.getEncoder().encodeToString(imageB); %>
      <tr>
        <td><a href="product?action=read&id=<%=bean.getID()%>"><img src="data:image/jpg;base64, <%= base64img %>" width="100" height="100"></a></td>
        <td><%= bean.getNome() %></td>
      </tr>
    <% }}
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