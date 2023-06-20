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
    if((int) session.getAttribute("tipo_account")== 1){
%>

<!DOCTYPE html>
<html lang="it">
<head>
<title>Pagina Amministratore</title>
<style>
body{
overflow-x:hidden;
}
    /* Stili CSS */
   .s-layout__content {
   justify-content: center;
   text-align: center;
   margin-top: 90px;
   height: auto;
   left: -15vw;
   
}
    /* Banner */
    .banner {
        background-color: rgba(235, 235, 240, 0.66);
        position: relative;
        height: 90px;
        width: auto;
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
table {
    border-collapse: collapse;
    width: 100%;
    max-width: 800px; /* Imposta la larghezza massima desiderata per la tabella */
}

th,
td {
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
    text-align: center;
}

td a:hover {
    text-decoration: underline;
}
	

    /* Order Form */
    .order-form {
         display: none;
         margin-left:10vw;
         margin-top: -70px;
         margin-bottom: 20vw;
         text-align:center;
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
	
	.profile-form{
			display: block;
	         margin-left:10vw;
	         margin-top: -70px;
	         text-align:center;
	}
	
	
	
	@media screen and (max-width: 750px) {
  table {
    display: block;
    margin-left:40px;
  }
  th,
  td {
    display: block;
    width: 100%;
  }
  th {
    text-align: center;
  }
  td {
    text-align: center;
  }
  tr:nth-child(even) {
    background-color: transparent;
  }
  tr {
    margin-bottom: 10px;
    border: 1px solid #ddd;
  }
  td:before {
    content: attr(data-label);
    font-weight: bold;
    display: block;
    margin-bottom: 5px;
    text-align: center;
  }
}
	
</style>
<link href="styleAreautente.css" rel="stylesheet" type="text/css">
</head>

<body>
<div class="banner">
    <a href="Home.jsp"><img src="./nuovologo.png" id="image"></a>
    <div class="dx">
        <% if (session.getAttribute("email") == null) { %>
            <a href="Accedi.jsp"><img src="utente.png"></a>
            <a href="product?action=viewC"><img src="cart.png"></a>
        <% } else { %>
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
                        <i class="fa fa-home"></i><em>Prodotti</em>
                    </a>
                </li>
                <li>
                    <a class="s-sidebar__nav-link" href="#0" id="utentiLink">
                        <i class="fa fa-user"></i><em>Utenti</em>
                    </a>
                </li>
                <li>
                    <a class="s-sidebar__nav-link" href="#0" id="ordiniLink">
                        <i class="fa fa-camera"></i><em>Ordini</em>
                    </a>
                </li>
            </ul>
        </nav>
    </div>

    <main class="s-layout__content">
        <div class="profile-form">
          <h2>Catalogo </h2>
			<table class="product-table" id="productTable">
    <tr>
        <th>ID</th>
        <th>Nome</th>
        <th>Descrizione</th>
        <th>Prezzo</th>
        <th>Disponibilità</th>
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
            String base64img = null;
            if (bean.getImg() != null) {
                byte[] imageB = bean.getImg();
                base64img = Base64.getEncoder().encodeToString(imageB);
            }
            %>
            <td><%= bean.getID() %></td>
            <td><%= bean.getNome() %></td>
            <td><%= bean.getDescrizione() %></td>
            <td>
                <form action="product" method="GET">
                    <input type="hidden" name="action" value="edit">
                    <input type="hidden" name="id" value="<%= bean.getID() %>">
                    <span id="spanPrezzo<%= bean.getID() %>"><%= bean.getPrezzo() %>€</span>
                    <br>
                    <input type="submit" value="Salva" style="display: none;" id="salvaButton<%= bean.getID() %>">
                </form>
            </td>
            <td>
                <%if(bean.getQuantita()==0){ %><p>SI</p>
                <%}else{ %> <p>NO</p>
                <%} %>
            </td>
            <% if (base64img != null) { %>
                <td><img src="data:image/jpg;base64, <%= base64img %>" width="100" height="100"></td>
            <% } %>
            <td><%= bean.getSesso() %></td>
            <td>
                <a href="#" onclick="mostraInputPrezzo('<%= bean.getID() %>'); return false;">
                    <input type="submit" value="Modifica">
                </a>
                <%if(bean.getQuantita()==0){ %>
                    <br>
                    <input type="hidden" id="deleteId" value="<%= bean.getID() %>">
                    <a href="product?action=delete&id=<%=bean.getID()%>">
                        <input type="submit" value="Cancella" id="deleteButton">
                    </a>
                <%}else{ %>
                    <br>
                    <input type="hidden" id="updateId" value="<%= bean.getID() %>">
                    <a href="product?action=updateq&id=<%=bean.getID()%>">
                        <input type="submit" value="Aggiungi" id="updateq">
                    </a>
                <%} %>
            </td>
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
    <tr id="addProductRow">
    <td colspan="8">
        <button onclick="aggiungiProdotto()">+</button>
    </td>
</tr>
    
</table>

		<h2>Inserimento</h2>
		 <form action="product?action=insert" method="post" enctype="multipart/form-data">
		  <input type="hidden" name="action" value="insert"> 
		  
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
		  
		  <label for="categoria">Categoria:</label><br> 
		  <input name="categoria" type="text"><br>
		  
		  <label for="foto">Foto:</label><br> 
		  <input type="file" name="foto" accept="image/*" ><br>
		
		 <input type="submit" value="Aggiungi"><input type="reset" value="Reset">
		 </form>
		 <br>
		 

        </div>

        <div class="order-form">
            <!-- Seconda sottopagina: Lista Utenti -->
			 <h2>Lista Utenti</h2>
			<div>
			    <h3>Ricerca Cliente</h3>
			<div class="search-form">
			    <form id="search-form" action="registration" method="GET">
			        <input type="text" id="user-email-input" name="email" placeholder="Inserisci l'email del cliente">
			        <button type="submit" id="search-button">Cerca</button>
			        <button type="button" id="reset-button">Reset</button>
			    </form>
			</div>
			</div>
			<table class="user-table" id="user-table">
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
		    <button onclick="sortOrdiniPerData()">Ordina per Data</button>
		</div>
		<div>
		    <h3>Ricerca Cliente</h3>
			<div class="search">
			    <form id="search" action="ordine" method="GET">
			        <input type="text" id="user-email-input-orders" name="email" placeholder="Inserisci l'email del cliente">
			        <button type="submit" id="search-button">Cerca</button>
			        <button type="button" id="reset-button-orders">Reset</button>
			    </form>
			</div>
		</div>
		<div id="ordiniSection">
		<table class="order-table" id="orderTable">
		    <tr>
		        <th>Email</th>
		        <th>Numero Ordine</th>
		        <th id="dataOrdineHeader" data-ordine="asc" onclick="sortOrdiniPerData()">Data</th>
		        <th>Totale</th>
		        <th>Stato Ordine</th>
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
		                <td><%= ordine.getTotale() %>€</td>
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
        </div>
    </main>
</div>

<jsp:include page="footer.jsp"/>

<script>
var searchForm = document.getElementById("search-form");
if (searchForm) {
  searchForm.addEventListener("submit", function(e) {
    e.preventDefault();

    var email = document.getElementById("user-email-input").value;
    var table = document.getElementById("user-table");

    var rows = table.getElementsByTagName("tr");
    for (var i = 0; i < rows.length; i++) {
      var row = rows[i];
      if (i === 0 || row.getAttribute("data-email") === email) {
        row.style.display = "table-row";
      } else {
        row.style.display = "none";
      }
    }

    document.getElementById("user-email-input").value = "";
  });
}

var resetButton = document.getElementById("reset-button");
if (resetButton) {
  resetButton.addEventListener("click", function() {
    var table = document.getElementById("user-table");
    var rows = table.getElementsByTagName("tr");
    for (var i = 0; i < rows.length; i++) {
      rows[i].style.display = "table-row";
    }
  });
}

  
var searchFormOrders = document.getElementById("search");
if (searchFormOrders) {
  searchFormOrders.addEventListener("submit", function(e) {
    e.preventDefault();

    var email = document.getElementById("user-email-input-orders").value;
    var table = document.getElementById("orderTable");

    var rows = table.getElementsByTagName("tr");
    for (var i = 0; i < rows.length; i++) {
      var row = rows[i];
      if (i === 0 || row.getAttribute("data-email") === email) {
        row.style.display = "table-row";
      } else {
        row.style.display = "none";
      }
    }

    document.getElementById("user-email-input-orders").value = "";
  });
}

  
  var resetButtonOrders = document.getElementById("reset-button-orders");
  if (resetButtonOrders) {
    resetButtonOrders.addEventListener("click", function() {
      var table = document.getElementById("orderTable");
      var rows = table.getElementsByTagName("tr");
      for (var i = 0; i < rows.length; i++) {
        rows[i].style.display = "table-row"; // Mostra tutte le righe
      }
    });
  }
</script>


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
	    
	    function showModificaForm() {
	    	  var formSection = document.getElementById("modifica-form");
	    	  formSection.style.display = "block";
	    	  
	    	  formSection.scrollIntoView({ behavior: 'smooth' });
	    	}
	    function noneForm() {
	    	  var formSection = document.getElementById("modifica-form");
	    	  formSection.style.display = "none";

	    	}

			function deleteItem() {
			    var id = document.getElementById('deleteId').value;
			    window.location.href = 'doDelete?id=' + encodeURIComponent(id);
			  }
		
</script>
<script>
function mostraInputPrezzo(id) {
    var spanPrezzo = document.getElementById('spanPrezzo' + id);
    var inputPrezzo = document.createElement('input');
    inputPrezzo.type = 'text';
    inputPrezzo.name = 'prezzo';
    inputPrezzo.value = spanPrezzo.textContent.trim();
    spanPrezzo.textContent = '';
    spanPrezzo.appendChild(inputPrezzo);
    
    var salvaButton = document.getElementById('salvaButton' + id);
    salvaButton.style.display = 'block';
}

function aggiungiProdotto() {
    var newRow = document.createElement("tr");

    newRow.innerHTML = `
        <td><input type="text" name="nuovoProdottoID"></td>
        <td><input type="text" name="nuovoProdottoNome"></td>
        <td><input type="text" name="nuovoProdottoDescrizione"></td>
        <td><input type="text" name="nuovoProdottoPrezzo"></td>
        <td><input type="text" name="nuovoProdottoDisponibilita"></td>
        <td><input type="text" name="nuovoProdottoFoto"></td>
        <td><input type="text" name="nuovoProdottoSesso"></td>
        <td>
            <button onclick="salvaNuovoProdotto()">Salva</button>
        </td>
    `;

    var table = document.getElementById("productTable");
    table.appendChild(newRow);
}
</script>



</body>
</html>
<%} //ciao
    else {
    	RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/Erorre500.jsp");
		dispatcher.forward(request, response);
    }
%>
