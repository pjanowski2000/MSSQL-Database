--TWORZENIE TABEL

CREATE TABLE cena(
cena decimal(6,2) PRIMARY KEY,
)
CREATE TABLE wydawca(
nazwa_wydawcy VARCHAR(20) PRIMARY KEY,
)
CREATE TABLE pegi(
pegi TINYINT  PRIMARY KEY,
)
CREATE TABLE gatunek(
gatunek VARCHAR(20) PRIMARY KEY,
)
CREATE TABLE platforma(
nazwa_platformy VARCHAR(20) PRIMARY KEY,
)

CREATE TABLE klient(
email_klienta VARCHAR(20) PRIMARY KEY,
imie_klienta VARCHAR(20),
nazwisko_klienta VARCHAR(20),
haslo VARCHAR(20),

) 
CREATE TABLE gra(
tytul VARCHAR(20) PRIMARY KEY,
pegi TINYINT  FOREIGN KEY REFERENCES pegi(pegi),
  nazwa_wydawcy  VARCHAR(20) REFERENCES wydawca(nazwa_wydawcy),
 cena decimal(6,2) FOREIGN KEY REFERENCES cena(cena),
)
CREATE TABLE gra_gatunek(
id_gra_gatunek INT PRIMARY KEY IDENTITY (1,1),
tytul  VARCHAR(20) FOREIGN KEY REFERENCES gra(tytul),
  gatunek  VARCHAR(20) FOREIGN KEY REFERENCES gatunek(gatunek),
)
CREATE TABLE gra_platforma(
id_gra_platforma INT PRIMARY KEY IDENTITY (1,1),
tytul  VARCHAR(20) FOREIGN KEY REFERENCES gra(tytul),
nazwa_platformy  VARCHAR(20) FOREIGN KEY REFERENCES platforma(nazwa_platformy),
)
CREATE TABLE klucze(
klucz VARCHAR(20) PRIMARY KEY,
id_gra_platforma INT FOREIGN KEY REFERENCES gra_platforma(id_gra_platforma),
)

CREATE TABLE zamowienie(
id_zamowienie INT PRIMARY KEY IDENTITY (1,1),
email_klienta VARCHAR(20) FOREIGN KEY REFERENCES klient(email_klienta),
klucz1  VARCHAR(20) FOREIGN KEY REFERENCES klucze(klucz),
klucz2  VARCHAR(20) FOREIGN KEY REFERENCES klucze(klucz),
klucz3  VARCHAR(20) FOREIGN KEY REFERENCES klucze(klucz),
klucz4  VARCHAR(20) FOREIGN KEY REFERENCES klucze(klucz),
klucz5  VARCHAR(20) FOREIGN KEY REFERENCES klucze(klucz),
)

	