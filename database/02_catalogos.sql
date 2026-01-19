-- Tablas de Catálogo

-- catalogs.TipoVehiculo
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[catalogs].[TipoVehiculo]') AND type in (N'U'))
BEGIN
    CREATE TABLE [catalogs].[TipoVehiculo](
        [TipoVehiculoId] [int] IDENTITY(1,1) NOT NULL,
        [Nombre] [nvarchar](50) NOT NULL,
        CONSTRAINT [PK_TipoVehiculo] PRIMARY KEY CLUSTERED ([TipoVehiculoId] ASC)
    );
END
GO

-- catalogs.ModalidadTransporte
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[catalogs].[ModalidadTransporte]') AND type in (N'U'))
BEGIN
    CREATE TABLE [catalogs].[ModalidadTransporte](
        [ModalidadTransporteId] [int] IDENTITY(1,1) NOT NULL,
        [Nombre] [nvarchar](50) NOT NULL,
        CONSTRAINT [PK_ModalidadTransporte] PRIMARY KEY CLUSTERED ([ModalidadTransporteId] ASC)
    );
END
GO

-- catalogs.EstadoVehiculo
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[catalogs].[EstadoVehiculo]') AND type in (N'U'))
BEGIN
    CREATE TABLE [catalogs].[EstadoVehiculo](
        [EstadoVehiculoId] [int] IDENTITY(1,1) NOT NULL,
        [Nombre] [nvarchar](50) NOT NULL,
        CONSTRAINT [PK_EstadoVehiculo] PRIMARY KEY CLUSTERED ([EstadoVehiculoId] ASC)
    );
END
GO
