
CREATE TRIGGER dodawanie_gry
--po dodaniu gry do tabeli gra uzupe³niane
--sa rowniez tabele pegi cena i wydawca
   ON [dbo].[gra] 
   INSTEAD OF INSERT
   AS
   DECLARE @tytul VARCHAR(20)
   DECLARE @nazwa_wydawcy VARCHAR (20)
   DECLARE @cena decimal(6,2)
   DECLARE	@pegi TINYINT 
   SELECT @nazwa_wydawcy=i.nazwa_wydawcy from inserted i;
   SELECT @cena=i.cena from inserted i;
   SELECT @pegi=i.pegi from inserted i;
   SELECT @tytul=i.tytul from inserted i;

	BEGIN
	IF @pegi NOT IN (SELECT * FROM pegi)
		INSERT INTO pegi VALUES (@pegi)
	IF @nazwa_wydawcy NOT IN (SELECT * FROM wydawca)
		INSERT INTO wydawca VALUES (@nazwa_wydawcy)
	IF @cena NOT IN (SELECT * FROM cena)
		INSERT INTO cena VALUES (@cena)
	IF @tytul NOT IN (SELECT tytul FROM gra)
		INSERT INTO gra VALUES (@tytul,@pegi,@nazwa_wydawcy,@cena)
	
	END; 
	GO
CREATE TRIGGER usuwanie_klienta
--kiedy usuniemy klienta usuwaja sie rowniez jego zamowienia i klucze kupione przez niego 
   ON [dbo].[klient] 
   INSTEAD OF DELETE
   AS
   DECLARE @email_klienta VARCHAR (20)
   SELECT @email_klienta=i.email_klienta from deleted i;

   

	BEGIN
	DELETE FROM zamowienie WHERE @email_klienta=email_klienta
	DELETE FROM klucze where klucze.klucz IN (
	SELECT klucze.klucz
	FROM klucze
	inner join gra_platforma on gra_platforma.id_gra_platforma=klucze.id_gra_platforma
	inner join zamowienie on klucze.klucz=zamowienie.klucz1 
	OR klucze.klucz=zamowienie.klucz2				
	OR klucze.klucz=zamowienie.klucz3 				
	OR klucze.klucz=zamowienie.klucz4 				
	OR klucze.klucz=zamowienie.klucz5 
	WHERE email_klienta=@email_klienta 
	)
	
	DELETE FROM klient WHERE @email_klienta=email_klienta
	END; 
GO
CREATE TRIGGER zamiana_danych_klienta
--kiedy zmieniamy maila klienta w tabeli klient rowniez zamieniany jest email w  zamowieniach
   ON [dbo].[klient] 
   INSTEAD OF UPDATE
   AS
	DECLARE @email_klienta VARCHAR (20)
    DECLARE @email_klienta_old VARCHAR (20)
	SELECT @email_klienta=i.email_klienta from inserted i;
	SELECT  @email_klienta_old=i.email_klienta from deleted i;
	BEGIN
	IF (SELECT dbo.czy_email_poprawny(@email_klienta))=1 AND @email_klienta NOT IN klient.email_klienta
		BEGIN
		CREATE TABLE #tmp1
		(
			email_klienta VARCHAR(20) ,
			imie_klienta VARCHAR(20),
			nazwisko_klienta VARCHAR(20),
			haslo VARCHAR(20),
		
		)
		INSERT INTO #tmp1(email_klienta,imie_klienta,haslo) SELECT email_klienta,imie_klienta,haslo FROM klient WHERE @email_klienta_old=klient.email_klienta
		
		CREATE TABLE #tmp2
		(
			id_zamowienie INT PRIMARY KEY IDENTITY (1,1),
			email_klienta VARCHAR(20) ,
			klucz1  VARCHAR(20), 
			klucz2  VARCHAR(20) ,
			klucz3  VARCHAR(20) ,
			klucz4  VARCHAR(20) ,
			klucz5  VARCHAR(20) ,
		
		)
		
		
		INSERT INTO #tmp2(email_klienta,klucz1,klucz2,klucz3,klucz4,klucz5) SELECT email_klienta,klucz1,klucz2,klucz3,klucz4,klucz5 FROM zamowienie WHERE @email_klienta_old=zamowienie.email_klienta	
		
		UPDATE #tmp1
		SET #tmp1.email_klienta=@email_klienta WHERE email_klienta=@email_klienta_old
		UPDATE #tmp2
		SET #tmp2.email_klienta=@email_klienta  WHERE email_klienta=@email_klienta_old
		
		DELETE FROM zamowienie WHERE email_klienta=@email_klienta_old
		DELETE FROM klient WHERE email_klienta=@email_klienta_old
		INSERT INTO klient SELECT * FROM #tmp1
		INSERT INTO zamowienie SELECT email_klienta,klucz1,klucz2,klucz3,klucz4,klucz5 FROM #tmp2
		DROP TABLE #tmp1
		DROP TABLE #tmp2
		END
	ELSE
	BEGIN
	PRINT 'Podaj poprawny email'
	END
	END; 
	--SELECT email_klienta FROM zamowienie
	--SELECT email_klienta FROM klient
	--UPDATE klient
	--SET email_klienta='adamek636@wp.pl' where email_klienta='fin417@gmail.com'
	
	