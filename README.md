**8bitTV** es una plataforma para emitir archivos de video en formato canal 24h utilizando **FFmpeg**, **Nginx RTMP**, y **WordPress** como interfaz de usuario. El proyecto está diseñado para ejecutarse en un entorno Docker, utilizando `docker-compose` para gestionar los servicios.

## Características

- **Transmisión de video en vivo**: Convierte archivos de video en transmisiones RTMP y HLS.
- **Codificación con FFmpeg**: Procesa y transmite archivos de video desde carpetas específicas.
- **Interfaz de usuario con WordPress**: Utiliza WordPress como front-end para emitir contenido.
- **Configuración basada en Docker**: Simplifica la implementación y gestión del entorno.

---

## Requisitos

- **Docker** y **Docker Compose** instalados en tu sistema.
- Carpeta `channel` con subcarpetas (`channel1`, `channel2`, etc.) que contengan los archivos de video a transmitir.

---

## Instalación

1. **Clona el repositorio**:
   ```bash
   git clone https://github.com/tu-usuario/8bitTV.git
   cd 8bitTV
   ```

2. **Configura las variables de entorno**:
   Crea un archivo `.env` en el directorio raíz con el siguiente contenido:
   ```env
   MYSQL_ROOT_PASSWORD=somewordpress
   MYSQL_DATABASE=wordpress
   MYSQL_USER=wordpress
   MYSQL_PASSWORD=wordpress
   WORDPRESS_PORT=80
   NGINX_PORT=8070
   ```

3. **Inicia los servicios**:
   Ejecuta el siguiente comando para iniciar los contenedores:
   ```bash
   docker-compose up -d
   ```

4. **Accede a la interfaz de WordPress**:
   Abre tu navegador y ve a `http://localhost` para configurar WordPress.

---

## Estructura del Proyecto

```plaintext
8bitTV/
├── conf/
│   ├── nginx.conf         # Configuración de Nginx RTMP
│   ├── channel.sh         # Script para procesar y transmitir videos
├── db/                    # Datos persistentes de MySQL
├── front/                 # Archivos de WordPress
├── channel/               # Carpeta para los archivos de video
│   ├── channel1/          # Subcarpeta para el canal 1
│   ├── channel2/          # Subcarpeta para el canal 2
├── docker-compose.yml     # Configuración de Docker Compose
└── README.md              # Documentación del proyecto
```

---

## Configuración de Nginx RTMP

El archivo `conf/nginx.conf` define la configuración del servidor RTMP. Asegúrate de que el bloque `application show` esté configurado correctamente para habilitar la transmisión en vivo.

```nginx
rtmp {
    server {
        listen 1935;
        chunk_size 4096;

        application show {
            live on;
            record off;
        }
    }
}
```

---

## Uso

1. **Coloca los archivos de video**:
   - Coloca los archivos de video en las subcarpetas dentro de `channel/` (por ejemplo, `channel/channel1`).

2. **Inicia la transmisión**:
   - El script `channel.sh` se ejecuta automáticamente al iniciar el contenedor `channel` y procesa los archivos de video para transmitirlos a través de RTMP.

3. **Accede a las transmisiones**:
   - Las transmisiones estarán disponibles en las siguientes URLs:
     - `rtmp://localhost/show/stream1` (para `channel1`)
     - `rtmp://localhost/show/stream2` (para `channel2`)
     - Y así sucesivamente.

---

## Solución de Problemas

### Error: `Failed to resolve hostname nginx`
- Asegúrate de que el servicio de Nginx esté definido como `back` en `docker-compose.yml`.
- Verifica que los contenedores estén en la misma red.

### Error: `Input/output error`
- Verifica los permisos de la carpeta `channel` y asegúrate de que Docker tenga acceso a ella.
- Revisa los logs del contenedor de Nginx:
  ```bash
  docker logs <nginx_container_name>
  ```

---

## Créditos

- **Nginx RTMP**: [tiangolo/nginx-rtmp](https://hub.docker.com/r/tiangolo/nginx-rtmp)
- **FFmpeg**: [jrottenberg/ffmpeg](https://hub.docker.com/r/jrottenberg/ffmpeg)
- **WordPress**: [wordpress](https://hub.docker.com/_/wordpress)

---

## Licencia

Este proyecto está bajo la licencia MIT. Consulta el archivo `LICENSE` para más detalles.
```