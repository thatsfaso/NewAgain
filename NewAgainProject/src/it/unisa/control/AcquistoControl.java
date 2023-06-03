package it.unisa.control;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.unisa.model.AcquistoDao;
import it.unisa.model.Cart;


/**
 * Servlet implementation class AcquistoControl
 */
@WebServlet("/AcquistoControl")
public class AcquistoControl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
	AcquistoDao	model = new AcquistoDao();
    public AcquistoControl() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		Cart cart = (Cart)request.getSession().getAttribute("cart");
		String action = request.getParameter("action");
		if (action != null) {
			
			if (action.equalsIgnoreCase("visualizza")) {
				String pagamento = request.getParameter("Pagamento");
				String numeroCarta = request.getParameter("card-number");
				String titolareCarta = request.getParameter("card-holder");
				String scadenzaCarta = request.getParameter("expiration-date");
				String cvv = request.getParameter("cvv");
				String TipoC = request.getParameter("delivery-option");
				String indirizzo = request.getParameter("address");
				String citta = request.getParameter("citta");
				String cap = request.getParameter("CAP");
				String provincia = request.getParameter("provincia");
				request.setAttribute("provincia", provincia);
				request.setAttribute("citta", citta);
				request.setAttribute("cap", cap);
				request.setAttribute("indirizzo", indirizzo);
				request.setAttribute("TipoC", TipoC);
				request.setAttribute("cart",cart);
				request.setAttribute("Pagamento", pagamento);
				request.setAttribute("numeroCarta", numeroCarta);
				request.setAttribute("card-holder", titolareCarta);
				request.setAttribute("scadenzaCarta",scadenzaCarta);
				request.setAttribute("cvv", cvv);
				RequestDispatcher dispatcher = request.getRequestDispatcher("/ConfermaOrdine.jsp");
				dispatcher.forward(request, response);
			}
			if (action.equalsIgnoreCase("completa")) {
				String pagamento = request.getParameter("Pagamento");
				String numeroCarta = request.getParameter("NumeroC");
				String titolareCarta = request.getParameter("TitolareC");
				String scadenzaCarta = request.getParameter("ScadenzaC");
				String cvv = request.getParameter("cvv");
				String TipoC = request.getParameter("Tipocons");
				String indirizzo = request.getParameter("indirizzo");
				String citta = request.getParameter("citta");
				String cap = request.getParameter("cap");
				String provincia = request.getParameter("provincia");
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/prova.jsp");
				dispatcher.forward(request, response);
				
			}
	}

}}
