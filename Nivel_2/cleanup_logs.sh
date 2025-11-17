#!/bin/bash

LOG_DIR="/var/log"
BACKUP_DIR="/backup/logs"
LOG_FILE="cleanup_actions.log"
DAYS_OLD=7
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

echo "[$TIMESTAMP] --- INICIO de la Limpieza de Logs ---" >> "$LOG_FILE"

# Crear la carpeta de backup si no existe
mkdir -p "$BACKUP_DIR"

# 1. Busca archivos en /var/log con más de N días y los almacena en una variable
FILES_TO_COMPRESS=$(find "$LOG_DIR" -type f -mtime +"$DAYS_OLD" -name "*.log" 2>/dev/null)

if [ -z "$FILES_TO_COMPRESS" ]; then
    ACTION_MESSAGE="No se encontraron archivos de log con más de $DAYS_OLD días."
    echo "[$TIMESTAMP] $ACTION_MESSAGE" >> "$LOG_FILE"
    echo "$ACTION_MESSAGE"
    exit 0
fi

# Definir el nombre del archivo de backup
BACKUP_ARCHIVE="$BACKUP_DIR/logs_$(date +%Y%m%d_%H%M%S).tar.gz"

# 2. Comprimir (tar.gz) y mover a /backup/logs/
echo "Comprimiendo logs antiguos a $BACKUP_ARCHIVE..."
tar -czf "$BACKUP_ARCHIVE" $FILES_TO_COMPRESS

# Verificar si la compresión fue exitosa
if [ $? -eq 0 ]; then
    echo "Compresión exitosa. Eliminando archivos originales..."
    
    # 3. Eliminar los archivos originales
    for file in $FILES_TO_COMPRESS; do
        rm "$file"
        echo "[$TIMESTAMP] ELIMINADO: $file (Comprimido a $BACKUP_ARCHIVE)" >> "$LOG_FILE"
    done
    
    ACTION_MESSAGE="Limpieza exitosa. Archivos antiguos eliminados y movidos a $BACKUP_ARCHIVE."
else
    ACTION_MESSAGE="[ERROR] Falló la compresión. No se eliminaron archivos."
fi

# 4. Generar log con las acciones realizadas
echo "[$TIMESTAMP] $ACTION_MESSAGE" >> "$LOG_FILE"
echo "[$TIMESTAMP] --- FIN de la Limpieza de Logs ---" >> "$LOG_FILE"
echo "$ACTION_MESSAGE"
