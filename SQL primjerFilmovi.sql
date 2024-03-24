/*
	(5 bodova)

	1. Kreiranje nove baze podataka kroz SQL kod u obliku Ime_Prezime_BrojIndeksa, na sljedeći način:

		a) primarni data fajl:
			- veličina:				20 MB
			- maksimalna veličina: 	neograničena
			- postotak rasta:		15%

		b) log fajl
			- veličina:				10 MB
			- maksimalna veličina: 	neograničena
			- postotak rasta:		5%

	Napomena: Svi fajlovi treba da budu kreirani u folderu C:\Juli kojeg treba kreirati ako ne postoji
*/

/*
	(15 bodova)
	2. Unutar prethodno kreirane baze podataka iz zadatka 1., kreirati tabele sa sljedecom strukturom:

	Dvorane
		ID - automatski generator cjelobrojnih vrijednosti i primarni ključ
		Naziv - polje za unos 100 UNICODE karaktera, obavezno polje
		DatumKreiranja - polje za unos datuma i vremena dodavanja zapisa (obavezan unos), DEFAULT je datum i vrijeme unosa (poželjno UTC datum)
		DatumModifikovanja - polje za unos datuma i vremena izmjene originalnog zapisa, DEFAULT je NULL

	Sjedista (jedna dvorana ima više sjedišta, a sjedište sa određenom kolonom i redom je unikatno u jednoj dvorani)
		ID - automatski generator unikatnih vrijednosti i primarni ključ, DEFAULT nova unikatna vrijednost
		Kolona - polje za unos cjelobrojnih vrijednosti, obavezno polje
		Red - polje za unos cjelobrojnih vrijednosti, obavezno polje
		DatumKreiranja - polje za unos datuma i vremena dodavanja zapisa (obavezan unos), DEFAULT je datum i vrijeme unosa (poželjno UTC datum)
		DatumModifikovanja - polje za unos datuma i vremena izmjene originalnog zapisa, DEFAULT je NULL

	Filmovi
		ID - automatski generator cjelobrojnih NEPARNIH vrijednosti i primarni ključ
		IzvorniNaziv - polje za unos 200 UNICODE karaktera, DEFAULT je NULL
		Naziv - polje za unos 200 UNICODE karaktera, obavezno polje
		DatumIzlaska - polje za unos datuma bez vremenskog dijela
		TrajanjeMinuta - polje za unos cjelobrojnih vrijednosti
		DatumKreiranja - polje za unos datuma i vremena dodavanja zapisa (obavezan unos), DEFAULT je datum i vrijeme unosa (poželjno UTC datum)
		DatumModifikovanja - polje za unos datuma i vremena izmjene originalnog zapisa, DEFAULT je NULL

	Projekcije (jedna projekcija prikazuje jedan film i u jednoj dvorani)
		ID - automatski generator cjelobrojnih PARNIH vrijednosti i primarni ključ
		VrijemePocetka - polje za unos datuma i vremena, obavezno polje
		CijenaUlaznice - polje za unos decimalne vrijednosti preciznosi 4 sa dva decimalna mjesta, obavezno polje
		DatumKreiranja - polje za unos datuma i vremena dodavanja zapisa (obavezan unos), DEFAULT je datum i vrijeme unosa (poželjno UTC datum)
		DatumModifikovanja - polje za unos datuma i vremena izmjene originalnog zapisa, DEFAULT je NULL

	Ulaznice (jedna ulaznica je za jedno sjedište i jednu projekciju)
		ID - automatski generator unikatnih vrijednosti i primarni ključ, DEFAULT nova unikatna vrijednost
		Cijena - polje za unos decimalne vrijednosti preciznosi 4 sa dva decimalna mjesta, obavezno polje
		Kod - polje za unos 10 karaktera, obavezno polje
		DatumKreiranja - polje za unos datuma i vremena dodavanja zapisa (obavezan unos), DEFAULT je datum i vrijeme unosa (poželjno UTC datum)
		DatumModifikovanja - polje za unos datuma i vremena izmjene originalnog zapisa, DEFAULT je NULL
*/

/*
	(10 bodova)
	3. UNOS PODATAKA (Nakon svakog podzadatka provjeriti da li su podaci unešeni)

	a) U tabelu "Dvorane" unijeti dva zapisa sa nazivima "Dvorana NBP1" i "Dvorana NBP2"

	b) U tabelu "Filmovi" unijeti sljedeće vrijednosti:
		The Lord of the Rings: The Two Towers - Gospodar prstenova: Dvije kule - 5. decembar 2002. - 179 minuta
		Inception - Početak - 8. juli 2010. - 148 minuta
		The Dark Knight - Vitez tame - 14. juli 2008. - 152 minute

	c) U tabelu "Projekcije" unijeti vrijednosti koje zadovoljavaju sljedeće parametre:
		Film "Inception" igra 1. avgusta 2022. godine u 21:00 sati u Dvorani NBP1, po cijeni ulaznice 10 KM
		Film "Vitez tame" igra 2. avgusta 2022. godine u 20:30 sati u Dvorani NBP2, po cijeni ulaznice 12 KM
		Film "Gospodar prstenova: Dvije kule" igra 3. avgusta 2022. godine u 19:00 sati u Dvorani NBP1, po cijeni ulaznice 15 KM
*/

/*
	(5 bodova)
	4. U tabelu "Dvorane" dodati novu kolonu:
	BrojSjedista - polje cjelobrojnog tipa čija vrijednost ne smije biti negativna
*/

/*
	(10 bodova)
	5. Kreirati uskladištenu proceduru usp_GridGenerator koja će generisati sjedišta u obliku koordinatne mreže sa M kolona i N redova za određenu dvoranu. Ulazni parametri DvoranaID, broj kolona (M), broj redova (N).
	Npr. (kolona, red)
	1,1		1,2		1,3		1,4		1,5
	2,1		2,2		2,3		2,4		2,5
	3,1		3,2		3,3		3,4		3,5
	4,1		4,2		4,3		4,4		4,5
	5,1		5,2		5,3		5,4		5,5

	a) Za dvoranu "Dvorana NBP1" generisati 100 sjedišta u koordinatnoj mreži 10 kolona x 10 redova. Ažurirati vrijednost kolone Dvorane -> BrojSjedista
	b) Za dvoranu "Dvorana NBP2" generisati 48 sjedišta u koordinatnoj mreži 8 kolona x 6 redova. Ažurirati vrijednost kolone Dvorane -> BrojSjedista
*/

/*
	(10 bodova)
	6. Kreirati funkciju udf_CodeGenerator čiji su ulazni parametri @ulaz UNIQUEIDENTIFIER i @duzina INT. Funkcija modifikuje @input na zahtijevanu dužinu i vraća rezultat maksimalne dužine 32. U slučaju da je vrijednost N veća od 32 ili manja od 0, postaviti vrijednost N na 10.
	Provjeriti tačnost funkcije sa vrijednostima:
	a) -1 - ispisat će 10 alfanumeričkih karaktera
	b) 33 - ispisat će 10 alfanumeričkih karaktera
	c) 7 - uspješno će generisati vrijednost od 7 alfanumeričkih karaktera
*/

/*
	(10 bodova)
	7. 
	a) Kreirati uskladištenu proceduru usp_ProdajaUlaznica koja će izvršavati logiku prodaje ulaznica. Ulazni parametri su:
		ProjekcijaID - tip ID kolone iz tabele Projekcija
		Kolona - tip Kolona kolone iz tabele Sjedista
		Red - tip Red kolone iz tabele Sjedista

	Napomene: 
		- "Kolona" i "Red" se ne unose u tabelu Ulaznice, već ID sjedišta za projekciju. 
		- Za vrijednost "Kod" koristiti prethodnu funkciju udf_CodeGenerator koja generiše 10 unikatnih alfanumeričkih karaktera.
		- Za vrijednost "Cijena" koristiti trenutnu vrijednost iz "Projekcije -> CijenaUlaznice" za projekciju

	b) Izvršiti prodaju po nekoliko ulaznica koristeći usp_ProdajaUlaznica.
*/

/*
	(10 bodova)
	8a. Kreirati tabelu IzmjenaCijenaLog sa kolonama:
		ProjekcijaID - polje cjelobrojnog tipa
		StaraCijenaUlaznice - polje decimalnog tipa preciznosti 4 sa 2 decimalna mjesta
		NovaCijenaUlaznice - polje decimalnog tipa preciznosti 4 sa 2 decimalna mjesta
		DatumIzmjene - polje za unos datuma i vremena, DEFAULT je datum i vrijeme unosa (poželjno UTC datum)

	8b. Kreirati okidač tg_IzmjenaCijena na tabelu Projekcije koja će pri ažuriranju vrijednosti CijenaUlaznice na bilo kojem zapisu, unijeti podatke u tabelu IzmjenaCijenaLog:
		ProjekcijaID -> ID projekcije koja se ažurira
		StaraCijenaUlaznice -> cijena prije ažuriranja
		NovaCijenaUlaznice -> cijena poslije ažuriranja

	Testirati okidač izmjenom cijene za projekciju promjenom cijene sa 15,00 KM na 13,00 KM
*/

/*
	(10 bodova)
	9. Kreirati pogled vw_ZauzetostDvorana koja za svaku dvoranu prikazuje trenutno stanje zauzetih i slobodnih sjedišta.
*/

/*
	(5 bodova)
	10a. Kreirati backup vaše baze na istu lokaciju na kojoj se nalazi trenutna baza (C:\Juli)
*/

/*
	(5 bodova)
	10b. Brisanje svih zapisa iz tabela
	Kreirati proceduru koja briše sve zapise iz svih tabela unutar jednog izvršenja. Testirati da li su podaci obrisani	
*/

/*
	(5 bodova)
	10c. Uraditi restore rezervene kopije baze podataka 
*/

-- 1. Kreiranje nove baze podataka










USE master;
GO

CREATE DATABASE Ime_Prezime_BrojIndeksa
ON PRIMARY
(
    NAME = Ime_Prezime_BrojIndeksa_data,
    FILENAME = 'C:\Juli\Ime_Prezime_BrojIndeksa_data.mdf',
    SIZE = 20MB,
    MAXSIZE = UNLIMITED,
    FILEGROWTH = 15%
)
LOG ON
(
    NAME = Ime_Prezime_BrojIndeksa_log,
    FILENAME = 'C:\Juli\Ime_Prezime_BrojIndeksa_log.ldf',
    SIZE = 10MB,
    MAXSIZE = UNLIMITED,
    FILEGROWTH = 5%
);
GO

-- 2. Kreiranje tabela
USE Ime_Prezime_BrojIndeksa;
GO

CREATE TABLE Dvorane (
    ID INT IDENTITY(1, 1) PRIMARY KEY,
    Naziv NVARCHAR(100) NOT NULL,
    DatumKreiranja DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    DatumModifikovanja DATETIME2 DEFAULT NULL
);

CREATE TABLE Sjedista (
    ID INT IDENTITY(1, 1) PRIMARY KEY,
    DvoranaID INT NOT NULL,
    Kolona INT NOT NULL,
    Red INT NOT NULL,
    DatumKreiranja DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    DatumModifikovanja DATETIME2 DEFAULT NULL,
    CONSTRAINT FK_Sjedista_Dvorane FOREIGN KEY (DvoranaID) REFERENCES Dvorane (ID)
);

CREATE TABLE Filmovi (
    ID INT IDENTITY(1, 2) PRIMARY KEY,
    IzvorniNaziv NVARCHAR(200) DEFAULT NULL,
    Naziv NVARCHAR(200) NOT NULL,
    DatumIzlaska DATE,
    TrajanjeMinuta INT,
    DatumKreiranja DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    DatumModifikovanja DATETIME2 DEFAULT NULL
);

CREATE TABLE Projekcije (
    ID INT IDENTITY(2, 2) PRIMARY KEY,
    VrijemePocetka DATETIME2 NOT NULL,
    CijenaUlaznice DECIMAL(9, 2) NOT NULL,
    DatumKreiranja DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    DatumModifikovanja DATETIME2 DEFAULT NULL,
    CONSTRAINT CHK_Projekcije_CijenaUlaznice CHECK (CijenaUlaznice >= 0)
);

CREATE TABLE Ulaznice (
    ID INT IDENTITY(1, 1) PRIMARY KEY,
    SjedisteID INT NOT NULL,
    ProjekcijaID INT NOT NULL,
    Cijena DECIMAL(9, 2) NOT NULL,
    Kod NVARCHAR(10) NOT NULL,
    DatumKreiranja DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    DatumModifikovanja DATETIME2 DEFAULT NULL,
    CONSTRAINT FK_Ulaznice_Sjedista FOREIGN KEY (SjedisteID) REFERENCES Sjedista (ID),
    CONSTRAINT FK_Ulaznice_Projekcije FOREIGN KEY (ProjekcijaID) REFERENCES Projekcije (ID)
);

-- 3. Unos podataka
-- a) U tabelu "Dvorane" unijeti dva zapisa
INSERT INTO Dvorane (Naziv) VALUES ('Dvorana NBP1'), ('Dvorana NBP2');

-- b) U tabelu "Filmovi" unijeti vrijednosti
INSERT INTO Filmovi (IzvorniNaziv, Naziv, DatumIzlaska, TrajanjeMinuta)
VALUES (NULL, 'The Lord of the Rings: The Two Towers', '2002-12-05', 179),
       (NULL, 'Inception', '2010-07-08', 148),
       (NULL, 'The Dark Knight', '2008-07-14', 152);

-- c) U tabelu "Projekcije" unijeti vrijednosti
INSERT INTO Projekcije (VrijemePocetka, CijenaUlaznice)
VALUES ('2022-08-01 21:00:00', 10),
       ('2022-08-02 20:30:00', 12),
       ('2022-08-03 19:00:00', 15);

-- 4. Dodavanje nove kolone u tabelu "Dvorane"
ALTER TABLE Dvorane ADD BrojSjedista INT CHECK (BrojSjedista >= 0);

-- 5. Kreiranje uskladištene procedure za generisanje sjedišta
CREATE PROCEDURE usp_GridGenerator
    @DvoranaID INT,
    @M INT,
    @N INT
AS
BEGIN
    DECLARE @BrojSjedista INT = @M * @N;
    
    UPDATE Dvorane SET BrojSjedista = @BrojSjedista WHERE ID = @DvoranaID;

    ;WITH CTE AS (
        SELECT
            ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS RN,
            SjedisteID = ROW_NUMBER() OVER (PARTITION BY DvoranaID ORDER BY (SELECT NULL)),
            Kolona = (ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) - 1) % @M + 1,
            Red = (ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) - 1) / @M + 1
        FROM sys.all_objects
    )
    INSERT INTO Sjedista (DvoranaID, Kolona, Red)
    SELECT @DvoranaID, Kolona, Red
    FROM CTE
    WHERE RN <= @BrojSjedista;
END;

-- a) Generisanje sjedišta za "Dvorana NBP1"
EXEC usp_GridGenerator @DvoranaID = 1, @M = 10, @N = 10;

-- b) Generisanje sjedišta za "Dvorana NBP2"
EXEC usp_GridGenerator @DvoranaID = 2, @M = 8, @N = 6;

-- 6. Kreiranje funkcije za generisanje koda
CREATE FUNCTION udf_CodeGenerator
    (@ulaz UNIQUEIDENTIFIER, @duzina INT)
RETURNS NVARCHAR(32)
AS
BEGIN
    SET @duzina = CASE WHEN @duzina > 32 OR @duzina < 0 THEN 10 ELSE @duzina END;

    DECLARE @rezultat NVARCHAR(32);
    SET @rezultat = CONVERT(NVARCHAR(32), HASHBYTES('MD5', @ulaz), 2);

    RETURN SUBSTRING(@rezultat, 1, @duzina);
END;

-- Provjera funkcije
SELECT udf_CodeGenerator(NEWID(), -1) AS Test1; -- Generisaće 10 alfanumeričkih karaktera
SELECT udf_CodeGenerator(NEWID(), 33) AS Test2; -- Generisaće 10 alfanumeričkih karaktera
SELECT udf_CodeGenerator(NEWID(), 7) AS Test3; -- Generisaće 7 alfanumeričkih karaktera

-- 7. Kreiranje uskladištene procedure za prodaju ulaznica
CREATE PROCEDURE usp_ProdajaUlaznica
    @ProjekcijaID INT,
    @Kolona INT,
    @Red INT
AS
BEGIN
    DECLARE @Cijena DECIMAL(9, 2);

    -- Dohvati cijenu ulaznice za projekciju
    SELECT @Cijena = CijenaUlaznice FROM Projekcije WHERE ID = @ProjekcijaID;

    -- Generiši kod ulaznice
    DECLARE @Kod NVARCHAR(10) = udf_CodeGenerator(NEWID(), 10);

    -- Unesi ulaznicu
    INSERT INTO Ulaznice (SjedisteID, ProjekcijaID, Cijena, Kod)
    VALUES ((SELECT ID FROM Sjedista WHERE DvoranaID = (SELECT DvoranaID FROM Projekcije WHERE ID = @ProjekcijaID) AND Kolona = @Kolona AND Red = @Red),
            @ProjekcijaID,
            @Cijena,
            @Kod);
END;

-- Izvrši prodaju ulaznica
EXEC usp_ProdajaUlaznica @ProjekcijaID = 2, @Kolona = 2, @Red = 3;
EXEC usp_ProdajaUlaznica @ProjekcijaID = 2, @Kolona = 3, @Red = 4;
EXEC usp_ProdajaUlaznica @ProjekcijaID = 2, @Kolona = 4, @Red = 5;

-- 8a. Kreiranje tabele IzmjenaCijenaLog
CREATE TABLE IzmjenaCijenaLog (
    ProjekcijaID INT,
    StaraCijenaUlaznice DECIMAL(9, 2),
    NovaCijenaUlaznice DECIMAL(9, 2),
    DatumIzmjene DATETIME2 DEFAULT GETUTCDATE()
);

-- 8b. Kreiranje okidača za ažuriranje cijene ulaznice
CREATE TRIGGER tg_IzmjenaCijena
ON Projekcije
AFTER UPDATE
AS
BEGIN
    IF UPDATE(CijenaUlaznice)
    BEGIN
        INSERT INTO IzmjenaCijenaLog (ProjekcijaID, StaraCijenaUlaznice, NovaCijenaUlaznice)
        SELECT ID, CijenaUlaznice, (SELECT CijenaUlaznice FROM INSERTED)
        FROM DELETED;
    END;
END;

-- Testiranje okidača ažuriranjem cijene za projekciju
UPDATE Projekcije SET CijenaUlaznice = 13 WHERE ID = 2;

-- 9. Kreiranje pogleda za zauzetost dvorana
CREATE VIEW vw_ZauzetostDvorana
AS
SELECT
    D.ID AS DvoranaID,
    D.Naziv AS NazivDvorane,
    COUNT(U.ID) AS BrojZauzetihSjedista,
    D.BrojSjedista - COUNT(U.ID) AS BrojSlobodnihSjedista
FROM Dvorane D
LEFT JOIN Sjedista S ON D.ID = S.DvoranaID
LEFT JOIN Ulaznice U ON S.ID = U.SjedisteID
GROUP BY D.ID, D.Naziv, D.BrojSjedista;

-- 10a. Backup baze podataka
BACKUP DATABASE Ime_Prezime_BrojIndeksa TO DISK = 'C:\Juli\Ime_Prezime_BrojIndeksa.bak';

-- 10b. Brisanje svih zapisa iz tabela
CREATE PROCEDURE usp_ObrisiSveZapise
AS
BEGIN
    DELETE FROM Ulaznice;
    DELETE FROM Projekcije;
    DELETE FROM Filmovi;
    DELETE FROM Sjedista;
    DELETE FROM Dvorane;
END;

-- Izvrši brisanje svih zapisa
EXEC usp_ObrisiSveZapise;

-- 10c. Restore rezervne kopije baze podataka
-- Koristite SQL Server Management Studio (SSMS) za obnovu rezervne kopije baze podataka
