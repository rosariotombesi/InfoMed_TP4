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
imagen

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


