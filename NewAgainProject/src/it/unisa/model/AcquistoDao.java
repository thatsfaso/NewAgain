package it.unisa.model;



import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class AcquistoDao {
	
		private static DataSource ds;
	    static {
			try {
				Context initCtx = new InitialContext();
				Context envCtx = (Context) initCtx.lookup("java:comp/env");

				ds = (DataSource) envCtx.lookup("jdbc/sito");

			} catch (NamingException e) {
				System.out.println("Error:" + e.getMessage());
			}
		}
	    public AcquistoDao() {}
	public void inserimentoaq(String provincia, String indirizzo, String cap, String citta, Cart cart, String email,
			String pagamento, String numeroCarta, String titolareCarta, String scadenzaCarta, String cvv) {
		Date dataCorrente = new Date();
        java.sql.Date dataOrdine = new java.sql.Date(dataCorrente.getTime());
        double prezzotot=0;
        for(Prodotto p: cart.getProducts()) {
        	prezzotot+=p.getPrezzo();
        }

    	Connection connection = null;
	    PreparedStatement preparedStatement = null;
	    String sql1 = "INSERT INTO ordine (dataOrdine, totale, stato, email, indirizzo, citta, provincia, cap)"+
	    		"VALUES (?, ?, 'In Preparazione',?, ?, ?, ?, ?)";
	    
	    try {
	        connection = ds.getConnection();
	        preparedStatement = connection.prepareStatement(sql1);
	        preparedStatement.setDate(1, dataOrdine);
	        preparedStatement.setDouble(2,prezzotot);
	        preparedStatement.setString(3,email);
	        preparedStatement.setString(4,indirizzo);
	        preparedStatement.setString(5,citta);
	        preparedStatement.setString(6,provincia);
	        preparedStatement.setString(7,cap);
	        preparedStatement.executeUpdate();

    }catch (SQLException e) {
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
    }
}
