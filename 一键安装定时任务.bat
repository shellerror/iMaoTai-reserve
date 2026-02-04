@echo off
echo ====================================================================
echo  i茅台预约工具 - 一键安装定时任务
echo ====================================================================
echo.
echo 正在配置每天 09:05 自动运行...
echo.

REM 创建任务的完整命令
set TASK_CMD=schtasks /create /tn "iMaoTai_AutoReserve" /tr "D:\MyCode\iMaoTai-reserve-master\run_reservation.bat" /sc daily /st 09:05 /ru SYSTEM /rl highest /f

echo 执行命令:
echo %TASK_CMD%
echo.

%TASK_CMD%

if %errorLevel% equ 0 (
    echo.
    echo ====================================================================
    echo  [成功] 定时任务已创建！
    echo ====================================================================
    echo.
    echo 任务信息:
    echo   名称: iMaoTai_AutoReserve
    echo   时间: 每天 09:05
    echo   脚本: D:\MyCode\iMaoTai-reserve-master\run_reservation.bat
    echo.
    echo 管理命令:
    echo   查看任务: taskschd.msc
    echo   立即运行: schtasks /run /tn "iMaoTai_AutoReserve"
    echo   删除任务: schtasks /delete /tn "iMaoTai_AutoReserve" /f
    echo.
    echo ====================================================================
) else (
    echo.
    echo ====================================================================
    echo  [失败] 任务创建失败！
    echo ====================================================================
    echo.
    echo 可能的原因:
    echo   1. 没有管理员权限
    echo   2. 路径不存在
    echo   3. 命令格式错误
    echo.
    echo 解决方法:
    echo   1. 右键点击此文件
    echo   2. 选择"以管理员身份运行"
    echo   3. 或手动运行上面的命令
    echo.
    echo ====================================================================
)

echo.
echo 按任意键查看详细配置...
pause >nul

schtasks /query /tn "iMaoTai_AutoReserve" /fo LIST /v

echo.
pause
