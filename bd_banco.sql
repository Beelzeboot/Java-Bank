-- drop

DROP database bd_banco;

-- Crear la base de datos
CREATE DATABASE bd_banco;

-- Usar la base de datos
USE bd_banco;

-- Crear la tabla 'usuarios'
CREATE TABLE usuarios (
   Dni_Usuario varchar(8) NOT NULL,
   Cuil_Usuario varchar(13) NOT NULL,
   Nombre_Usuario varchar(40) NOT NULL,
   Apellido_Usuario varchar(40) NOT NULL,
   Sexo_Usuario varchar(1) NOT NULL,
   Nacionalidad_Usuario varchar(40) NOT NULL,
   FechaNacimiento_Usuario date NOT NULL,
   Direccion_Usuario varchar(45) NOT NULL,
   Localidad_Usuario varchar(40) NOT NULL,
   Provincia_Usuario varchar(40) NOT NULL,
   CorreoElectronico_Usuario varchar(45) NOT NULL,
   Telefono_Usuario varchar(30) DEFAULT NULL,
   NombreUsuario_Usuario varchar(40) NOT NULL,
   Contrasena_Usuario varchar(30) NOT NULL,
   TipoUsuario_Usuario tinyint DEFAULT '0',
   Estado_Usuario tinyint DEFAULT '1',
   PRIMARY KEY (Dni_Usuario)
); 
/*
TipoUsuario_Usuario 4 numeros
Estado_Usuario 4 numeros
*/
-- Crear la tabla 'tipos_de_cuenta'
CREATE TABLE tipos_de_cuenta (
   CodTipoCuenta_TipoDeCuenta int NOT NULL,
   Descripcion_TipoDeCuenta varchar(20) NOT NULL,
   PRIMARY KEY (CodTipoCuenta_TipoDeCuenta)
); 

/*
CodTipoCuenta_TipoDeCuenta 11 numeros
*/
-- Crear la tabla 'cuentas'
CREATE TABLE cuentas (
   NumCuenta_Cuenta char(5) NOT NULL,
   Dni_Cuenta varchar(8) DEFAULT NULL,
   FechaCreacion_Cuenta datetime NOT NULL,
   CodTipoCuenta_Cuenta int NOT NULL,
   Cbu_Cuenta varchar(10) NOT NULL,
   Saldo_Cuenta decimal(11,2) DEFAULT '10000.00',
   Estado_Cuenta tinyint DEFAULT '1',
   PRIMARY KEY (NumCuenta_Cuenta),
   FOREIGN KEY (Dni_Cuenta) REFERENCES usuarios (Dni_Usuario)
); 

/*
CodTipoCuenta_Cuenta 
Estado_Cuenta 4 numeros
*/

-- Crear la tabla 'tipos_de_movimientos'
CREATE TABLE tipos_de_movimientos (
   CodTipoMovimiento_TipoDeMovimiento int NOT NULL,
   Descripcion_TipoDeMovimiento varchar(20) NOT NULL,
   PRIMARY KEY (CodTipoMovimiento_TipoDeMovimiento)
); 

/*
CodTipoMovimiento_TipoDeMovimiento 11 numeros
*/

-- Crear la tabla 'movimientos'
CREATE TABLE movimientos (
   Cod_Movimiento int NOT NULL AUTO_INCREMENT,
   Fecha_Movimiento datetime NOT NULL,
   Detalle_Movimiento varchar(250) DEFAULT NULL,
   Importe_Movimiento decimal(11,2) NOT NULL,
   CodTipoMovimiento_Movimiento int NOT NULL,
   NumCuenta_Movimiento char(5) NOT NULL,
   PRIMARY KEY (Cod_Movimiento),
   FOREIGN KEY (CodTipoMovimiento_Movimiento) REFERENCES tipos_de_movimientos (CodTipoMovimiento_TipoDeMovimiento)
); 

/*
Cod_Movimiento 11 numeros
CodTipoMovimiento_Movimiento 11 numeros
*/

-- Crear la tabla 'prestamos'
CREATE TABLE prestamos (
   Cod_Prestamo int NOT NULL AUTO_INCREMENT,
   NumCuenta_Prestamo char(5) NOT NULL,
   Fecha_Prestamo datetime NOT NULL,
   ImportePagar_Prestamo decimal(11,2) DEFAULT '0.00',
   ImportePedido_Prestamo decimal(11,2) DEFAULT '0.00',
   PlazoDePago_Prestamo datetime DEFAULT '1971-01-01 00:00:00',
   Cuotas_Prestamo int DEFAULT 0,
   CuotasPagadas_Prestamo int DEFAULT 0,
   Estado_Prestamo int DEFAULT 0,
   PRIMARY KEY (Cod_Prestamo),
   FOREIGN KEY (NumCuenta_Prestamo) REFERENCES cuentas (NumCuenta_Cuenta)
);
/*
Cod_Prestamo 10 numeros
CuotasPagadas_Prestamo 11 numeros
Cuotas_Prestamo 11 numeros
Estado_Prestamo 11 numeros
*/
-- Insertar datos en la tabla 'usuarios'
INSERT INTO usuarios (Dni_Usuario, Cuil_Usuario, Nombre_Usuario, Apellido_Usuario, Sexo_Usuario, Nacionalidad_Usuario, FechaNacimiento_Usuario, Direccion_Usuario, Localidad_Usuario, Provincia_Usuario, CorreoElectronico_Usuario, Telefono_Usuario, NombreUsuario_Usuario, Contrasena_Usuario, TipoUsuario_Usuario, Estado_Usuario)
VALUES
('15346666', '20153466669', 'Jose', 'Perez', 'M', 'Argentina', '1990-01-15', 'Calle Principal 123', 'Buenos Aires', 'Buenos Aires', 'jose@gmail.com', '1234567890', 'admin', 'admin', 0, 1),
('15345678', '20153456789', 'Juan', 'Perez', 'M', 'Argentina', '1990-01-15', 'Calle Principal 123', 'Buenos Aires', 'Buenos Aires', 'juan@gmail.com', '1234567890', 'juanperez', 'password123', 1, 1),
('28765432', '20287654329', 'Maria', 'Gonzalez', 'F', 'Argentina', '1985-05-20', 'Avenida Central 456', 'Córdoba', 'Córdoba', 'maria@gmail.com', '9876543210', 'mariagonzalez', 'password456', 1, 1),
('16111111', '20161111112', 'Carlos', 'Lopez', 'M', 'Argentina', '1995-11-10', 'Avenida Norte 789', 'Rosario', 'Santa Fe', 'carlos@gmail.com', '1111222233', 'carloslopez', 'password789', 1, 1);

-- Insertar datos en la tabla 'tipos_de_cuenta'
INSERT INTO tipos_de_cuenta (CodTipoCuenta_TipoDeCuenta, Descripcion_TipoDeCuenta)
VALUES
(1, 'Cuenta Corriente'),
(2, 'Caja de Ahorro'),
(3, 'Ahorro Plazo fijo');

-- Insertar datos en la tabla 'cuentas'
INSERT INTO cuentas (NumCuenta_Cuenta, Dni_Cuenta, FechaCreacion_Cuenta, CodTipoCuenta_Cuenta, Cbu_Cuenta, Saldo_Cuenta, Estado_Cuenta)
VALUES
('00001', '15345678', NOW(), 1, '1534567890', 15000.00, 1),
('00002', '28765432', NOW(), 2, '2876543210', 8000.00, 1),
('00003', '16111111', NOW(), 3, '1611111122', 25000.00, 1);

-- Insertar datos en la tabla 'tipos_de_movimientos'
INSERT INTO tipos_de_movimientos (CodTipoMovimiento_TipoDeMovimiento, Descripcion_TipoDeMovimiento)
VALUES
(1, 'Depósito'),
(2, 'Retiro'),
(3, 'Transferencia');

-- Insertar datos en la tabla 'movimientos'
INSERT INTO movimientos (Fecha_Movimiento, Detalle_Movimiento, Importe_Movimiento, CodTipoMovimiento_Movimiento, NumCuenta_Movimiento)
VALUES
(NOW(), 'Depósito inicial', 10000.00, 1, '00001'),
(NOW(), 'Retiro de efectivo', -500.00, 2, '00001'),
(NOW(), 'Transferencia a cuenta 00002', -1000.00, 3, '00001'),
(NOW(), 'Depósito inicial', 5000.00, 1, '00002'),
(NOW(), 'Retiro de efectivo', -100.00, 2, '00002'),
(NOW(), 'Transferencia a cuenta 00001', -300.00, 3, '00002');

-- Insertar datos en la tabla 'prestamos'
INSERT INTO prestamos (NumCuenta_Prestamo, Fecha_Prestamo, ImportePagar_Prestamo, ImportePedido_Prestamo, PlazoDePago_Prestamo, Cuotas_Prestamo, CuotasPagadas_Prestamo, Estado_Prestamo)
VALUES
('00001', NOW(), 5000.00, 10000.00, '2023-12-31 00:00:00', 12, 3, 1),
('00002', NOW(), 3000.00, 5000.00, '2024-01-15 00:00:00', 6, 1, 1),
('00003', NOW(), 2000.00, 4000.00, '2024-02-28 00:00:00', 4, 0, 1);


