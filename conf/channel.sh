#!/bin/bash

# Función para procesar un canal
process_channel() {
  local channel=$1
  local stream_url=$2

  echo "Iniciando transmisión para $channel hacia $stream_url"

  while :; do
    for file in /channel/$channel/*.*; do
      echo "Procesando archivo $file para $channel"
      ffmpeg -re -i "$file" \
        -vcodec libx264 \
        -vprofile baseline \
        -g 30 \
        -acodec aac \
        -strict -2 \
        -f flv "$stream_url" || echo "Error al procesar $file para $channel"
    done
  done
}

# Lista de canales y sus URLs de transmisión
declare -A channels=(
  ["channel1"]="rtmp://back/iptv/stream1"
)

# Iniciar transmisión para cada canal en segundo plano
for channel in "${!channels[@]}"; do
  process_channel "$channel" "${channels[$channel]}" &
done

# Esperar a que todos los procesos en segundo plano terminen
wait