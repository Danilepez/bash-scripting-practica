# Nivel 4: Monitoreo y Alertas

## Objetivo
Aprender a recopilar métricas y generar alertas con Bash.

## Escenario
Quieres monitorear el uso de CPU, RAM y espacio en disco, y enviar alertas si se superan ciertos límites.

## Laboratorio
Crea un script `monitor_system.sh` que:

- Mida: Porcentaje de CPU (top o mpstat), Uso de RAM (free -m), Uso de disco (df -h).
- Si alguno supera los límites definidos (80%), guarda una alerta en `alerts.log`.
- Envía una alerta por correo o webhook.
- **Bonus**: Agrega colores a la salida del terminal (verde = OK, rojo = alerta).
- **Bonus**: Guarda un histórico diario de métricas (`metrics_YYYYMMDD.log`).

## Configuración

Configura umbrales en el script (CPU_THRESHOLD, RAM_THRESHOLD, DISK_THRESHOLD). Para alertas por mail, configura s-nail como en el README general.

## Cómo Probar

1. Ejecuta `./monitor_system.sh`.
2. Observa la salida coloreada en terminal.
3. Verifica `alerts.log` si hay alertas.
4. Revisa `metrics_20251117.log` para el histórico.
5. Para simular alto uso, ejecuta procesos intensivos y corre el script.

## Ejemplo de Salida

```bash
CPU: 45%
RAM: 60%
DISK: 75%
Sistema bajo control. No se detectaron alertas.
```

Si hay alerta:

```bash
ALERTA: Se superaron uno o más umbrales. Ver alerts.log
```