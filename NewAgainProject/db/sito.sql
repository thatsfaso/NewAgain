DROP DATABASE IF EXISTS sito;
CREATE DATABASE sito;
USE sito;

CREATE TABLE product ( 
  id int primary key auto_increment,
  descrizione varchar(100),
  prezzo double,
  quantita int ,
  foto mediumblob,
  sesso varchar(255),
  nome varchar(50)
);

CREATE TABLE utente (
    email VARCHAR(50) PRIMARY KEY,
    nome VARCHAR(50),
    cognome VARCHAR(50),
    indirizzo VARCHAR(100),
    citta VARCHAR(50),
    provincia VARCHAR(50),
    cap VARCHAR(10),
    pass VARCHAR(50) 
);

CREATE TABLE immagini (
  cod int primary key auto_increment,
  codprodotto int,
  img mediumblob,
  foreign key (codprodotto) references product(id)
);

CREATE TABLE ordine (
  numeroOrdine INT PRIMARY KEY auto_increment,
  dataOrdine DATE,
  totale DECIMAL(10, 2),
  stato VARCHAR(50),
  email VARCHAR(50),
  FOREIGN KEY (email) REFERENCES utente(email)
);

CREATE TABLE composizione(
	IVA double not null default 22,
    quantita int,
    totale double,
    email varchar(50),
    numeroO int,
    primary key(email, numeroO),
    foreign key (email) REFERENCES utente(email),
    foreign key (numeroO) REFERENCES Ordine(numeroOrdine)
);

INSERT INTO product (descrizione,prezzo,quantita,sesso,nome) VALUES ("Cargo Nike nero",12,2,'F', "Cargo Nike Donna");
INSERT INTO product (descrizione,prezzo,quantita,sesso) VALUES ('Maglietta Nike grigia', 29.99, 10, 'M');
INSERT INTO product (descrizione,prezzo,quantita,sesso) VALUES ('Polo Ralph Lauren nera ', 59.99, 5, 'M');
INSERT INTO product (descrizione,prezzo,quantita,sesso) VALUES ('Felpa Nike nera', 49.99, 8, 'U');
INSERT INTO product (descrizione,prezzo,quantita,sesso) VALUES ('Jeans Levi\'s color jeans ', 89.99, 3, 'M');
INSERT INTO product (descrizione,prezzo,quantita,sesso,nome) VALUES ('Maglione Lacoste beige', 79.99, 6,'F', "Maglione Lacoste Donna");
INSERT INTO immagini (codprodotto) VALUES (1);
INSERT INTO immagini (codprodotto) VALUES (1);
INSERT INTO immagini (codprodotto) VALUES (1);
INSERT INTO immagini (codprodotto) VALUES (1);

INSERT INTO utente (email, nome, cognome, indirizzo, citta, provincia, cap, pass) VALUES ('mario.rossi@gmail.com', 'Mario', 'Rossi', 'Via Roma 1', 'Milano', 'Milano', '20121', 'mario123');
INSERT INTO utente (email, nome, cognome, indirizzo, citta, provincia, cap, pass) VALUES ('giulia.verdi@gmail.com', 'Giulia', 'Verdi', 'Via Garibaldi 2', 'Firenze', 'Firenze', '50122', 'giulia123');
INSERT INTO utente (email, nome, cognome, indirizzo, citta, provincia, cap, pass) VALUES ('palmadaniela218@gmail.com', 'Daniela', 'Palma', 'Contrada Carrara 13', 'Castelpoto', 'Benevento', '82030', 'dani123');
INSERT INTO utente (email, nome, cognome, indirizzo, citta, provincia, cap, pass) VALUES ('angelo.genito.000@gmail.com', 'Angelo', 'Genito', 'Contrada Olmeri 1', 'Benevento', 'Benevento', '82100', 'angelo123');
Insert into ordine (dataOrdine, totale, stato, email) VALUES ("2022-11-10",22,"ordine consegnato", "palmadaniela218@gmail.com");
insert into composizione (quantita, totale, email, numeroO) values (1, 22.6, "palmadaniela218@gmail.com", 1);