while :; do (for file in /channel/channel3/*.*; do ffmpeg -re -i "$file" -vcodec libx264 -vprofile baseline -g 30 -acodec aac -strict -2 -f flv rtmp://back/iptv/channel3; done); done