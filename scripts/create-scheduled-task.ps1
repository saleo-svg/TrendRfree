$taskName = "TrendRadar-Daily-Crawl"
$taskDescription = "TrendRadar 每日 8:00 自动抓取热点新闻"
$pythonExe = "F:\TrendRadar\venv\Scripts\python.exe"
$workDir = "F:\TrendRadar"
$logDir = "F:\TrendRadar\output\logs"
$logFile = Join-Path $logDir "trendradar-$(Get-Date -Format 'yyyyMMdd-HHmmss').log"

if (!(Test-Path $logDir)) { New-Item -ItemType Directory -Path $logDir -Force | Out-Null }

$action = New-ScheduledTaskAction `
    -Execute $pythonExe `
    -Argument "-m trendradar" `
    -WorkingDirectory $workDir

$trigger = New-ScheduledTaskTrigger `
    -Daily `
    -At "08:00"

$principal = New-ScheduledTaskPrincipal `
    -UserId $env:USERNAME `
    -RunLevel Highest `
    -LogonType Interactive

$settings = New-ScheduledTaskSettingsSet `
    -StartWhenAvailable `
    -DontStopIfGoingOnBatteries `
    -ExecutionTimeLimit (New-TimeSpan -Hours 1)

$task = New-ScheduledTask `
    -Action $action `
    -Trigger $trigger `
    -Principal $principal `
    -Settings $settings `
    -Description $taskDescription

Register-ScheduledTask `
    -TaskName $taskName `
    -InputObject $task `
    -Force | Out-Null

Write-Host ""
Write-Host "================================================"
Write-Host "  Windows 计划任务创建成功"
Write-Host "================================================"
Write-Host "  任务名称: $taskName"
Write-Host "  触发时间: 每天 08:00"
Write-Host "  执行命令: $pythonExe -m trendradar"
Write-Host "  工作目录: $workDir"
Write-Host "================================================"
Write-Host "  查看/修改: 任务计划程序 -> $taskName"
Write-Host "================================================"
Write-Host ""
Write-Host "日志目录: $logDir"
