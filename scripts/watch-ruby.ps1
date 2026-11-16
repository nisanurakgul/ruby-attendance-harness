param()

$ErrorActionPreference = "Stop"
$projectRoot = Split-Path -Parent $PSScriptRoot
$controlScript = Join-Path $projectRoot "bin\kontrol"
$sourcePrefix = "RubyFileWatch"

$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $projectRoot
$watcher.Filter = "*"
$watcher.IncludeSubdirectories = $true
$watcher.NotifyFilter = [System.IO.NotifyFilters]::LastWrite -bor `
    [System.IO.NotifyFilters]::FileName -bor `
    [System.IO.NotifyFilters]::Size
$watcher.EnableRaisingEvents = $true

$eventNames = @("Changed", "Created", "Deleted", "Renamed")
foreach ($eventName in $eventNames) {
    Register-ObjectEvent -InputObject $watcher -EventName $eventName `
        -SourceIdentifier "$sourcePrefix.$eventName" | Out-Null
}

Write-Host "Watching Ruby files: $projectRoot" -ForegroundColor Cyan
Write-Host "A Ruby file change runs ruby bin/kontrol. Press Ctrl+C to stop." -ForegroundColor Cyan

try {
    while ($true) {
        $null = Wait-Event -Timeout 1
        $queuedEvents = @(Get-Event | Where-Object { $_.SourceIdentifier -like "$sourcePrefix.*" })
        if ($queuedEvents.Count -eq 0) {
            continue
        }

        # Coalesce duplicate events commonly emitted for one editor save.
        Start-Sleep -Milliseconds 350
        $queuedEvents += @(Get-Event | Where-Object { $_.SourceIdentifier -like "$sourcePrefix.*" })
        $queuedEvents = @($queuedEvents | Sort-Object EventIdentifier -Unique)

        $changedPaths = @($queuedEvents | ForEach-Object { $_.SourceEventArgs.FullPath })
        foreach ($queuedEvent in $queuedEvents) {
            Remove-Event -EventIdentifier $queuedEvent.EventIdentifier -ErrorAction SilentlyContinue
        }

        $rubyPaths = @($changedPaths | Where-Object {
            ([System.IO.Path]::GetExtension($_) -ieq ".rb") -or ($_ -ieq $controlScript)
        } | Select-Object -Unique)
        if ($rubyPaths.Count -eq 0) {
            continue
        }

        $displayPaths = @($rubyPaths | ForEach-Object {
            $_.Substring($projectRoot.Length).TrimStart([char]92, [char]47)
        })
        Write-Host "`nRuby change detected: $($displayPaths -join ', ')" -ForegroundColor Yellow
        Write-Host "Command: ruby bin/kontrol" -ForegroundColor DarkGray

        Push-Location $projectRoot
        try {
            & ruby bin/kontrol
            $exitCode = $LASTEXITCODE
        }
        catch {
            $exitCode = 1
            Write-Host "Could not start ruby bin/kontrol: $_" -ForegroundColor Red
        }
        finally {
            Pop-Location
        }

        if ($exitCode -eq 0) {
            Write-Host "Control passed." -ForegroundColor Green
        }
        else {
            Write-Host "CONTROL FAILED (exit code: $exitCode). Review the error output above." -ForegroundColor Red
        }
    }
}
finally {
    foreach ($eventName in $eventNames) {
        Unregister-Event -SourceIdentifier "$sourcePrefix.$eventName" -ErrorAction SilentlyContinue
    }
    Get-Event | Where-Object { $_.SourceIdentifier -like "$sourcePrefix.*" } |
        Remove-Event -ErrorAction SilentlyContinue
    $watcher.Dispose()
    Write-Host "Ruby file watcher stopped." -ForegroundColor Cyan
}
