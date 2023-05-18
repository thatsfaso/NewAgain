<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="it">
<head>
<meta charset="ISO-8859-1">
<link href="ProductStyle.css" rel="stylesheet" type="text/css">
<title>Insert</title>
</head>
<body>
	<h2>Insert</h2>
<form action="./insert" method="post" enctype= "multipart/form-data">
	<input type="hidden" name="action" value="insert"> 
	
	<label for="descrizione">Description:</label><br>
	<textarea name="descrizione" maxlength="100" rows="3" required placeholder="enter description"></textarea><br>
	
	<label for="prezzo">Price:</label><br> 
	<input name="prezzo" type="number" min="0" value="0" step="0.01" required><br>

<label for="quantita">Quantity:</label><br>
<input name="quantita" type="number" min="1" value="1" required><br>

<label for="foto">Photo:</label><br>
<input type="file" name="foto" accept="image/*" required><br> 

<input type="submit" value="Add">
<input type="reset" value="Reset">
</form>
</body>
</html>