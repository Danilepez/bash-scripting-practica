#!/bin/bash

LOG_FILE="service_status.log"
ADMIN_EMAIL="danilepez5@gmail.com"
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

if [ -z "$1" ]; then
    echo "Error: Debes especificar el nombre del servicio."
    echo "Ejemplo de uso: $0 nginx"
    exit 1
fi

SERVICE_NAME="$1"

if systemctl is-active --quiet "$SERVICE_NAME"; then
    STATUS="activo"
    MENSAJE_LOG="[$TIMESTAMP] INFO: El servicio $SERVICE_NAME está $STATUS."

else
    STATUS="inactivo"
    MENSAJE_LOG="[$TIMESTAMP] ALERTA: El servicio $SERVICE_NAME está $STATUS."
    
    echo "$MENSAJE_LOG"

    SUBJECT="ALERTA: El servicio $SERVICE_NAME está INACTIVO"
    BODY="El servicio $SERVICE_NAME se reportó como $STATUS a las $TIMESTAMP."
    
    echo "$BODY" | mail -s "$SUBJECT" "$ADMIN_EMAIL"

fi

echo "$MENSAJE_LOG" >> "$LOG_FILE"

echo "Revisión completada. Estado guardado en $LOG_FILE."

