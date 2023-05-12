package it.unisa.control;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import it.unisa.model.Utente;
import it.unisa.model.UtenteDao;

public class ModificaControl extends HttpServlet {
    private static final long serialVersionUID = 1L;
    UtenteDao model = new UtenteDao();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String nome = request.getParameter("nome");
        String cognome = request.getParameter("cognome");
        String indirizzo = request.getParameter("indirizzo");
        String citta = request.getParameter("citta");
        String provincia = request.getParameter("provincia");
        String cap = request.getParameter("cap");
        String newPass = request.getParameter("newpass");

        try {
            Utente utente = model.doRetrieveByEmail(email);

            if (utente != null) {
                // Aggiorna i dati dell'utente
                utente.setNome(nome);
                utente.setCognome(cognome);
                utente.setIndirizzo(indirizzo);
                utente.setCitta(citta);
                utente.setProvincia(provincia);
                utente.setCap(cap);

                if (newPass != null && !newPass.isEmpty()) {
                    // Se è stata fornita una nuova password, aggiorna anche quella
                    utente.setPass(newPass);
                }

                model.doUpdate(utente);

                // Aggiorna i dati nella sessione
                HttpSession session = request.getSession();
                session.setAttribute("nome", utente.getNome());
                session.setAttribute("cognome", utente.getCognome());
                session.setAttribute("indirizzo", utente.getIndirizzo());
                session.setAttribute("citta", utente.getCitta());
                session.setAttribute("provincia", utente.getProvincia());
                session.setAttribute("cap", utente.getCap());

                // Reindirizza all pagina del profilo aggiornato
                response.sendRedirect(request.getContextPath() + "/Profilo.jsp");
            } else {
                // Utente non trovato, gestisci l'errore
                request.setAttribute("errore", "Utente non trovato");
                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/Errore.jsp");
                dispatcher.forward(request, response);
            }
        } catch (SQLException e) {
            // Errore del database, gestisci l'errore
            e.printStackTrace();
            request.setAttribute("errore", "Errore del database: " + e.getMessage());
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/Errore.jsp");
            dispatcher.forward(request, response);
        }
    }
}
