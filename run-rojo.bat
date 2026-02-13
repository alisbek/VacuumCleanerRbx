@echo off
cd /d "%~dp0\src"
echo Starting Rojo serve using project file ..\default.project.json from %cd%
rojo serve ..\default.project.json
