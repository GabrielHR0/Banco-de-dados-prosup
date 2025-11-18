@echo off
setlocal enabledelayedexpansion

REM Obter o diretório do script
set "SCRIPT_DIR=%~dp0"
set "SCRIPT_DIR=%SCRIPT_DIR:~0,-1%"
set "PROJECT_ROOT=%SCRIPT_DIR%\.."

REM Carregar configurações
call "%SCRIPT_DIR%\config\database_config_win.bat"

echo Executando seeds no banco: %DB_NAME%

REM Executar todos os arquivos de seed em ordem
for %%f in ("%SCRIPT_DIR%\seed_data\*.sql") do (
    echo Aplicando seed: %%~nxf
    set PGPASSWORD=%DB_PASSWORD%
    psql -h %DB_HOST% -p %DB_PORT% -U %DB_USER% -d %DB_NAME% -f "%%f"
    
    if !errorlevel! equ 0 (
        echo ✓ Seed %%~nxf aplicado com sucesso
    ) else (
        echo ✗ Erro no seed %%~nxf
        exit /b 1
    )
)

echo Todos os seeds foram executados!
endlocal