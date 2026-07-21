@echo off
set LOG_DIR="C:\xampp\tomcat\logs"

echo Depurando archivos temporales de logs mayores a 30 dias...
forfiles /p %LOG_DIR% /s /m *.log /d -30 /c "cmd /c del @path" 2>nul
forfiles /p %LOG_DIR% /s /m *.txt /d -30 /c "cmd /c del @path" 2>nul
echo [OK] Limpieza preventiva del entorno de despliegue finalizada.
pause