$batchFile = "F:\TrendRadar\scripts\create-scheduled-task.bat"

try {
    $psi = New-Object System.Diagnostics.ProcessStartInfo
    $psi.FileName = $batchFile
    $psi.Verb = "runas"
    $psi.UseShellExecute = $true
    $psi.WindowStyle = "Normal"

    $p = [System.Diagnostics.Process]::Start($psi)
    Write-Host "Started elevated process, waiting for completion..."
    $p.WaitForExit()
    Write-Host "Process exited with code: $($p.ExitCode)"
}
catch {
    Write-Host ""
    Write-Host "Elevation failed: $_"
    Write-Host ""
    Write-Host "请手动操作："
    Write-Host "1. 打开文件资源管理器"
    Write-Host "2. 进入 F:\TrendRadar\scripts\"
    Write-Host "3. 右键 create-scheduled-task.bat"
    Write-Host "4. 选择 '以管理员身份运行'"
    Write-Host "5. 在 UAC 弹窗中点 '是'"
    exit 1
}
