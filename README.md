# Práctica de Bash Scripting

Esta práctica está dividida en 4 niveles de dificultad creciente para aprender scripting en Bash, enfocándose en automatización de tareas de DevOps.

## Niveles

### Nivel 1: Fundamentos del scripting en Bash
- **Objetivo**: Aprender a crear y ejecutar scripts, usar variables, condicionales, loops y parámetros.
- **Escenario**: Verificar la salud de un servicio en Linux (ejemplo: Nginx o Apache).
- **Script**: `check_service.sh`
- **Cómo probar**: `./check_service.sh nginx` (requiere systemctl y s-nail configurado para mail).

### Nivel 2: Automatización de tareas de mantenimiento
- **Objetivo**: Manipular archivos, redirigir salidas y usar tareas programadas.
- **Escenario**: Limpiar logs antiguos para liberar espacio en disco.
- **Script**: `cleanup_logs.sh`
- **Cómo probar**: Ejecutar `generate_fake_logs.sh` primero para crear logs de prueba, luego `./cleanup_logs.sh` (requiere permisos de root para /var/log).

### Nivel 3: Despliegue automatizado (mini-CI/CD)
- **Objetivo**: Integración continua y automatización de despliegues simples.
- **Escenario**: Desplegar código desde GitHub al actualizar el repositorio.
- **Script**: `deploy_app.sh`
- **Cómo probar**: `./deploy_app.sh` (requiere git, sudo para systemctl, y curl para Discord webhook).

### Nivel 4: Monitoreo y Alertas
- **Objetivo**: Recopilar métricas y generar alertas.
- **Escenario**: Monitorear CPU, RAM y disco, alertar si supera límites.
- **Script**: `monitor_system.sh`
- **Cómo probar**: `./monitor_system.sh` (requiere top, free, df; opcional mail o webhook).

## Requisitos Técnicos
- **SO**: Ubuntu, Linux o macOS.
- **Herramientas**: bash, cron, git, curl, mailutils (s-nail).
- **Editor**: vim, nano, neovim o VS Code.

## Configuración del Correo
Para envío de correos, instala s-nail y configura `~/.mailrc`:

```
# --- Configuración Moderna de s-nail (v15+) ---
set v15-compat
set from="tu-email@gmail.com"
set mta=smtps://tu-email%40gmail.com:TU_CONTRASEÑA_DE_APLICACIÓN@smtp.gmail.com:465
set mta-auth=login
```

Reemplaza con tu email y contraseña de aplicación de Gmail.

## Cómo Probar Cada Nivel
1. **Nivel 1**: Asegúrate de tener un servicio como nginx instalado. Ejecuta `./check_service.sh nginx`. Verifica `service_status.log` y si está inactivo, revisa el mail.
2. **Nivel 2**: Ejecuta `sudo ./generate_fake_logs.sh` para crear logs falsos en /var/log. Luego `sudo ./cleanup_logs.sh`. Verifica /backup/logs y cleanup_actions.log.
3. **Nivel 3**: Ejecuta `./deploy_app.sh`. Verifica deploy.log y notificación en Discord (configura WEBHOOK_URL).
4. **Nivel 4**: Ejecuta `./monitor_system.sh`. Verifica alerts.log y metrics_YYYYMMDD.log. Para alertas, simula alto uso si es necesario.

Nota: Los scripts están diseñados para Linux. Si editas en Windows, push al repo y ejecuta en una VM Linux.</content>
<parameter name="filePath">d:\UPB\6to Semestre\Certificacion DevOps\bash-scripting-practica\README.md