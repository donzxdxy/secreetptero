#!/bin/bash

clear
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "    PROTECT PANEL BY DONZY"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo " [1] Install Semua Proteksi"
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
echo "🚀 Install Proteksi Panel..."

echo "📦 Backup file lama..."

# Anti Intip
cp $PT_PATH/app/Http/Controllers/Api/Client/Servers/FileController.php \
$PT_PATH/app/Http/Controllers/Api/Client/Servers/FileController.php.bak

cp $PT_PATH/app/Http/Controllers/Api/Client/Servers/ServerController.php \
$PT_PATH/app/Http/Controllers/Api/Client/Servers/ServerController.php.bak

# Anti Delete Server
cp $PT_PATH/app/Services/Servers/ServerDeletionService.php \
$PT_PATH/app/Services/Servers/ServerDeletionService.php.bak

# Anti Delete User
cp $PT_PATH/app/Http/Controllers/Admin/UserController.php \
$PT_PATH/app/Http/Controllers/Admin/UserController.php.bak


echo "⬇️ Mengunduh file proteksi..."

# Anti Intip
curl -s https://raw.githubusercontent.com/donzxdxy/protect-panel/main/ServerAntiIntip/FileController.php \
-o $PT_PATH/app/Http/Controllers/Api/Client/Servers/FileController.php

curl -s https://raw.githubusercontent.com/donzxdxy/protect-panel/main/ServerAntiIntip/ServerController.php \
-o $PT_PATH/app/Http/Controllers/Api/Client/Servers/ServerController.php

# Anti Delete Server
curl -s https://raw.githubusercontent.com/donzxdxy/protect-panel/main/AntiDeleteServer/ServerDeletionService.php \
-o $PT_PATH/app/Services/Servers/ServerDeletionService.php

# Anti Delete User
curl -s https://raw.githubusercontent.com/donzxdxy/protect-panel/main/AntiDeleteUser/UserController.php \
-o $PT_PATH/app/Http/Controllers/Admin/UserController.php


echo "♻️ Optimize & Restart..."
cd $PT_PATH || exit
php artisan optimize:clear >/dev/null 2>&1
php artisan optimize >/dev/null 2>&1
systemctl restart pteroq.service

echo ""
echo "✅ SEMUA PROTEKSI AKTIF"
echo "🔒 User tidak bisa intip server lain"
echo "⛔ User tidak bisa hapus server"
echo "⛔ User tidak bisa hapus user"
echo "👑 Admin ID 1 bebas akses semua"
echo ""
;;
0)
echo "Keluar dari script"
exit 0
;;
*)
echo "❌ Pilihan tidak valid"
exit 1
;;
esac
