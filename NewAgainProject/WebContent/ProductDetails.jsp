<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Base64" %>

<%
    Prodotto product = (Prodotto) request.getAttribute("product");
%>

<!DOCTYPE html>
<html lang="it">
<%@ page contentType="text/html; charset=UTF-8" import="java.util.*,it.unisa.model.Prodotto,it.unisa.model.Cart,it.unisa.model.immagine"%>
<head>
    <meta charset="UTF-8">
    <title>Dettagli prodotto</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,700;1,800&display=swap');

        * {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background: #f5f5f7;
			
        }

			#footer {
			  bottom: 0;
			  left: 0;
			  top: 0;
			  width: 100%;
			  height: auto;
			}

			#footer iframe {
			  width: 100%;
			  height: 100%;
			  border: none;
			}

        a:hover {
            color: #000;
        }

        .cart {
            height: auto;
            background: #f5f5f7;
            padding: 50px;
            border-radius: 20px;
            margin: 27px 50px;
            margin-top: 60px;
            box-shadow: 0 0 15px 2px rgba(0, 0, 0, 0.1);
        }

        .row1 {
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        #ProductImg {
			min-height: 200px !important;
			min-width: 200px !important;
            transition: 0.4s;
            height: 22vw;
            width: 20vw;
        }

        .price {
            margin-bottom: 15px;
        }

        .price span:first-child {
            font-size: 30px;
            font-weight: 700;
            margin-right: 10px;
        }

        .price span:last-child {
            color: rgb(117, 117, 117);
            text-decoration: line-through;
            font-size: 19px;
        }

        .reviews {
            display: flex;
            margin: 16px 0;
        }

        .reviews p {
            font-size: 15px;
            color: #777;
            margin: 0;
            margin-left: 8px;
            line-height: 19px;
        }

        .reviews i {
            color: black;
        }

        .product-title {
            font-size: 35px;
            font-weight: 700;
            font-style: italic;
            color: #000;
        }

        .product-inf {
            width: 100%;
            margin-top: 20px;
           
        }

        .product-inf ul {
            display: flex;
            list-style: none;
        }

        .product-inf ul li:first-child {
            margin-right: 15px;
        }

        .product-inf ul li {
            padding: 10px 30px;
            border-radius: 10px;
            transition: 0.3s;
            cursor: pointer;
        }

        .product-inf ul li:hover {
            border-radius: 5px;
            background: #eee;
        }

        .product-inf ul li a {
            color: #000;
            font-size: 18px;
            font-weight: 500;
        }

        .product-inf ul li a:hover {
            text-decoration: none;
        }

        .product-inf ul li.active {
            border-bottom: 3px solid #000 !important;
			border: 1px solid black;
            background: #eee;
            transition: 0.3s;
			width: 100%;
			text-align: center;
        }

        .custom-btn {
            border-radius: 5px;
            color: #1B1B1B;
            display: block;
            width: 205px;
            text-align: center;
            font-size: 16px;
            border-radius: 25px;
            padding: 10px;
            transition: 0.3s;
            font-weight: 500;
            margin-top: 20px;
            text-decoration: none;
        }

        .custom-btn:hover {
            text-decoration: none;
            background: #e87960;
            color: #f5f5f7;
            opacity: 0.88;
        }
        
        .col-md-6{
        	width: 100%;
        }
        

        .buttons .row .col-md-6 {
            display: flex;
            align-items: center;
            justify-content: center;
         
        }

        .small-imgs {
            display: flex;
          
        }

        .small-imgs img {
			min-height: 80px;
			min-width: 80px;
            width: 7vw;
            height: 7vw;
          
        }

        .small-img {
            margin: 0 5px;
            cursor: pointer;
            width: 22%;
        }

        .custom-btn i {
            margin-left: 15px;
        }

        .size,
        .quantity {
            cursor: pointer;
        }

        .size:focus,
        .quantity:focus {
            border-color: #919191 !important;
            outline: 0;
            box-shadow: 0 0 0 .2rem rgba(0, 0, 0, 0.25) !important;
        }

        @media only screen and (max-width: 768px) {
            .cart {
                padding: 25px;
            }

            .row1 {
                flex-direction: column;
                align-items: center;
            }

            #ProductImg {
                margin-left: 0;
                margin-bottom: 20px;
            }

            .price {
                text-align: center;
            }

            .product-title {
                text-align: center;
                margin-top: 20px;
            }

            .reviews {
                justify-content: center;
                margin-bottom: 20px;
            }

            .buttons .row .col-md-6 {
                margin-top: 20px;
            }
        }

        @media only screen and (max-width: 390px) {
            .cart {
                padding: 15px;
            }
        }
		.img1{
			display: flex;
			justify-content: center;
		}
		#col6{
			
			margin-left: 20px;
		}
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
</head>
<body>
<%
    if (product != null) {
        byte[] imageB = product.getImg();
        String base64img = "";
        if (imageB != null) {
            base64img = Base64.getEncoder().encodeToString(imageB);
        }
%>

<div class="cart">
    <div class="row row1">
        <div class="col-md-4">
		<div class="img1">
            <img src="data:image/jpg;base64, <%=base64img%>" width="400px" id="ProductImg">
		</div>
            <div class="small-imgs">
                <% if (product.getAllimg() != null) {
	                ArrayList<immagine> a = product.getAllimg();
	                for (int i = 0; i < a.size(); i++) {
	                    immagine im = a.get(i);
	                    byte[] foto = im.getImg();
	                    String base64foto = "";
	                    if (foto != null) {
	                        base64foto = Base64.getEncoder().encodeToString(foto);
	                    }
	            %>
	            <a href="product?action=change&id=<%=im.getId()%>&productid=<%=product.getID()%>">
	                <img src="data:image/jpg;base64, <%=base64foto%>" class="small-img" width="80px">
	            </a>
	            <%          
	                    }
	                }
	            %> 
				</div>
        </div>
        <div class="col-md-6" id="col6">
            <h1 class="product-title"><%= product.getNome() %></h1>
            <div class="reviews">
                <i class="fas fa-star"></i>
                <i class="fas fa-star"></i>
                <i class="fas fa-star"></i>
                <i class="fas fa-star-half-alt"></i>
                <i class="far fa-star"></i>
                <p>240 recensioni</p>
            </div>
            <div class="price">
                € <%=product.getPrezzo()%>
            </div>
			<%int q = product.getQuantita();%>
            <div class="row">
                <div class="col-md-4 qty">
                    <h5>Quantità</h5>
                    <select class="quantity custom-select">
                        <% for(int i=1; i<=q; i++) { %>
							<option><%= i %></option>
						  <% } %>
                    </select>
                </div>
            </div>
            <br>
            <div id="product" class="product-inf">
                <ul>
                    <li class="active">Descrizione</li>
                </ul>
                <br>
                <div class="tabs-content">
                    <div id="Description">
                        <p><%= product.getDescrizione() %></div>

                </div>
            </div>
            <div class="buttons">
                <div class="row">
                    <div class="col-md-6">
                        <a href="product?action=addC&id=<%=product.getID()%>" class="custom-btn">Aggiungi al carrello<i class="fas fa-angle-right"></i></a>
                    </div>
                </div>
            </div>
        </div>
        <%} %>
    </div>
</div>


<br><br><br>

</body>
</html>