-- Creación de Schemas
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'core')
BEGIN
    EXEC('CREATE SCHEMA [core]')
END
GO

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'catalogs')
BEGIN
    EXEC('CREATE SCHEMA [catalogs]')
END
GO
