param(
    [string]$SourceDirectory = $PSScriptRoot,
    [string]$DestinationDirectory = $HOME,
    [string]$ProfilePath = $PROFILE.CurrentUserCurrentHost
)

$ErrorActionPreference = 'Stop'
$files = @('.editorconfig', '.gitconfig', '.vimrc', 'powershell-profile.ps1')
$contents = @{}
# Fetch everything before changing any installed configuration.
foreach ($file in $files) {
    if ($SourceDirectory) {
        $contents[$file] = [IO.File]::ReadAllText((Join-Path $SourceDirectory $file))
    } else {
        $contents[$file] = (Invoke-WebRequest -UseBasicParsing -Uri "https://raw.githubusercontent.com/andre487/dotfiles/master/$file").Content
    }
}

$null = New-Item -ItemType Directory -Force -Path $DestinationDirectory
$utf8 = New-Object System.Text.UTF8Encoding($false)
foreach ($file in $files) {
    $target = Join-Path $DestinationDirectory $file
    if ($file -eq 'powershell-profile.ps1') {
        $target = $ProfilePath
        $null = New-Item -ItemType Directory -Force -Path (Split-Path $target -Parent)
    }
    if (Test-Path -LiteralPath $target) {
        $item = Get-Item -Force -LiteralPath $target
        if ($item.PSIsContainer -or ($item.Attributes -band [IO.FileAttributes]::ReparsePoint)) {
            throw "Refusing to replace a directory or link: $target"
        }
        if ([IO.File]::ReadAllText($target) -ceq $contents[$file]) { continue }
        $backup = "$target.backup-$([guid]::NewGuid().ToString('N'))"
        Copy-Item -LiteralPath $target -Destination $backup
        Write-Host "Backup: $backup"
    }
    [IO.File]::WriteAllText($target, $contents[$file], $utf8)
    Write-Host "Installed: $target"
}

Write-Host 'Vim: run :PluginInstall to install plugins (requires Git in PATH).'
Write-Host "PowerShell profile: $ProfilePath (automatic loading requires a policy that allows scripts)."
if (Test-Path -LiteralPath (Join-Path $DestinationDirectory '_vimrc')) {
    Write-Warning 'Existing _vimrc takes precedence over .vimrc in Windows Vim; merge or rename it manually.'
}
