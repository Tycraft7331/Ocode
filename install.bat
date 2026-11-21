@echo off
setlocal EnableExtensions
cd /d "%~dp0"
title ocode installer
echo.
echo   ocode installer
echo   ---------------
echo.

set "PY="
where py >nul 2>nul && set "PY=py -3"
if not defined PY (
  where python >nul 2>nul && set "PY=python"
)
if not defined PY goto nopython

%PY% -c "import sys; sys.exit(0 if sys.version_info >= (3,9) else 1)"
if errorlevel 1 goto oldpython

set "USERFLAG=--user"
if defined VIRTUAL_ENV set "USERFLAG="

echo   [1/4] Updating pip...
%PY% -m pip install --upgrade pip %USERFLAG% >nul 2>nul

echo   [2/4] Installing ocode...
%PY% -m pip install --upgrade %USERFLAG% .
if errorlevel 1 goto failed

echo   [3/4] Installing optional features (any that can't be installed are skipped)...
call :optional "images, videos, screen" pillow av
call :optional "CPU / RAM monitor" psutil
call :optional "voice input" sounddevice numpy faster-whisper
call :optional "Discord bot" discord.py

echo   [4/4] Setting up PATH, the right-click menu and Windows Terminal...
%PY% -m ocode setup
if errorlevel 1 goto failed

echo.
%PY% -m ocode doctor
echo.
echo   Done!  Open a NEW Command Prompt, go to a project folder and type:  ocode
echo.
pause
exit /b 0

:optional
set "LABEL=%~1"
shift
%PY% -m pip install --upgrade %USERFLAG% %1 %2 %3 %4 >nul 2>nul
if errorlevel 1 (echo         - %LABEL%: skipped) else (echo         + %LABEL%)
exit /b 0

:nopython
echo   Python 3.9 or newer was not found.
echo   Install it from https://www.python.org/downloads/ and tick "Add python.exe to PATH",
echo   then run this installer again.
echo.
pause
exit /b 1

:oldpython
echo   Your Python is too old - ocode needs 3.9 or newer.
echo   Get a newer one from https://www.python.org/downloads/ and run this installer again.
echo.
pause
exit /b 1

:failed
echo.
echo   Something went wrong - scroll up for the error message.
echo   You can also try:  python -m pip install .   and then:  python -m ocode setup
echo.
pause
exit /b 1
