DISABLE TRIGGER ALL ON Participations;

INSERT INTO Hippodromes (Nom, Ville, typePiste)
SELECT DISTINCT course, 'Inconnu', 'Herbe'
FROM races_2020
WHERE course IS NOT NULL;

SET DATEFORMAT ymd;
SET IDENTITY_INSERT Courses ON;

INSERT INTO Courses (id, Nom, dateCourse, dotationEuro, id_hippodrome)
SELECT 
    TRY_CAST(r.rid AS INT),
    r.title,
    r.date,
    ISNULL(TRY_CAST(r.prize AS INT), 0),
    h.id
FROM races_2020 r
JOIN Hippodromes h ON r.course = h.Nom
WHERE r.rid IS NOT NULL 
  AND r.date IS NOT NULL;

SET IDENTITY_INSERT Courses OFF;

INSERT INTO Chevaux (Nom, Age, Sexe, Race)
SELECT DISTINCT horseName, ISNULL(TRY_CAST(age AS INT), 0), 'Inconnu', 'Pur-Sang'
FROM horses_2020
WHERE horseName IS NOT NULL;

INSERT INTO Participations (id_Course, id_Cheval, positionArriver, tempsChrono, cotePari)
SELECT 
    c.id,
    ch.id,
    TRY_CAST(h.position AS INT),
    NULL,
    TRY_CAST(h.decimalPrice AS DECIMAL(10,2))
FROM horses_2020 h
JOIN Courses c ON TRY_CAST(h.rid AS INT) = c.id
JOIN Chevaux ch ON h.horseName = ch.Nom;

ENABLE TRIGGER ALL ON Participations;