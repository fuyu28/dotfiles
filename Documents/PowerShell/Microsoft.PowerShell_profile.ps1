if (Get-Command mise -ErrorAction SilentlyContinue) {
  (& mise activate pwsh) | Out-String | Invoke-Expression
}

if (Get-Command starship -ErrorAction SilentlyContinue) {
  Invoke-Expression (&starship init powershell)
}

if (Get-Command zoxide -ErrorAction SilentlyContinue) {
  Invoke-Expression (& { (zoxide init powershell | Out-String) })
}
