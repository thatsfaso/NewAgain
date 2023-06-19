package it.unisa.control;

import org.apache.commons.io.IOUtils;

import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
					if (action.equalsIgnoreCase("addC")) {
					    int id = Integer.parseInt(request.getParameter("id"));
					    cart.addProduct(model.doRetrieveByKey(id));
					    request.setAttribute("cart", cart);
					    
					    // Ottieni il riferimento alla pagina precedente
					    String referer = request.getHeader("Referer");
					    
					    // Reindirizza la richiesta alla pagina precedente
					    response.sendRedirect(referer);
					}
				    
				}
				else if(action.equalsIgnoreCase("svuotaC")) {
					cart.deleteAllProduct();
					request.setAttribute("cart", cart);
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
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/Amministratore.jsp");
					dispatcher.forward(request, response); 
				}
				else if (action.equalsIgnoreCase("search")) {
					String nome = request.getParameter("nome");
					try {
						request.removeAttribute("products");
						request.setAttribute("products", model.searchProducts(nome));
					} catch (SQLException e) {
						System.out.println("Error:" + e.getMessage());
					}

					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/ProductView.jsp");
					dispatcher.forward(request, response);
				}
				else if (action.equalsIgnoreCase("updateq")) {
					int id = Integer.valueOf(request.getParameter("id"));
					model.doupdateq(id);
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/Amministratore.jsp");
					dispatcher.forward(request, response); 
				}
				else if (action.equalsIgnoreCase("change")) {
					int idfoto = Integer.parseInt(request.getParameter("id"));
					int idprod = Integer.parseInt(request.getParameter("productid"));
					request.setAttribute("product", model.Cambiafoto(idfoto,idprod));
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/ProductDetails.jsp");
					dispatcher.forward(request, response);				
				}
				else if (action.equalsIgnoreCase("dettaglio")) {
				    String sesso = request.getParameter("sesso");
				    String categoria = request.getParameter("categoria");
				    try {
				        request.removeAttribute("products");
				        if (sesso != null && categoria != null) {
				            request.setAttribute("products", model.doRetrieveBySessoAndCategoria(sesso, categoria));
				        } else if (sesso != null) {
				            request.setAttribute("products", model.doRetrieveBySesso(sesso));
				        } else if (categoria != null) {
				            request.setAttribute("products", model.doRetrieveByCategoria(categoria));
				        }
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
				else if (action.equalsIgnoreCase("modifica")) {
				    int id = Integer.parseInt(request.getParameter("id"));
				    String descrizione = request.getParameter("descrizione");
				    double prezzo = Double.parseDouble(request.getParameter("prezzo"));
				    int quantita = Integer.parseInt(request.getParameter("quantita"));
				    String sesso = request.getParameter("sesso");
				    String nome = request.getParameter("nome");
				    InputStream inputStream = request.getPart("foto").getInputStream();
				    byte[] bytes = null;
				    try {
				        bytes = IOUtils.toByteArray(inputStream);
				    } catch (IOException e) {
				        e.printStackTrace();
				    }
				    inputStream.close();
				    
				    Prodotto prodotto = new Prodotto();
				    prodotto.setID(id);
				    prodotto.setDescrizione(descrizione);
				    prodotto.setPrezzo(prezzo);
				    prodotto.setQuantita(quantita);
				    prodotto.setImg(bytes);
				    prodotto.setSesso(sesso);
				    prodotto.setNome(nome);

				    try {
				        model.doUpdate(prodotto);
				        response.sendRedirect(request.getContextPath() + "/Amministratore.jsp?id=" + id);
				    } catch (SQLException e) {
				        // Errore del database, gestisci l'errore
				        e.printStackTrace();
				        request.setAttribute("errore", "Errore del database: " + e.getMessage());
				        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/Errore.jsp");
				        dispatcher.forward(request, response);
				    }
				}
				else if (action.equalsIgnoreCase("insert")) {
		            String descrizione = request.getParameter("descrizione");
		            double prezzo = Double.parseDouble(request.getParameter("prezzo"));
		            int quantita = Integer.parseInt(request.getParameter("quantita"));
		            String sesso = request.getParameter("sesso");
		            String nome = request.getParameter("nome");
		            InputStream inputStream = request.getPart("foto").getInputStream();
		            String categoria = request.getParameter("categoria");
		            byte[] bytes = null;
		            try {
		                bytes = IOUtils.toByteArray(inputStream);
		            } catch (IOException e) {
		                e.printStackTrace();
		            }
		            inputStream.close();
		            
		            Prodotto prodotto = new Prodotto();
		            prodotto.setDescrizione(descrizione);
		            prodotto.setPrezzo(prezzo);
		            prodotto.setQuantita(quantita);
		            prodotto.setImg(bytes);
		            prodotto.setSesso(sesso);
		            prodotto.setNome(nome);
		            prodotto.setCategoria(categoria);

		            try {
		                model.doSave(prodotto);
		                response.sendRedirect(request.getContextPath() + "/Amministratore.jsp");
		            } catch (SQLException e) {
		                // Errore del database, gestisci l'errore
		                e.printStackTrace();
		                request.setAttribute("errore", "Errore del database: " + e.getMessage());
		                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/Errore.jsp");
		                dispatcher.forward(request, response);
		            }
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
