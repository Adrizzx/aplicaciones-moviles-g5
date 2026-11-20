# API REST – Sistema de Incidencias Universitarias

Este proyecto utiliza **JSON Server** para simular una API REST y almacenar la información en `db.json`.

## Iniciar la API

Desde la terminal, ubicarse en la carpeta donde se encuentra `db.json` y ejecutar:

```bash
npx json-server db.json --port 3000
```

La API estará disponible en:

`http://localhost:3000`

**Endpoints:**
- `http://localhost:3000/usuarios`
- `http://localhost:3000/incidencias`
- `http://localhost:3000/areas`

**Nota:** Mantener la terminal de JSON Server abierta mientras se ejecuta la aplicación Flutter. Para detener el servidor, presionar `Ctrl + C`.