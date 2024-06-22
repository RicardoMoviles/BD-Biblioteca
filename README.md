# BD-Biblioteca

# Base de Datos de Biblioteca

Este proyecto contiene una base de datos diseñada para gestionar el catálogo y préstamo de libros de una biblioteca, incluyendo vistas, funciones y procedimientos almacenados para funcionalidades avanzadas.

## Estructura de la Base de Datos

La base de datos `Biblioteca` está estructurada con las siguientes tablas principales:

- **Libros**: Almacena información detallada sobre cada libro en el catálogo de la biblioteca.
- **Usuarios**: Registra los datos de los usuarios registrados en la biblioteca.
- **Préstamos**: Gestiona los préstamos de libros, incluyendo la fecha de préstamo y devolución.
- **Editoriales**: Contiene las editoriales asociadas a los libros.
- **Autores**: Registra los autores de los libros, asociados opcionalmente con editoriales.
- **Libros_Autores**: Tabla de relación muchos a muchos entre libros y autores.

## Archivos SQL

### Estructura y Datos Iniciales

- `Biblioteca-Restrepo.sql`: Script SQL que define la estructura de la base de datos `Biblioteca`, incluyendo la creación de tablas y relaciones.
- `Biblioteca-Restrepo-Data.sql`: Script SQL que contiene datos iniciales para poblar la base de datos con ejemplos de libros, usuarios, etc.

### Vistas, Funciones y Procedimientos Almacenados

- `Vistas_Funciones_Store-Procedure_Trigger.sql`: Script SQL que incluye vistas, funciones, stored procedures y triggers para funcionalidades adicionales.

## Configuración Inicial

1. **Crear la Base de Datos**: Ejecuta el siguiente comando para crear la base de datos `Biblioteca`:

   ```sql
   CREATE DATABASE Biblioteca;
   ```

2. **Usar la Base de Datos**: Cambia al contexto de la base de datos `Biblioteca` con el siguiente comando:

   ```sql
   USE Biblioteca;
   ```

3. **Ejecutar el Script SQL**: Ejecuta el script `Biblioteca-Restrepo.sql` para crear todas las tablas necesarias en tu servidor de base de datos y establecer las relaciones entre ellas.

4. **Cargar Datos Iniciales**: Opcionalmente, ejecuta el script `Biblioteca-Restrepo-Data.sql` para insertar datos iniciales de ejemplo en las tablas.

## Uso

- Utiliza consultas SQL estándar para realizar operaciones como búsqueda de libros, gestión de préstamos y generación de informes.
- Aprovecha las vistas, funciones y procedimientos almacenados definidos en `Vistas_Funciones_Store-Procedure_Trigger.sql` para simplificar y automatizar tareas recurrentes.

## Ejemplos de Consultas SQL

- **Buscar libros por título**:

  ```sql
  SELECT * FROM Libros WHERE Titulo LIKE '%Harry Potter%';
  ```

- **Registrar un nuevo préstamo**:

  ```sql
  INSERT INTO Prestamos (ID_Usuario, ISBN, Cant_Prestado, Fecha_Prestamo, Fecha_Devolucion)
  VALUES (1, 'ISBN1234567890', 1, '2024-06-21', '2024-07-21');
  ```

- **Obtener préstamos activos por usuario**:

  ```sql
  SELECT * FROM Prestamos WHERE ID_Usuario = 1 AND Fecha_Devolucion IS NULL;
  ```


