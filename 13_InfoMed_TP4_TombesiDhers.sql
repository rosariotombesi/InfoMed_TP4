SELECT p.nombre, COUNT(*) AS cantidad_recetas
FROM Recetas r
JOIN Pacientes p ON r.id_paciente = p.id_paciente
GROUP BY p.nombre
ORDER BY cantidad_recetas DESC;
