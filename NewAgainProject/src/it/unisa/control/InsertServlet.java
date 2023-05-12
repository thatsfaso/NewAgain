package it.unisa.control;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import it.unisa.model.*;

/**

Servlet implementation class RegistrationControl
*/
public class InsertServlet extends HttpServlet {
private static final long serialVersionUID = 1L;
ProductDao model = new ProductDao();
/**

@see HttpServlet#HttpServlet()
*/
public InsertServlet() {
super();
}
/**

@see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
*/
protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

}
/**

@see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
*/
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	String action = request.getParameter("action");
	try {
		
	if (action != null) {
		
		if (action.equalsIgnoreCase("insert")) {
			String descrizione = request.getParameter("descrizione");
			double prezzo = Double.parseDouble(request.getParameter("prezzo"));
		    int quantita = Integer.parseInt(request.getParameter("quantita"));
			Prodotto p = new Prodotto();
			 p.setDescrizione(descrizione);
			 p.setPrezzo(prezzo);
			 p.setQuantita(quantita);
			model.doSave(p);
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/Insert.jsp");
			dispatcher.forward(request, response);
		}
	}}
	catch (SQLException e) {
	System.out.println("Error:" + e.getMessage());
}
}}