# Nivel 1: Fundamentos del scripting en Bash

## Objetivo
Aprender a crear y ejecutar scripts, usar variables, condicionales, loops y parámetros.

## Escenario
Tu empresa necesita un script para verificar la salud de un servicio en Linux (por ejemplo, Nginx o Apache).

## Laboratorio
Crea un script `check_service.sh` que:

- Reciba el nombre del servicio como parámetro (ej: `./check_service.sh nginx`).
- Verifique si el servicio está activo usando `systemctl is-active`.
- Si no está activo, muestre un mensaje de alerta.
- Guarde el resultado (activo/inactivo) en `service_status.log` con timestamp.
- **Bonus**: Envía una notificación por correo usando `mail` (requiere s-nail configurado).

## Configuración del Correo

Para el bonus, instala s-nail y configura `~/.mailrc` como se describe en el README general.

## Cómo Probar

1. Asegúrate de tener un servicio instalado (ej: `sudo apt install nginx`).
2. Ejecuta `./check_service.sh nginx`.
3. Verifica la salida en consola y `service_status.log`.
4. Si el servicio está inactivo, verifica el correo enviado (configura s-nail primero).

## Ejemplo de Salida

```bash
./check_service.sh nginx
Revisión completada. Estado guardado en service_status.log.
```

En `service_status.log`:

```bash
[2025-11-17 12:00:00] INFO: El servicio nginx está activo.
```

