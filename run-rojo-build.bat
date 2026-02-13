@echo off
SET OUTPUT=%~1
IF "%OUTPUT%"=="" SET OUTPUT=..\VacuumCleaner.rbxlx
cd /d "%~dp0\src"
echo Running: rojo build ..\default.project.json -o %OUTPUT% from %cd%
rojo build ..\default.project.json -o %OUTPUT%
