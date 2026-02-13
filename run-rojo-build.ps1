# run-rojo-build.ps1
# Wrapper to run `rojo build` from the `src` folder
param(
    [string]$Output = "..\VacuumCleaner.rbxlx"
)

Set-Location -Path "$PSScriptRoot\src"
Write-Host "Running: rojo build ..\default.project.json -o $Output from $PWD"
rojo build ..\default.project.json -o $Output
