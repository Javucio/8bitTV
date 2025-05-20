#!/bin/bash

# Validar que las dependencias necesarias estén disponibles
validate_dependencies() {
  # Verificar que FFmpeg esté instalado
  if ! command -v ffmpeg &> /dev/null; then
    echo "Error: FFmpeg no está instalado o no está en el PATH."
    exit 1
  fi

  # Verificar que el servidor Nginx RTMP esté accesible
  if ! curl -s "http://back:8070" &> /dev/null; then
    echo "Error: El servidor Nginx RTMP no está accesible en http://back:8070."
    exit 1
  fi

  echo "Todas las dependencias están disponibles."
}

# Función para procesar un canal
process_channel() {
  local channel=$1
  local stream_url=$2
  local log_file="/channel/$channel/error.log"

  echo "Iniciando transmisión para $channel hacia $stream_url"

  # Limpiar archivo de log previo
  > "$log_file"

  while :; do
    for file in /channel/$channel/*.*; do
      if [[ -f "$file" ]]; then
        echo "Procesando archivo $file para $channel"
        ffmpeg -re -i "$file" \
          -vcodec libx264 \
          -vprofile baseline \
          -g 30 \
          -acodec aac \
          -strict -2 \
          -f flv "$stream_url"

        # Verificar si FFmpeg tuvo éxito
        if [[ $? -eq 0 ]]; then
          echo "Archivo procesado correctamente: $file"
        else
          echo "Error al procesar $file para $channel" | tee -a "$log_file"
        fi
      else
        echo "Saltando: $file no es un archivo válido."
      fi
    done
  done
}

# Validar dependencias antes de iniciar
validate_dependencies

# Lista de canales y sus URLs de transmisión
declare -A channels=(
  ["channel1"]="rtmp://back/iptv/stream1"
)

# Iniciar transmisión para cada canal en segundo plano
for channel in "${!channels[@]}"; do
  if [[ -d "/channel/$channel" ]]; then
    process_channel "$channel" "${channels[$channel]}" &
  else
    echo "Advertencia: La carpeta /channel/$channel no existe. Saltando..."
  fi
done

# Esperar a que todos los procesos en segundo plano terminen
wait