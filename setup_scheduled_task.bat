@echo off
REM ========================================
REM i茅台预约工具 - 定时任务安装脚本
REM ========================================

echo 正在配置 i茅台 自动预约定时任务...
echo.

REM 检查是否有管理员权限
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [错误] 需要管理员权限！
    echo.
    echo 请右键点击此文件，选择"以管理员身份运行"
    echo.
    pause
    exit /b 1
)

echo [1/3] 删除旧的任务计划（如果存在）...
schtasks /delete /tn "i茅台自动预约" /f >nul 2>&1

echo [2/3] 创建新的定时任务...
schtasks /create /tn "i茅台自动预约" /tr "D:\MyCode\iMaoTai-reserve-master\run_reservation.bat" /sc daily /st 09:05 /ru SYSTEM /f

if %errorLevel% neq 0 (
    echo.
    echo [错误] 任务创建失败！
    echo.
    pause
    exit /b 1
)

echo [3/3] 验证任务创建...
schtasks /query /tn "i茅台自动预约" /fo LIST /v

echo.
echo ========================================
echo ✓ 定时任务配置成功！
echo ========================================
echo.
echo 任务名称: i茅台自动预约
echo 运行时间: 每天 09:05
echo 运行脚本: D:\MyCode\iMaoTai-reserve-master\run_reservation.bat
echo.
echo 查看任务:
echo   - 打开"任务计划程序"（taskschd.msc）
echo   - 找到"i茅台自动预约"任务
echo.
echo 测试运行（立即执行一次）:
echo   schtasks /run /tn "i茅台自动预约"
echo.
echo 删除任务:
echo   schtasks /delete /tn "i茅台自动预约" /f
echo.
echo ========================================

pause
