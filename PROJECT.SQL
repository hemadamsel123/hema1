CREATE DATABASE AcademicResearch;
USE AcademicResearch;

-- Table for Authors
CREATE TABLE Authors (
    AuthorID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    Affiliation VARCHAR(255),
    Email VARCHAR(100));
 INSERT INTO Authors (FirstName, LastName, Affiliation, Email)
VALUES ('John', 'Doe', 'University X', 'john.doe@univx.edu'),
       ('Jane', 'Smith', 'Institute Y', 'jane.smith@insty.org');   
-- Table for Journals
CREATE TABLE Journals (
    JournalID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255),
    ISSN VARCHAR(100));
INSERT INTO Journals (Name, ISSN)
VALUES ('Journal of AI Research', '1234-5678'),
       ('Conference on Database Systems', '9876-5432');
--Table for Papers
CREATE TABLE Papers (
    PaperID INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(255),
    Abstract TEXT,
    YearPublished YEAR,
    JournalID INT,
    DOI VARCHAR(100),
    FOREIGN KEY (JournalID) REFERENCES Journals(JournalID));
INSERT INTO Papers (Title, Abstract, YearPublished, JournalID, DOI)
VALUES ('AI in Healthcare', 'Abstract on AI in Healthcare', 2024, 1, '10.1234/ai.2024.001'),
       ('Database Optimization', 'Abstract on DB Optimization', 2023, 2, '10.9876/db.2023.002');

-- Table for PaperAuthors (Many-to-Many Relationship)
CREATE TABLE PaperAuthors (
    PaperID INT,
    AuthorID INT,
    PRIMARY KEY (PaperID, AuthorID),
    FOREIGN KEY (PaperID) REFERENCES Papers(PaperID),
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID));
INSERT INTO PaperAuthors (PaperID, AuthorID)
VALUES (1, 1), (1, 2), (2, 1);


-- Table for Citations (Self-Referencing Relationship)
CREATE TABLE Citations (
    CitationID INT PRIMARY KEY AUTO_INCREMENT,
    CitingPaperID INT,
    CitedPaperID INT,
    FOREIGN KEY (CitingPaperID) REFERENCES Papers(PaperID),
    FOREIGN KEY (CitedPaperID) REFERENCES Papers(PaperID));
INSERT INTO Citations (CitingPaperID, CitedPaperID)
VALUES (2, 1);

-- Table for Keywords
CREATE TABLE Keywords (
    KeywordID INT PRIMARY KEY AUTO_INCREMENT,
    Keyword VARCHAR(100));
INSERT INTO Keywords (Keyword)
VALUES ('Artificial Intelligence'), ('Healthcare'), ('Database Systems');

-- Table for PaperKeywords (Many-to-Many Relationship)
CREATE TABLE PaperKeywords (
    PaperID INT,
    KeywordID INT,
    PRIMARY KEY (PaperID, KeywordID),
    FOREIGN KEY (PaperID) REFERENCES Papers(PaperID),
    FOREIGN KEY (KeywordID) REFERENCES Keywords(KeywordID));
INSERT INTO PaperKeywords (PaperID, KeywordID)
VALUES (1, 1), (1, 2), (2, 3);
select * from Papers
select * from PaperAuthors
SELECT P.Title, P.YearPublished, P.abstract
FROM Papers as P
inner join PaperAuthors as PA ON P.PaperID = PA.PaperID
select title from Papers where YearPublished=2024