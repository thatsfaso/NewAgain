package it.unisa.model;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Ordine {
    private int numeroOrdine;
    private Date dataOrdine;
    private double totale;
    private String stato;
    
    // Costruttore
    public Ordine(int numeroOrdine, Date dataOrdine, double totale, String stato) {
        this.numeroOrdine = numeroOrdine;
        this.dataOrdine = dataOrdine;
        this.totale = totale;
        this.stato = stato;
    }
    
    // Metodi getter e setter
    public int getNumeroOrdine() {
        return numeroOrdine;
    }
    
    public void setNumeroOrdine(int numeroOrdine) {
        this.numeroOrdine = numeroOrdine;
    }
    
    public Date getData() {
        return dataOrdine;
    }
    
    public void setData(Date data) {
        this.dataOrdine = data;
    }
    
    public double getTotale() {
        return totale;
    }
    
    public void setTotale(double totale) {
        this.totale = totale;
    }
    
    public String getStato() {
        return stato;
    }
    
    public void setStato(String stato) {
        this.stato = stato;
    }
    
    @Override
    public String toString() {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        String dataFormattata = dateFormat.format(dataOrdine);
        return "Numero ordine: " + numeroOrdine +
               ", Data: " + dataFormattata +
               ", Totale: " + totale +
               ", Stato: " + stato;
    }

}
