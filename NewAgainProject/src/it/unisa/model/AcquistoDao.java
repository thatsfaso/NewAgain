package it.unisa.model;



import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class AcquistoDao {
	public class OrdineDAO {
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
	   

}}
