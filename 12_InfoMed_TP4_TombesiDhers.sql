SELECT me.nombre AS medicamento, COUNT(*) AS cantidad_prescripciones
FROM Recetas r
JOIN Medicamentos me ON r.id_medicamento = me.id_medicamento
WHERE r.id_medico = 2
GROUP BY me.nombre
HAVING COUNT(*) > 1
ORDER BY cantidad_prescripciones DESC;
