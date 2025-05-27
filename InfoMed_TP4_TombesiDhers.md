# Trabajo Práctico N°4
![image](https://github.com/user-attachments/assets/f2e54dc0-6027-4cd7-817a-a42e47570113)

## _Autores:_ 
* Tombesi Rosario
* D´hers Galo

## **PARTE 1:** Bases de Datos

### 1. ¿Qué tipo de base de datos es? 

* Se trata de una base de datos relacional, ya que los datos se almacenan en una estructura previamente diseñada, que está formada por entidades o tablas, y relaciones entre ellas. 
* La información se organiza en tablas (entidades) con filas (registros) y columnas (atributos), que se relacionan entre sí mediante claves primarias y foráneas. 

### 2. Armar el diagrama entidad-relación de la base de datos dada. 
En primer lugar, se identifican las entidades y atributos:
* Paciente (entidad fuerte).
  Atributos: ID_Paciente (Clave primaria), Nombre, Fecha_Nacimiento, ID_Sexo (Clave foránea), Número, Calle y Ciudad.
* Médico (entidad fuerte).
  Atributos: ID_Médico (Clave primaria), Nombre, ID_Especialidad (Clave foránea), Teléfono, Correo_Electrónico, Matrícula.
* Especialidad (entidad fuerte).
  Atributos: ID_Especialidad, Nombre.
* Sexo (entidad fuerte).
  Atributos: ID_Sexo, Nombre.
* Consultas (entidad fuerte).
  Atributos: ID_Consulta (Clave primaria compuesta por dos claves foráneas: ID_Paciente y ID_Médico), ID_Paciente, ID_Médico, Fecha_Consulta, Diagnóstico, Tratamiento.
* Medicamentos (entidad fuerte).
  Atributos: ID_Medicamento, Nombre.
* Receta (entidad débil, su existencia depende de Consultas).
  Atributos: ID_Receta , ID_Paciente, ID_Médico, Fecha_receta (Clave parcial), ID_Medicamento, Descripción.

Una vez identificadas las entidades y sus atributos, se procede a identificar las relaciones existentes entre ellas:

1. Realiza (Paciente - Consulta)
* Un paciente puede realizar muchas consultas pero cada consulta se asocia a un único paciente
* Participación: Parcial en “Paciente” (se asume que un paciente puede existir en el sistema sin haber realizado una consulta aún). Total en “Consulta” (toda consulta debe asociarse a un paciente).
* Cardinalidad 1:N

2. Atiende (Médico - Consulta)
* Un médico puede realizar muchas consultas pero cada consulta es atendida por un sólo médico
* Participación: Parcial en “Médico” pues se asume que un médico puede estar registrado sin haber atendido aún. Total en “Consulta”, porque una consulta tiene que tener un médico asociado.
* Cardinalidad 1:N

3. Pertenece a (Médico - Especialidad)
* Muchos médicos pueden tener la misma especialidad y cada médico tiene sólo una especialidad asignada
* Participación: Total para “Médico”, porque todo médico tiene que tener una especialidad. Parcial para “Especialidad”, se considera que puede haber especialidades que no tengan médicos asociados todavía.
* Cardinalidad N:1

4. Tiene (Paciente - Sexo)
* Muchos pacientes pueden tener el mismo sexo biológico, pero cada paciente puede tener uno sólo.
* Participación: Total para “Paciente” porque todo paciente debe tener un sexo registrado. Parcial para “Sexo biológico” porque puede haber sexos sin pacientes registrados aún. 
* Cardinalidad N:1

5. Genera (Consulta - Receta)
* Una consulta puede generar varias recetas, pero cada receta corresponde a una sola consulta.
* Participación: Parcial para “Consulta” porque no necesariamente en todas las consultas se generan recetas. Total para “Recetas” pues toda receta debe pertenecer a una consulta.
* Cardinalidad 1:N

6. Incluye (Receta - Medicamentos)
* Una receta puede incluir varios medicamentos y un medicamento puede estar en varias recetas
* Participación: Parcial para “Receta” porque puede haber recetas que no contengan medicamentos. Parcial para “Medicamentos” porque puede haber medicamentos dentro del catálogo que aún no hayan sido recetados.
* Cardinalidad M:N

En base a esto se obtiene el siguiente diagrama:

![image](https://github.com/user-attachments/assets/0904bc89-6355-46ec-9420-484ab3155767)


### 3. Armar el Modelo relacional de la base de datos dada.

![Uploading image.png…]()

### 4. Considera que la base de datos está normalizada. En caso que no lo esté, ¿cómo podría hacerlo?

* Primera Forma Normal:
Dado que en esta base de datos, todos los campos cuentan con valores unicos, es decir sin listas o arreglos, y que a su ves comparten cantidad de columnas entre todas las filas en cada una de las tablas, podemos afirmar que la base de datos esta normalizada segun 1FN.

* Segunda Forma Normal:
En cuanto a la segunda forma normal, la base de datos esta a grandes razgos tambien se encuentra normalizada. Esto sucede ya que en las tablas no se encuentran dependencias parciales sino que todo sucede a traves de las claves primarias "id_". Sin embargo aclaramos que es "a grandes razgos" debido a las problematicas de la columna de "ciudades" en la tabla de "pacientes". Es to es debido a que la creacion de un indice para navegar mde forma mas eficaz la tabla, es redundante sobre la inclusion del nombre de la ciudad en esa tabla. Esto podria solucionarse si se modificase la tabla "pacientes" para incluir solamente el id de la ciudad y no su nombre, y crear una nueva tabla de conversion para correlacionar los indices de ciudades con los nombres que les corresponda. 

* Tercera Forma Normal:
Por lo explicado para la 2FN , creemos que podemos considerar la tabla como normal tambien para 3FN, ya que los atributos de las tablas se encuentran dispersados en las columnas de forma totalmente independiente.

## **PARTE 2:** Bases de Datos

### 1. Cuando se realizan consultas sobre la tabla paciente agrupando por ciudad los tiempos de respuesta son demasiado largos. Proponer mediante una query SQL una solución a este problema.

```
CREATE INDEX idx_ciudad_pacientes ON Pacientes(Ciudad);

--Para visualizar el índice:
SELECT indexname, indexdef
FROM pg_indexes
WHERE schemaname = 'public';

```
![image](https://github.com/user-attachments/assets/7e290de2-69c4-4aa6-91e7-96b060280d9d)

### 2. Se tiene la fecha de nacimiento de los pacientes. Se desea calcular la edad de los pacientes y almacenarla de forma dinámica en el sistema ya que es un valor típicamente consultado, junto con otra información relevante del paciente.

```
CREATE VIEW VistaPacientesConEdad AS
SELECT *,
       EXTRACT(YEAR FROM AGE(CURRENT_DATE, fecha_nacimiento)) AS edad
FROM Pacientes;

-- Para visualizar:
SELECT * FROM VistaPacientesConEdad;

```
![image](https://github.com/user-attachments/assets/d40b4ec7-3161-4173-af20-056d16dd37f9)

### 3. La paciente, “Luciana Gómez”, ha cambiado de dirección. Antes vivía en “Avenida Las Heras 121” en “Buenos Aires”, pero ahora vive en “Calle Corrientes 500” en “Buenos Aires”. Actualizar la dirección de este paciente en la base de datos.

```
UPDATE Pacientes
SET calle = 'Calle Corrientes',
    numero = '500',
    ciudad = 'Buenos Aires'
WHERE nombre = 'Luciana Gómez'
  AND calle = 'Avenida Las Heras'
  AND numero = '121'
  AND ciudad = 'Bs Aires';

```
![image](https://github.com/user-attachments/assets/0ade8eda-c1d5-448b-a590-5c4a92280123)

### 4. Seleccionar el nombre y la matrícula de cada médico cuya especialidad sea identificada por el id 4.

```
SELECT nombre, matricula
FROM Medicos
WHERE especialidad_id = 4;

```
![image](https://github.com/user-attachments/assets/bae4f154-02f1-4fa2-a385-47b06e75bf76)

### 5. Puede pasar que haya inconsistencias en la forma en la que están escritos los nombres de las ciudades, ¿cómo se corrige esto? Agregar la query correspondiente.

```
-- Identificar variantes en los nombres de las ciudades
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

```
![image](https://github.com/user-attachments/assets/3754bee6-bd12-4372-81b6-19fd80b37e2d)
![image](https://github.com/user-attachments/assets/c9f10c49-dbeb-4b1b-8b5b-87181e462d73)

### 6. Obtener el nombre y la dirección de los pacientes que viven en Buenos Aires.

```
SELECT nombre, numero, calle, ciudad
FROM Pacientes
WHERE ciudad = 'Buenos Aires';

```
![image](https://github.com/user-attachments/assets/dbbc186a-52d7-43ee-869a-f90d32543552)

### 7. Cantidad de pacientes que viven en cada ciudad.

```
SELECT ciudad, COUNT(*) AS cantidad_pacientes
FROM Pacientes
GROUP BY ciudad
ORDER BY cantidad_pacientes DESC;

```
![image](https://github.com/user-attachments/assets/ac723d1e-c6ae-4eaa-989f-8059796bc596)

### 8. Cantidad de pacientes por sexo que viven en cada ciudad.

```
SELECT p.ciudad, s.descripcion AS sexo, COUNT(*) AS cantidad_pacientes
FROM Pacientes p
JOIN SexoBiologico s ON p.id_sexo = s.id_sexo
GROUP BY p.ciudad, s.descripcion
ORDER BY p.ciudad, s.descripcion;

```
![image](https://github.com/user-attachments/assets/6c226efd-4cf3-4275-a342-92b60882d71e)

### 9. Obtener la cantidad de recetas emitidas por cada médico.

```
SELECT m.nombre, COUNT(*) AS cantidad_recetas
FROM medicos m
INNER JOIN recetas r
ON m.id_medico = r.id_medico
GROUP BY m.nombre
ORDER BY cantidad_recetas DESC;

```
![image](https://github.com/user-attachments/assets/533ffeca-dbeb-4ee9-a7f7-d871c6d74151)

### 10. Obtener todas las consultas médicas realizadas por el médico con ID igual a 3 durante el mes de agosto de 2024.

```
SELECT *
FROM consultas
WHERE id_medico = 3
  AND fecha BETWEEN '2024-08-01' AND '2024-08-31';

-- Otra forma:
SELECT *
FROM consultas
WHERE id_medico = 3
  AND EXTRACT(YEAR FROM fecha) = 2024
  AND EXTRACT(MONTH FROM fecha) = 8;

```
![image](https://github.com/user-attachments/assets/3aed556f-576c-492a-9b3e-e746d602d580)

### 11. Obtener el nombre de los pacientes junto con la fecha y el diagnóstico de todas las consultas médicas realizadas en agosto del 2024.

```
SELECT p.nombre, c.fecha, c.diagnostico
FROM Consultas c
JOIN Pacientes p ON c.id_paciente = p.id_paciente
WHERE c.fecha >= '2024-08-01' AND c.fecha < '2024-09-01'
ORDER BY p.nombre, c.fecha, c.diagnostico;
```
![image](https://github.com/user-attachments/assets/a4e2b44a-9244-4bbf-969f-98e992253332)
![image](https://github.com/user-attachments/assets/58df7a3d-2ae9-4de4-bc73-4a92fedc5816)
![image](https://github.com/user-attachments/assets/f1bc8003-8176-46c1-8d00-c24ff9564da5)

### 12. Obtener el nombre de los medicamentos prescritos más de una vez por el médico con ID igual a 2.

```
SELECT me.nombre AS medicamento, COUNT(*) AS cantidad_prescripciones
FROM Recetas r
JOIN Medicamentos me ON r.id_medicamento = me.id_medicamento
WHERE r.id_medico = 2
GROUP BY me.nombre
HAVING COUNT(*) > 1
ORDER BY cantidad_prescripciones DESC;

```
![image](https://github.com/user-attachments/assets/3e867a6c-81d3-40e4-a276-fe1ec2fecbb0)

### 13. Obtener el nombre de los pacientes junto con la cantidad total de recetas que han recibido.

```
SELECT p.nombre, COUNT(*) AS cantidad_recetas
FROM Recetas r
JOIN Pacientes p ON r.id_paciente = p.id_paciente
GROUP BY p.nombre
ORDER BY cantidad_recetas DESC;

```
![image](https://github.com/user-attachments/assets/d3af16a7-61bf-472e-bf6e-eb0c5ece34b7)
![image](https://github.com/user-attachments/assets/1c4c2b0a-cf43-4bb9-8c59-81443b2a1fbb)

### 14. Obtener el nombre del medicamento más recetado junto con la cantidad de recetas emitidas para ese medicamento.

```
SELECT p.nombre, COUNT(*) AS cantidad_recetas
FROM Recetas r
JOIN Pacientes p ON r.id_paciente = p.id_paciente
GROUP BY p.nombre
ORDER BY cantidad_recetas DESC;

```
![image](https://github.com/user-attachments/assets/10dc68a6-ee59-4249-8337-87c098c3bb3c)

### 15. Obtener el nombre del paciente junto con la fecha de su última consulta y el diagnóstico asociado.

```
SELECT p.nombre, c.fecha, c.diagnostico
FROM Consultas c
JOIN Pacientes p ON c.id_paciente = p.id_paciente
WHERE c.fecha = (
    SELECT MAX(c2.fecha)
    FROM Consultas c2
    WHERE c2.id_paciente = c.id_paciente
);

```
![image](https://github.com/user-attachments/assets/86bd27d0-6392-4f9f-8f1e-f46db798f5bd)
![image](https://github.com/user-attachments/assets/31f42ee2-4505-49ae-b542-e0198eec49c0)

### 16. Obtener el nombre del médico junto con el nombre del paciente y el número total de consultas realizadas por cada médico para cada paciente, ordenado por médico y paciente.

```
SELECT m.nombre AS nombre_medico,
       p.nombre AS nombre_paciente,
       COUNT(*) AS total_consultas
FROM Consultas c
JOIN Medicos m ON c.id_medico = m.id_medico
JOIN Pacientes p ON c.id_paciente = p.id_paciente
GROUP BY m.nombre, p.nombre
ORDER BY m.nombre, p.nombre;

```
![image](https://github.com/user-attachments/assets/660e11e7-01b8-4e42-b9f7-289c6594f2cf)
![image](https://github.com/user-attachments/assets/90a1b6ac-6720-4a6e-99a3-b7230f04213b)
![image](https://github.com/user-attachments/assets/8737dcb5-c254-41e5-b91b-ea50b5b20a5f)
![image](https://github.com/user-attachments/assets/4997fa41-91d1-4306-94ae-00980ba66489)
![image](https://github.com/user-attachments/assets/6406f2fa-e564-4876-a913-0ccfdb933a6b)

### 17. Obtener el nombre del medicamento junto con el total de recetas prescritas para ese medicamento, el nombre del médico que lo recetó y el nombre del paciente al que se le recetó, ordenado por total de recetas en orden descendente.

```
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

```
![image](https://github.com/user-attachments/assets/f38febd9-5b66-420f-8557-9817cedc7086)
![image](https://github.com/user-attachments/assets/d16fcb8f-417e-45b1-bc42-d8dc0ab32de6)
![image](https://github.com/user-attachments/assets/5c3d063d-b898-4881-b3ca-4b037e5a6a94)
![image](https://github.com/user-attachments/assets/b916f06d-ead4-47bd-ae9a-0f0aeed062d7)

### 18. Obtener el nombre del médico junto con el total de pacientes a los que ha atendido, ordenado por el total de pacientes en orden descendente.

```
SELECT m.nombre,
       COUNT(DISTINCT p.id_paciente) AS cant_p
FROM consultas c
JOIN medicos m ON m.id_medico = c.id_medico
JOIN pacientes p ON c.id_paciente = p.id_paciente
GROUP BY m.nombre
ORDER BY cant_p DESC;

```
![image](https://github.com/user-attachments/assets/666c874e-989c-4628-af5a-a6b89c583623)
