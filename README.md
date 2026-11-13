# My dotfiles

## macOS / Linux

Install / update:

```bash
curl -L https://github.com/andre487/dotfiles/raw/master/setup.sh | bash
```

## Windows

- PowerShell 5.1+; no administrator rights required.
- Copies `.editorconfig`, `.gitconfig`, `.vimrc` and the current shell's PowerShell profile; backs up changed files.
- Run setup in each shell you use (Windows PowerShell / PowerShell 7).
- Profile: Vim editor, user PATH directories, fnm if installed; local settings in `~/.powershell-profile.extra.ps1`.

Install / update without changing ExecutionPolicy:

```powershell
irm https://raw.githubusercontent.com/andre487/dotfiles/master/setup.ps1 | iex
```

From a local checkout:

```powershell
& ([scriptblock]::Create((Get-Content -Raw .\setup.ps1))) -SourceDirectory $PWD.Path
```

Enable automatic profile loading, then restart PowerShell (organization policies may override):

```powershell
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
```

- Git and Vim must be installed separately; run `:PluginInstall` in Vim.
- Existing `_vimrc` takes precedence over `.vimrc` on Windows.
- `.gitconfig` contains Andrey's name/email; LFS repositories require Git LFS.
