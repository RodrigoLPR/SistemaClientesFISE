@echo off
:: =============================================================================
:: SCRIPT DE MANTENIMIENTO ROBUSTO - RESPALDO BD CLIENTES FISE
:: =============================================================================

set MYSQL_BIN="C:\xampp\mysql\bin\mysqldump.exe"
set DB_NAME=bd_clientes_fise
set BACKUP_DIR=C:\Users\Rodrigo\Documents\NetBeansProjects\SistemaClientesFISE\backups

:: Crear la carpeta si no existe
if not exist "%BACKUP_DIR%" mkdir "%BACKUP_DIR%"

:: Obtener fecha universal (AAAA-MM-DD) mediante PowerShell
for /f %%a in ('powershell -Command "Get-Date -Format yyyy-MM-dd"') do set FECHA=%%a

set FILE_NAME=%DB_NAME%_backup_%FECHA%.sql

echo Generando copia de seguridad de %DB_NAME%...
%MYSQL_BIN% -u root --opt %DB_NAME% > "%BACKUP_DIR%\%FILE_NAME%"

if exist "%BACKUP_DIR%\%FILE_NAME%" (
    echo.
    echo [OK] Backup generado exitosamente en:
    echo %BACKUP_DIR%\%FILE_NAME%
) else (
    echo.
    echo [ERROR] No se pudo crear el archivo. Verifica que MySQL este activo en XAMPP.
)
echo.
pause