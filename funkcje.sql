

CREATE FUNCTION wartosc_zamowienia (@id_zamowienie int)
	--jesli cena wieksza od 250zl rabat 15%
		RETURNS INT
		AS
		BEGIN
			DECLARE @suma int
			
			
			SELECT @suma=SUM(gra.cena) FROM gra
			INNER JOIN gra_platforma on gra_platforma.tytul=gra.tytul
			INNER JOIN klucze on gra_platforma.id_gra_platforma=klucze.id_gra_platforma
			inner join zamowienie on klucze.klucz=zamowienie.klucz1 
			OR klucze.klucz=zamowienie.klucz2				
			OR klucze.klucz=zamowienie.klucz3 				
			OR klucze.klucz=zamowienie.klucz4 				
			OR klucze.klucz=zamowienie.klucz5
			WHERE zamowienie.id_zamowienie=@id_zamowienie
			If @suma>=250
			BEGIN
					SET @suma=(@suma*0.85)
			END
			
			RETURN (@suma)
			
		END
		--SELECT dbo.wartosc_zamowienia(10)

GO
CREATE FUNCTION czy_email_poprawny (@email VARCHAR(20))
		RETURNS Bit
		AS
		BEGIN
			Declare @bit bit
			IF @email LIKE '%@%.%[a-z]'
				BEGIN
					SET @bit=1
				END 
			ELSE
			BEGIN
				SET @bit=0
			END
		RETURN(@bit)
		END
GO
CREATE FUNCTION czy_haslo_poprawne (@haslo VARCHAR(20))
		RETURNS Bit
		AS
		BEGIN
			Declare @bit bit
			IF @haslo LIKE '%[a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,r,s,t,u,w,y,z]%' and @haslo LIKE '%[0-9]%' and @haslo LIKE'%[A,B,C,D ,E ,F, G, H, I, J, K, L, M, N, O, P,R, S,T, U, W, Y, Z]%' and @haslo LIKE '______%'
				BEGIN
					SET @bit=1
				END 
			ELSE
			BEGIN
				SET @bit=0
			END
		RETURN(@bit)
		END 
	
		--drop function dbo.czy_email_poprawny
		--select dbo.czy_email_poprawny ('dsadas@wp.pl')
		--drop function dbo.czy_haslo_poprawne
		--select dbo.czy_haslo_poprawne ('lmdWsd1as')
		
		
	
	
	