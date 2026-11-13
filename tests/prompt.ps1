param([string]$Repository = (Split-Path $PSScriptRoot -Parent))
$ErrorActionPreference = 'Stop'
$code = Get-Content -Raw (Join-Path $Repository 'powershell-profile.ps1')
$definition = [regex]::Match($code, '(?ms)^function prompt \{.*?^\}').Value
if (-not $definition) { throw 'Missing prompt function' }
. ([scriptblock]::Create($definition))
function Write-Host {
    param($Object, [switch]$NoNewline, $ForegroundColor)
    $script:rendered += @(@{ Text = [string]$Object; Color = $ForegroundColor })
}
Push-Location $HOME
try {
    $script:rendered = @()
    $spacing = prompt
    if ($spacing -ne ' > ' -or $rendered[0].Color -ne 'Green' -or $rendered[1].Text -ne '  ~') {
        throw 'Success prompt or home label is incorrect'
    }
    $script:rendered = @()
    $null = Write-Error 'Expected failure' -ErrorAction SilentlyContinue
    $spacing = prompt
    if ($rendered[0].Color -ne 'Red') { throw 'Failure prompt is incorrect' }
    Push-Location ([IO.Path]::GetPathRoot($Repository))
    try {
        $script:rendered = @()
        $spacing = prompt
        if ($rendered[1].Text.Trim().Length -eq 0) { throw 'Empty root label' }
    } finally { Pop-Location }
} finally { Pop-Location }
'Prompt checks passed.'
