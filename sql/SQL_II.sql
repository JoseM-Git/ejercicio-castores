use ejercicio1;
GO
INSERT INTO ejercicio1.dbo.estatus (nombre) VALUES
	 (N'Usuario Activo'),
	 (N'Usuario inactivo'),
	 (N'Historial activo'),
	 (N'Historial inactivo'),
	 (N'Producto activo'),
	 (N'Producto inactivo')
GO
INSERT INTO ejercicio1.dbo.usuarios (nombre, correo, contrasena, idRolFk, idEstatusFk)
VALUES
('administrador', 'administrador@123.com', 'admin', 1, 1),
('almacenista', 'almacenista@123.com', 'almacen', 2, 1);
GO
INSERT INTO ejercicio1.dbo.rol
(nombre)
VALUES('Administrador'),
('Almacenista');
GO