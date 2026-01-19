-- Script de Datos Iniciales (Seed Data)
-- Este script puebla la base de datos con información base para pruebas y operación inicial.

USE [master]; -- O la base de datos que estés usando, idealmente deberíamos parametrizar o asumir contexto
GO

-- 1. Poblar Catálogos (Tablas de Referencia)
-- Usamos NOT EXISTS para evitar duplicados si el script se corre 2 veces

-- TipoVehiculo
INSERT INTO [catalogs].[TipoVehiculo] (Nombre)
SELECT 'Camión' WHERE NOT EXISTS (SELECT 1 FROM [catalogs].[TipoVehiculo] WHERE Nombre = 'Camión')
UNION ALL
SELECT 'Furgoneta' WHERE NOT EXISTS (SELECT 1 FROM [catalogs].[TipoVehiculo] WHERE Nombre = 'Furgoneta')
UNION ALL
SELECT 'Autobús' WHERE NOT EXISTS (SELECT 1 FROM [catalogs].[TipoVehiculo] WHERE Nombre = 'Autobús')
UNION ALL
SELECT 'Automóvil' WHERE NOT EXISTS (SELECT 1 FROM [catalogs].[TipoVehiculo] WHERE Nombre = 'Automóvil');
GO

-- ModalidadTransporte
INSERT INTO [catalogs].[ModalidadTransporte] (Nombre)
SELECT 'Carga General' WHERE NOT EXISTS (SELECT 1 FROM [catalogs].[ModalidadTransporte] WHERE Nombre = 'Carga General')
UNION ALL
SELECT 'Pasajeros Urbano' WHERE NOT EXISTS (SELECT 1 FROM [catalogs].[ModalidadTransporte] WHERE Nombre = 'Pasajeros Urbano')
UNION ALL
SELECT 'Pasajeros Interurbano' WHERE NOT EXISTS (SELECT 1 FROM [catalogs].[ModalidadTransporte] WHERE Nombre = 'Pasajeros Interurbano')
UNION ALL
SELECT 'Carga Peligrosa' WHERE NOT EXISTS (SELECT 1 FROM [catalogs].[ModalidadTransporte] WHERE Nombre = 'Carga Peligrosa');
GO

-- EstadoVehiculo
INSERT INTO [catalogs].[EstadoVehiculo] (Nombre)
SELECT 'Activo' WHERE NOT EXISTS (SELECT 1 FROM [catalogs].[EstadoVehiculo] WHERE Nombre = 'Activo')
UNION ALL
SELECT 'En Mantenimiento' WHERE NOT EXISTS (SELECT 1 FROM [catalogs].[EstadoVehiculo] WHERE Nombre = 'En Mantenimiento')
UNION ALL
SELECT 'Fuera de Servicio' WHERE NOT EXISTS (SELECT 1 FROM [catalogs].[EstadoVehiculo] WHERE Nombre = 'Fuera de Servicio')
UNION ALL
SELECT 'Baja' WHERE NOT EXISTS (SELECT 1 FROM [catalogs].[EstadoVehiculo] WHERE Nombre = 'Baja');
GO

-- 2. Poblar Vehículos (Datos de Ejemplo)
-- Obtenemos los IDs dinámicamente para no depender de números fijos

DECLARE @TipoCamion INT = (SELECT TOP 1 TipoVehiculoId FROM [catalogs].[TipoVehiculo] WHERE Nombre = 'Camión');
DECLARE @TipoFurgoneta INT = (SELECT TOP 1 TipoVehiculoId FROM [catalogs].[TipoVehiculo] WHERE Nombre = 'Furgoneta');
DECLARE @TipoBus INT = (SELECT TOP 1 TipoVehiculoId FROM [catalogs].[TipoVehiculo] WHERE Nombre = 'Autobús');

DECLARE @ModCarga INT = (SELECT TOP 1 ModalidadTransporteId FROM [catalogs].[ModalidadTransporte] WHERE Nombre = 'Carga General');
DECLARE @ModPasajeros INT = (SELECT TOP 1 ModalidadTransporteId FROM [catalogs].[ModalidadTransporte] WHERE Nombre = 'Pasajeros Interurbano');

DECLARE @EstadoActivo INT = (SELECT TOP 1 EstadoVehiculoId FROM [catalogs].[EstadoVehiculo] WHERE Nombre = 'Activo');
DECLARE @EstadoMant INT = (SELECT TOP 1 EstadoVehiculoId FROM [catalogs].[EstadoVehiculo] WHERE Nombre = 'En Mantenimiento');

-- Vehículo 1: Camión Volvo (Carga)
IF NOT EXISTS (SELECT 1 FROM [core].[Vehiculo] WHERE Patente = 'AA-123-BB')
BEGIN
    INSERT INTO [core].[Vehiculo] 
    (TipoVehiculoId, ModalidadTransporteId, EstadoVehiculoId, Patente, Marca, Modelo, Anio, CapacidadCargaKg, CapacidadPasajeros)
    VALUES 
    (@TipoCamion, @ModCarga, @EstadoActivo, 'AA-123-BB', 'Volvo', 'FH16', 2023, 25000.00, 2);
END

-- Vehículo 2: Bus Scania (Pasajeros)
IF NOT EXISTS (SELECT 1 FROM [core].[Vehiculo] WHERE Patente = 'CC-987-DD')
BEGIN
    INSERT INTO [core].[Vehiculo] 
    (TipoVehiculoId, ModalidadTransporteId, EstadoVehiculoId, Patente, Marca, Modelo, Anio, CapacidadCargaKg, CapacidadPasajeros)
    VALUES 
    (@TipoBus, @ModPasajeros, @EstadoActivo, 'CC-987-DD', 'Scania', 'Touring', 2022, 1000.00, 50);
END

-- Vehículo 3: Furgoneta Mercedes (Mantenimiento)
IF NOT EXISTS (SELECT 1 FROM [core].[Vehiculo] WHERE Patente = 'ZZ-555-XX')
BEGIN
    INSERT INTO [core].[Vehiculo] 
    (TipoVehiculoId, ModalidadTransporteId, EstadoVehiculoId, Patente, Marca, Modelo, Anio, CapacidadCargaKg, CapacidadPasajeros)
    VALUES 
    (@TipoFurgoneta, @ModCarga, @EstadoMant, 'ZZ-555-XX', 'Mercedes-Benz', 'Sprinter', 2021, 3500.00, 3);
END
GO
