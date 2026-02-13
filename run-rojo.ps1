# run-rojo.ps1
# Wrapper to run rojo serve using the project file in the repo root
Set-Location -Path "$PSScriptRoot\src"
Write-Host "Starting Rojo serve using project file ..\default.project.json from $PWD"
rojo serve ..\default.project.json
