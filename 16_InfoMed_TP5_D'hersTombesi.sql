
/* Punto 16 */

/* Nombre del médico junto con el nombre del paciente y el número total de
consultas realizadas por cada médico para cada paciente, ordenado por médico y
paciente. */

SELECT m.nombre,
       p.nombre,
       COUNT(c.id_consulta)
FROM medicos m
JOIN consultas c ON m.id_medico = c.id_medico
JOIN pacientes p ON c.id_paciente = p.id_paciente
/*WHERE m.nombre = 'Dr. Carlos García' AND p.nombre = 'Esteban Muñoz'*/
GROUP BY p.nombre, m.nombre
ORDER BY m.nombre, p.nombre;