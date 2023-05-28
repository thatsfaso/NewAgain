<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" import="java.util.*,it.unisa.control.*,it.unisa.model.*"%>

<%
  
    ProductDao productDao = new ProductDao();
    Collection<Prodotto> products = productDao.doRetrieveAll();
    request.setAttribute("products", products);
    
    OrdineDAO ordineDao = new OrdineDAO();
    List<Ordine> ordini = ordineDao.getAllOrdini();
    request.setAttribute("ordini", ordini);
    
    UtenteDao utenteDao = new UtenteDao();
    List<Utente> utenti = utenteDao.doRetrieveAll();
    request.setAttribute("utenti", utenti);


%>

<html>
<head>
<title>Pagina Amministratore</title>
<style>
    /* Stili CSS */
	body{
		text-align:center;
	}
    /* Banner */
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

	/* Product table */
	td {
        width: auto;
    }
    
    table {
        width: 100%;
        border-collapse: collapse;
    }
    
    th,td {
        padding: 8px;
        text-align: center;
    }
    
    th {
        background-color: #f2f2f2;
        font-weight: bold;
        
    }
    
    tr:nth-child(even) {
        background-color: #f9f9f9;
    }
    
    tr:hover {
        background-color: #e9e9e9;
    }
    
    td a {
        color: #0066cc;
        text-decoration: none;
        margin-right: 10px;
    }
    
    td a:hover {
        text-decoration: underline;
    }

    /* Order Form */
    .order-form {
         display: none;
    }

    .order-table th,
    .order-table td {
        padding: 8px;
    }

    .order-table th:not(:last-child),
    .order-table td:not(:last-child) {
        margin-right: 10px;
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
	
	    input[type="reset"] {
	  background-color: #333;
	  color: #fff;
	  border: none;
	  margin: 27px;
	  padding: 10px 20px;
	  cursor: pointer;
	  transition: all 0.3s ease-in-out;
	}
	
	input[type="reset"]:hover {
	  background-color: #FF6848;
	  border-radius: 14px;
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
    <div class="s-layout__sidebar">
        <a class="s-sidebar__trigger" href="#0">
            <i class="fa fa-bars"></i>
        </a>

        <nav class="s-sidebar__nav">
            <ul>
                <li>
                    <a class="s-sidebar__nav-link" href="#0" id="catalogoLink">
                        <i class="fa fa-home"></i><em>Catalogo Prodotti</em>
                    </a>
                </li>
                <li>
                    <a class="s-sidebar__nav-link" href="#0" id="utentiLink">
                        <i class="fa fa-user"></i><em>Lista Utenti</em>
                    </a>
                </li>
                <li>
                    <a class="s-sidebar__nav-link" href="#0" id="ordiniLink">
                        <i class="fa fa-camera"></i><em>Lista Ordini</em>
                    </a>
                </li>
            </ul>
        </nav>
    </div>

    <main class="s-layout__content">
        <div class="profile-form">
          <h2>Catalogo Prodotti</h2>
			<table class="product-table">
        <tr>
            <th>ID</th>
            <th>Nome Prodotto</th>
            <th>Descrizione</th>
            <th>Prezzo</th>
            <th>Quantità</th>
            <th>Foto</th>
            <th>Sesso</th>
            <th>Azioni</th>
        </tr>
			<% 
			  if (products != null && !products.isEmpty()) {
			    Iterator<?> it = products.iterator();
			    int count = 0;
			    while (it.hasNext()) {
			      if (count % 4 == 0) { %>
				  <tr>
			      <% }
			      Prodotto bean = (Prodotto) it.next();
			      byte[] imageB = bean.getImg();
			      String base64img = Base64.getEncoder().encodeToString(imageB);
			      %>
			<td><%= bean.getID() %></td>
            <td><%= bean.getNome() %></td>
            <td><%= bean.getDescrizione() %></td>
            <td><%= bean.getPrezzo() %></td>
            <td><%= bean.getQuantita() %></td>
            <td><img src="data:image/jpg;base64, <%= base64img %>" width="100" height="100"></td>
            <td><%= bean.getSesso() %></td>
            <td>
                <input type="submit" value="Modifica" onclick="scrollToForm();">
                <br>
			     <a href="doDelete?id=<%= bean.getID() %>"> <input type="submit" value="Cancella"></a></td>
        </tr>
		<% 
	count++;
	}
	if (count % 4 != 0) { %>
	 <% for (int i = 0; i < 8 - (count % 8); i++) { %>
<% } %>
			      </tr>
			    <% }
			  } else { %>
			    <tr>
			      <td colspan="8">Nessun prodotto disponibile</td>
			    </tr>
			  <% } %>
    </table>

		<h2>Inserimento</h2>
		 <form action="" method="post" enctype="multipart/form-data">
		  <input type="hidden" name="action" value="insert"> 
		  
		  <label for="nome">Nome:</label><br> 
		  <input name="nome" type="text"><br>
		  
		  <label for="quantita">Quantità:</label><br> 
		  <input name="quantita" type="number" min="1" value="1" required><br>
		  
		  <label for="descrizione">Descrizione:</label><br>
		  <textarea name="descrizione" maxlength="100" rows="3" required placeholder="inserisci descrizione"></textarea><br>
		  
		  <label for="prezzo">Prezzo:</label><br> 
		  <input name="prezzo" type="number" min="0" value="0" step="0.01" required><br>
		
		  <label for="sesso">Sesso:</label><br> 
		  <input name="sesso" type="text"><br>
		  
		  <label for="foto">foto:</label><br> 
		  <input type="file" name="foto" accept="image/*" ><br>
		
		  <a href="product?action=insert"><input type="submit" value="Aggiungi"></a><input type="reset" value="Reset">
		 </form>
		 <br>
		 
		 <h2 id="modifica">Modifica</h2>
		<form id="modifica-form" action="" method="post" enctype="multipart/form-data">
		<input type="hidden" name="action" value="modifica">
		  
		  <label for="nome">Nome:</label><br> 
		  <input name="nome" type="text"><br>
		  
		  <label for="quantita">Quantità:</label><br> 
		  <input name="quantita" type="number" min="1" value="1"><br>
		  
		  <label for="descrizione">Descrizione:</label><br>
		  <textarea name="descrizione" maxlength="100" rows="3" placeholder="inserisci descrizione"></textarea><br>
		  
		  <label for="prezzo">Prezzo:</label><br> 
		  <input name="prezzo" type="number" min="0" value="0" step="0.01"><br>
		
		  <label for="sesso">Sesso:</label><br> 
		  <input name="sesso" type="text"><br>
		  
		  <label for="foto">foto:</label><br> 
		  <input type="file" name="foto" accept="image/*" ><br>
		
		  <a href="product?action=modifica"><input type="submit" value="Modifica" form="modifica-form"></a>
		 </form>
		 <br>

        </div>

        <div class="order-form">
            <!-- Seconda sottopagina: Lista Utenti -->
			 <h2>Lista Utenti</h2>
			<div>
			    <h3>Ricerca Utente</h3>
				<div class="search-form">
				    <form action="profilo" method="GET">
				        <input type="text" id="user-email-input" placeholder="Inserisci l'email del cliente">
				        <button type="button" onclick="searchUser('user-table', 'user-email-input')">Cerca</button>
				    </form>
				</div>
			</div>
			<table class="user-table">
			    <tr>
			        <th>Email</th>
			        <th>Nome</th>
			        <th>Cognome</th>
			        <th>Indirizzo</th>
			        <th>Città</th>
			        <th>Provincia</th>
			        <th>CAP</th>
			    </tr>
			    <% 
			    if (utenti != null && !utenti.isEmpty()) {
			        for (Utente utente : utenti) { %>
			            <tr data-email="<%= utente.getEmail() %>">
			                <td><%= utente.getEmail() %></td>
			                <td><%= utente.getNome() %></td>
			                <td><%= utente.getCognome() %></td>
			                <td><%= utente.getIndirizzo() %></td>
			                <td><%= utente.getCitta() %></td>
			                <td><%= utente.getProvincia() %></td>
			                <td><%= utente.getCap() %></td>
			            </tr>
			        <% }
			    }
			    %>
			</table>
			</div>
 
        <div class="order-form">
		<!-- Terza sottopagina: Lista Ordini -->
		<h2>Lista Ordini</h2>
		<div>
		    <h3>Ordini per Data</h3>
		    <button onclick="sortOrdiniPerData()">Ordina per Data</button>
		</div>
		<div>
		    <h3>Ricerca Cliente</h3>
		    <div class="search-bar">
		        <form action="ordine" method="GET">
		            <input type="text" id="order-email-input" name="email" placeholder="Inserisci l'email del cliente">
		            <button type="button" onclick="searchUser('order-table', 'order-email-input')">Cerca</button>
		        </form>
		    </div>
		</div>
		<table class="order-table">
		    <tr>
		        <th>Email</th>
		        <th>Numero Ordine</th>
		        <th id="dataOrdineHeader" data-ordine="asc" onclick="sortOrdiniPerData()">Data Ordine</th>
		        <th>Totale</th>
		        <th>Stato</th>
		        <th>Indirizzo</th>
		        <th>Città</th>
		        <th>Provincia</th>
		        <th>CAP</th>
		    </tr>
		    <% 
		    if (ordini != null && !ordini.isEmpty()) {
		        for (Ordine ordine : ordini) { %>
		            <tr data-email="<%= ordine.getEmail() %>">
		                <td><%= ordine.getEmail() %></td>
		                <td><%= ordine.getNumeroOrdine() %></td>
		                <td><%= ordine.getData() %></td>
		                <td><%= ordine.getTotale() %></td>
		                <td><%= ordine.getStato() %></td>
		                <td><%= ordine.getIndirizzo() %></td>
		                <td><%= ordine.getCitta() %></td>
		                <td><%= ordine.getProvincia() %></td>
		                <td><%= ordine.getCap() %></td>
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
    // Gestione degli eventi per le sottopagine

    // Prima sottopagina: Catalogo Prodotti
    var catalogoLink = document.getElementById("catalogoLink");
    var catalogoSection = document.querySelector(".profile-form");

    catalogoLink.addEventListener("click", function(event) {
        event.preventDefault();
        catalogoSection.style.display = "block";
        utentiSection.style.display = "none";
        ordiniSection.style.display = "none";
    });

    // Seconda sottopagina: Lista Utenti
    var utentiLink = document.getElementById("utentiLink");
    var utentiSection = document.querySelector(".order-form:nth-of-type(2)");

    utentiLink.addEventListener("click", function(event) {
        event.preventDefault();
        catalogoSection.style.display = "none";
        utentiSection.style.display = "block";
        ordiniSection.style.display = "none";
    });

	 // Terza sottopagina: Lista Ordini
	    var ordiniLink = document.getElementById("ordiniLink");
	    var ordiniSection = document.querySelector(".order-form:nth-of-type(3)");
	
	    ordiniLink.addEventListener("click", function(event) {
	        event.preventDefault();
	        catalogoSection.style.display = "none";
	        utentiSection.style.display = "none";
	        ordiniSection.style.display = "block";
	    });
	
	    // Ordina gli ordini per data
	    function sortOrdiniPerData() {
	        var ordiniTable = document.querySelector(".order-table");
	        var dataOrdineHeader = document.getElementById("dataOrdineHeader");
	        var rows = Array.from(ordiniTable.getElementsByTagName("tr")).slice(1);
	
	        var ordine = dataOrdineHeader.getAttribute("data-ordine");
	        rows.sort(function(a, b) {
	            var dataA = new Date(a.cells[2].innerText);
	            var dataB = new Date(b.cells[2].innerText);
	
	            if (ordine === "asc") {
	                return dataA - dataB;
	            } else {
	                return dataB - dataA;
	            }
	        });
	
	        while (ordiniTable.rows.length > 1) {
	            ordiniTable.deleteRow(1);
	        }
	
	        rows.forEach(function(row) {
	            ordiniTable.appendChild(row);
	        });
	
	        dataOrdineHeader.setAttribute("data-ordine", ordine === "asc" ? "desc" : "asc");
	    }
	    
	    function scrollToForm() {
	      var formSection = document.getElementById("modifica");
	      formSection.scrollIntoView({ behavior: 'smooth' });
	    }
	    
	    //ricerca email
		function searchUser(tableId, inputId) {
		    var searchValue = document.getElementById(inputId).value.toLowerCase();
		    var rows = document.querySelectorAll("." + tableId + " tr");
		
		    for (var i = 0; i < rows.length; i++) {
		        var row = rows[i];
		        var rowData = row.textContent.toLowerCase();
		
		        if (searchValue === "" || rowData.includes(searchValue)) {
		            row.style.display = "table-row";
		        } else {
		            row.style.display = "none";
		        }
		    }
		}
	    
		function searchOrder(tableId) {
		    searchUser(tableId, "order-email-input");
		}
</script>
</body>
</html>