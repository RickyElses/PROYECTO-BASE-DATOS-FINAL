-- ====================================================
-- PROYECTO FINAL - MICROEMPRESA DE CONSOLAS
-- BASE DE DATOS: GameHouseDB
-- INTEGRANTES: Lewis reyes (2024-1623)
-- RONALD MIESES (2025-0980)
--JENCI SANCHEZ
--DANYY
-- ====================================================

IF DB_ID('GameHouseDB') IS NOT NULL
    DROP DATABASE GameHouseDB;
GO

CREATE DATABASE GameHouseDB;
GO

USE GameHouseDB;
GO

/* =======================================
   TABLA EMPLEADO
   ======================================= */
CREATE TABLE Empleado (
    IdEmpleado INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(50),
    Apellido NVARCHAR(50),
    Telefono NVARCHAR(20),
    Direccion NVARCHAR(200),
    FechaNacimiento DATE,
    Sueldo DECIMAL(10,2),
    FechaContrato DATE
);
GO

/* =======================================
   TABLA CLIENTES
   ======================================= */
CREATE TABLE Clientes (
    IdCliente INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(50),
    Apellido NVARCHAR(50),
    Direccion NVARCHAR(200),
    Telefono NVARCHAR(20)
);
GO

/* =======================================
   TABLA PRODUCTOS (Consolas y videojuegos)
   ======================================= */
CREATE TABLE Productos (
    IdProducto INT IDENTITY(1,1) PRIMARY KEY,
    NombreProducto NVARCHAR(100),
    PrecioUnitario DECIMAL(10,2)
);
GO

/* =======================================
   TABLA COMPRAS
   ======================================= */
CREATE TABLE Compras (
    IdCompras INT IDENTITY(1,1) PRIMARY KEY,
    FechaCompras DATE,
    Hora TIME,
    IdProducto INT,
    NombreProducto NVARCHAR(100),
    PrecioUnitario DECIMAL(10,2),
    Cantidad INT,
    TotalCompra AS (PrecioUnitario * Cantidad),
    CONSTRAINT FK_Compras_Productos FOREIGN KEY (IdProducto) REFERENCES Productos(IdProducto)
);
GO

/* =======================================
   TABLA VENTAS
   ======================================= */
CREATE TABLE Ventas (
    CodigoVentas INT IDENTITY(1000,1) PRIMARY KEY,
    FechaVentas DATE,
    HoraVentas TIME,
    NombreProductos NVARCHAR(100),
    IdProductos INT,
    CantidadProductos INT,
    Total DECIMAL(10,2),
    IdCliente INT,
    CONSTRAINT FK_Ventas_Productos FOREIGN KEY (IdProductos) REFERENCES Productos(IdProducto),
    CONSTRAINT FK_Ventas_Clientes FOREIGN KEY (IdCliente) REFERENCES Clientes(IdCliente)
);
GO

/* =======================================
   TABLA LOG PARA TRIGGERS
   ======================================= */
CREATE TABLE AuditLog (
    AuditId INT IDENTITY(1,1) PRIMARY KEY,
    Tabla NVARCHAR(50),
    Operacion NVARCHAR(20),
    Fecha DATETIME DEFAULT GETDATE(),
    Detalle NVARCHAR(MAX)
);
GO

/* =======================================
   INSERTAR REGISTROS
   ======================================= */

-- EMPLEADOS (5)
INSERT INTO Empleado (Nombre, Apellido, Telefono, Direccion, FechaNacimiento, Sueldo, FechaContrato)
VALUES
('Carlos','Perez','809-321-1111','Av. Gamer #10','1985-04-10',30000,'2022-01-10'),
('Ana','Lopez','809-222-1010','Calle Play #12','1970-03-22',24000,'2020-05-12'),
('Luis','Martinez','809-333-2020','Calle XBOX #8','1992-07-18',26000,'2023-06-01'),
('Sofia','Gomez','809-444-3030','Sector Sony','1970-12-02',27000,'2019-09-15'),
('Juan','Santos','809-555-4040','Barrio Switch','1998-10-05',22000,'2024-05-01'),
('Andres','Morales','809-234-1112','Av. Indie #20','1983-01-12',28500,'2021-08-09'),
('Patricia','Reyes','809-345-2223','Calle GamerZone #5','1997-04-03',23000,'2024-02-15'),
('Diego','Hernandez','809-456-3334','Sector VR World','1989-09-17',32000,'2019-11-30'),
('Valeria','Jimenez','809-567-4445','Barrio Pixel #9','1993-12-25',27500,'2022-04-21'),
('Fernando','Cruz','809-678-5556','Calle RetroArcade #2','1978-08-14',29500,'2020-07-07'),
('María','Fernandez','809-666-5050','Av. PC Master #15','1988-11-25',28000,'2021-03-20'),
('Pedro','Ramirez','809-777-6060','Calle Gamer Pro #7','1995-02-14',25000,'2022-07-11'),
('Lucia','Torres','809-888-7070','Sector Steam','1982-09-30',31000,'2018-12-05'),
('Miguel','Diaz','809-999-8080','Barrio Epic','1990-06-21',29500,'2023-01-18'),
('Elena','Castro','809-123-9090','Calle Retro #3','1975-05-09',26500,'2020-10-22');
GO

-- CLIENTES (5)
INSERT INTO Clientes (Nombre, Apellido, Direccion, Telefono)
VALUES
('Pedro','Nuñez','Calle 1','809-100-1000'),
('Maria','Castillo','Calle 2','809-200-2000'),
('Josue','Reyes','Calle 3','809-300-3000'),
('Laura','Hernandez','Calle 4','809-400-4000'),
('Karina','Vargas','Calle 5','809-500-5000'),
('Carmen','Silva','Av. Caribe #11','809-222-3333'),
('Roberto','Mendez','Calle Sol #6','809-333-4444'),
('Isabel','Ortiz','Sector Luna #9','809-444-5555'),
('Javier','Pena','Barrio Estrella #2','809-555-6666'),
('Natalia','Rojas','Calle Aurora #7','809-666-7777'),
('Andres','Gomez','Av. Central #12','809-600-6000'),
('Patricia','Lopez','Calle Norte #8','809-700-7000'),
('Diego','Martinez','Sector Este #4','809-800-8000'),
('Valeria','Jimenez','Barrio Sur #9','809-900-9000'),
('Fernando','Cruz','Calle Oeste #2','809-111-1111');
GO

-- PRODUCTOS (Consolas y videojuegos)
INSERT INTO Productos (NombreProducto, PrecioUnitario)
VALUES
('PlayStation 5', 45000),
('Xbox Series X', 42000),
('Nintendo Switch OLED', 28000),
('FIFA 25', 4500),
('Call of Duty: Modern Warfare 4', 5200),
('PlayStation 4', 25000),
('Xbox One S', 23000),
('Nintendo Switch Lite', 18000),
('The Legend of Zelda: Breath of the Wild', 4800),
('Super Mario Odyssey', 4600),
('Halo Infinite', 5000),
('Gran Turismo 7', 5200),
('Minecraft', 3000),
('Resident Evil 9', 5500),
('Street Fighter VI', 4900);
GO

-- COMPRAS (5)
INSERT INTO Compras (FechaCompras, Hora, IdProducto, NombreProducto, PrecioUnitario, Cantidad)
VALUES
('2025-11-01','08:30',1,'PlayStation 5',45000,3),
('2025-11-02','09:20',2,'Xbox Series X',42000,2),
('2025-11-03','10:10',3,'Nintendo Switch OLED',28000,5),
('2025-11-04','11:00',4,'FIFA 25',4500,20),
('2025-11-05','11:30',5,'Call of Duty: MW4',5200,15),
('2025-11-06','12:15',6,'PlayStation 4',25000,4),
('2025-11-07','13:00',7,'Xbox One S',23000,3),
('2025-11-08','14:20',8,'Nintendo Switch Lite',18000,6),
('2025-11-09','15:10',9,'The Legend of Zelda: Breath of the Wild',4800,12),
('2025-11-10','16:05',10,'Super Mario Odyssey',4600,10),
('2025-11-11','17:30',11,'Halo Infinite',5000,8),
('2025-11-12','18:45',12,'Gran Turismo 7',5200,7),
('2025-11-13','19:20',13,'Minecraft',3000,25),
('2025-11-14','20:00',14,'Resident Evil 9',5500,9),
('2025-11-15','21:10',15,'Street Fighter VI',4900,11);

GO

-- VENTAS (5)
INSERT INTO Ventas (FechaVentas, HoraVentas, NombreProductos, IdProductos, CantidadProductos, Total, IdCliente)
VALUES
('2025-11-10','13:00','PlayStation 5',1,1,45000,1),
('2025-11-11','14:20','Xbox Series X',2,1,42000,2),
('2025-11-12','15:10','Nintendo Switch OLED',3,2,56000,3),
('2025-11-13','16:00','FIFA 25',4,3,13500,4),
('2025-11-14','17:00','Call of Duty: MW4',5,2,10400,5),
('2025-11-15','10:30','PlayStation 4',6,1,25000,6),
('2025-11-16','11:45','Xbox One S',7,2,46000,7),
('2025-11-17','12:20','Nintendo Switch Lite',8,1,18000,8),
('2025-11-18','13:10','The Legend of Zelda: Breath of the Wild',9,2,9600,9),
('2025-11-19','14:00','Super Mario Odyssey',10,1,4600,10),
('2025-11-20','15:15','Halo Infinite',11,3,15000,11),
('2025-11-21','16:40','Gran Turismo 7',12,2,10400,12),
('2025-11-22','17:25','Minecraft',13,5,15000,13),
('2025-11-23','18:50','Resident Evil 9',14,2,11000,14),
('2025-11-24','19:30','Street Fighter VI',15,4,19600,15);

GO

/* =======================================
   REQUERIMIENTOS
   ======================================= */

-- 1) Desvincular empleados nacidos en 1970
DELETE FROM Empleado
WHERE YEAR(FechaNacimiento) = 1970;
GO

-- 2) Actualizar sueldos menores de 25,000 → 35,000
UPDATE Empleado
SET Sueldo = 35000
WHERE Sueldo < 25000;
GO

-- 3) Ordenar empleados por edad descendente
SELECT Nombre, Apellido, FechaNacimiento,
DATEDIFF(YEAR, FechaNacimiento, GETDATE()) AS Edad
FROM Empleado
ORDER BY Edad DESC;
GO

-- 4) Ordenar ventas por fecha ascendente
SELECT * FROM Ventas
ORDER BY FechaVentas ASC;
GO

-- 5) Agrupar compras
SELECT NombreProducto, SUM(Cantidad) AS TotalComprado, SUM(PrecioUnitario*Cantidad) AS TotalGastado
FROM Compras
GROUP BY NombreProducto;
GO

-- 6) Agrupar ventas
SELECT NombreProductos, SUM(CantidadProductos) AS TotalVendido, SUM(Total) AS TotalIngresos
FROM Ventas
GROUP BY NombreProductos;
GO

-- 7) Insertar 2 nuevos empleados con sueldo 70,000
INSERT INTO Empleado (Nombre, Apellido, Telefono, Direccion, FechaNacimiento, Sueldo, FechaContrato)
VALUES
('Esteban','Hidalgo','809-666-1111','Calle Gamer 9','1990-02-10',70000,'2025-01-10'),
('Melisa','Torres','809-777-2222','Calle Retro 4','1987-09-04',70000,'2025-01-15');
GO

/* =======================================
   TRIGGER PARA VENTAS
   ======================================= */
CREATE TRIGGER TR_Ventas_Insert
ON Ventas
AFTER INSERT
AS
BEGIN
    INSERT INTO AuditLog (Tabla, Operacion, Detalle)
    SELECT 'Ventas','INSERT', CONCAT('Venta realizada: ', NombreProductos, ' Total: ', Total)
    FROM inserted;
END;
GO

/* =======================================
   TRIGGER PARA CLIENTES
   ======================================= */
CREATE TRIGGER TR_Clientes_Insert
ON Clientes
AFTER INSERT
AS
BEGIN
    INSERT INTO AuditLog (Tabla, Operacion, Detalle)
    SELECT 'Clientes','INSERT', CONCAT('Nuevo cliente: ', Nombre, ' ', Apellido)
    FROM inserted;
END;
GO

/* =======================================
   FILTRADO DE VENTAS
   ======================================= */

-- Ventas mayores de RD$15,000
SELECT * FROM Ventas
WHERE Total > 15000;
GO

/* =======================================
   JOIN VENTAS + COMPRAS (Por IdProducto)
   ======================================= */
SELECT v.CodigoVentas, v.NombreProductos,
       c.IdCompras, c.NombreProducto,
       v.Total AS TotalVenta, c.TotalCompra AS TotalCompra
FROM Ventas v
FULL JOIN Compras c
ON v.IdProductos = c.IdProducto;
GO

/* =======================================
   JOIN CLIENTES + COMPRAS (prioridad cliente)
   ======================================= */
SELECT cl.IdCliente, cl.Nombre, cl.Apellido,
       co.IdCompras, co.NombreProducto, co.TotalCompra
FROM Clientes cl
LEFT JOIN Ventas v
    ON cl.IdCliente = v.IdCliente
LEFT JOIN Compras co
    ON v.IdProductos = co.IdProducto;
GO

-- Mostrar Audit Log
SELECT * FROM AuditLog;
GO



-- 1. Crear LOGIN a nivel de servidor
CREATE LOGIN gameuser WITH PASSWORD = '1234', CHECK_POLICY = OFF;
GO

-- 2. Darle acceso a la base de datos
USE GameHouseDB;
GO
CREATE USER gameuser FOR LOGIN gameuser;
GO

-- 3. Darle permisos (LECTURA y ESCRITURA)
ALTER ROLE db_datareader ADD MEMBER gameuser;
ALTER ROLE db_datawriter ADD MEMBER gameuser;
GO
