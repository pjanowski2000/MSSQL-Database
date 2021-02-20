# MSSQL-Database
MSSQL Database 
Opis bazy danych



Wykonał: Paweł Janowski
Projekt bazy danych 
Mój projekt przedstawia bazę danych sklepu internetowego z kluczami do gier komputerowych, oprócz gier i kluczy zawiera ona również informacje dotyczące klientów zamawiających klucze do gier. Baza składa się z 11 tabel. Na stronie sklepu istnieje wyszukiwarka za pomocą której możemy szukać gier za pomocą gatunku, ceny, pegi i wydawcy.
Przeznaczenie: Baza jest przeznaczona dla osoby która zarządza sklepem oraz kompletuje zamówienia 

![alt text](https://github.com/pjanowski2000/MSSQL-Database/blob/main/view.png?raw=true)
Założenia:
	Klient na jednym zamówieniu może kupić maksymalnie 5 kluczy
Omówienia tabel:

	Cena: zawiera cenę gry która zależy tylko od tego jaki to tytuł połączona jest z tabelą gra typu 1:n.Ponieważ wiele gier ma taką samą cenę .

	Wydawca: zawiera nazwę  wydawcy gry połączona jest z tabelą gra typu 1:n.Ponieważ wiele gier ma tego samego wydawcę

	Pegi: zawiera dane odnośnie europejskiego system oceniania gier komputerowych(ocenę od jakiego wieku można grać w dane gry) połączona jest z tabelą gra typu 1:n.Ponieważ wiele gier ma taką samą ocenę 

	Gatuenk: zawiera  gatunki gier połączone jest z tabelą gra_gatunek 1:n

	Gra_gatunek: jest to tabela pomocnicza łączonca grę z gatunkiem 

	Gra: zawiera tytuł gry jego wydawcę cenę i ocenę pegi.

	Gra_platforma: jest to tabela pomocnicza łącząca grę i platformę, posiada ona dane na temat gry, platformy oraz id_gry_plafformy, połączona jest ona z tabelami gra (n:1),platforma(n:1),klucze(1:n)

	Platforma: jest to tabela zawierająca nazwy platfrom na które są wydawane gry połączona jest ona z tabelą gra_platforma(1:n)

	Klucze: jest to tabela zawierająca klucze dzięki którym na danej platformie można odblokować dostęp do gry. Połączona jest ona z tabelami gra_platforma(n:1) i zamówienie (n:1)

	Zamowienia: jest to tabela zawierająca id_zamówienia, email_klienta oraz 5 kluczy. Połączona jest ona z tabelami klucze(5:n) oraz klient(n:1)

	Klient: jest to tabela zawierajaca email_klienta, imie_klienta, nazwisko klienta oraz hasło. Połączona jest z tabelą zamówiena (1:n)


Widoki:
	Popularnoscplatform jest to widok pokazujący ile na dana platformę sprzedano kluczy

	sprzedaneklucze jest to widok dzięki któremu możemy zobaczyć jakie klucze zostały sprzedane i powinny zostać usunięte z bazy

	najczesciejkupowanagra jest to widok pokazujący wszystkie tytuły oraz  liczbę sprzedanych egzemplarzy


Wyzwalacze:
	dodawanie_gry jest to wyzwalacz który zamiast wprowadzać dane tylko do tabeli gra wypełnia również tabele wydawca cena i pegi 

	usuwanie_klienta jest to wyzwalacz który oprócz usuwania rekordu klienta w tabeli klient również usuwa jego wszystkie zamówienia i usuwa jego klucze z bazy aby nikt inny nie mógł ich kupić

	zamiana_danych_klienta jest to wyzwalacz który zmienia maila klienta nie tylko w tabeli klient ale również w tabeli zamówienia


Funkcje:
	czy_email_poprawny jest to funkcja sprawdzająca poprawność emaila(czy zawiera znaki po czym @ potem znowu znaki potem kropkę i znowu znaki)

	czy_haslo_poprawne jest to funkcja sprawdzająca poprawność hasła(minimum 6 znaków , duże i małe litery oraz cyfrę)

	wartosc_zamowienia jest to funkcja  zwracająca wartość wybranego zamówienia, jeśli jego wartość przekroczy 250zł jest nabijany rabat 15%


Procedury:
	WszystkieZamKlienta jest to procedura pokazująca wszystkie zamówienia danego klienta (imie,nazwisko,tytuł,nazwe_platformy)

	dodawanie_klienta jest to procedura dodająca klienta do bazy danych która sprawdza poprawność hasła i maila 

Kolejność tworzenia bazy danych:
1)	tworzenie_tabel.sql
2)	wypełnianie_tabel.sql
3)	widoki.sql
4)	funkcje.sql
5)	procedury.sql
6)	triggery.sql

