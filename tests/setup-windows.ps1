param([string]$Repository = (Split-Path $PSScriptRoot -Parent))
$ErrorActionPreference = 'Stop'
$destination = Join-Path ([IO.Path]::GetTempPath()) "dotfiles-test-$([guid]::NewGuid())"
$installer = [scriptblock]::Create([IO.File]::ReadAllText((Join-Path $Repository 'setup.ps1')))
$profileTarget = Join-Path $destination 'PowerShell/Microsoft.PowerShell_profile.ps1'
try {
    $null = New-Item -ItemType Directory -Path $destination
    [IO.File]::WriteAllText((Join-Path $destination '.gitconfig'), 'original')
    & $installer -SourceDirectory $Repository -DestinationDirectory $destination -ProfilePath $profileTarget
    foreach ($file in @('.editorconfig', '.gitconfig', '.vimrc')) {
        if ([IO.File]::ReadAllText((Join-Path $destination $file)) -cne
            [IO.File]::ReadAllText((Join-Path $Repository $file))) { throw "Mismatch: $file" }
    }
    if ([IO.File]::ReadAllText($profileTarget) -cne
        [IO.File]::ReadAllText((Join-Path $Repository 'powershell-profile.ps1'))) { throw 'Profile mismatch' }
    & $installer -SourceDirectory $Repository -DestinationDirectory $destination -ProfilePath $profileTarget
    $backups = @(Get-ChildItem -Force -LiteralPath $destination -Filter '*.backup-*')
    if ($backups.Count -ne 1 -or [IO.File]::ReadAllText($backups[0].FullName) -ne 'original') {
        throw 'Backup preservation or repeat installation failed'
    }
    Write-Host 'Windows setup checks passed.'
} finally {
    # Only remove the uniquely named test directory created above.
    if ((Split-Path $destination -Parent) -ne [IO.Path]::GetTempPath().TrimEnd('\')) {
        throw "Unexpected cleanup path: $destination"
    }
    Remove-Item -LiteralPath $destination -Recurse -Force
}
