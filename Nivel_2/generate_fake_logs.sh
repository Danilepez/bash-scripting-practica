#!/bin/bash

# Script para crear logs falsos en /var/log para testing de cleanup_logs.sh
# Ejecutar como root: sudo ./generate_fake_logs.sh

LOG_DIR="/var/log"

echo "Creando archivos de log falsos en $LOG_DIR..."

# Crear archivos
touch "$LOG_DIR/app.log"
touch "$LOG_DIR/error.log"
touch "$LOG_DIR/access.log"
touch "$LOG_DIR/nginx.log"
touch "$LOG_DIR/system.log"
touch "$LOG_DIR/old_app.log"
touch "$LOG_DIR/old_error.log"

# Agregar contenido simulado
echo "INFO - Application started successfully" > "$LOG_DIR/app.log"
echo "ERROR - Database connection failed" > "$LOG_DIR/error.log"
echo "GET /index.html 200 OK" > "$LOG_DIR/access.log"
echo "nginx: worker process started" > "$LOG_DIR/nginx.log"
echo "System check OK" > "$LOG_DIR/system.log"
echo "Old app log entry" > "$LOG_DIR/old_app.log"
echo "Old error log entry" > "$LOG_DIR/old_error.log"

# Modificar fechas (10 días de antigüedad)
touch -d "10 days ago" "$LOG_DIR/old_app.log"
touch -d "10 days ago" "$LOG_DIR/old_error.log"

# Modificar fechas (2 días de antigüedad)
touch -d "2 days ago" "$LOG_DIR/app.log"
touch -d "2 days ago" "$LOG_DIR/error.log"
touch -d "2 days ago" "$LOG_DIR/access.log"

# nginx.log y system.log quedan con fecha de hoy

echo "Logs falsos creados. Verifica con 'ls -la $LOG_DIR/*.log'"