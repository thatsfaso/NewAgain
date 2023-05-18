package it.unisa.model;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class OrdineDAO {
	private static DataSource ds;
    private List<Ordine> ordini;
    
    static {
		try {
			Context initCtx = new InitialContext();
			Context envCtx = (Context) initCtx.lookup("java:comp/env");

			ds = (DataSource) envCtx.lookup("jdbc/sito");

		} catch (NamingException e) {
			System.out.println("Error:" + e.getMessage());
		}
	}
    
    public OrdineDAO() {
        ordini = new ArrayList<>();
    }
    
    public void aggiungiOrdine(Ordine ordine) {
        ordini.add(ordine);
    }
    
    public List<Ordine> getOrdini(String email) {
    	Connection connection = null;
	    PreparedStatement preparedStatement = null;
    	List<Ordine> ordini = new ArrayList<>();
    	String selectSQL = "SELECT * FROM ordine WHERE email = ?";
    	
    	try {
	        connection = ds.getConnection();
	        preparedStatement = connection.prepareStatement(selectSQL);
	        preparedStatement.setString(1, email);

	        ResultSet rs = preparedStatement.executeQuery();

	        if (rs.next()) {
                int numeroOrdine = rs.getInt("numeroOrdine");
                Date data = rs.getDate("dataOrdine");
                double totale = rs.getDouble("totale");
                String stato = rs.getString("stato");
                String indirizzo = rs.getString("indirizzo");
                String cap = rs.getString("cap");
                String provincia = rs.getString("provincia");
                String citta = rs.getString("citta");
                

                Ordine ordine = new Ordine();
                ordine.setCap(cap);
                ordine.setCitta(citta);
                ordine.setData(data);
                ordine.setIndirizzo(indirizzo);
                ordine.setProvincia(provincia);
                ordine.setTotale(totale);
                ordine.setNumeroOrdine(numeroOrdine);
                ordine.setStato(stato);
                ordini.add(ordine);
	        }

	    } catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
	        try {
	            if (preparedStatement != null)
	                preparedStatement.close();
	        } catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
	            if (connection != null)
					try {
						connection.close();
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
	        }
	    }

	    return ordini;

    }

    
    public Ordine getOrdineByNumero(int numeroOrdine) {
        for (Ordine ordine : ordini) {
            if (ordine.getNumeroOrdine() == numeroOrdine) {
                return ordine;
            }
        }
        return null;
    }
    
    public void aggiornaStatoOrdine(int numeroOrdine, String nuovoStato) {
        Ordine ordine = getOrdineByNumero(numeroOrdine);
        if (ordine != null) {
            ordine.setStato(nuovoStato);
        }
    }
    
}
