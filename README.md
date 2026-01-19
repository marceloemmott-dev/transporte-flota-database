# Sistema de Transporte y Gestión de Flota

> **Arquitectura de Base de Datos SQL Server con Docker**

Este repositorio contiene el diseño, modelado e implementación de una base de datos relacional robusta para una empresa de transporte y logística. El proyecto simula un entorno empresarial real, enfocándose en la normalización, integridad de datos, seguridad y escalabilidad, utilizando las últimas tecnologías de **SQL Server 2022**.

Este proyecto sirve como **portafolio técnico** para demostrar competencias en **Arquitectura de Datos**, **SQL Avanzado** y **DevOps (Docker)**.

---

## 📖 Historia y Contexto del Proyecto

Este repositorio no es solo una base de datos estática; es la **bitácora viva de un análisis incremental**.

Estamos simulando el proceso real de digitalización de una **Empresa de Transporte** que está creciendo. El proyecto evoluciona paso a paso:

1.  **Fase 1: "El Inventario" (Estado Actual)**
    *   *Problema*: La empresa necesita saber qué vehículos tiene, dónde están y en qué estado.
    *   *Solución*: Se modeló el núcleo (`core`) con la entidad `Vehiculo`, apoyada por catálogos para evitar inconsistencias (estandarización de tipos, marcas y estados).

2.  **Fase 2: "El Factor Humano" (Próximamente)**
    *   *Desafío*: Asignar responsables. ¿Quién conduce qué?
    *   *Plan*: Incorporar conductores, licencias y asignaciones.

3.  **Fase 3: "Operaciones" (Futuro)**
    *   *Desafío*: Controlar el movimiento.
    *   *Plan*: Implementar hojas de ruta y tracking GPS.

Cada commit en este repositorio representa una decisión de diseño tomada tras analizar los requisitos del negocio.

---

## 🎯 Objetivo del Proyecto

El objetivo principal es diseñar una "Fuente de Verdad" confiable para las operaciones de una flota de vehículos. A diferencia de las bases de datos académicas simples, este proyecto aborda problemas reales:

- **Organización lógica**: Uso de *Schemas* para separar responsabilidades.
- **Integridad**: Claves foráneas, constraints y tipos de datos adecuados.
- **Estandarización**: Uso de tablas de catálogo para evitar redundancia y "números mágicos".
- **Infraestructura como Código**: Despliegue reproducible mediante Docker.

## 🛠️ Tecnologías

- **Base de Datos**: Microsoft SQL Server 2022 (Linux container image).
- **Infraestructura**: Docker & Docker Compose.
- **Lenguaje**: T-SQL (Transact-SQL).
- **Documentación**: Markdown & Mermaid Diagrams.

## 📂 Estructura del Repositorio

```bash
transporte-flota/
├── database/           # Scripts SQL (Source of Truth)
│   ├── 01_schemas.sql    # Definición de estructura lógica (Namespaces)
│   ├── 02_catalogos.sql  # Tablas de referencia (Enums en base de datos)
│   └── 03_vehiculo.sql   # Tablas transaccionales/Core
├── docs/               # Documentación técnica
│   ├── diagrama_er.md    # Diagramas Entidad-Relación
│   └── decisiones.md     # Registro de decisiones de arquitectura (ADR)
├── infra/              # Infraestructura y Despliegue
│   └── docker-compose.yml
├── .env.example        # Plantilla de variables de entorno
└── README.md           # Documentación principal
```

## 📐 Diseño y Arquitectura

Se ha optado por una arquitectura basada en **Schemas** para modularizar el sistema. Esto permite una gestión de permisos granular y mejora la legibilidad.

| Schema      | Descripción |
|bP           | :--- |
| **`core`**  | Contiene las entidades principales del negocio (Ej: `Vehiculo`, `Conductor`). |
| **`catalogs`** | Tablas de búsqueda o referencia estática (Ej: `TipoVehiculo`, `EstadoVehiculo`). Equivalente a Enums. |
| **`tracking`** | *(Futuro)* Historial de ubicaciones y telemetría. |
| **`security`** | *(Futuro)* Gestión de usuarios, roles y auditoría. |

### Entidad Principal: Vehículo

La tabla `Vehiculo` es el corazón del sistema actual. Soporta tanto transporte de pasajeros como de carga mediante un diseño flexible:

- **Normalización**: Tipos y Estados son claves foráneas a `catalogs`.
- **Validación**: Constraints para asegurar la integridad (ej. Patentes únicas).

## 🚀 Guía de Inicio Rápido (Quick Start)

Sigue estos pasos para levantar el entorno de desarrollo localmente.

### Prerrequisitos
- [Docker Desktop](https://www.docker.com/products/docker-desktop) instalado y corriendo.

### 1. Configuración de Entorno

Clona el repositorio y configura las variables de entorno. Por seguridad, **nunca** subimos contraseñas al repositorio.

```bash
# Clona el repo (si no lo has hecho)
git clone https://github.com/tu-usuario/transporte-flota.git
cd transporte-flota

# Crea el archivo de variables de entorno
cp .env.example .env
```
*Tip: Puedes editar el archivo `.env` para cambiar la contraseña de SA si lo deseas.*

### 2. Levantar la Base de Datos

Utilizamos Docker Compose para orquestar el contenedor de SQL Server.

```bash
docker-compose -f infra/docker-compose.yml up -d
```

Verifica que el contenedor esté corriendo:
```bash
docker ps
```

### 3. Ejecutar Scripts SQL

Conéctate a tu base de datos (usando **Azure Data Studio**, **SSMS** o **DBeaver**) con las credenciales de tu `.env`:
- **Server**: `localhost,1433`
- **User**: `sa`
- **Password**: *(La que definiste en .env)*

Ejecuta los scripts en el siguiente orden estricto para respetar las dependencias:

1.  `database/01_schemas.sql` (Crea la estructura base)
2.  `database/02_catalogos.sql` (Crea tablas sin dependencias)
3.  `database/03_vehiculo.sql` (Crea tablas que dependen de catálogos)

## ✅ Buenas Prácticas Aplicadas

En este repositorio podrás observar:

1.  **Idempotencia**: Todos los scripts SQL verifican la existencia de objetos (`IF NOT EXISTS`) antes de crear, permitiendo re-ejecuciones seguras.
2.  **Naming Conventions**: Uso consistente de *PascalCase* para tablas y columnas, y nombres descriptivos en inglés o español (consistente).
3.  **Seguridad**: No se exponen credenciales en el código (uso de `.env`).
4.  **Separation of Concerns**: Datos maestros separados de datos transaccionales.

## 🔮 Próximos Pasos (Roadmap)

- [ ] Implementar Schema `tracking` para viajes y coordenadas GPS.
- [ ] Agregar tabla `Mantenimiento` para gestión de reparaciones.
- [ ] Crear Seed Data scripts para poblar catálogos automáticamente.
- [ ] Implementar auditoría (campos `CreatedBy`, `UpdatedBy`).

---

Hecho con 💻 y SQL Server.
