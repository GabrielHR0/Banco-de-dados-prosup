@echo off
setlocal enabledelayedexpansion

REM Carregar configurações
call .\config\database_config_win.bat

echo Conectando ao banco: %DB_NAME% em %DB_HOST%:%DB_PORT%

REM Função para verificar se migration já foi executado
:is_migration_applied
setlocal
set version=%~1

psql -h %DB_HOST% -p %DB_PORT% -U %DB_USER% -d %DB_NAME% -t -c "SELECT 1 FROM schema_migrations WHERE version = '%version%'" | findstr /r /c:"^ *1$" > nul
if %errorlevel% equ 0 (
    endlocal && exit /b 0
) else (
    endlocal && exit /b 1
)
goto :eof

REM Executar cada migration
for %%f in (.\migrations\*.sql) do (
    for /f "tokens=1 delims=_" %%a in ("%%~nxf") do set "version=%%a"
    
    call :is_migration_applied !version!
    if !errorlevel! equ 1 (
        echo Aplicando migration: %%f
        psql -h %DB_HOST% -p %DB_PORT% -U %DB_USER% -d %DB_NAME% -f "%%f"
        
        if !errorlevel! equ 0 (
            psql -h %DB_HOST% -p %DB_PORT% -U %DB_USER% -d %DB_NAME% -c "INSERT INTO schema_migrations (version, name) VALUES ('!version!', '%%~nxf')"
            echo ✓ Migration !version! aplicado com sucesso
        ) else (
            echo ✗ Erro no migration !version!
            exit /b 1
        )
    ) else (
        echo → Migration !version! já aplicado
    )
)

echo Todas as migrations foram executadas!
echo.

echo Executando seeds...
for %%f in (.\seed_data\*.sql) do (
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

echo Todas as migrations e seeds foram executadas!
endlocal