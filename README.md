# produderm

## Arquitectura de desarrollo
aplication
  - base
  - repository
core
  - catalog
  - entities
infraestructure
  - local
    - mappers
  - remote
    - api
    - mappers
    - model
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
Se encuentra definida la estructura de los archivos que se comunicaran con web service a traves de clases abtractas
### Core
Se encuenra los modelos que se utilizaran en la aplicacion movil
### Infraestructura
Se encuentra la implementacion de las clases abtactas declaradas en la capa de aplicacion.
### Src
Se encuentra las rutas de vistas, logica de negocio y vista de la aplicacion movil
