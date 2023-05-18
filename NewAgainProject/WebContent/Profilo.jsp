<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" import="java.util.*,it.unisa.control.*,it.unisa.model.*"%>
<%
	List<Ordine> ordini = (List <Ordine>) request.getAttribute("ordini");
	
	/*Cart cart = (Cart) request.getAttribute("cart");*/
%>
<!DOCTYPE html>
<html lang="it">
<link href="LoginStyle.css" rel="stylesheet" type="text/css">
<head>
<meta charset="UTF-8">
<title>Profilo utente</title>
<style>
		body{
		margin: 0;
		text-align: center;
		}
		
		
		.banner 
		{
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
		.order-table {
  		margin-top: 20px;
 		 border-spacing: 0;
		}

.order-table th,
.order-table td {
  padding: 10px;
}

.order-table th {
  background-color: #f0f0f0;
}

.order-table tr:nth-child(even) {
  background-color: #f9f9f9;
}

.order-table tr:hover {
  background-color: #eaeaea;
}
		
</style>
</head>
<body>

<%
// Verifica se l'utente è loggato
if (session.getAttribute("email") == null) {
    response.sendRedirect("Accedi.jsp");
} else {
    // Recupera i dati dell'utente dalla sessione
    String nome = (String) session.getAttribute("nome");
    String cognome = (String) session.getAttribute("cognome");
    String indirizzo = (String) session.getAttribute("indirizzo");
    String email = (String) session.getAttribute("email");
    String citta = (String) session.getAttribute("citta");
    String provincia = (String) session.getAttribute("provincia");
    String cap = (String) session.getAttribute("cap");
    
    OrdineDAO ordineDAO = new OrdineDAO(); // Istanzio l'oggetto OrdineDAO
	 // Recupera i dati dell'ordine dalla sessione
	Integer numeroOrdine = (Integer) session.getAttribute("numeroOrdine");
	Date dataOrdine = (Date) session.getAttribute("dataOrdine");
	Double totale = (Double) session.getAttribute("totale");
	String stato = (String) session.getAttribute("stato"); 
	// Imposto l'oggetto OrdineDAO nella sessione
	session.setAttribute("ordineDAO", ordineDAO);
%>

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
	
	<script>
	    function logout() {
	        var xhr = new XMLHttpRequest();
	        xhr.onreadystatechange = function() {
	            if (xhr.readyState === 4 && xhr.status === 200) {
	                window.location.reload(); // Ricarica la pagina dopo aver effettuato il logout
	            }
	        };
	        xhr.open("GET", "registration?action=logout", true);
	        xhr.send();
	    }
	</script>
		 
	</div>
	
<h1>Profilo utente</h1>

<form action="modifica" method="post">
    <label>Nome:</label>
    <input type="text" name="nome" value="<%=nome%>"><br>
    
    <label>Cognome:</label>
    <input type="text" name="cognome" value="<%=cognome%>"><br>
    
    <label>Indirizzo:</label>
    <input type="text" name="indirizzo" value="<%=indirizzo%>"><br>
    
    <label>Email:</label>
    <input type="text" name="email" value="<%=email%>"><br>
    
    <label>Città:</label>
    <input type="text" name="citta" value="<%=citta%>"><br>
    
    <label>Provincia:</label>
    <input type="text" name="provincia" value="<%=provincia%>"><br>
    
    <label>CAP:</label>
    <input type="text" name="cap" value="<%=cap%>"><br>
    
    <label>Password:</label>
    <input type="password" name="pass"><br>
    
    <input type="submit" value="Salva modifiche">
</form>

	
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

<%
}
%>

	<br><br><br>
	<jsp:include page="footer.jsp"/>
</body>
</html>