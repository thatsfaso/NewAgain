package it.unisa.control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import it.unisa.model.Utente;
import it.unisa.model.UtenteDao;

/**

Servlet implementation class RegistrationControl
*/
public class RegistrationControl extends HttpServlet {
private static final long serialVersionUID = 1L;
UtenteDao model = new UtenteDao();
/**

@see HttpServlet#HttpServlet()
*/
public RegistrationControl() {
super();
}
/**

@see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
*/
protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String action = request.getParameter("action");
    
    if (action != null && action.equalsIgnoreCase("logout")) {
        HttpSession session = request.getSession();
        session.invalidate();
        response.sendRedirect("Home.jsp");
    }
}
/**

@see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
*/
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	String action = request.getParameter("action");
	try {
		
	if (action != null) {
		
		if (action.equalsIgnoreCase("insert")) {
			String email = request.getParameter("email");
			String pass = request.getParameter("pass");
			String nome = request.getParameter("nome");
			String cognome = request.getParameter("cognome");
			String citta = request.getParameter("citta");
			String indirizzo = request.getParameter("indirizzo");
			String provincia = request.getParameter("provincia");
			String cap = request.getParameter("cap");
			
			Utente bean = new Utente();
			bean.setEmail(email);
			bean.setPass(pass);
			bean.setCap(cap);
			bean.setCitta(citta);
			bean.setCognome(cognome);
			bean.setNome(nome);
			bean.setIndirizzo(indirizzo);
			bean.setProvincia(provincia);
			model.doSave(bean);
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/Home.jsp");
			dispatcher.forward(request, response);
		}
		if (action.equalsIgnoreCase("insertbreve")) {
			String email = request.getParameter("email");
			String pass = request.getParameter("pass");
			String nome = request.getParameter("nome");
			String cognome = request.getParameter("cognome");
			
			Utente bean = new Utente();
			bean.setEmail(email);
			bean.setPass(pass);
			bean.setCognome(cognome);
			bean.setNome(nome);
		
			model.doSaveRistretto(bean);
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/Home.jsp");
			dispatcher.forward(request, response);
		}
		if (action.equalsIgnoreCase("login")){
            String email = request.getParameter("username");
            String pwd = request.getParameter("pass");
            
            try {
                UtenteDao dao = new UtenteDao();
                Utente utente = dao.doRetrieveByEmail(email);
                
                if (utente != null && utente.getPass().equals(pwd)) {
                    HttpSession session = request.getSession();
                    session.setAttribute("email", utente.getEmail());
                    session.setAttribute("citta", utente.getCitta());
                    session.setAttribute("cognome", utente.getCognome());
                    session.setAttribute("pass", utente.getPass());
                    session.setAttribute("indirizzo", utente.getIndirizzo());
                    session.setAttribute("cap", utente.getCap());
                    session.setAttribute("provincia", utente.getProvincia());
                    session.setAttribute("nome", utente.getNome()); 
                    session.setAttribute("tipo_account", utente.getTipo_account());
                    if(utente.getTipo_account()==0) {
                    response.sendRedirect(request.getContextPath() + "/Home.jsp");
                    } 
                    else if (utente.getTipo_account() == 1) {
                        response.sendRedirect(request.getContextPath() + "/Amministratore.jsp");
                    }
                    else {
                	request.setAttribute("errore", "Email o password non validi");
                    request.getRequestDispatcher("/Accedi.jsp").forward(request, response);
                }
            } }catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("errore", "Errore del database: " + e.getMessage());
                request.getRequestDispatcher("/Accedi.jsp").forward(request, response);
            }
        }
		if (action.equalsIgnoreCase("searchByEmail")) {

		    try {
		    	String email = request.getParameter("email");
	            // Esegui la logica per ottenere gli utenti corrispondenti all'email dal tuo database
		        UtenteDao dao = new UtenteDao();
		        List<Utente> utenti = dao.searchByEmail(email);

	            // Converte gli utenti in formato JSON e invia la risposta
	            Gson gson = new Gson();
	            String json = gson.toJson(utenti);
	            response.setContentType("application/json");
	            response.setCharacterEncoding("UTF-8");
	            response.getWriter().write(json);

		    } catch (SQLException e) {
		        e.printStackTrace();
		        request.setAttribute("errore", "Errore del database: " + e.getMessage());
		    }
		}
        if (action != null && action.equalsIgnoreCase("modifica")) {
            String email = request.getParameter("email");
            String nome = request.getParameter("nome");
            String cognome = request.getParameter("cognome");
            String indirizzo = request.getParameter("indirizzo");
            String citta = request.getParameter("citta");
            String provincia = request.getParameter("provincia");
            String cap = request.getParameter("cap");
            String pass = request.getParameter("pass");
            
            Utente utente = new Utente();
            utente.setEmail(email);
            utente.setNome(nome);
            utente.setCognome(cognome);
            utente.setIndirizzo(indirizzo);
            utente.setCitta(citta);
            utente.setProvincia(provincia);
            utente.setCap(cap);
            utente.setPass(pass);
            
            UtenteDao utenteDao = new UtenteDao();
            utenteDao.doUpdate(utente);
            
            HttpSession session = request.getSession();
            session.setAttribute("nome", nome);
            session.setAttribute("cognome", cognome);
            session.setAttribute("indirizzo", indirizzo);
            session.setAttribute("citta", citta);
            session.setAttribute("provincia", provincia);
            session.setAttribute("cap", cap);
            
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/Profilo.jsp");
            dispatcher.forward(request, response);
        }
	}}
	catch (SQLException e) {
	System.out.println("Error:" + e.getMessage());
	request.setAttribute("errore2", "Username gia usato" );
	RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/Accedi.jsp");
	dispatcher.forward(request, response);
}
	
}}