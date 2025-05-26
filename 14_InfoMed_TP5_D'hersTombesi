SELECT m.nombre,
       COUNT(*) AS cant_recetas
FROM recetas r
JOIN medicamentos m 
    ON r.id_medicamento = m.id_medicamento
GROUP BY m.nombre, m.id_medicamento
ORDER BY cant_recetas DESC
LIMIT 1;
