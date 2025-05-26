
SELECT p.nombre,
       c.fecha,
       c.diagnostico
FROM consultas c
JOIN pacientes p 
    ON c.id_paciente = p.id_paciente
WHERE /*p.nombre = 'Micaela Gutiérrez' AND*/ (c.id_paciente, c.fecha) IN (
  SELECT id_paciente,
         MAX(fecha) AS max_fecha
  FROM consultas
  GROUP BY id_paciente
);
