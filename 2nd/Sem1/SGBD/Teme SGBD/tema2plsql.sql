

--definirea tipului pentru subordonati (artisti asistati)
CREATE TYPE asistenti_artisti AS VARRAY(10) OF VARCHAR2(20);

--crearea tabelului pentru manageri(artisti)
CREATE TABLE artisti_manageri (
    cod_mgr NUMBER(10),
    nume VARCHAR2(20),
    lista_asistenti asistenti_artisti
);

--inserarea a 3 linii în tabel
INSERT INTO artisti_manageri VALUES (1, 'Ne-Yo', asistenti_artisti('Asistent1', 'Asistent2', 'Asistent3'));
INSERT INTO artisti_manageri VALUES (2, 'Rihanna', asistenti_artisti('Asistent4', 'Asistent5'));
INSERT INTO artisti_manageri VALUES (3, 'USHER', asistenti_artisti('Asistent6', 'Asistent7', 'Asistent8', 'Asistent9'));

-- Afi?area informa?iilor din tabel
SELECT * FROM artisti_manageri;

-- ?tergerea tabelului
DROP TABLE artisti_manageri;

-- ?tergerea tipului
DROP TYPE asistenti_artisti;



--10
--crearea tipului pentru numerele de telefon
CREATE TYPE telefoane_artisti AS VARRAY(10) OF VARCHAR2(15);

--crearea tabelului pentru artisti
CREATE TABLE artisti (
    artist_id NUMBER(10),
    nume_artist VARCHAR2(50),
    telefon telefoane_artisti
);

--inserarea artist oin tabel
INSERT INTO artisti VALUES (1, 'NumeArtist1', telefoane_artisti('123456789', '987654321'));

SELECT * FROM artisti;

--actualizarea unui nr de tlf pt un artist
UPDATE artisti
SET telefon = telefoane_artisti('987654321', '987654322')
WHERE artist_id = 1;

--afis dupa actualizare
SELECT * FROM artisti;

--stergerea tabelului
DROP TABLE artisti;

--stergerea tipului
DROP TYPE telefoane_artisti;


