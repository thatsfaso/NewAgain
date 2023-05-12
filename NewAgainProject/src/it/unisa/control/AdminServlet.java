package it.unisa.control;

import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import it.unisa.model.*;

/**

Servlet implementation class RegistrationControl
*/
public class AdminServlet extends HttpServlet {
private static final long serialVersionUID = 1L;
ProductDao model = new ProductDao();
/**

@see HttpServlet#HttpServlet()
*/
public AdminServlet() {
super();
}
/**

@see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
*/
protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Cart cart = (Cart)request.getSession().getAttribute("cart");
		if(cart == null) {
		cart = new Cart();
		request.getSession().setAttribute("cart", cart);
	}
		String action = request.getParameter("action");
		
	try {
	    if (action != null) {
	        
	         if (action.equalsIgnoreCase("read")) {
	            int id = Integer.parseInt(request.getParameter("id"));
	            request.removeAttribute("product");
	            request.setAttribute("product", model.doRetrieveByKey(id));
	            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/ProductDetails.jsp");
	            dispatcher.forward(request, response); 
	        }
	        
	        else if (action.equalsIgnoreCase("delete")) {
	            int id = Integer.valueOf(request.getParameter("id"));
	            model.doDelete(id);
	        }
	        
	        else if (action.equalsIgnoreCase("insert")) {
				String descrizione = request.getParameter("descrizione");
				double prezzo = Double.parseDouble(request.getParameter("prezzo"));
			    int quantita = Integer.parseInt(request.getParameter("quantita"));
			    Part filePart = request.getPart("image");
			    InputStream inputStream = filePart.getInputStream();
	            int fileLength = inputStream.available();
	            byte[] imageData = new byte[fileLength];
	            inputStream.read(imageData);
	            inputStream.close();
	            
			    Prodotto p = new Prodotto();
				 p.setDescrizione(descrizione);
				 p.setPrezzo(prezzo);
				 p.setQuantita(quantita);
				 p.setImg(imageData);
				model.doSave(p);
				/*RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/ProductViewAdmin.jsp");
				dispatcher.forward(request, response);*/
			}
		}}
		catch (SQLException e) {
		System.out.println("Error:" + e.getMessage());
	}request.getSession().setAttribute("cart", cart);
	request.setAttribute("cart", cart);
	
	try {
	    request.removeAttribute("products");
	    request.setAttribute("products", model.doRetrieveAll());
	} catch (SQLException e) {
	    System.out.println("Error:" + e.getMessage());
	}
	
	RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/ProductViewAdmin.jsp");
	dispatcher.forward(request, response); 
	}

/**

@see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
*/
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	doGet(request, response);
}
}