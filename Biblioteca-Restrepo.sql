-- Crear la base de datos
CREATE DATABASE Biblioteca;

-- Usar la base de datos
USE Biblioteca;

-- Crear tabla Libros
CREATE TABLE Libros (
    ISBN VARCHAR(20) PRIMARY KEY,
    Titulo VARCHAR(100),
    Anio_Publicacion INT,
    Cant_Disponible INT,
    Genero VARCHAR(50)
);

-- Crear tabla Usuarios
CREATE TABLE Usuarios (
    ID_Usuario INT PRIMARY KEY,
    Nombre VARCHAR(50),
    Apellido VARCHAR(50),
    Direccion VARCHAR(100),
    Telefono VARCHAR(15),
    Email VARCHAR(100)
);

-- Crear tabla Préstamos
CREATE TABLE Prestamos (
    ID_Prestamo INT PRIMARY KEY,
    ID_Usuario INT,
    ISBN VARCHAR(20),
    Cant_Prestado INT,
    Fecha_Prestamo DATE,
    Fecha_Devolucion DATE,
    FOREIGN KEY (ID_Usuario) REFERENCES Usuarios(ID_Usuario),
    FOREIGN KEY (ISBN) REFERENCES Libros(ISBN)
);

-- Crear tabla Editoriales
CREATE TABLE Editoriales (
    ID_Editorial INT PRIMARY KEY,
    Nombre_Editorial VARCHAR(100)
);

-- Crear tabla Autores
CREATE TABLE Autores (
    ID_Autor INT PRIMARY KEY,
    Nombre_Autor VARCHAR(100),
    ID_Editorial INT,
    FOREIGN KEY (ID_Editorial) REFERENCES Editoriales(ID_Editorial)
);

-- Crear tabla de relación entre Libros y Autores para la relación muchos a muchos
CREATE TABLE Libros_Autores (
    ISBN VARCHAR(20),
    ID_Autor INT,
    PRIMARY KEY (ISBN, ID_Autor),
    FOREIGN KEY (ISBN) REFERENCES Libros(ISBN),
    FOREIGN KEY (ID_Autor) REFERENCES Autores(ID_Autor)
);