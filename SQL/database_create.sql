CREATE TABLE Chevaux (
    id INT IDENTITY(1,1) PRIMARY KEY,
    Nom VARCHAR(100) NOT NULL,
    Age INT NOT NULL,
    Sexe VARCHAR(50) NOT NULL,
    Race VARCHAR(50) NOT NULL
);

CREATE TABLE Hippodromes (
    id INT IDENTITY(1,1) PRIMARY KEY,
    Nom VARCHAR(50) NOT NULL,
    Ville VARCHAR(50) NOT NULL,
    typePiste VARCHAR(50) NOT NULL
);

CREATE TABLE Courses (
    id INT PRIMARY KEY,
    Nom NVARCHAR(250) NOT NULL,
    dateCourse DATETIME NOT NULL,
    dotationEuro DECIMAL(18,0) NOT NULL,
    id_hippodrome INT NOT NULL,
    FOREIGN KEY (id_hippodrome) REFERENCES Hippodromes(id)
);

CREATE TABLE Participations (
    id_Course INT NOT NULL,
    id_Cheval INT NOT NULL,
    positionArriver INT NULL,
    tempsChrono TIME(7) NULL,  
    cotePari DECIMAL(10,2) NOT NULL, 
    PRIMARY KEY (id_Cheval, id_Course),
    FOREIGN KEY (id_Cheval) REFERENCES Chevaux(id),
    FOREIGN KEY (id_Course) REFERENCES Courses(id)
);