CREATE PROCEDURE WszystkieZamKlienta (@input varchar(20))
	AS
	SELECT klient.imie_klienta,klient.nazwisko_klienta,gra_platforma.tytul,gra_platforma.nazwa_platformy 
	FROM klient 
	inner join zamowienie on klient.email_klienta=zamowienie.email_klienta
	inner join klucze on klucze.klucz=zamowienie.klucz1 
	OR klucze.klucz=zamowienie.klucz2				
	OR klucze.klucz=zamowienie.klucz3 				
	OR klucze.klucz=zamowienie.klucz4 				
	OR klucze.klucz=zamowienie.klucz5 				
	inner join gra_platforma on klucze.id_gra_platforma=gra_platforma.id_gra_platforma
	WHERE
	@input=klient.email_klienta
	
	--EXEC WszystkieZamKlienta 'fin417@gmail.com'
GO
CREATE PROCEDURE dodawanie_klienta(@email VARCHAR(20),@imie VARCHAR(20),@nazwisko VARCHAR(20),@haslo VARCHAR(20))
		AS
		IF (SELECT dbo.czy_email_poprawny(@email))=1
			BEGIN 
				IF (SELECT dbo.czy_haslo_poprawne(@haslo))=1
					BEGIN
					INSERT INTO klient(email_klienta,imie_klienta,nazwisko_klienta,haslo)
					VALUES
					(@email,@imie,@nazwisko,@haslo)
					END
				ELSE
					PRINT 'Has³o musi siê sk³adaæ z ma³ych i wielkich liter cyfry i mieæ conajmniej 6 znaków'
			END
		ELSE
			PRINT 'Podaj poprawny email'
		--EXEC dbo.dodawanie_klienta @email='asa@dsa.pl',@imie='Ala',@nazwisko='Kowalska',@haslo='asdasdsa'
		


	




		