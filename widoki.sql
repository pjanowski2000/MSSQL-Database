CREATE VIEW [popularnoscplatform] AS
	SELECT platforma.nazwa_platformy, COUNT(klucze.klucz) as 'ilość kupionych kluczy na dana platforme'
		FROM platforma
		inner join gra_platforma on gra_platforma.nazwa_platformy=platforma.nazwa_platformy
		inner join klucze on gra_platforma.id_gra_platforma=klucze.id_gra_platforma
		right join zamowienie on klucze.klucz=zamowienie.klucz1 
		OR klucze.klucz=zamowienie.klucz2				
		OR klucze.klucz=zamowienie.klucz3 				
		OR klucze.klucz=zamowienie.klucz4 				
		OR klucze.klucz=zamowienie.klucz5
		GROUP BY platforma.nazwa_platformy
GO
CREATE VIEW [najczesciejkupowanagra] AS
		SELECT gra.tytul,gra.nazwa_wydawcy,gra.cena,COUNT(klucze.klucz) as 'ilość kupionych kluczy'
		FROM klucze
		inner join gra_platforma on gra_platforma.id_gra_platforma=klucze.id_gra_platforma
		inner join zamowienie on klucze.klucz=zamowienie.klucz1 
		OR klucze.klucz=zamowienie.klucz2				
		OR klucze.klucz=zamowienie.klucz3 				
		OR klucze.klucz=zamowienie.klucz4 				
		OR klucze.klucz=zamowienie.klucz5
		right join gra on gra_platforma.tytul=gra.tytul
		GROUP BY gra.tytul,gra.nazwa_wydawcy,gra.cena
GO
CREATE VIEW [sprzedaneklucze] AS
	SELECT klucze.klucz,gra_platforma.tytul,gra_platforma.nazwa_platformy
	FROM klucze
	inner join gra_platforma on gra_platforma.id_gra_platforma=klucze.id_gra_platforma
	inner join zamowienie on klucze.klucz=zamowienie.klucz1 
	OR klucze.klucz=zamowienie.klucz2				
	OR klucze.klucz=zamowienie.klucz3 				
	OR klucze.klucz=zamowienie.klucz4 				
	OR klucze.klucz=zamowienie.klucz5 
	
	
	