#!/bin/bash

# Nombre del archivo: deploy_app.sh
# Ubicación: Nivel_3/

REPO_URL="https://github.com/rayner-villalba-coderoad-com/clash-of-clan"
APP_DIR="/var/www/clash-of-clan" # Directorio donde se desplegará
LOG_FILE="deploy.log"
SERVICE_NAME="nginx" # O el servicio que uses, como 'apache2' o 'pm2'
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

echo "[$TIMESTAMP] --- INICIO del Despliegue ---" >> "$LOG_FILE"

# Crear el directorio de despliegue si no existe
mkdir -p "$APP_DIR"

cd "$APP_DIR" || { echo "[$TIMESTAMP] [ERROR] No se pudo cambiar al directorio $APP_DIR. Abortando."; exit 1; }

# 1. Clonar o actualizar el repositorio
if [ -d ".git" ]; then
    # El repositorio ya existe, hacer 'git pull'
    echo "[$TIMESTAMP] Actualizando repositorio..." >> "$LOG_FILE"
    git pull origin main # Asume que la rama principal es 'main'
    PULL_STATUS=$?
else
    # El repositorio no existe, hacer 'git clone'
    echo "[$TIMESTAMP] Clonando repositorio..." >> "$LOG_FILE"
    git clone "$REPO_URL" .
    PULL_STATUS=$?
fi

# Control de errores (Bonus)
if [ $PULL_STATUS -ne 0 ]; then
    echo "[$TIMESTAMP] [ERROR] Falló la operación de Git (pull/clone). Abortando el despliegue." >> "$LOG_FILE"
    echo "Despliegue fallido."
    exit 1
fi

echo "[$TIMESTAMP] Código actualizado correctamente." >> "$LOG_FILE"

# 2. Reiniciar el servicio
echo "[$TIMESTAMP] Reiniciando servicio $SERVICE_NAME..." >> "$LOG_FILE"
sudo systemctl restart "$SERVICE_NAME"
SERVICE_STATUS=$?

# 3. Guardar el resultado del despliegue en deploy.log
if [ $SERVICE_STATUS -eq 0 ]; then
    echo "[$TIMESTAMP] [OK] Despliegue completado. Servicio $SERVICE_NAME reiniciado exitosamente." >> "$LOG_FILE"
    DEPLOY_MESSAGE="Despliegue exitoso."
else
    echo "[$TIMESTAMP] [ERROR] Falló el reinicio del servicio $SERVICE_NAME." >> "$LOG_FILE"
    DEPLOY_MESSAGE="Despliegue completado con errores."
fi

echo "[$TIMESTAMP] --- FIN del Despliegue ---" >> "$LOG_FILE"
echo "$DEPLOY_MESSAGE"

# BONUS: Envío de notificación (ejemplo con webhook de Discord/Slack - requiere 'curl')
# WEBHOOK_URL="TU_WEBHOOK_URL_AQUI"
# NOTIF_PAYLOAD='{"content": "Despliegue de Clash of Clan: '$DEPLOY_MESSAGE'"}'
# curl -H "Content-Type: application/json" -d "$NOTIF_PAYLOAD" "$WEBHOOK_URL"
