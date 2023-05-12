package it.unisa.control;

import org.apache.commons.io.IOUtils;

import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import it.unisa.model.Cart;
import it.unisa.model.Prodotto;

import it.unisa.model.ProductDao;
/**
 * Servlet implementation class ProductControl
 */
public class ProductControl extends HttpServlet {
	private static final long serialVersionUID = 1L;	
	
	ProductDao	model = new ProductDao();
	
	public ProductControl() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		Cart cart = (Cart)request.getSession().getAttribute("cart");
		if(cart == null) {
			cart = new Cart();
			request.getSession().setAttribute("cart", cart);
		}
		
		String action = request.getParameter("action");

		try {
			if (action != null) {
				
				if (action.equalsIgnoreCase("addC")) {
					int id =Integer.parseInt(request.getParameter("id"));
					cart.addProduct(model.doRetrieveByKey(id));
					request.setAttribute("cart",cart);
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/carrello.jsp");
					dispatcher.forward(request, response);
				} 
				
				else if (action.equalsIgnoreCase("deleteC")) {
					int id =Integer.parseInt(request.getParameter("id"));
					cart.deleteProduct(model.doRetrieveByKey(id));
					request.setAttribute("cart", cart);
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/carrello.jsp");
					dispatcher.forward(request, response);
					} 
				
				else if (action.equalsIgnoreCase("read")) {
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
				else if (action.equalsIgnoreCase("change")) {
					int idfoto = Integer.parseInt(request.getParameter("id"));
					int idprod = Integer.parseInt(request.getParameter("productid"));
					request.setAttribute("product", model.Cambiafoto(idfoto,idprod));
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/ProductDetails.jsp");
					dispatcher.forward(request, response);				
				}
				
				else if (action.equalsIgnoreCase("insert")) {
					String descrizione = request.getParameter("descrizione");
					double prezzo = Double.parseDouble(request.getParameter("prezzo"));
					int quantita = Integer.parseInt(request.getParameter("quantita"));
					InputStream inputStream = request.getPart("foto").getInputStream();
					// Convertire l'InputStream in un array di byte utilizzando Apache Commons IO
					byte[] bytes = null;
					try {
					    bytes = IOUtils.toByteArray(inputStream);
					} catch (IOException e) {
					    e.printStackTrace();
					}
					// Chiudere l'InputStream
					inputStream.close();

					Prodotto bean = new Prodotto();
					bean.setDescrizione(descrizione);
					bean.setPrezzo(prezzo);
					bean.setQuantita(quantita);
					bean.setImg(bytes);
					model.doSave(bean);
				}
				else if (action.equalsIgnoreCase("dettaglio")) {
					String sesso = request.getParameter("sesso");
					try {
						request.removeAttribute("products");
						request.setAttribute("products", model.doRetrieveBySesso(sesso));
					} catch (SQLException e) {
						System.out.println("Error:" + e.getMessage());
					}

					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/ProductView.jsp");
					dispatcher.forward(request, response);
				}
				else if(action.equalsIgnoreCase("viewC")) {
					request.setAttribute("cart",cart);
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/carrello.jsp");
					dispatcher.forward(request, response);					
				}
				else if (action.equalsIgnoreCase("all")) {
					try {
						request.removeAttribute("products");
						request.setAttribute("products", model.doRetrieveAll());
					} catch (SQLException e) {
						System.out.println("Error:" + e.getMessage());
					}

					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/ProductView.jsp");
					dispatcher.forward(request, response);
					}
			}			
		} catch (SQLException e) {
			System.out.println("Error:" + e.getMessage());
		}

		request.getSession().setAttribute("cart", cart);
		request.setAttribute("cart", cart);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}