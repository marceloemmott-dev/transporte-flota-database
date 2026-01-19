-- Tabla Principal: Vehiculo
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[core].[Vehiculo]') AND type in (N'U'))
BEGIN
    CREATE TABLE [core].[Vehiculo](
        [VehiculoId] [int] IDENTITY(1,1) NOT NULL,
        [TipoVehiculoId] [int] NOT NULL,
        [ModalidadTransporteId] [int] NULL, -- Asumiendo NULL según diagrama visual, ajustar si es NOT NULL
        [EstadoVehiculoId] [int] NOT NULL,
        [Patente] [nvarchar](20) NOT NULL,
        [Marca] [nvarchar](50) NULL,
        [Modelo] [nvarchar](50) NULL,
        [Anio] [int] NULL,
        [CapacidadPasajeros] [int] NULL,
        [CapacidadCargaKg] [decimal](10, 2) NULL,
        [FechaAlta] [datetime] DEFAULT GETDATE(),
        [Activo] [bit] DEFAULT 1,
        
        CONSTRAINT [PK_Vehiculo] PRIMARY KEY CLUSTERED ([VehiculoId] ASC),
        
        CONSTRAINT [FK_Vehiculo_TipoVehiculo] FOREIGN KEY([TipoVehiculoId])
        REFERENCES [catalogs].[TipoVehiculo] ([TipoVehiculoId]),
        
        CONSTRAINT [FK_Vehiculo_ModalidadTransporte] FOREIGN KEY([ModalidadTransporteId])
        REFERENCES [catalogs].[ModalidadTransporte] ([ModalidadTransporteId]),
        
        CONSTRAINT [FK_Vehiculo_EstadoVehiculo] FOREIGN KEY([EstadoVehiculoId])
        REFERENCES [catalogs].[EstadoVehiculo] ([EstadoVehiculoId])
    );
END
GO
