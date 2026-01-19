# Diagrama Entidad-Relación (ERD)

Este diagrama representa la estructura actual de la base de datos "Transporte Flota". Se actualiza a medida que evoluciona el modelado.

```mermaid
erDiagram
    %% DEFINICIÓN DE ENTIDADES
    
    %% Schema: catalogs
    %% Tablas maestras para evitar redundancia de datos
    TipoVehiculo {
        int TipoVehiculoId PK
        nvarchar Nombre "Ej: Autobús, Camión, Van"
    }

    ModalidadTransporte {
        int ModalidadTransporteId PK
        nvarchar Nombre "Ej: Pasajeros, Carga, Mixto"
    }

    EstadoVehiculo {
        int EstadoVehiculoId PK
        nvarchar Nombre "Ej: Activo, En Mantenimiento, Baja"
    }

    %% Schema: core
    %% Tablas transaccionales principales
    Vehiculo {
        int VehiculoId PK
        int TipoVehiculoId FK
        int ModalidadTransporteId FK
        int EstadoVehiculoId FK
        nvarchar Patente "Unique"
        nvarchar Marca
        nvarchar Modelo
        int Anio
        int CapacidadPasajeros "Nullable"
        decimal CapacidadCargaKg "Nullable"
        datetime FechaAlta
        bit Activo
    }

    %% RELACIONES
    %% ||--o{ : Uno a Muchos (One to Many)
    
    TipoVehiculo ||--o{ Vehiculo : "define el tipo de"
    ModalidadTransporte ||--o{ Vehiculo : "establece modalidad a"
    EstadoVehiculo ||--o{ Vehiculo : "indica estado actual de"
```

## Leyenda
- **PK**: Primary Key (Llave Primaria)
- **FK**: Foreign Key (Llave Foránea)
- **catalogs**: Esquema para datos estáticos.
- **core**: Esquema para datos principales del negocio.
