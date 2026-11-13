if (Get-Command vim -ErrorAction SilentlyContinue) {
    $env:EDITOR = 'vim'
}

foreach ($directory in @("$HOME/bin", "$HOME/.local/bin", "$HOME/go/bin", "$HOME/node_modules/.bin")) {
    if ((Test-Path -LiteralPath $directory -PathType Container) -and
        ($env:PATH -split ';' -notcontains $directory)) {
        $env:PATH = "$directory;$env:PATH"
    }
}

if (Get-Command fnm -ErrorAction SilentlyContinue) {
    fnm env --use-on-cd --shell powershell | Out-String | Invoke-Expression
}

$extraProfile = Join-Path $HOME '.powershell-profile.extra.ps1'
if (Test-Path -LiteralPath $extraProfile -PathType Leaf) {
    . $extraProfile
}
Remove-Variable directory, extraProfile -ErrorAction SilentlyContinue
