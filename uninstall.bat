@echo off
setlocal EnableExtensions
cd /d "%~dp0"
title ocode uninstaller
set "PY="
where py >nul 2>nul && set "PY=py -3"
if not defined PY (
  where python >nul 2>nul && set "PY=python"
)
if not defined PY (
  echo   Python was not found, so there is nothing to uninstall.
  pause
  exit /b 1
)
echo.
echo   Removing the PATH entry, right-click menu and Windows Terminal profile...
%PY% -m ocode setup --uninstall
echo   Removing the ocode package...
%PY% -m pip uninstall -y ocode
echo.
echo   Done. Your settings and memory in %USERPROFILE%\.ocode were kept - delete that folder to remove them.
echo.
pause
