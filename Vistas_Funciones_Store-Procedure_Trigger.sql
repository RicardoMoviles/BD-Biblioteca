-- 1. Vista de Libros Disponibles:
CREATE OR REPLACE VIEW Libros_Disponibles AS
SELECT l.ISBN, l.Titulo, l.Anio_Publicacion,
       l.Cant_Disponible - COALESCE(p.Total_Prestado, 0) AS Disponibles
FROM Libros l
LEFT JOIN (
    SELECT ISBN, SUM(Cant_Prestado) AS Total_Prestado
    FROM Prestamos
    GROUP BY ISBN
) p ON l.ISBN = p.ISBN;

-- 2. Vista de Préstamos por Usuario:
CREATE VIEW Prestamos_Usuario AS
SELECT u.ID_Usuario, u.Nombre, l.Titulo, p.Fecha_Prestamo, p.Fecha_Devolucion
FROM Usuarios u
JOIN Prestamos p ON u.ID_Usuario = p.ID_Usuario
JOIN Libros l ON p.ISBN = l.ISBN;

-- 3. Vista de Autores con sus Libros:
CREATE VIEW Autores_Libros AS
SELECT a.Nombre_Autor, GROUP_CONCAT(l.Titulo SEPARATOR ', ') AS Libros_Escritos
FROM Autores a
JOIN Libros_Autores la ON a.ID_Autor = la.ID_Autor
JOIN Libros l ON la.ISBN = l.ISBN
GROUP BY a.ID_Autor;

-- 1. Función para calcular la disponibilidad de un libro:
DELIMITER $$
CREATE FUNCTION is_libro_disponible(isbn VARCHAR(20))
RETURNS INT
BEGIN
  DECLARE cant_disponible INT;
  SELECT Cant_Disponible INTO cant_disponible FROM Libros WHERE ISBN = isbn;
  RETURN cant_disponible;
END;
$$ DELIMITER ;

-- 1. Procedimiento para registrar un nuevo préstamo:
DELIMITER $$
CREATE PROCEDURE registrar_prestamo(id_usuario INT, isbn VARCHAR(20), cant_prestado INT)
BEGIN
  DECLARE fecha_actual DATE;
  DECLARE fecha_devolucion DATE;

  SET fecha_actual = CURDATE();
  SET fecha_devolucion = calcular_fecha_devolucion(fecha_actual, 14);

  INSERT INTO Prestamos (ID_Usuario, ISBN, Cant_Prestado, Fecha_Prestamo, Fecha_Devolucion)
  VALUES (id_usuario, isbn, cant_prestado, fecha_actual, fecha_devolucion);

  UPDATE Libros SET Cant_Disponible = Cant_Disponible - cant_prestado WHERE ISBN = isbn;
END;
$$ DELIMITER ;

-- 2.	Procedimiento para devolver un préstamo
DELIMITER $$
CREATE PROCEDURE devolver_prestamo(id_prestamo INT)
BEGIN
  DECLARE fecha_devolucion DATE;

  SET fecha_devolucion = CURDATE();

  UPDATE Prestamos SET Fecha_Devolucion = fecha_devolucion WHERE ID_Prestamo = id_prestamo;

  UPDATE Libros SET Cant_Disponible = Cant_Disponible + (SELECT Cant_Prestado FROM Prestamos WHERE ID_Prestamo = id_prestamo)
  WHERE ISBN = (SELECT ISBN FROM Prestamos WHERE ID_Prestamo = id_prestamo);
END;
$$ DELIMITER ;

-- 1.	Trigger para verificar disponibilidad antes de prestar un libro: 
DELIMITER $$
CREATE TRIGGER verificar_disponibilidad_libro
BEFORE INSERT ON Prestamos
FOR EACH ROW
BEGIN
  DECLARE cant_disponible INT;

  SELECT Cant_Disponible INTO cant_disponible FROM Libros WHERE NEW.ISBN = NEW.ISBN;

  IF cant_disponible - NEW.Cant_Prestado < 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No hay ejemplares disponibles del libro solicitado';
  END IF;
END;
$$ DELIMITER ;

