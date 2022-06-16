# produderm

## Arquitectura de desarrollo
aplication
  - base
  - repository
core
  - entities
infraestructure
  - local
    - mappers
  - remote
    - api
    - mappers    
src
  - bloc_aplication
    - blocs
  - models
  - pages
    - login
     - bloc     
  - router
  - utils

### Aplication
Se encuentra definida la estructura de los archivos que se comunicaran con web service a través de clases abtractas
### Core
Se encuentra los modelos que se utilizaran en la aplicación móvil
### Infraestructura
Se encuentra la implementación de las clases abstractas declaradas en la capa de aplicación.
### Src
Se encuentra las rutas de vistas, widget reutilizables, lógica de negocio y vista de la aplicación móvil

