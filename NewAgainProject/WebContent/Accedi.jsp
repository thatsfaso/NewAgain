<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% 
String mess = (String) request.getAttribute("errore"); 
String mess2 = (String) request.getAttribute("errore2");
String mess3 = (String) request.getAttribute("errore3");

%>
<!DOCTYPE html>
<html lang="it">
	<%@ page contentType="text/html; charset=UTF-8" import="java.util.*, it.unisa.control.*,java.sql.Connection, java.sql.*, it.unisa.model.*"%>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Accedi</title>
		<link rel="stylesheet" type="text/css" href="style.css">
	</head>
<body>

<div class="container" id="container">
	<div class="form-container sign-up-container">
		<form action="registration" method="post" >
		<input type="hidden" name="action" value="insertbreve">
			<h1>Crea Account</h1>
			<div class="form">
				<div class="form-row">
				  <input type="text" name="nome" placeholder="Nome" />
				  <input type="text" name="cognome" required placeholder="Cognome">
				</div>
				<div>
				  <input type="email" name="email" required placeholder="Email">
				</div>
				<div>
				  <input type="password" name="pass" required placeholder="Password">
				</div>
				<div>
				<%
				if (mess2 != null) { %>
					<p style="color: red;"><%=mess2%></p>
					<% } %>
				 <button  type="submit" value="Crea">Crea </button>
				</div>
			  </div>
		</form>
	</div>
	<div class="form-container sign-in-container">
		<form action="registration" method="post">
		<input type="hidden" name="action" value="login">
			<h1>Accedi</h1>
			<input type="email" name="username" required placeholder="Username">
			<input type="password" name="pass" required placeholder="Password">
			<%
	if (mess != null) { %>
	<p style="color: red;"><%=mess%></p>
	
<% } %>
<%
				if (mess3 != null) { %>
					<p style="color: red;"><%=mess3%></p>
					<% } %>
			<button>Accedi</button>
		</form>
	</div>
	<div class="overlay-container">
		<div class="overlay">
			<div class="overlay-panel overlay-left">
				<h1>Bentornato!</h1>
				<p>Se sei già registrato inserisci le tue credenziali</p>
				<button class="ghost" id="signIn">Accedi</button>
			</div>
			<div class="overlay-panel overlay-right">
				<h1>Benvenuto!</h1>
				<p>Crea un account per conoscerci meglio</p>
				<%
				if (mess2 != null) { %>
					<p style="color: red;"><%=mess2%></p>
					<% } %>
				<button class="ghost" id="signUp">Registrati</button>
			</div>
		</div>
	</div>
</div>



<script type="text/javascript" src="script.js"></script>

</body>
</html>
