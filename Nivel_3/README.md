# Nivel 3: Despliegue automatizado (mini-CI/CD)

## Objetivo
Practicar la integración continua y automatización de despliegues simples con Bash.

## Escenario
Cada vez que un desarrollador actualiza el repositorio de Git, se debe desplegar el nuevo código en un servidor web.

## Laboratorio
Crea un script `deploy_app.sh` que:

- Clone o actualice el repositorio desde GitHub ([https://github.com/rayner-villalba-coderoad-com/clash-of-clan](https://github.com/rayner-villalba-coderoad-com/clash-of-clan)).
- Reinicie el servicio (por ejemplo, systemctl restart nginx o pm2 restart app).
- Guarde el resultado del despliegue en un archivo `deploy.log`.
- **Bonus**: Envía una notificación al Slack o Discord usando un webhook.
- **Bonus**: Agrega control de errores (por ejemplo, si falla git pull, abortar el despliegue).

## Configuración de Webhook

Para el bonus de Discord, configura `WEBHOOK_URL` en el script con tu webhook de Discord.

## Cómo Probar

1. Asegúrate de tener git instalado y acceso al repo.
2. Ejecuta `./deploy_app.sh`.
3. Verifica `deploy.log` para el resultado.
4. Si hay cambios, el servicio se reinicia y se envía notificación a Discord.
5. Para simular cambios, modifica el repo y ejecuta de nuevo.

## Ejemplo de Salida

```bash
Actualizando repositorio...
Código actualizado correctamente.
Reiniciando servicio nginx...
Despliegue exitoso.
```

En `deploy.log`:

```bash
[2025-11-17 12:00:00] --- INICIO del Despliegue ---
[2025-11-17 12:00:00] Actualizando repositorio...
[2025-11-17 12:00:00] Código actualizado correctamente.
[2025-11-17 12:00:00] Reiniciando servicio nginx...
[2025-11-17 12:00:00] [OK] Despliegue completado. Servicio nginx reiniciado exitosamente.
[2025-11-17 12:00:00] --- FIN del Despliegue ---
```