package it.unisa.model;

import java.util.ArrayList;

public class Prodotto {
	int id;
	int Quantita;
	String Nome;
	String Descrizione;
	double Prezzo;
	String Sesso;
	byte [] img;
	ArrayList<immagine> allimg;
	
	public int getID() {
		return id;
	}
	public void setID(int id) {
		this.id = id;
	}
	public int getQuantita() {
		return Quantita;
	}
	public void setQuantita(int quantita) {
		Quantita= quantita;
	}
	public String getDescrizione() {
		return Descrizione;
	}
	public void setDescrizione(String descrizione) {
		Descrizione = descrizione;
	}
	public String getNome() {
		return Nome;
	}
	public void setNome(String nome) {
		Nome = nome;
	}
	public double getPrezzo() {
		return Prezzo;
	}
	public void setPrezzo(double prezzo) {
		Prezzo = prezzo;
	}
	public byte[] getImg() {
		return img;
	}
	public void setImg(byte[] img) {
		this.img = img;
	}
	public ArrayList<immagine> getAllimg() {
		return allimg;
	}
	public void setAllimg(ArrayList<immagine> allimg) {
		this.allimg = allimg;
	}
	public String getSesso() {
		return Sesso;
	}
	public void setSesso(String sesso) {
		Sesso = sesso;
	}
		
}