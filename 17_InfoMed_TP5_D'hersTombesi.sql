
/* Punto 17 */

/* Nombre del medicamento junto con el total de recetas prescritas para ese
medicamento, el nombre del médico que lo recetó y el nombre del paciente al que se
le recetó, ordenado por total de recetas en orden descendente. */

/* Asumo que se busca saber cuantas veces receto cada medico un medicamento especifico a cada paciente */

SELECT m.nombre,
       COUNT(r.id_receta) AS cant_recetas,
       d.nombre,
       p.nombre
FROM recetas r
JOIN medicamentos m ON r.id_medicamento = m.id_medicamento
JOIN medicos d ON r.id_medico = d.id_medico
JOIN pacientes p ON r.id_paciente = p.id_paciente
GROUP BY m.nombre, d.nombre, p.nombre
ORDER BY cant_recetas, m.nombre DESC;


/* En otro caso, muestro por separado total de recetas por medicamento */

SELECT m.nombre,
       COUNT(r.id_receta) AS cant_recetas
FROM recetas r
JOIN medicamentos m
    ON r.id_medicamento = m.id_medicamento
GROUP BY m.nombre
ORDER BY cant_recetas DESC;