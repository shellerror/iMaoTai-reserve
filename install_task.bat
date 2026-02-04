@echo off
REM ========================================
REM iMaoTai Reservation Task Installer
REM ========================================

echo ========================================
echo  iMaoTai Auto-Reservation Setup
echo ========================================
echo.
echo Creating scheduled task...
echo.

REM Delete old task if exists
schtasks /delete /tn "iMaoTai_Reserve" /f >nul 2>&1

REM Create new scheduled task
schtasks /create /tn "iMaoTai_Reserve" /tr "D:\MyCode\iMaoTai-reserve-master\run_reservation.bat" /sc daily /st 09:05 /ru SYSTEM /rl highest /f

if %errorLevel% equ 0 (
    echo.
    echo ========================================
    echo  SUCCESS! Task created.
    echo ========================================
    echo.
    echo Task Details:
    echo   Name: iMaoTai_Reserve
    echo   Time: Daily 09:05
    echo   Script: run_reservation.bat
    echo.
    echo To view task: taskschd.msc
    echo To run now: schtasks /run /tn "iMaoTai_Reserve"
    echo To delete: schtasks /delete /tn "iMaoTai_Reserve" /f
    echo.
    echo ========================================
) else (
    echo.
    echo ========================================
    echo  FAILED! Task creation error.
    echo ========================================
    echo.
    echo Possible reasons:
    echo   1. No admin rights
    echo   2. Path not found
    echo.
    echo Solution:
    echo   Right-click this file
    echo   Select "Run as administrator"
    echo.
    echo ========================================
)

echo.
pause
