if (Get-Command vim -ErrorAction SilentlyContinue) {
    $env:EDITOR = 'vim'
}

foreach ($directory in @("$HOME/bin", "$HOME/.local/bin", "$HOME/go/bin", "$HOME/node_modules/.bin")) {
    if ((Test-Path -LiteralPath $directory -PathType Container) -and
        ($env:PATH -split ';' -notcontains $directory)) {
        $env:PATH = "$directory;$env:PATH"
    }
}

function prompt {
    $succeeded = $?
    $arrowColor = if ($succeeded) { 'Green' } else { 'Red' }
    $location = Get-Location
    $label = if ($location.Path -eq $HOME) { '~' } else { Split-Path $location.Path -Leaf }
    if (-not $label) { $label = $location.Path }
    Write-Host ([char]0x279C) -NoNewline -ForegroundColor $arrowColor
    Write-Host "  $label" -NoNewline -ForegroundColor Cyan
    return ' > '
}

if (Get-Command fnm -ErrorAction SilentlyContinue) {
    fnm env --use-on-cd --shell powershell | Out-String | Invoke-Expression
}

if (Get-Command Set-PSReadLineKeyHandler -ErrorAction SilentlyContinue) {
    Set-PSReadLineOption -HistorySearchCursorMovesToEnd
    Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
    Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
}

$extraProfile = Join-Path $HOME '.powershell-profile.extra.ps1'
if (Test-Path -LiteralPath $extraProfile -PathType Leaf) {
    . $extraProfile
}
Remove-Variable directory, extraProfile -ErrorAction SilentlyContinue
