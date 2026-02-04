# i茅台预约工具 - 定时任务安装脚本
# 需要以管理员身份运行 PowerShell

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "i茅台 自动预约 - 定时任务配置" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 检查管理员权限
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Host "[错误] 需要管理员权限！" -ForegroundColor Red
    Write-Host ""
    Write-Host "请按以下步骤操作：" -ForegroundColor Yellow
    Write-Host "1. 右键点击 PowerShell 图标"
    Write-Host "2. 选择 '以管理员身份运行'"
    Write-Host "3. 运行此脚本"
    Write-Host ""
    Read-Host "按回车键退出"
    exit 1
}

# 定义任务名称和脚本路径
$taskName = "i茅台自动预约"
$scriptPath = "D:\MyCode\iMaoTai-reserve-master\run_reservation.bat"

# 检查脚本是否存在
if (-not (Test-Path $scriptPath)) {
    Write-Host "[错误] 找不到运行脚本: $scriptPath" -ForegroundColor Red
    Read-Host "按回车键退出"
    exit 1
}

Write-Host "[1/4] 删除旧的任务计划（如果存在）..." -ForegroundColor Yellow
try {
    Unregister-ScheduledTask -TaskName $taskName -Confirm:$false -ErrorAction SilentlyContinue
    Write-Host "  完成" -ForegroundColor Green
} catch {
    Write-Host "  无旧任务，跳过" -ForegroundColor Gray
}

Write-Host "[2/4] 创建新的定时任务..." -ForegroundColor Yellow
try {
    $action = New-ScheduledTaskAction -Execute $scriptPath -WorkingDirectory "D:\MyCode\iMaoTai-reserve-master"
    $trigger = New-ScheduledTaskTrigger -Daily -At 09:05
    $principal = New-ScheduledTaskPrincipal -UserId "SYSTEM" -LogonType ServiceAccount -RunLevel Highest
    $settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable

    Register-ScheduledTask -TaskName $taskName -Action $action -Trigger $trigger -Principal $principal -Settings $settings -ErrorAction Stop
    Write-Host "  完成" -ForegroundColor Green
} catch {
    Write-Host "  失败: $_" -ForegroundColor Red
    Read-Host "按回车键退出"
    exit 1
}

Write-Host "[3/4] 验证任务配置..." -ForegroundColor Yellow
try {
    $task = Get-ScheduledTask -TaskName $taskName
    Write-Host "  任务名称: $($task.TaskName)" -ForegroundColor Cyan
    Write-Host "  运行时间: $($task.Triggers.StartBoundary)" -ForegroundColor Cyan
    Write-Host "  运行用户: $($task.Principal.UserId)" -ForegroundColor Cyan
    Write-Host "  状态: $($task.State)" -ForegroundColor Cyan
    Write-Host "  完成" -ForegroundColor Green
} catch {
    Write-Host "  验证失败: $_" -ForegroundColor Red
}

Write-Host "[4/4] 测试任务（可选）..." -ForegroundColor Yellow
Write-Host ""
Write-Host "是否立即测试运行一次？(Y/N)" -ForegroundColor Yellow
$test = Read-Host

if ($test -eq 'Y' -or $test -eq 'y') {
    Write-Host "正在启动测试任务..." -ForegroundColor Yellow
    try {
        Start-ScheduledTask -TaskName $taskName
        Write-Host "测试任务已启动！" -ForegroundColor Green
        Write-Host "请查看任务计划程序或等待推送消息" -ForegroundColor Cyan
    } catch {
        Write-Host "测试失败: $_" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "✓ 定时任务配置成功！" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "任务信息:" -ForegroundColor Cyan
Write-Host "  任务名称: $taskName"
Write-Host "  运行时间: 每天 09:05"
Write-Host "  运行脚本: $scriptPath"
Write-Host ""
Write-Host "管理命令:" -ForegroundColor Yellow
Write-Host "  查看任务:taskschd.msc"
Write-Host "  立即运行: Start-ScheduledTask -TaskName '$taskName'"
Write-Host "  删除任务: Unregister-ScheduledTask -TaskName '$taskName'"
Write-Host "  禁用任务: Disable-ScheduledTask -TaskName '$taskName'"
Write-Host "  启用任务: Enable-ScheduledTask -TaskName '$taskName'"
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan

Read-Host "按回车键退出"
