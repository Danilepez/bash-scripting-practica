# Nivel 2: Automatización de tareas de mantenimiento

## Objetivo
Aprender a manipular archivos, redirigir salidas y usar tareas programadas.

## Escenario
Necesitas limpiar los logs antiguos del sistema para liberar espacio en disco.

## Laboratorio
Crea un script `cleanup_logs.sh` que:

- Busque en `/var/log` todos los archivos con más de 7 días.
- Los comprima (tar.gz) y mueva a una carpeta `/backup/logs/`.
- Elimine los archivos originales luego de confirmar la compresión.
- Genere un log con las acciones realizadas.
- **Bonus**: Configura este script en cron para que se ejecute cada noche a las 2 AM.

## Entorno de Prueba
Para simular el escenario, primero se pueden crear archivos de log falsos con distintas fechas.

### Creación de archivos de logs falsos (Ejecutar como root)
Estos comandos crean archivos en `/var/log` y modifican sus fechas para simular antigüedad.

```bash
# Ejecuta esto como root o con sudo
# 1. Crear archivos
cd /var/log
touch app.log error.log access.log nginx.log system.log old_app.log old_error.log

# 2. Modificar fechas (10 días de antigüedad)
touch -d "10 days ago" old_app.log old_error.log

# 3. Modificar fechas (2 días de antigüedad)
touch -d "2 days ago" app.log error.log access.log

# (nginx.log y system.log quedan con la fecha de hoy)
cd -
```

O usa el script `generate_fake_logs.sh` incluido.

## Cómo Probar
1. Ejecuta `sudo ./generate_fake_logs.sh` para crear logs de prueba.
2. Ejecuta `sudo ./cleanup_logs.sh`.
3. Verifica que los archivos antiguos se comprimieron en `/backup/logs/` y se eliminaron de `/var/log`.
4. Revisa `cleanup_actions.log` para las acciones realizadas.
5. Para cron: `crontab -e` y agrega `0 2 * * * /ruta/a/cleanup_logs.sh`.

## Ejemplo de Salida

```bash
Comprimiendo logs antiguos a /backup/logs/logs_20251117_120000.tar.gz...
Compresión exitosa. Eliminando archivos originales...
Limpieza exitosa. Archivos antiguos eliminados y movidos a /backup/logs/logs_20251117_120000.tar.gz.
```

</content>
<parameter name="filePath">d:\UPB\6to Semestre\Certificacion DevOps\bash-scripting-practica\Nivel_2\README.md