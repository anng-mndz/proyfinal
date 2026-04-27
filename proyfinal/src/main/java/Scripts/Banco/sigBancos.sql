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
  `TCidcuenta` INT          NOT NULL AUTO_INCREMENT,
  `TCnombretipo`    VARCHAR(50)  NOT NULL UNIQUE,
  `TCdescripcion`    VARCHAR(150),
  PRIMARY KEY (`TCidcuenta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
 
-- Catálogo: tipos de transacción
CREATE TABLE IF NOT EXISTS `Cat_TipoTransaccion` (
  `TTid` INT         NOT NULL AUTO_INCREMENT,
  `TTnombretipo`         VARCHAR(50) NOT NULL UNIQUE,
  `TTdescripcion`         VARCHAR(150),
  PRIMARY KEY (`TTid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
 
-- Catálogo: estados de conciliación
CREATE TABLE IF NOT EXISTS `Cat_EstadoConciliacion` (
  `Catesid`     INT         NOT NULL AUTO_INCREMENT,
  `Catesnombreestado` VARCHAR(50) NOT NULL UNIQUE,
  PRIMARY KEY (`Catesid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
 
-- Tabla: Banco
CREATE TABLE IF NOT EXISTS `Banco` (
  `Banid`       INT          NOT NULL AUTO_INCREMENT,
  `Bannombre`   VARCHAR(100) NOT NULL,
  `Bandireccion`      VARCHAR(200),
  `Bantelefono`       VARCHAR(20),
  `Bancorreo`         VARCHAR(100),
  `Banfecharegistro` DATETIME     DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Banid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
 
-- Tabla: Cliente (bancario)
-- Nota: se mantiene separada de `usuario` ya que cliente es una entidad
-- externa que puede no tener acceso al sistema.
CREATE TABLE IF NOT EXISTS `Cliente` (
  `Clid`      INT          NOT NULL AUTO_INCREMENT,
  `Clinombre` VARCHAR(150) NOT NULL,
  `Clinit`         VARCHAR(30)  UNIQUE,
  `Clitelefono`        VARCHAR(20),
  `Cliestado`       VARCHAR(20),
  `Clidireccion`       VARCHAR(200),
  `Clicorreo`          VARCHAR(100),
  PRIMARY KEY (`Clid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
 
-- Tabla: Cuenta_Bancaria
CREATE TABLE IF NOT EXISTS `CuentaBancaria` (
  `CBANid`      INT           NOT NULL AUTO_INCREMENT,
  `CBANnumerocuenta`  VARCHAR(50)   NOT NULL UNIQUE,
  `CBANsaldoactual`   DECIMAL(12,2) DEFAULT 0.00,
  `CBANfechaapertura` DATE          NOT NULL,
  `Banid`       INT           NOT NULL,
  `Cliid`     INT           NOT NULL,
  `TCidcuenta` INT           NOT NULL,
  PRIMARY KEY (`TCidcuenta`),
  FOREIGN KEY (`Banid`)       REFERENCES `Banco`          (`Banid`),
  FOREIGN KEY (`Cliid`)     REFERENCES `Cliente`        (`Cliid`),
  FOREIGN KEY (`TCidcuenta`) REFERENCES `CatTipoCuenta` (`TCicuenta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
 
-- Tabla: Movimiento_Bancario
CREATE TABLE IF NOT EXISTS `MovimientoBancario` (
  `Movbid`       INT           NOT NULL AUTO_INCREMENT,
  `Movbfechamovimiento`    DATETIME      DEFAULT CURRENT_TIMESTAMP,
  `Movibmonto`               DECIMAL(12,2) NOT NULL,
  `Movdescripcion`         VARCHAR(255),
  `CBANid`           INT           NOT NULL,
  `TTid` INT           NOT NULL,
  `Movbtipomov`     VARCHAR(20) NOT NULL,
  `Movbreferencia`   VARCHAR(50),
  `Movbconciliado`  CHAR(1) DEFAULT 'N', 
  PRIMARY KEY (`Movbid`),
  FOREIGN KEY (`CBANid`)           REFERENCES `CuentaBancaria`    (`CBANid`),
  FOREIGN KEY (`TTid`) REFERENCES `CatTipoTransaccion` (`TTid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
 
-- Tabla: Conciliacion_Bancaria
CREATE TABLE IF NOT EXISTS `ConciliacionBancaria` (
  `Conbid`    INT           NOT NULL AUTO_INCREMENT,
  `conbfecha` DATETIME      DEFAULT CURRENT_TIMESTAMP,
  `Conbsaldosistema`      DECIMAL(12,2) NOT NULL,
  `Conbsaldobanco`        DECIMAL(12,2) NOT NULL,
  `Conbdiferencia`         DECIMAL(12,2) NOT NULL,
  `CBANid`          INT           NOT NULL,
  `Catesid`          INT           NOT NULL,
  PRIMARY KEY (`Conbid`),
  FOREIGN KEY (`CBANid`) REFERENCES `CuentaBancaria`      (`CBANid`),
  FOREIGN KEY (`Catesid`) REFERENCES `CatEstadoConciliacion` (`Catesid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
 
-- Tabla: Bitacora_Bancaria
-- Vinculada a usuario del módulo de seguridad
CREATE TABLE IF NOT EXISTS `BitacoraBancaria` (
  `BBid`      INT          NOT NULL AUTO_INCREMENT,
  `BBusuarioaccion`            INT          DEFAULT NULL,
  `BBaccionrealizada` VARCHAR(200),
  `BBtablaafectada`   VARCHAR(100),
  `BBfechaaccion`     DATETIME     DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`BBid`),
  FOREIGN KEY (`BBusuarioaccion`) REFERENCES `usuario` (`BBusuarioaccion`)
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
 
