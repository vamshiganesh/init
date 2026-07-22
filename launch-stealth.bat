@echo off
rem Relaunch without rebuilding. Electron is started detached from this console.

cd /D "%~dp0"

set NODE_ENV=production
set "ELECTRON_EXE=%~dp0node_modules\electron\dist\electron.exe"
set "MAIN_JS=%~dp0dist-electron\main.js"

if not exist "%ELECTRON_EXE%" (
  echo ERROR: Electron not found. Run 'npm install' first.
  pause
  exit /b 1
)

if not exist "%MAIN_JS%" (
  echo ERROR: App not built yet. Run stealth-run.bat or stealth-run-silent.vbs first.
  pause
  exit /b 1
)

start "" /D "%~dp0" "%ELECTRON_EXE%" "%MAIN_JS%"

echo App launched. Press Ctrl+B to show the window.
echo This terminal can be closed - the app will keep running.
timeout /t 3 /nobreak >nul
exit
