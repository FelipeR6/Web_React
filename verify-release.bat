@echo off
echo Verificando contenido de release.zip...
echo.

if not exist "release.zip" (
    echo Error: release.zip no encontrado
    echo Ejecuta create-release.bat primero
    pause
    exit /b 1
)

echo Creando directorio temporal para verificación...
if exist "temp_verify" rmdir /s /q "temp_verify"
mkdir "temp_verify"

echo Extrayendo release.zip...
powershell "Expand-Archive -Path .\release.zip -DestinationPath .\temp_verify -Force"

echo.
echo Contenido de release.zip:
dir "temp_verify" /b

echo.
echo Verificando archivos críticos:
if exist "temp_verify\package.json" (
    echo ✅ package.json encontrado
) else (
    echo ❌ package.json NO encontrado
)

if exist "temp_verify\build" (
    echo ✅ Carpeta build encontrada
) else (
    echo ❌ Carpeta build NO encontrada
)

if exist "temp_verify\public" (
    echo ✅ Carpeta public encontrada
) else (
    echo ❌ Carpeta public NO encontrada
)

echo.
echo Limpiando archivos temporales...
rmdir /s /q "temp_verify"

echo.
echo Verificación completada
pause