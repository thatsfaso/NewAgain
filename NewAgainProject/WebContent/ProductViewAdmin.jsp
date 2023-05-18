<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "java.util.Base64" %>
<%
 Collection<Prodotto> products = (Collection<Prodotto>) request.getAttribute("products");
 if(products == null) {
  response.sendRedirect("./admin"); 
  return;
 }
 
 Prodotto product = (Prodotto) request.getAttribute("product");
%>

<!DOCTYPE html>
<html lang="it">
<%@ page contentType="text/html; charset=UTF-8" import="java.util.*,it.unisa.model.Prodotto,it.unisa.model.Cart"%>

<head>
 <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <link href="ProductStyle.css" rel="stylesheet" type="text/css">
 <title>Amministratore</title>
 <style>
 footer {
  text-align: center;
  padding: 3px;
  background-color: DarkSalmon;
  color: white;
}
 
 </style>
</head>

<body>

 <h2>Prodotti</h2>
 <a href="product">List</a>
 <table border="1">
  <tr>
   <th>Foto</th>
   <th>Code <a href="admin?sort=id">Sort</a></th>
   <th>Description <a href="admin?sort=descrizione">Sort</a></th>
   <th>Action</th>
  </tr> 
  <%
   if (products != null && products.size() != 0) {
    Iterator<?> it = products.iterator();
    while (it.hasNext()) {
     Prodotto bean = (Prodotto) it.next();
     byte[] imageB = bean.getImg();
     String base64img = Base64.getEncoder().encodeToString(imageB);
  %>
  <tr>
   <td><a href="admin?action=read&id=<%=bean.getID()%>"><img src="data:image/jpg;base64, <%=base64img%>"  width="200" height="200"></a></td>
   <td><%=bean.getID()%></td>
   <td><%=bean.getDescrizione()%></td>
   <td><a href="admin?action=delete&id=<%=bean.getID()%>">Delete</a><br>
    </td>
  </tr>
  <%
    }
   } else {
  %>
  <tr>
   <td colspan="6">No products available</td>
  </tr>
  <%
   }
  %>
 </table>
 <h2>Inserimento</h2>
 <form action="admin" method="post" enctype="multipart/form-data">
  <input type="hidden" name="action" value="insert"> 
  
  <label for="descrizione">descrizione:</label><br>
  <textarea name="descrizione" maxlength="100" rows="3" required placeholder="inserisci descrizione"></textarea><br>
  
  <label for="prezzo">prezzo:</label><br> 
  <input name="prezzo" type="number" min="0" value="0" step="0.01" required><br>

  <label for="quantita">quantita:</label><br> 
  <input name="quantita" type="number" min="1" value="1" required><br>
  
  <label for="foto">foto:</label><br> 
  <input type="file" name="foto" accept="image/*" ><br>

  <a href="admin?action=insert">Aggiungi</a><input type="reset" value="Reset">
 </form>
 <br><br><br>
 
 <footer>
    <p>Author: New Again<br>
    <a href="mailto:hege@example.com">nwagn@example.com</a></p>
 </footer>

 
</body>
</html>