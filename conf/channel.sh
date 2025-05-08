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
        -f flv "$stream_url"
    done
  done
}

# Lista de canales y sus URLs de transmisión
declare -A channels=(
  ["channel1"]="rtmp://nginx/show/stream1"
  ["channel2"]="rtmp://nginx/show/stream2"
  ["channel3"]="rtmp://nginx/show/stream3"
  ["channel4"]="rtmp://nginx/show/stream4"
  ["channel5"]="rtmp://nginx/show/stream5"
  ["channel6"]="rtmp://nginx/show/stream6"
  ["channel7"]="rtmp://nginx/show/stream7"
  ["channel8"]="rtmp://nginx/show/stream8"
  ["channel9"]="rtmp://nginx/show/stream9"
  ["channel10"]="rtmp://nginx/show/stream10"
  ["channel11"]="rtmp://nginx/show/stream11"
  ["channel12"]="rtmp://nginx/show/stream12"
  ["channel13"]="rtmp://nginx/show/stream13"
  ["channel14"]="rtmp://nginx/show/stream14"
  ["channel15"]="rtmp://nginx/show/stream15"
  ["channel16"]="rtmp://nginx/show/stream16"
  ["channel17"]="rtmp://nginx/show/stream17"
  ["channel18"]="rtmp://nginx/show/stream18"
  ["channel19"]="rtmp://nginx/show/stream19"
  ["channel20"]="rtmp://nginx/show/stream20"
  ["channel21"]="rtmp://nginx/show/stream21"
)

# Iniciar transmisión para cada canal en segundo plano
for channel in "${!channels[@]}"; do
  process_channel "$channel" "${channels[$channel]}" &
done

# Esperar a que todos los procesos en segundo plano terminen
wait