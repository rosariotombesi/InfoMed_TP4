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

Respuesta

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


