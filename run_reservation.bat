@echo off
REM iMaoTai Auto-Reservation Task
REM Runs daily at 9:05 AM

cd /d D:\MyCode\iMaoTai-reserve-master
call venv\Scripts\activate.bat
python main.py
pause
