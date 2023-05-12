<%@ page contentType="text/html; charset=UTF-8" import="java.util.*,it.unisa.control.*,it.unisa.model.*"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>Homepage</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<style>
		body{
			margin: 0;
		}
		/* Stile per il contenitore dello slideshow */
		.slideshow-container {
		  width: 100%;
		  position: relative;
		  margin: auto;
		  height: 
		}

		/* Nasconde tutte le immagini inizialmente */
		.mySlides {
		  display: none;
		}

		/* Stile per i pulsanti del cambio immagine */
		.prev, .next {
		  cursor: pointer;
		  position: absolute;
		  top: 50%;
		  width: auto;
		  margin-top: -22px;
		  padding: 16px;
		  color: white;
		  font-weight: bold;
		  font-size: 18px;
		  transition: 0.6s ease;
		  border-radius: 0 3px 3px 0;
		}

		/* Stile per il pulsante prev */
		.prev {
		  left: 0;
		  border-radius: 3px 0 0 3px;
		}

		/* Stile per il pulsante next */
		.next {
		  right: 0;
		  border-radius: 3px 0 0 3px;
		}

		/* Stile per il punto attivo */
		.dot {
		  cursor: pointer;
		  height: 15px;
		  width: 15px;
		  margin: 0 2px;
		  background-color: #bbb;
		  border-radius: 50%;
		  display: inline-block;
		  transition: background-color 0.6s ease;
		}

		/* Stile per il punto attivo */
		.active, .dot:hover {
		  background-color: #717171;
		}
		/*PER LE COSE SOTTO*/
		.container {
			display: flex;
			justify-content: center;
			align-items: center;
			height: 20vw;
		}

		.container img {
			margin: 0 30px;
			width: 250px;
			height: auto;
			margin-top: 0;
		}
		
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
	<!-- Contenitore dello slideshow -->
	<div class="slideshow-container">

		<!-- Prima immagine -->
		<div class="mySlides fade">
			<img src="slideshow1.png" style="width:100%">
		</div>
		<!-- Seconda immagine -->
		<div class="mySlides fade">
			<img src="slideshow3.png" style="width:100%">
		</div>
		<!-- terza immagine -->
		<div class="mySlides fade">
			<img src="slideshow4.png" style="width:100%">
		</div>

		<!-- Pulsante per la visualizzazione dell'immagine precedente -->
		<a class="prev" onclick="plusSlides(-1)">&#10094;</a>

		<!-- Pulsante per la visualizzazione dell'immagine successiva -->
		<a class="next" onclick="plusSlides(1)">&#10095;</a>

	</div>

	<br>

	<!-- Punti per il cambio immagine -->
	<div style="text-align:center">
		<span class="dot" onclick="currentSlide(1)"></span>
		<span class="dot" onclick="currentSlide(2)"></span>
		<span class="dot" onclick="currentSlide(3)"></span>
	</div>

	<!-- Script per lo slideshow automatico -->
	<script>
	// Inizializzazione dello slideshow
	var slideIndex = 1;
	showSlides(slideIndex);

	// Definizione della funzione per il cambio immagine
	function plusSlides(n) {
		showSlides(slideIndex += n);
	}

	// Definizione della funzione per il cambio immagine corrente
	function currentSlide(n) {
		showSlides(slideIndex = n);
	}

	// Definizione della funzione per il cambio immagine automatico ogni 2 secondi
	function autoSlides() {
		showSlides(slideIndex += 1);
	}

	// Definizione della funzione per la visualizzazione delle slide
	function showSlides(n) {
		var i;
		var slides = document.getElementsByClassName("mySlides");
		var dots = document.getElementsByClassName("dot");
		if (n > slides.length) {slideIndex = 1}
		if (n < 1) {slideIndex = slides.length}
		for (i = 0; i < slides.length; i++) {
			slides[i].style.display = "none";
		}
		for (i = 0; i < dots.length; i++) {
			dots[i].className = dots[i].className.replace(" active", "");
		}
		slides[slideIndex-1].style.display = "block";
		dots[slideIndex-1].className += " active";
	}

	// Avvio del cambio immagine automatico ogni 2 secondi
	setInterval(autoSlides, 2000);
</script>

	<div class="container">
		<a href="product?action=dettaglio&sesso=F"><img src="DONNA.png" alt="Immagine 1"></a>
		<a href="product?action=dettaglio&sesso=M"><img src="uomo.png" alt="Immagine 2"></a>
		<img src="acc.png" alt="Immagine 3">
		<a href="product?action=all"><img src="all.png" alt="Immagine 4"></a>
	</div>



</body>
</html>