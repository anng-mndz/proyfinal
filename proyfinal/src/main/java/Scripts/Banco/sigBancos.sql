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
  `id_cliente`      INT          NOT NULL AUTO_INCREMENT,
  `nombre_completo` VARCHAR(150) NOT NULL,
  `dpi_nit`         VARCHAR(30)  UNIQUE,
  `telefono`        VARCHAR(20),
  `direccion`       VARCHAR(200),
  `correo`          VARCHAR(100),
  PRIMARY KEY (`id_cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
 
-- Tabla: Cuenta_Bancaria
CREATE TABLE IF NOT EXISTS `Cuenta_Bancaria` (
  `id_cuenta`      INT           NOT NULL AUTO_INCREMENT,
  `numero_cuenta`  VARCHAR(50)   NOT NULL UNIQUE,
  `saldo_actual`   DECIMAL(12,2) DEFAULT 0.00,
  `fecha_apertura` DATE          NOT NULL,
  `id_banco`       INT           NOT NULL,
  `id_cliente`     INT           NOT NULL,
  `id_tipo_cuenta` INT           NOT NULL,
  PRIMARY KEY (`id_cuenta`),
  FOREIGN KEY (`id_banco`)       REFERENCES `Banco`          (`id_banco`),
  FOREIGN KEY (`id_cliente`)     REFERENCES `Cliente`        (`id_cliente`),
  FOREIGN KEY (`id_tipo_cuenta`) REFERENCES `Cat_TipoCuenta` (`id_tipo_cuenta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
 
-- Tabla: Movimiento_Bancario
CREATE TABLE IF NOT EXISTS `Movimiento_Bancario` (
  `id_movimiento`       INT           NOT NULL AUTO_INCREMENT,
  `fecha_movimiento`    DATETIME      DEFAULT CURRENT_TIMESTAMP,
  `monto`               DECIMAL(12,2) NOT NULL,
  `descripcion`         VARCHAR(255),
  `id_cuenta`           INT           NOT NULL,
  `id_tipo_transaccion` INT           NOT NULL,
  PRIMARY KEY (`id_movimiento`),
  FOREIGN KEY (`id_cuenta`)           REFERENCES `Cuenta_Bancaria`    (`id_cuenta`),
  FOREIGN KEY (`id_tipo_transaccion`) REFERENCES `Cat_TipoTransaccion` (`id_tipo_transaccion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
 
-- Tabla: Conciliacion_Bancaria
CREATE TABLE IF NOT EXISTS `Conciliacion_Bancaria` (
  `id_conciliacion`    INT           NOT NULL AUTO_INCREMENT,
  `fecha_conciliacion` DATETIME      DEFAULT CURRENT_TIMESTAMP,
  `saldo_sistema`      DECIMAL(12,2) NOT NULL,
  `saldo_banco`        DECIMAL(12,2) NOT NULL,
  `diferencia`         DECIMAL(12,2) NOT NULL,
  `id_cuenta`          INT           NOT NULL,
  `id_estado`          INT           NOT NULL,
  PRIMARY KEY (`id_conciliacion`),
  FOREIGN KEY (`id_cuenta`) REFERENCES `Cuenta_Bancaria`      (`id_cuenta`),
  FOREIGN KEY (`id_estado`) REFERENCES `Cat_EstadoConciliacion` (`id_estado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
 
-- Tabla: Bitacora_Bancaria
-- Vinculada a usuario del módulo de seguridad
CREATE TABLE IF NOT EXISTS `Bitacora_Bancaria` (
  `id_bitacora`      INT          NOT NULL AUTO_INCREMENT,
  `usuid`            INT          DEFAULT NULL,
  `accion_realizada` VARCHAR(200),
  `tabla_afectada`   VARCHAR(100),
  `fecha_accion`     DATETIME     DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_bitacora`),
  FOREIGN KEY (`usuid`) REFERENCES `usuario` (`usuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
 
-- ============================================================
-- DATOS INICIALES
-- ============================================================
 
INSERT INTO `Cat_TipoCuenta` (`nombre_tipo`, `descripcion`) VALUES
  ('Monetaria', 'Cuenta de uso diario'),
  ('Ahorro',    'Cuenta de ahorro personal');
 
INSERT INTO `Cat_TipoTransaccion` (`nombre_tipo`, `descripcion`) VALUES
  ('Deposito',      'Ingreso de dinero'),
  ('Retiro',        'Salida de dinero'),
  ('Transferencia', 'Movimiento entre cuentas'),
  ('Pago',          'Pago realizado'),
  ('Cobro',         'Cobro recibido');
 
INSERT INTO `Cat_EstadoConciliacion` (`nombre_estado`) VALUES
  ('Conciliado'),
  ('Pendiente'),
  ('Con Diferencia');
 
COMMIT;
 
SET FOREIGN_KEY_CHECKS = 1;
 
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
 
