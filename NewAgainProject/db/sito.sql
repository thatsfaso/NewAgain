DROP DATABASE IF EXISTS sito;
CREATE DATABASE sito;
USE sito;

CREATE TABLE product ( 
  id int primary key,
  descrizione varchar(100),
  prezzo double,
  quantita int ,
  foto longblob
);

CREATE TABLE utente (
    email VARCHAR(50) PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    cognome VARCHAR(50) NOT NULL,
    indirizzo VARCHAR(100) NOT NULL,
    citta VARCHAR(50) NOT NULL,
    provincia VARCHAR(50) NOT NULL,
    cap VARCHAR(10) NOT NULL,
    pwd VARCHAR(50) NOT NULL
);


INSERT INTO product (id,descrizione,prezzo,quantita) VALUES (01,"Cargo",12,2);
INSERT INTO utente (email, nome, cognome, indirizzo, citta, provincia, cap, pwd) VALUES ('palmadaniela218@gmail.com', 'Daniela', 'Palma', 'Contrada Carrara 13', 'Castelpoto', 'Benevento', '82030', 'dani123');
INSERT INTO utente (email, nome, cognome, indirizzo, citta, provincia, cap, pwd) VALUES ('angelo.genito.000@gmail.com', 'Angelo', 'Genito', 'Contrada Olmeri 1', 'Benevento', 'Benevento', '82100', 'angelo123');