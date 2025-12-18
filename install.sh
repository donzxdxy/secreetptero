#!/bin/bash

clear
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "    PROTECT PANEL BY DONZY"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo " [1] Server Anti Intip (Owner Only)"
echo " [0] Exit"
echo ""
read -p " Pilih menu : " menu

PT_PATH="/var/www/pterodactyl"

if [ ! -d "$PT_PATH" ]; then
  echo "❌ Pterodactyl tidak ditemukan di $PT_PATH"
  exit 1
fi

case $menu in
1)
  echo ""
  echo " Menginstall Server Anti Intip..."

  echo " Backup file lama..."
  cp $PT_PATH/app/Http/Controllers/Api/Client/Servers/FileController.php \
     $PT_PATH/app/Http/Controllers/Api/Client/Servers/FileController.php.bak

  cp $PT_PATH/app/Http/Controllers/Api/Client/Servers/ServerController.php \
     $PT_PATH/app/Http/Controllers/Api/Client/Servers/ServerController.php.bak

  echo " Mengganti file controller..."

  curl -s https://raw.githubusercontent.com/donzxdxy/secreetptero/main/ServerAntiIntip/FileController.php \
    -o $PT_PATH/app/Http/Controllers/Api/Client/Servers/FileController.php

  curl -s https://raw.githubusercontent.com/donzxdxy/secreetptero/main/ServerAntiIntip/ServerController.php \
    -o $PT_PATH/app/Http/Controllers/Api/Client/Servers/ServerController.php

  echo "♻️ Restart service..."
  php artisan optimize:clear >/dev/null 2>&1
  php artisan optimize >/dev/null 2>&1
  systemctl restart pteroq.service

  echo ""
  echo "✅ SERVER ANTI INTIP AKTIF"
  echo "🔒 User hanya bisa akses server sendiri"
  echo "👑 Admin ID 1 bebas akses semua"
  echo ""
  ;;
0)
  echo "Keluar Dari Script"
  exit 0
  ;;
*)
  echo "❌ Pilihan tidak valid"
  exit 1
  ;;
esac


