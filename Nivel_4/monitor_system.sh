#!/bin/bash

# Nombre del archivo: monitor_system.sh
# Ubicación: Nivel_4/

# Umbrales de Alerta
CPU_THRESHOLD=80
RAM_THRESHOLD=80
DISK_THRESHOLD=80

# Archivos de Log
ALERTS_LOG="alerts.log"
DATE_YMD=$(date +%Y%m%d)
METRICS_LOG="metrics_${DATE_YMD}.log"
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

ALERT_TRIGGERED=0
ALERT_MESSAGE=""

# Definición de Colores para el terminal (Bonus)
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo "[$TIMESTAMP] --- Inicio del Monitoreo ---" >> "$METRICS_LOG"

# 1. Medir Porcentaje de CPU
# Uso 'top' y 'awk' para obtener la carga de CPU (ajusta según tu OS)
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | sed 's/,/./g' | cut -d . -f 1)
echo "[$TIMESTAMP] CPU: $CPU_USAGE%" >> "$METRICS_LOG"
if [ "$CPU_USAGE" -ge "$CPU_THRESHOLD" ]; then
    ALERT_TRIGGERED=1
    ALERT_MESSAGE+="- ALERTA: Uso de CPU ($CPU_USAGE%) supera el umbral ($CPU_THRESHOLD%).\n"
    OUTPUT_COLOR=$RED
else
    OUTPUT_COLOR=$GREEN
fi
echo -e "${OUTPUT_COLOR}CPU: ${CPU_USAGE}%${NC}"

# 2. Medir Uso de RAM
# Uso 'free -m' para obtener el porcentaje de uso
TOTAL_RAM=$(free -m | grep Mem | awk '{print $2}')
USED_RAM=$(free -m | grep Mem | awk '{print $3}')
RAM_USAGE=$((USED_RAM * 100 / TOTAL_RAM))
echo "[$TIMESTAMP] RAM: $RAM_USAGE%" >> "$METRICS_LOG"
if [ "$RAM_USAGE" -ge "$RAM_THRESHOLD" ]; then
    ALERT_TRIGGERED=1
    ALERT_MESSAGE+="- ALERTA: Uso de RAM ($RAM_USAGE%) supera el umbral ($RAM_THRESHOLD%).\n"
    OUTPUT_COLOR=$RED
else
    OUTPUT_COLOR=$GREEN
fi
echo -e "${OUTPUT_COLOR}RAM: ${RAM_USAGE}%${NC}"

# 3. Medir Uso de Disco (Root "/")
# Uso 'df -h' y 'awk' para obtener el porcentaje de uso del directorio raíz
DISK_USAGE=$(df -h / | grep / | awk '{print $5}' | sed 's/%//g')
echo "[$TIMESTAMP] DISK: $DISK_USAGE%" >> "$METRICS_LOG"
if [ "$DISK_USAGE" -ge "$DISK_THRESHOLD" ]; then
    ALERT_TRIGGERED=1
    ALERT_MESSAGE+="- ALERTA: Uso de Disco ($DISK_USAGE%) supera el umbral ($DISK_THRESHOLD%).\n"
    OUTPUT_COLOR=$RED
else
    OUTPUT_COLOR=$GREEN
fi
echo -e "${OUTPUT_COLOR}DISK: ${DISK_USAGE}%${NC}"

echo "[$TIMESTAMP] --- Fin del Monitoreo ---" >> "$METRICS_LOG"

# Generar y enviar alerta
if [ "$ALERT_TRIGGERED" -eq 1 ]; then
    # 4. Guarda una alerta en alerts.log
    echo "[$TIMESTAMP] ALERTA DE SISTEMA:" >> "$ALERTS_LOG"
    echo -e "$ALERT_MESSAGE" >> "$ALERTS_LOG"
    echo "ALERTA: Se superaron uno o más umbrales. Ver $ALERTS_LOG"

    # Envío de Correo o Webhook
    # mail -s "ALERTA CRITICA DE SISTEMA" tu-correo@ejemplo.com <<< "El sistema ha superado los siguientes umbrales:\n\n$ALERT_MESSAGE"
else
    echo -e "${GREEN}Sistema bajo control. No se detectaron alertas.${NC}"
fi
