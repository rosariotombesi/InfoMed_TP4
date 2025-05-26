--Identificar variantes en los nombres de las ciudades
SELECT ciudad, COUNT(*) AS cantidad
FROM Pacientes
GROUP BY ciudad
ORDER BY cantidad DESC;

-- Corregir inconsistencias en nombres de ciudades
UPDATE Pacientes SET ciudad = 'Buenos Aires'
WHERE ciudad ILIKE 'bs aires'
   OR ciudad ILIKE 'buenos aires '
   OR ciudad ILIKE '  buenos aires'
   OR ciudad ILIKE 'buenos   aires'
   OR ciudad ILIKE 'buenos aires'
   OR ciudad ILIKE 'buenos aiers';

UPDATE Pacientes SET ciudad = 'Córdoba'
WHERE ciudad ILIKE 'córodba'
   OR ciudad ILIKE 'cordoba';

UPDATE Pacientes SET ciudad = 'Mendoza'
WHERE ciudad ILIKE 'mendzoa';
