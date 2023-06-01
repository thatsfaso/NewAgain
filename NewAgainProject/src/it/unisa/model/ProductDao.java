package it.unisa.model;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.LinkedList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class ProductDao {

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
	private static final String TABLE_NAME = "product";
	
	public synchronized void doSave(Prodotto product) throws SQLException {
	    Connection connection = null;
	    PreparedStatement preparedStatement = null;
	    String insertSQL = "INSERT INTO " + ProductDao.TABLE_NAME + " (descrizione, prezzo, quantita,foto, sesso, nome) VALUES (?, ?, ?,?, ?, ?)";

	    try {
	        connection = ds.getConnection();
	        preparedStatement = connection.prepareStatement(insertSQL);
	        preparedStatement.setString(1, product.getDescrizione());
	        preparedStatement.setDouble(2, product.getPrezzo());
	        preparedStatement.setInt(3, product.getQuantita());
	        InputStream inputStream = new ByteArrayInputStream(product.getImg());
	        preparedStatement.setBinaryStream(4, inputStream, product.getImg().length);
	        preparedStatement.setString(5, product.getSesso());
	        preparedStatement.setString(6, product.getNome());
	        preparedStatement.executeUpdate();
	    } finally {
	        try {
	            if (preparedStatement != null) {
	                preparedStatement.close();
	            }
	        } finally {
	            if (connection != null) {
	                connection.close();
	            }
	        }
	    }
	}
	public synchronized Prodotto Cambiafoto(int codef, int codp) throws SQLException{
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Prodotto bean = new Prodotto();

		String selectSQL = "SELECT * FROM " + ProductDao.TABLE_NAME + " WHERE id = ?";
		String selectsql2 = "SELECT img FROM immagini WHERE cod = ?";
		String selectsql3 = "SELECT cod,img FROM immagini WHERE codprodotto = ?";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setInt(1, codp);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				bean.setID(rs.getInt("id"));
				bean.setDescrizione(rs.getString("descrizione"));
				bean.setPrezzo(rs.getDouble("prezzo"));
				bean.setQuantita(rs.getInt("quantita"));
				bean.setImg(rs.getBytes("foto"));
			}

		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null)
					connection.close();
			}
		}
		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectsql2);
			preparedStatement.setInt(1, codef);

			ResultSet rs = preparedStatement.executeQuery();						
			while (rs.next()) {
			    immagine i = new immagine();
			    i.setImg(rs.getBytes("img"));
			    bean.setImg(i.getImg());								
			}
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null)
					connection.close();
			}
		}
		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectsql3);
			preparedStatement.setInt(1, codp);

			ResultSet rs = preparedStatement.executeQuery();
			ArrayList<immagine> a = new ArrayList<immagine>();						
			while (rs.next()) {
			    immagine i = new immagine();
			    i.setId(rs.getInt("cod"));
			    i.setImg(rs.getBytes("img"));
			    a.add(i);								
			}
			bean.setAllimg(a);
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null)
					connection.close();
			}
		}
		return bean;
	}
		

	public synchronized Prodotto doRetrieveByKey(int code) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Prodotto bean = new Prodotto();

		String selectSQL = "SELECT * FROM " + ProductDao.TABLE_NAME + " WHERE id = ?";
		String selectsql2 = "SELECT cod,img FROM immagini WHERE codprodotto = ?";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setInt(1, code);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				bean.setID(rs.getInt("id"));
				bean.setNome(rs.getString("nome"));
				bean.setDescrizione(rs.getString("descrizione"));
				bean.setPrezzo(rs.getDouble("prezzo"));
				bean.setQuantita(rs.getInt("quantita"));
				bean.setImg(rs.getBytes("foto"));
			}

		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null)
					connection.close();
			}
		}
		
	    // Check se l'immagine è nulla e assegna un'immagine vuota
	    if (bean.getImg() == null) {
	        byte[] emptyImage = new byte[0];
	        bean.setImg(emptyImage);
	    }
		
		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectsql2);
			preparedStatement.setInt(1, code);

			ResultSet rs = preparedStatement.executeQuery();
			ArrayList<immagine> a = new ArrayList<immagine>();						
			while (rs.next()) {
			    immagine i = new immagine();
			    i.setId(rs.getInt("cod"));
			    i.setImg(rs.getBytes("img"));
			    a.add(i);								
			}
			bean.setAllimg(a);
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null)
					connection.close();
			}
		}
		return bean;
	}

	public synchronized boolean doDelete(int code) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		int result = 0;

		String deleteSQL = "UPDATE " + ProductDao.TABLE_NAME + " SET quantita = 1 WHERE id = ?";


		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(deleteSQL);
			preparedStatement.setInt(1, code);

			result = preparedStatement.executeUpdate();

		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null)
					connection.close();
			}
		}
		return (result != 0);
	}
	public synchronized boolean doupdateq(int code) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		int result = 0;

		String deleteSQL = "UPDATE " + ProductDao.TABLE_NAME + " SET quantita = 0 WHERE id = ?";


		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(deleteSQL);
			preparedStatement.setInt(1, code);

			result = preparedStatement.executeUpdate();

		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null)
					connection.close();
			}
		}
		return (result != 0);
	}

	public synchronized Collection<Prodotto> doRetrieveAll() throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Collection<Prodotto> products = new LinkedList<Prodotto>();

		String selectSQL = "SELECT * FROM " + ProductDao.TABLE_NAME;

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				Prodotto bean = new Prodotto();

				bean.setID(rs.getInt("id"));
				bean.setDescrizione(rs.getString("descrizione"));
				bean.setPrezzo(rs.getInt("prezzo"));
				bean.setQuantita(rs.getInt("quantita"));
				Blob blob = rs.getBlob("foto");
				bean.setSesso(rs.getString("sesso"));
				bean.setNome(rs.getString("nome"));
				byte[] imageByte = blob.getBytes(1,(int) blob.length());
				bean.setImg(imageByte);
				
				 // Check se l'immagine è nulla e assegna un'immagine vuota
	            if (bean.getImg() == null) {
	                byte[] emptyImage = new byte[0];
	                bean.setImg(emptyImage);
	            }
				
				products.add(bean);
			}

		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null)
					connection.close();
			}
		}
		return products;
	}
	public synchronized Collection<Prodotto> doRetrieveBySesso(String s1) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Collection<Prodotto> products = new LinkedList<Prodotto>();

		String selectSQL = "SELECT * FROM " + ProductDao.TABLE_NAME + " WHERE sesso = ? OR sesso = 'U'";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setString(1,s1);
			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				Prodotto bean = new Prodotto();

				bean.setID(rs.getInt("id"));
				bean.setDescrizione(rs.getString("descrizione"));
				bean.setPrezzo(rs.getInt("prezzo"));
				bean.setQuantita(rs.getInt("quantita"));
				bean.setSesso(rs.getString("sesso"));
				bean.setNome(rs.getString("nome"));
				Blob blob = rs.getBlob("foto");
				byte[] imageByte = blob.getBytes(1,(int) blob.length());
				bean.setImg(imageByte);
				products.add(bean);
			}

		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null)
					connection.close();
			}
		}
		return products;
	}
	
	public synchronized void doUpdate(Prodotto product) throws SQLException {
	    Connection connection = null;
	    PreparedStatement preparedStatement = null;
	    String updateSQL = "UPDATE " + ProductDao.TABLE_NAME + " SET descrizione = ?, prezzo = ?, quantita = ?, foto = ?, sesso = ?, nome = ? WHERE id = ?";

	    try {
	        connection = ds.getConnection();
	        preparedStatement = connection.prepareStatement(updateSQL);
	        preparedStatement.setString(1, product.getDescrizione());
	        preparedStatement.setDouble(2, product.getPrezzo());
	        preparedStatement.setInt(3, product.getQuantita());
	        InputStream inputStream = new ByteArrayInputStream(product.getImg());
	        preparedStatement.setBinaryStream(4, inputStream, product.getImg().length);
	        preparedStatement.setString(5, product.getSesso());
	        preparedStatement.setString(6, product.getNome());
	        preparedStatement.setInt(7, product.getID());
	        preparedStatement.executeUpdate();
	    } finally {
	        try {
	            if (preparedStatement != null) {
	                preparedStatement.close();
	            }
	        } finally {
	            if (connection != null) {
	                connection.close();
	            }
	        }
	    }
	}


}