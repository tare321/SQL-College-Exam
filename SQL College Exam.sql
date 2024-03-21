/* Ispit iz Naprednih baza podataka 08.02.2024.godine*/

/*
	1. Kreiranje nove baze podataka kroz SQL kod, sa default postavkama servera  (5)
*/

CREATE DATABASE baza
use baza



/*
	2a. Kreiranje tabela i unošenje testnih podataka (10)

	Unutar svoje baze podataka kreirati tabele sa slijede?om strukturom:

Pacijenti
	PacijentID, automatski generator neparnih vrijednosti - primarni klju?
	JMB, polje za unos 13 UNICODE karaktera (obavezan unos) - jedinstvena vrijednost
	Prezime, polje za unos 50 UNICODE karaktera (obavezan unos)
	Ime, polje za unos 50 UNICODE karaktera (obavezan unos)
	DatumRodjenja, polje za unos datuma, DEFAULT je NULL
	DatumKreiranja, polje za unos datuma dodavanja zapisa (obavezan unos) DEFAULT je datum unosa
	DatumModifikovanja, polje za unos datuma izmjene originalnog zapisa , DEFAULT je NULL

Titule
	TitulaID, automatski generator vrijednosti - primarni klju?
	Naziv, polje za unos 100 UNICODE karaktera (obavezan unos)
	DatumKreiranja, polje za unos datuma dodavanja zapisa (obavezan unos) DEFAULT je datum unosa
	DatumModifikovanja, polje za unos datuma izmjene originalnog zapisa , DEFAULT je NULL

Osoblje (Jednu titulu može imati više osoba)
	OsobljeID, automatski generator vrijednosti i primarni kljuè
	Prezime, polje za unos 50 UNICODE karaktera (obavezan unos)
	Ime, polje za unos 50 UNICODE karaktera (obavezan unos)
	DatumKreiranja, polje za unos datuma dodavanja zapisa (obavezan unos) DEFAULT je datum unosa
	DatumModifikovanja, polje za unos datuma izmjene originalnog zapisa , DEFAULT je NULL

Pregledi (Pacijent može izvršiti samo jedan pregled kod istog doktora unutar termina)
	PregledID, polje za unos cijelih brojeva (obavezan unos)
	DatumPregleda, polje za unos datuma (obavezan unos) DEFAULT je datum unosa
	Dijagnoza polje za unos 1000 UNICODE karaktera (obavezan unos)
*/

CREATE TABLE Pacijenti (
    PacijentID INT IDENTITY(1, 2) PRIMARY KEY,
    JMB NVARCHAR(13) NOT NULL UNIQUE,
    Prezime NVARCHAR(50) NOT NULL,
    Ime NVARCHAR(50) NOT NULL,
    DatumRodjenja DATE DEFAULT NULL,
    DatumKreiranja DATE NOT NULL DEFAULT GETDATE(),
    DatumModifikovanja DATE DEFAULT NULL
);


CREATE TABLE Titule (
    TitulaID INT IDENTITY(1, 1) PRIMARY KEY,
    Naziv NVARCHAR(100) NOT NULL,
    DatumKreiranja DATE NOT NULL DEFAULT GETDATE(),
    DatumModifikovanja DATE DEFAULT NULL
);


CREATE TABLE Osoblje (
    OsobljeID INT IDENTITY(1, 1) PRIMARY KEY,
    Prezime NVARCHAR(50) NOT NULL,
    Ime NVARCHAR(50) NOT NULL,
    DatumKreiranja DATE NOT NULL DEFAULT GETDATE(),
    DatumModifikovanja DATE DEFAULT NULL
);


CREATE TABLE Pregledi (
    PregledID INT NOT NULL,
    DatumPregleda DATE NOT NULL DEFAULT GETDATE(),
    Dijagnoza NVARCHAR(1000) NOT NULL,
    PRIMARY KEY (PregledID, DatumPregleda)
);



/*
		2b. Izmjena tabele "Pregledi" (5)

Modifikovati tabelu Pregledi i dodati dvije kolone:
DatumKreiranja, polje za unos datuma dodavanja zapisa (obavezan unos) DEFAULT je datum unosa
DatumModifikovanja, polje za unos datuma izmjene originalnog zapisa , DEFAULT je NULL
*/



	ALTER TABLE Pregledi
ADD DatumKreiranja DATE NOT NULL DEFAULT GETDATE(),
    DatumModifikovanja DATE DEFAULT NULL;



/*
		2b. Izmjena tabele "Pregledi" (5)

Modifikovati tabelu Pregledi i dodati dvije kolone:
DatumKreiranja, polje za unos datuma dodavanja zapisa (obavezan unos) DEFAULT je datum unosa
DatumModifikovanja, polje za unos datuma izmjene originalnog zapisa , DEFAULT je NULL
*/





/*
		2c. Unošenje testnih podataka (10)

Iz baze podataka Northwind, a putem podupita dodati sve zapise iz tabele Employees:
(LastName, FirstName, BirthDate) u tabelu Pacijenti. Za JMB koristiti SQL funkciju koja
generiše slu?ajne i jedinstvene ID vrijednosti. Obavezno testirati da li su podaci u tabeli.

U tabelu Titule, jednom komandom, dodati: Stomatolog, Oftalmolog, Ginekolog,
Pulmolog i Onkolog. Obavezno testirati da li su podaci u tabeli.

U tabelu Osoblje, jednom komandom, dodati proizvoljna dva zapisa. 
Obavezno testirati da li su podaci u tabeli.

*/

INSERT INTO Pacijenti (JMB, Prezime, Ime, DatumRodjenja)
SELECT
    LEFT(REPLACE(CONVERT(NVARCHAR(36), NEWID()), '-', ''), 13) AS JMB,
    LastName,
    FirstName,
    BirthDate
FROM NORTHWND.dbo.Employees;



INSERT INTO Titule (Naziv)
VALUES ('stomatolog'), ('psihijatar'), ('pedijatar'), ('hirurg'), ('anesteziolog');

SELECT * FROM Titule;


INSERT INTO Osoblje (Prezime, Ime)
VALUES ('Kubat', 'Tarik'), ('Kubi', 'Tare');


SELECT * FROM Osoblje;



/*
	2d. Kreirati uskladištenu proceduru (10) 

Procedura ?e u tabelu Pregledi dodati 4 zapisa proizvoljnog karaktera. Obavezno testirati da li su podaci u tabeli.
*/
CREATE PROCEDURE DodajZapiseUTabeluPregledi
AS
BEGIN
    
    INSERT INTO Pregledi (PregledID, DatumPregleda, Dijagnoza)
    VALUES
        (1, GETDATE(), 'viroza'),
        (2, GETDATE(), 'gripa'),
        (3, GETDATE(), 'korona'),
        (4, GETDATE(), 'kasalj');
END;

EXEC DodajZapiseUTabeluPregledi;

SELECT * FROM Pregledi



/*
	3. Kreiranje procedure za izmjenu podataka u tabeli "Pregledi" (10)

Koja ?e izvršiti izmjenu podataka u tabeli Pregledi, tako što ?e modifikovati dijagnoza za odre?eni pregled. 
Tako?er, potrebno je izmjeniti vrijednost još jednog atributa u tabeli kako bi zapis o poslovnom procesu
bio potpun. Obavezno testirati da li su podaci u tabeli modifikovani
*/
CREATE PROCEDURE IzmijeniPodatkeUTabeliPregledi
    @PregledID INT,
    @NovaDijagnoza NVARCHAR(1000)
AS
BEGIN
    
    UPDATE Pregledi
    SET Dijagnoza = @NovaDijagnoza,
        DatumModifikovanja = GETDATE()
    WHERE PregledID = @PregledID;
END;

EXEC IzmijeniPodatkeUTabeliPregledi
    @PregledID = 1,
    @NovaDijagnoza = 'Nova dijagnoza';

	SELECT * FROM Pregledi;




/*
	4. Kreiranje pogleda (5)

Kreirati pogled sa slijede?om definicijom: Prezime i ime pacijenta, datum pregleda, titulu, prezime i ime
doktora, dijagnozu i datum zadnje izmjene zapisa, ali samo onim pacijentima kojima je modfikovana
dijagnoza. Obavezno testirati funkcionalnost view objekta.

*/

CREATE VIEW PogledPregledi AS
SELECT
    p.Prezime AS PrezimePacijenta,
    p.Ime AS ImePacijenta,
    pr.DatumPregleda,
    t.Naziv AS Titula,
    o.Prezime AS PrezimeDoktora,
    o.Ime AS ImeDoktora,
    pr.Dijagnoza,
    pr.DatumModifikovanja
FROM Pregledi pr
JOIN Pacijenti p ON p.PacijentID = p.PacijentID
JOIN Osoblje o ON o.OsobljeID = o.OsobljeID
JOIN Titule t ON t.TitulaID = t.TitulaID
WHERE pr.DatumModifikovanja IS NOT NULL;

SELECT * FROM PogledPregledi;


/* GRANICA ZA OCJENU 6 (55 bodova) */



/*
	5. Prilagodjavanje tabele "Pacijenti" (5)

Modifikovati tabelu Pacijenti i dodati slijede?e tri kolone:
	Email, polje za unos 100 UNICODE karaktera, DEFAULT je NULL
	Lozinka, polje za unos 100 UNICODE karaktera, DEFAULT je NULL
	Telefon, polje za unos 100 UNICODE karaktera, DEFAULT je NUL
*/

ALTER TABLE Pacijenti
ADD Email NVARCHAR(100) DEFAULT NULL,
    Lozinka NVARCHAR(100) DEFAULT NULL,
    Telefon NVARCHAR(100) DEFAULT NULL;


/*
	6. Dodavanje dodatnih zapisa u tabelu "Pacijenti" (5)

Kreirati uskladištenu proceduru koja ?e iz baze podataka AdventureWorks i tabela:
Person.Person, HumanResources.Employee, Person.Password, Person.EmailAddress i
Person.PersonPhone mapirati odgovaraju?e kolone i prebaciti sve zapise u tabelu Pacijenti.
Obavezno testirati da li su podaci u tabeli

*/

select * from Pacijenti
CREATE PROCEDURE PrenesiPodatkeIzAdventurWorks
AS
BEGIN
   
    INSERT INTO Pacijenti (JMB, Prezime, Ime, DatumRodjenja)
    SELECT
        REPLACE(CONVERT(NVARCHAR(13), NEWID()), '-', '') AS JMB,
        p.LastName,
        p.FirstName,
        p.BirthDate
    FROM AdventureWorks2017.Person.Person p;

  
    UPDATE Pacijenti
    SET Email = e.EmailAddress
    FROM Pacijenti p
    JOIN AdventureWorks2017.HumanResources.Employee e ON p.JMB = e.BusinessEntityID;

 
    UPDATE Pacijenti
    SET Lozinka = pa.PasswordHash
    FROM Pacijenti p
    JOIN AdventureWorks2017.Person.Password pa ON p.JMB = pa.BusinessEntityID;

 
    UPDATE Pacijenti
    SET Telefon = pe.PhoneNumber
    FROM Pacijenti p
    JOIN AdventureWorks2017.Person.EmailAddress pe ON p.JMB = pe.BusinessEntityID;
END;

EXEC PrenesiPodatkeIzAdveturWorks;

SELECT * FROM Pacijenti;






/*
	7. Izmjena podataka u tabel "Pacijenti" (10)

Kreirati uskladištenu proceduru koja ?e u vašoj bazi podataka, svim pacijentima generisati novu email
adresu u formatu: Ime.Prezime@size.ba, lozinku od 12 karaktera putem SQL funkciju koja generiše
slu?ajne i jedinstvene ID vrijednosti i podatak da je postoje?i zapis u tabeli modifikovan.
*/



/*
	8. Kriranje upita i indeksa (5)

Napisati upit koji prikazuje prezime i ime pacijenta, datum pregleda, dijagnozu i spojene podatke o
doktoru (titula, prezime i ime doktora). U obzir dolaze samo oni pacijenti koji imaju dijagnozu ili ?ija
email adresa po?inje sa slovom „L“. 
Nakon toga kreirati indeks koji ?e prethodni upit, prema vašem mišljenju, maksimalno ubrzati
*/



/*
	9a. Brisanje pacijenata bez pregleda (5)

Kreirati uskladištenu proceduru koja briše sve pacijente koji nemaju realizovan niti jedan pregled.
Obavezno testirati funkcionalnost procedure. 
*/

/* 9b. Eliminacijski (10)
Izlistati inventar svih proizvoda po lokacijama ?ija ukupna koli?ina prelazi 700 jedinica. Upit treba da sadrži kolone Lokacija, Naziv proizvoda, Koli?ina i Po?etni znak. Kolona po?etni znak sadrži prva dva znaka iz kolone ProductNumber.

Rezultat je potrebno poredati abecedno po lokaciji inventara i po opadaju?oj koli?ini.
*/
SELECT 
    L.Name AS 'Lokacija',
    P.Name AS 'Naziv proizvoda',
    SUM(PI.Quantity) AS 'Kolicina',
    LEFT(P.ProductNumber, CHARINDEX('-', P.ProductNumber) - 1) AS 'Pocetni znak'
FROM Production.Product AS P
INNER JOIN Production.ProductInventory AS PI ON P.ProductID = PI.ProductID
INNER JOIN Production.Location AS L ON PI.LocationID = L.LocationID
GROUP BY L.Name, P.Name, LEFT(P.ProductNumber, CHARINDEX('-', P.ProductNumber) - 1)
HAVING SUM(PI.Quantity) > 700
ORDER BY L.Name, SUM(PI.Quantity) DESC


/*
	10. Backup i restore baze podataka (5)
Kreirati backup vaše baze na default lokaciju servera, izbrisati bazu, a zatim uraditi restore rezervne kopije.
*/

--backup moje baze
BACKUP DATABASE baza
TO DISK = 'default'

--restore rezervne kopije moje baze
RESTORE DATABASE Baza
FROM DISK = 'default'