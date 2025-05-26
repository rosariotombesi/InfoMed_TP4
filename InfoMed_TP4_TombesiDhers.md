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

![image](https://github.com/user-attachments/assets/c3485c5d-9f6d-4a63-a6fd-4797880a9ce6)

### 3. Armar el Modelo relacional de la base de datos dada.
imagen

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


