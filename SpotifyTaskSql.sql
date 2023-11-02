CREATE DATABASE Spotify

USE Spotify

CREATE TABLE Users
(
Id INT PRIMARY KEY IDENTITY,
[Name] VARCHAR(50) NOT NULL,
Surname VARCHAR(50) DEFAULT'XXX',
Username VARCHAR(50) NOT NULL,
[Password] VARCHAR(100) NOT NULL,
Gender VARCHAR(10),
)

CREATE TABLE Artists
(
Id INT PRIMARY KEY IDENTITY,
[Name] VARCHAR(50) NOT NULL,
Surname VARCHAR(50) DEFAULT'XXX',
Birthday DATE,
Gender VARCHAR(10),
)

CREATE TABLE Categories
(
Id INT PRIMARY KEY IDENTITY,
[Name] VARCHAR(50) NOT NULL,
)

CREATE TABLE Musics
(
Id INT PRIMARY KEY IDENTITY,
[Name] VARCHAR(50) NOT NULL,
Duration INT,
CategoryId INT REFERENCES Categories(Id),
ArtistId INT REFERENCES Artists(Id)
)

CREATE TABLE Playlist
(
MusicId INT REFERENCES Musics(Id),
UserId INT REFERENCES Users(Id)
)

INSERT INTO Users VALUES
('Rashad','Rufullayev','raboi808','salam123','male'),
('Alpay','Abdullayev','alphay0','alpay123','male'),
('Shamama','Quliyeva','semama1','samama123','female'),
('Sebuhi','Camalzade','jamalzadehh','sebuhi321','male')

INSERT INTO Artists VALUES
('Zuzu','Qurbanova','02.01.2004','Female'),
('Asiman','Qasimzade','03.04.2004','Male'),
('Murad','Qenberov','04.04.2004','Male'),
('Mehriban','Xelilova','05.03.2004','Female')

INSERT INTO Categories VALUES
('Rap'),
('Pop'),
('K-pop'),
('Rock')

INSERT INTO Musics ([Name], Duration, CategoryId, ArtistId) VALUES
('Wave',229,1,1),
('Heartless',318,2,2),
('Fake Love',200,3,3),
('Honey',247,4,4)


INSERT INTO Playlist VALUES
(1,1),
(2,2),
(3,3),
(4,4)

CREATE VIEW MusicInfo AS
SELECT 
m.Name AS [Mahni adi], m.Duration AS [Mahni Vaxti],c.Name AS [Kateqoriya], CONCAT(a.Name,' ',a.Surname) AS [Musiqici]
FROM Musics AS m
JOIN Categories AS c ON m.CategoryId=c.Id
JOIN Artists AS a ON m.ArtistId=a.Id

SELECT * FROM MusicInfo




CREATE PROCEDURE usp_CreateMusic
@musicname VARCHAR(50),
@duration INT, 
@categoryId INT, 
@artistId INT 
AS
EXEC usp_CreateMusic 'yaxshi',200,1,1

CREATE PROCEDURE usp_CreateUser
@name VARCHAR(50),
@surname VARCHAR(50),
@username VARCHAR(50),
@password VARCHAR(100),
@gender VARCHAR(10)
AS
EXEC usp_CreateUser 'Tofiq','Nasibli','tofiqq12','salam123','male'

CREATE PROCEDURE usp_CreateCategory
@name VARCHAR(50)
AS
EXEC usp_CreateCategory 'trap'




ALTER TABLE Musics
ADD IsDeleted BIT DEFAULT 0

CREATE TRIGGER DeleteMusic  
ON Musics
INSTEAD OF DELETE
AS
DECLARE @result BIT
DECLARE @id
SELECT @result=IsDeleted,@id=deleted.Id FROM deleted
IF(@result=0)
   BEGIN
   UPDATE Musics SET IsDeleted=1 WHERE Id=@id
   END
ELSE 
    BEGIN
	DELETE FROM Musics WHERE Id=@id
	END

DELETE FROM Musics WHERE Id=1