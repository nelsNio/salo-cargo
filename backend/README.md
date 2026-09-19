# Backend del MVP

API FastAPI para viajes, pagos/saldos, gastos, salarios, conductores y vehículos.

## Ejecución local

```bash
cd backend
python3 -m venv .venv
.venv/bin/pip install -r requirements.txt
.venv/bin/uvicorn app:app --reload
```

Documentación: `http://127.0.0.1:8000/docs`  
Salud: `http://127.0.0.1:8000/api/health`

## Configuración

Copiar `.env.example` a `.env` y definir al menos:

- `DATABASE_PATH`: ruta de la base. En cloud debe estar en un volumen persistente.
- `CORS_ORIGINS`: dominios exactos del frontend, separados por coma.
- `PORT`: lo define normalmente el proveedor cloud.

El frontend local usa automáticamente `http://127.0.0.1:8000`. En producción puede usar el mismo origen del sitio, `frontend-config.js` si frontend y backend están en dominios separados, o la URL temporal `?api=https://api.ejemplo.com`.

## Docker

```bash
docker build -t viajes-api ./backend
docker run --env-file backend/.env \
  -p 8000:8000 \
  -v viajes-data:/data \
  viajes-api
```

El volumen `viajes-data` es obligatorio con SQLite para no perder información cuando el contenedor se reinicie.

## Frontend

Servir `index.html` como sitio estático. Si el backend está en otro dominio, crear `frontend-config.js` a partir de `frontend-config.example.js` y cargarlo antes del script principal, o configurar `window.__API_BASE__` en el hosting.

## Checklist antes de producción

- Configurar HTTPS en frontend y backend.
- Definir `CORS_ORIGINS` sin `*`.
- Activar backups del volumen SQLite.
- Proteger el sitio con autenticación o un proxy seguro antes de compartirlo.
- Migrar a PostgreSQL cuando haya varios usuarios o escrituras simultáneas.
- Probar `/api/health`, creación de viaje, pago, gasto y reporte mensual.
