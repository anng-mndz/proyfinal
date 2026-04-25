-- ============================================================
-- phpMyAdmin SQL Dump - Integrado
-- Base de datos principal: sig
-- Incluye: Seguridad, Bancos, Películas
-- Versión del servidor: 10.4.32-MariaDB
-- ============================================================
 
CREATE DATABASE IF NOT EXISTS sig
DEFAULT CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci;
 
USE sig;
 
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";
SET FOREIGN_KEY_CHECKS = 0;
 
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
 
START TRANSACTION;
 
-- ============================================================
-- MÓDULO DE SEGURIDAD
-- ============================================================
 
-- Tabla: aplicaciones
CREATE TABLE IF NOT EXISTS `aplicaciones` (
  `Aplcodigo` int(11) NOT NULL,
  `Aplnombre` varchar(100) NOT NULL,
  `Aplestado` varchar(100) NOT NULL,
  PRIMARY KEY (`Aplcodigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
 
-- Tabla: perfiles
CREATE TABLE IF NOT EXISTS `perfiles` (
  `Percodigo` int(11) NOT NULL AUTO_INCREMENT,
  `Pernombre` varchar(100) NOT NULL,
  `Perestado` char(1) NOT NULL,
  PRIMARY KEY (`Percodigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
 
-- Tabla: usuario
CREATE TABLE IF NOT EXISTS `usuario` (
  `usuid`          INT          NOT NULL AUTO_INCREMENT,
  `usunombre`      VARCHAR(45)  NOT NULL,
  `usucontrasena`  VARCHAR(25)  NOT NULL,
  `usuultimasesion` DATE,
  `usuestatus`     VARCHAR(1)   NOT NULL,
  `usunombrereal`  VARCHAR(60),
  `usucorreoe`     VARCHAR(60),
  `usutelefono`    VARCHAR(25),
  `usudireccion`   VARCHAR(80),
  PRIMARY KEY (`usuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
 
-- Tabla: bitacora (seguridad)
CREATE TABLE IF NOT EXISTS `bitacora` (
  `Bitcodigo` int(11)      NOT NULL AUTO_INCREMENT,
  `UsuId`     int(11)      DEFAULT NULL,
  `Aplcodigo` int(11)      DEFAULT NULL,
  `Bitfecha`  datetime     DEFAULT NULL,
  `Bitip`     varchar(50)  DEFAULT NULL,
  `Bitequipo` varchar(100) DEFAULT NULL,
  `Bitaccion` varchar(50)  DEFAULT NULL,
  PRIMARY KEY (`Bitcodigo`),
  FOREIGN KEY (`UsuId`)    REFERENCES `usuario`      (`usuid`),
  FOREIGN KEY (`Aplcodigo`) REFERENCES `aplicaciones` (`Aplcodigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
 
-- Tabla: asignacionaplicacionperfil
CREATE TABLE IF NOT EXISTS `asignacionaplicacionperfil` (
  `Aplcodigo` int(11)     NOT NULL,
  `Percodigo` int(11)     NOT NULL,
  `APLPins`   varchar(1)  NOT NULL,
  `APLPsel`   varchar(1)  NOT NULL,
  `APLPupd`   varchar(1)  NOT NULL,
  `APLPdel`   varchar(1)  NOT NULL,
  `APLPrep`   varchar(1)  NOT NULL,
  PRIMARY KEY (`Aplcodigo`, `Percodigo`),
  FOREIGN KEY (`Aplcodigo`) REFERENCES `aplicaciones` (`Aplcodigo`),
  FOREIGN KEY (`Percodigo`) REFERENCES `perfiles`     (`Percodigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
 
-- Tabla: asignacionaplicacionusuarios
CREATE TABLE IF NOT EXISTS `asignacionaplicacionusuarios` (
  `Aplcodigo` int(11)    NOT NULL,
  `UsuId`     int(11)    NOT NULL,
  `APLUins`   varchar(1) NOT NULL,
  `APLUsel`   varchar(1) NOT NULL,
  `APLUupd`   varchar(1) NOT NULL,
  `APLUdel`   varchar(1) NOT NULL,
  `APLUrep`   varchar(1) NOT NULL,
  PRIMARY KEY (`Aplcodigo`, `UsuId`),
  FOREIGN KEY (`Aplcodigo`) REFERENCES `aplicaciones` (`Aplcodigo`),
  FOREIGN KEY (`UsuId`)     REFERENCES `usuario`      (`usuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
 
-- Tabla: asignacionperfilusuario
CREATE TABLE IF NOT EXISTS `asignacionperfilusuario` (
  `UsuId`     int(11) NOT NULL,
  `Percodigo` int(11) NOT NULL,
  PRIMARY KEY (`UsuId`, `Percodigo`),
  FOREIGN KEY (`UsuId`)     REFERENCES `usuario`  (`usuid`),
  FOREIGN KEY (`Percodigo`) REFERENCES `perfiles` (`Percodigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
 
-- ============================================================
-- MÓDULO DE PELÍCULAS
-- ============================================================
 
CREATE TABLE IF NOT EXISTS `Peliculas` (
  `idPelicula`    INT          NOT NULL AUTO_INCREMENT,
  `nombre`        VARCHAR(45),
  `clasificacion` VARCHAR(45),
  `genero`        VARCHAR(45),
  `subtitulado`   VARCHAR(45),
  `idioma`        VARCHAR(45),
  `precio`        DOUBLE,
  PRIMARY KEY (`idPelicula`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
 
-- ============================================================
-- MÓDULO BANCARIO
-- ============================================================
 
-- Catálogo: tipos de cuenta
CREATE TABLE IF NOT EXISTS `Cat_TipoCuenta` (
  `id_tipo_cuenta` INT          NOT NULL AUTO_INCREMENT,
  `nombre_tipo`    VARCHAR(50)  NOT NULL UNIQUE,
  `descripcion`    VARCHAR(150),
  PRIMARY KEY (`id_tipo_cuenta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
 
-- Catálogo: tipos de transacción
CREATE TABLE IF NOT EXISTS `Cat_TipoTransaccion` (
  `id_tipo_transaccion` INT         NOT NULL AUTO_INCREMENT,
  `nombre_tipo`         VARCHAR(50) NOT NULL UNIQUE,
  `descripcion`         VARCHAR(150),
  PRIMARY KEY (`id_tipo_transaccion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
 
-- Catálogo: estados de conciliación
CREATE TABLE IF NOT EXISTS `Cat_EstadoConciliacion` (
  `id_estado`     INT         NOT NULL AUTO_INCREMENT,
  `nombre_estado` VARCHAR(50) NOT NULL UNIQUE,
  PRIMARY KEY (`id_estado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
 
-- Tabla: Banco
CREATE TABLE IF NOT EXISTS `Banco` (
  `id_banco`       INT          NOT NULL AUTO_INCREMENT,
  `nombre_banco`   VARCHAR(100) NOT NULL,
  `direccion`      VARCHAR(200),
  `telefono`       VARCHAR(20),
  `correo`         VARCHAR(100),
  `fecha_registro` DATETIME     DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_banco`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
 
-- Tabla: Cliente (bancario)
-- Nota: se mantiene separada de `usuario` ya que cliente es una entidad
-- externa que puede no tener acceso al sistema.
CREATE TABLE IF NOT EXISTS `Cliente` (
  `Idcliente`      INT          NOT NULL AUTO_INCREMENT,
  `Nombrecompleto` VARCHAR(150) NOT NULL,
  `Dpinit`         VARCHAR(30)  UNIQUE,
  `Telefono`        VARCHAR(20),
  `Direccion`       VARCHAR(200),
  `Correo`          VARCHAR(100),
  PRIMARY KEY (`Idcliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
 
-- Tabla: Cuenta_Bancaria
CREATE TABLE IF NOT EXISTS `CuentaBancaria` (
  `Idcuenta`      INT           NOT NULL AUTO_INCREMENT,
  `Numerocuenta`  VARCHAR(50)   NOT NULL UNIQUE,
  `Saldoactual`   DECIMAL(12,2) DEFAULT 0.00,
  `Fechaapertura` DATE          NOT NULL,
  `Idbanco`       INT           NOT NULL,
  `Idcliente`     INT           NOT NULL,
  `Idtipocuenta` INT           NOT NULL,
  PRIMARY KEY (`Idcuenta`),
  FOREIGN KEY (`Idbanco`)       REFERENCES `Banco`          (`Idbanco`),
  FOREIGN KEY (`Idcliente`)     REFERENCES `Cliente`        (`Idcliente`),
  FOREIGN KEY (`Idtipocuenta`) REFERENCES `CatTipoCuenta` (`Idtipocuenta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
 
-- Tabla: Movimiento_Bancario
CREATE TABLE IF NOT EXISTS `MovimientoBancario` (
  `Idmovimiento`       INT           NOT NULL AUTO_INCREMENT,
  `Fechamovimiento`    DATETIME      DEFAULT CURRENT_TIMESTAMP,
  `Monto`               DECIMAL(12,2) NOT NULL,
  `Descripcion`         VARCHAR(255),
  `Idcuenta`           INT           NOT NULL,
  `Idtipotransaccion` INT           NOT NULL,
  PRIMARY KEY (`Idmovimiento`),
  FOREIGN KEY (`dcuenta`)           REFERENCES `CuentaBancaria`    (`Idcuenta`),
  FOREIGN KEY (`Idtipotransaccion`) REFERENCES `CatTipoTransaccion` (`Idtipotransaccion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
 
-- Tabla: Conciliacion_Bancaria
CREATE TABLE IF NOT EXISTS `ConciliacionBancaria` (
  `Idconciliacion`    INT           NOT NULL AUTO_INCREMENT,
  `Fechaconciliacion` DATETIME      DEFAULT CURRENT_TIMESTAMP,
  `Saldosistema`      DECIMAL(12,2) NOT NULL,
  `Saldobanco`        DECIMAL(12,2) NOT NULL,
  `Diferencia`         DECIMAL(12,2) NOT NULL,
  `Idcuenta`          INT           NOT NULL,
  `Idestado`          INT           NOT NULL,
  PRIMARY KEY (`Idconciliacion`),
  FOREIGN KEY (`Idcuenta`) REFERENCES `CuentaBancaria`      (`Idcuenta`),
  FOREIGN KEY (`Idestado`) REFERENCES `CatEstadoConciliacion` (`Idestado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
 
-- Tabla: Bitacora_Bancaria
-- Vinculada a usuario del módulo de seguridad
CREATE TABLE IF NOT EXISTS `BitacoraBancaria` (
  `Idbitacora`      INT          NOT NULL AUTO_INCREMENT,
  `Usuid`            INT          DEFAULT NULL,
  `Accionrealizada` VARCHAR(200),
  `Tablaafectada`   VARCHAR(100),
  `Fechaaccion`     DATETIME     DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Idbitacora`),
  FOREIGN KEY (`Usuid`) REFERENCES `usuario` (`Usuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
 
-- ============================================================
-- DATOS INICIALES
-- ============================================================
 
INSERT INTO `CatTipoCuenta` (`Nombretipo`, `Descripcion`) VALUES
  ('Monetaria', 'Cuenta de uso diario'),
  ('Ahorro',    'Cuenta de ahorro personal');
 
INSERT INTO `CatTipoTransaccion` (`Nombretipo`, `Descripcion`) VALUES
  ('Deposito',      'Ingreso de dinero'),
  ('Retiro',        'Salida de dinero'),
  ('Transferencia', 'Movimiento entre cuentas'),
  ('Pago',          'Pago realizado'),
  ('Cobro',         'Cobro recibido');
 
INSERT INTO `CatEstadoConciliacion` (`Nombreestado`) VALUES
  ('Conciliado'),
  ('Pendiente'),
  ('Con Diferencia');
 
COMMIT;
 
SET FOREIGN_KEY_CHECKS = 1;
 
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
 
