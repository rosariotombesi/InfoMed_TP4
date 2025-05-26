
/* Punto 18 */

/* Nombre del médico y total de pacientes a los que ha atendido,
ordenado por el total de pacientes en orden descendente. */

SELECT m.nombre,
       COUNT(DISTINCT p.id_paciente) AS cant_p
FROM consultas c
JOIN medicos m ON m.id_medico = c.id_medico
JOIN pacientes p ON c.id_paciente = p.id_paciente
GROUP BY m.nombre
ORDER BY cant_p DESC;