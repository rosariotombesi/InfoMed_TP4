SELECT *
FROM consultas
WHERE id_medico = 3
  AND fecha BETWEEN '2024-08-01' AND '2024-08-31';

-- Otra forma:
SELECT *
FROM consultas
WHERE id_medico = 3
  AND EXTRACT(YEAR FROM fecha_consulta) = 2024
  AND EXTRACT(MONTH FROM fecha_consulta) = 8;
