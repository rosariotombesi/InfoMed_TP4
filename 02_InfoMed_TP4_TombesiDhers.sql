CREATE VIEW VistaPacientesConEdad AS
SELECT *,
       EXTRACT(YEAR FROM AGE(CURRENT_DATE, fecha_nacimiento)) AS edad
FROM Pacientes;
