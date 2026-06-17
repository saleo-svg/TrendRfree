@echo off
chcp 65001 >nul
setlocal

set TASK_NAME=TrendRadar-Daily-Crawl
set PYTHON_EXE=F:\TrendRadar\venv\Scripts\python.exe
set WORK_DIR=F:\TrendRadar
set LOG_DIR=F:\TrendRadar\output\logs

if not exist "%LOG_DIR%" mkdir "%LOG_DIR%"

echo.
echo ================================================
echo  Configuring scheduled task: %TASK_NAME%
echo ================================================

schtasks /Delete /TN "%TASK_NAME%" /F >nul 2>&1

schtasks /Create ^
    /TN "%TASK_NAME%" ^
    /TR "\"%PYTHON_EXE%\" -m trendradar" ^
    /SC DAILY ^
    /ST 08:00 ^
    /RL HIGHEST ^
    /F ^
    /SD %DATE% ^
    /ED 2099/12/31

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ================================================
    echo  Scheduled task created successfully!
    echo ================================================
    echo  Task name:     %TASK_NAME%
    echo  Schedule:      Daily at 08:00
    echo  Command:       %PYTHON_EXE% -m trendradar
    echo  Working dir:   %WORK_DIR%
    echo  Log directory: %LOG_DIR%
    echo ================================================
    echo.
    echo  To verify: Win+R -^> taskschd.msc
    echo  Or run: schtasks /Query /TN "%TASK_NAME%" /V
    echo ================================================
) else (
    echo.
    echo ERROR: Failed to create scheduled task
    echo Please run this script as Administrator:
    echo   Right-click the .bat file -^> "Run as administrator"
    echo.
)
endlocal
pause
