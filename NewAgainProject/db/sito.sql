DROP DATABASE IF EXISTS sito;
CREATE DATABASE sito;
USE sito;

CREATE TABLE product ( 
  id int primary key auto_increment,
  descrizione varchar(100),
  prezzo double,
  quantita tinyint DEFAULT '0' ,
  foto mediumblob,
  sesso varchar(255),
  nome varchar(50),
  categoria ENUM('giacche', 'maglie', 'felpe', 'pantaloni', 'accessori', 'cappelli'),
  iva double NOT NULL DEFAULT '22'
);

CREATE TABLE utente (
    email VARCHAR(50) PRIMARY KEY,
    nome VARCHAR(50),
    cognome VARCHAR(50),
    tipo_account tinyint DEFAULT '0',
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
  totale double,
  stato ENUM('In Preparazione', 'In Consegna', 'Consegnato'),
  email VARCHAR(50),
  indirizzo VARCHAR(100),
  citta VARCHAR(50),
  provincia VARCHAR(50),
  cap VARCHAR(10),
  FOREIGN KEY (email) REFERENCES utente(email)
);

CREATE TABLE composizione(
	IVA double not null default 22,
    quantita int default 1,
    totale double,
    codP int,
    numeroO int,
    primary key(codP, numeroO),
    foreign key (codP) REFERENCES product(id),
    foreign key (numeroO) REFERENCES Ordine(numeroOrdine)
);

CREATE TABLE pagamento(
	id_pagamento int auto_increment,
    tipo ENUM('Carta di Credito', 'PayPal', 'Apple Pay'),
	titolare varchar(80),
	numero_carta varchar(16),
	scadenza varchar(5),
	CVV int,
	n_Ordine INT,
  PRIMARY KEY (id_pagamento),
  FOREIGN KEY (n_Ordine) REFERENCES ordine(numeroOrdine)
);
CREATE TABLE recensioni (
  valutazione INT,
  email VARCHAR(50),
  codp INT,
  PRIMARY KEY (codp,email),
  FOREIGN KEY (email) REFERENCES utente(email),
  FOREIGN KEY (codp) REFERENCES product(id)
);


INSERT INTO product (nome,prezzo,quantita,sesso,descrizione,categoria) VALUES ("IRON MAIDEN BLACK BAND T-SHIRT - M",50, 0, 'M', "Disponibile in colore  Nero.", "maglie");
INSERT INTO product (nome,prezzo,quantita,sesso,descrizione,categoria) VALUES ("REEBOK USA NAVY & RED #9 JAMES JERSEY - L",48, 0, 'M', "Maglia Reebok da basket USA navy e rossa '#9 James' completa di scollo a V.", "maglie");
INSERT INTO product (nome,prezzo,quantita,sesso,descrizione,categoria) VALUES ("T-SHIRT STAMPATA ROSSA TOMMY HILFIGER - L",48, 0, 'M', "T-shirt Tommy Hilfiger stampata in rosso.", "maglie");
INSERT INTO product (nome,prezzo,quantita,sesso,descrizione,categoria) VALUES ("T-SHIRT SPORTIVA BIANCA - XL",30, 0, 'M', "La maglietta sportiva è disponibile in bianco.", "maglie");
INSERT INTO product (nome,prezzo,quantita,sesso,descrizione,categoria) VALUES ("T-SHIRT STAMPATA ADIDAS REEDLEY COLLEGE - S",35, 0, 'M', "T-shirt stampata Reedley College di colore nero. Dal marchio Adidas.", "maglie");
INSERT INTO product (nome,prezzo,quantita,sesso,descrizione,categoria) VALUES ("T-SHIRT POLO ADIDAS - M",44, 0, 'M', "T-shirt polo in rosso con un collo davanti a bottone. Dal marchio Adidas.", "maglie");


INSERT INTO immagini (codprodotto) VALUES (1);
INSERT INTO immagini (codprodotto) VALUES (1);
INSERT INTO immagini (codprodotto) VALUES (1);
INSERT INTO immagini (codprodotto) VALUES (1);

INSERT INTO utente (email, nome, cognome,tipo_account, indirizzo, citta, provincia, cap, pass) VALUES ('mario.rossi@gmail.com', 'Mario', 'Rossi', 0, 'Via Roma 1', 'Milano', 'MI', '20121', 'mario123');
INSERT INTO utente (email, nome, cognome,tipo_account, indirizzo, citta, provincia, cap, pass) VALUES ('giulia.verdi@gmail.com', 'Giulia', 'Verdi',0, 'Via Garibaldi 2', 'Firenze', 'FI', '50122', 'giulia123');
INSERT INTO utente (email, nome, cognome,tipo_account, indirizzo, citta, provincia, cap, pass) VALUES ('palmadaniela218@gmail.com', 'Daniela', 'Palma', 1, 'Contrada Carrara 13', 'Castelpoto', 'BN', '82030', 'dani123');
INSERT INTO utente (email, nome, cognome,tipo_account, indirizzo, citta, provincia, cap, pass) VALUES ('angelo.genito.000@gmail.com', 'Angelo', 'Genito', 0, 'Contrada Olmeri 1', 'Benevento', 'BN', '82100', 'angelo123');
INSERT INTO ordine (dataOrdine, totale, stato, email, indirizzo, citta, provincia, cap) VALUES ("2022-11-10",22,'Consegnato', "palmadaniela218@gmail.com", 'Contrada Carrara 13', 'Castelpoto', 'BN', '82030');
INSERT INTO composizione (quantita, totale, codP, numeroO) values (1, 22.6, 1, 1);
INSERT INTO composizione (quantita, totale, codP, numeroO) values (1, 22.6, 2, 1);
INSERT INTO composizione (quantita, totale, codP, numeroO) values (1, 22.6, 6, 2);
INSERT INTO composizione (quantita, totale, codP, numeroO) values (1, 22.6, 3, 2);

INSERT INTO pagamento (id_pagamento, tipo, titolare, numero_carta, scadenza, CVV, n_Ordine) VALUES (1, 'Carta di Credito', 'Iliano Fasolino', '5354566943441223', 12-24, 666, 1);
INSERT INTO ordine (dataOrdine, totale, stato, email, indirizzo, citta, provincia, cap) VALUES ("2023-11-10",22,'In Preparazione', "giulia.verdi@gmail.com", 'Via Garibaldi 2', 'Firenze', 'FI', '50122');
INSERT INTO ordine (dataOrdine, totale, stato, email, indirizzo, citta, provincia, cap) VALUES ("2021-11-10",22,'In Preparazione', "giulia.verdi@gmail.com", 'Contrada Carrara 13', 'Castelpoto', 'BN', '82030');

