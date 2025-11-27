create database ejercicio1;
go
USE ejercicio1;
GO
CREATE TABLE estatus (
    idEstatus INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);
GO
CREATE TABLE rol (
    idRol INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);
GO
CREATE TABLE usuarios (
    idUsuario INT IDENTITY(1,1) PRIMARY KEY,
    idEstatusFk INT NOT NULL,
    idRolFk INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(50) NOT NULL,
    contrasena VARCHAR(25) NOT NULL    
);
GO
CREATE TABLE productos (
    idProducto INT IDENTITY(1,1) PRIMARY KEY,
    idEstatusFk VARCHAR(100) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    inventario INT NOT NULL
);
GO
CREATE TABLE historial (
    idHistorial INT IDENTITY(1,1) PRIMARY KEY,
    idEstatusFk VARCHAR(100) NOT NULL,
    idProductoFk INT NOT NULL,
    idUsuarioFk INT NOT NULL,
    fecha DATETIME DEFAULT GETDATE() NOT NULL,
    unidades INT NOT NULL
);
GO
