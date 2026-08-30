@echo off
chcp 65001 >nul
title Save LNT - Local Web Server
echo ============================================
echo   ເປີດ Local Web Server ສຳລັບທົດລອງ
echo ============================================
echo.

REM ຊອກຫາ IP ຂອງເຄື່ອງ (ສຳລັບເປີດຜ່ານມືຖືໃນ WiFi ດຽວກັນ)
echo [ IP ຂອງເຄື່ອງນີ້ - ໃຊ້ເປີດຜ່ານມືຖື ]
ipconfig | findstr /i "IPv4"
echo.
echo ເປີດຢູ່ Port 8000
echo   - ໃນເຄື່ອງນີ້   : http://localhost:8000
echo   - ໃນມືຖື (WiFi ດຽວກັນ) : http://IP-ຂ້າງເທິງ:8000
echo.
echo ໝາຍເຫດ: ໂໝດນີ້ເປັນ http ທຳມະດາ - ປຸ່ມ GPS ຈະໃຊ້ບໍ່ໄດ້ໃນມືຖື
echo         (GPS ຕ້ອງການ HTTPS) ແຕ່ສາມາດ "ແຕະເລືອກຈຸດເທິງແຜນທີ່" ໄດ້ປົກກະຕິ.
echo         ຢາກໃຫ້ GPS ໃຊ້ໄດ້ໃນມືຖື = Deploy ຂຶ້ນ Vercel (HTTPS).
echo.
echo ກົດ Ctrl + C ເພື່ອຢຸດ server
echo ============================================
echo.

REM ລອງໃຊ້ Python ກ່ອນ, ບໍ່ມີກໍໃຊ້ Node
where python >nul 2>nul
if %errorlevel%==0 (
  python -m http.server 8000
  goto :eof
)
where python3 >nul 2>nul
if %errorlevel%==0 (
  python3 -m http.server 8000
  goto :eof
)
where npx >nul 2>nul
if %errorlevel%==0 (
  npx --yes http-server -p 8000
  goto :eof
)

echo [ຜິດພາດ] ບໍ່ພົບ Python ຫຼື Node.js ໃນເຄື່ອງ.
echo ກະລຸນາຕິດຕັ້ງ Python (https://python.org) ຫຼື Node.js (https://nodejs.org) ກ່ອນ.
pause
