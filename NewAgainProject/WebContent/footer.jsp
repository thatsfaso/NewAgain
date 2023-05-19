<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
<head>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
<link href="CartStyle.css" rel="stylesheet" type="text/css">
	<title>Footer</title>
	<style>
	
	@import url('https://fonts.googleapis.com/css2?family=Questrial&display=swap');
	
		html, body {
			min-height: 100%;
			bottom: 0;
			margin: 0;
			
		}
		
		.footer{
			font-family: "Questrial";
			padding:50px 0;
			color: #1b1b1b;
			background-color: #ff6848;
			position: relative;
			margin-top: auto;
			display: flex; 
			justify-content: space-between; 
			align-items: center;
			flex-direction: column; 
			flex-wrap: wrap;
			height: auto;
  
		}
		
		.container{
			flex-wrap: wrap;
			width: 100%;
			height: auto;
			display: flex; 
			justify-content: center;
			align-items: center;  
		}
	
		.box1, .box2, .box3{
			width: auto;
			height: 120px;
			margin-bottom: 5vw;
		}
		
		.box1 {
		  margin-left: auto;
		  margin-right: auto;
		}
		
		.box2{
			margin-left: 1px;
		}

		.box3 {
		  margin-left: auto;
		  margin-right: auto;
		}
	
        @media (max-width: 550px) {
			
            .box1, .box2, .box3 {
                margin-bottom: 20px;
                text-align: center;
            }
            .box1{
                margin-left: auto;
		        margin-right: auto;
            }
            .box2{
                margin-left: auto;
		        margin-right: auto;
            }
            .footer{
                align-items: center;
                text-align: center;
            }
            .container {
                flex-direction: column;
                align-items: center;
                text-align: center;
            }
            .box3 {
                margin-top: 20px;
            }

            
        }

		@media (min-width: 551px) and (max-width: 698px) {
			.footer {
				text-align: center;
			}
		.container {
			display: flex;
			justify-content: center;
			align-items: center;
			flex-wrap: wrap;
			}

			.box {
			width: 200px;
			height: 180px;
			margin: 10px;
			
			}

			.box1,
			.box2 {
			flex: 1;
			}

			.box3 {
			margin-top: -10vw;
			flex-basis: 100%;
			
			}
			#items{
				
				position: absolute;
				top: 70%;
			}
			#na{
				margin-top: 0;
			}

			}

			.footer h3 {
				   margin-top:0;
				   margin-bottom:12px;
				   font-weight:bold;
				   font-size:16px;
			}
			.footer ul {
				 padding:0;
				 list-style:none;
				 line-height:1.6;
				 font-size:14px;
				 margin-bottom:0;
			}
	
			.footer  ul a {
				 color:inherit;
				text-decoration:none;
				 opacity:0.6;
			}
	
			.footer  ul a:hover {
				opacity:0.8;
			}
			.footer .item.text {
				 margin-bottom:36px;
			}
	
			.footer .item.text p {
				 opacity:0.6;
				 margin-bottom:0;
			}
			
			.footer .item.social {
			  text-align: center;
			}
			.footer .item.social > a {
			 font-size:20px;
			 width:36px;
			 height:36px;
			 line-height:36px;
			 display:inline-flex;
			 text-align:center;
			 border-radius:50%;
			 box-shadow:0 0 0 1px #1b1b1b;
			 margin:0 8px;
			 color:#1b1b1b;
			 opacity:0.75;
			 box-sizing: border-box;
			 align-items: center;
			 justify-content: center;
			 
			}
			.footer .item.social > a:hover {
				 opacity:0.9;
			}
			.footer .item:not(.social) {
			  text-align:center;
			  padding-bottom:20px;
			}
			.footer .item.social {
				text-align: center;
				margin-top: 20px;
			}
			.footer .box3 p {
				margin-bottom: 0;
			}
			.footer .box3 p:last-child {
				margin-top: 8px;
			}
			.footer .box3 p strong {
				font-weight: bold;
			}
			#items{
				margin-top: -3vw;
			}
	</style> 
</head>
<body>
	<div class="footer">
		<div class="container">
		<div class="box box1">
			<h3>Servizi</h3>
	                        <ul>
	                            <li><a href="#">FAQ</a></li>
								<li><a href="./Errore404.jsp">Privacy Policy</a></li>
	                            <li><a href="./Errore404.jsp">Termini e Condizioni</a></li>
	                        </ul>
		</div>
		<div class="box box2">
			<h3>Autori</h3>
	                        <ul>
	                            <li><a href="https://github.com/thatsfaso">Fasolino Iliano</a></li>
	                            <li><a href="https://github.com/GiuSeppE898">Giuseppe Pio Sorrentino</a></li>
								<li><a href="https://github.com/daniipa02">Daniela Palma</a></li>
								<li><a href="https://github.com/emaanuueele11">Emanuele Vitale</a></li>
	                        </ul>
		</div>
		<div class="box box3">
			<h3>NewAgain</h3>
	                        <p>"When creativity melds together with global issues,<br>I believe you can bring the world together"</p>
							<p><strong>- Virgil Abloh</strong></p>
		</div>
		</div>
		<div class="col item social" id="items">
	                    <a href="https://www.facebook.com/dinfunisa"><i class="icon ion-social-facebook"></i></a>
	                    <a href="https://twitter.com/dinfunisa"><i class="icon ion-social-twitter"></i></a>
	                    <a href="https://www.youtube.com/watch?v=Oc2WPtUkHWA"><i class="icon ion-social-youtube"></i></a>
	                    <a href="https://www.instagram.com/dinfunisa/?hl=it"><i class="icon ion-social-instagram"></i></a>
	    </div>   
		<p class="copyright" id="na">NewAgain © 2023</p>
	</div>
</body>
</html>