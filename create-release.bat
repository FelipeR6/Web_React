@echo off
echo Creando release.zip para despliegue en Azure...
echo.

:: Cambiar al directorio web si no estamos ahí
cd /d "%~dp0"

echo Instalando dependencias...
npm install
if %errorlevel% neq 0 (
    echo Error al instalar dependencias
    pause
    exit /b 1
)

echo.
echo Construyendo el proyecto...
npm run build
if %errorlevel% neq 0 (
    echo Error al construir el proyecto
    pause
    exit /b 1
)

echo.
echo Creando archivo release.zip...
if exist "release.zip" del "release.zip"
powershell "Compress-Archive -Path .\* -DestinationPath .\release.zip -Force"

if %errorlevel% equ 0 (
    echo.
    echo ✅ release.zip creado correctamente
    echo Tamaño del archivo:
    dir release.zip
    echo.
    echo El archivo está listo para despliegue en Azure
    echo Ubicación: %cd%\release.zip
) else (
    echo.
    echo ❌ Error al crear release.zip
)

echo.
pause