SELECT 
    c.Nom,
    COUNT(p.id_Course) AS Nombre_Courses,
    SUM(CASE WHEN p.positionArriver = 1 THEN 1 ELSE 0 END) AS Nombre_Victoires
FROM Participations p
JOIN Chevaux c ON p.id_Cheval = c.id
GROUP BY c.Nom
ORDER BY Nombre_Victoires DESC