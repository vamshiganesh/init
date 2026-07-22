@echo off
set "SILENT_MODE=0"
if /I "%~1"=="/silent" set "SILENT_MODE=1"
if /I "%~1"=="--silent" set "SILENT_MODE=1"

echo === Interview Coder - Invisible Edition (No Paywall) ===
echo.
echo IMPORTANT: This app is designed to be INVISIBLE by default!
echo Use the keyboard shortcuts to control it:
echo.
echo - Toggle Visibility: Ctrl+B (or Cmd+B on Mac)
echo - Take Screenshot: Ctrl+H
echo - Process Screenshots: Ctrl+Enter
echo - Move Window: Ctrl+Arrows (Left/Right/Up/Down)
echo - Adjust Opacity: Ctrl+[ (decrease) / Ctrl+] (increase)
echo - Reset View: Ctrl+R
echo - Quit App: Ctrl+Q
echo.
echo When you press Ctrl+B, the window will toggle between visible and invisible.
echo If movement shortcuts aren't working, try making the window visible first with Ctrl+B.
echo.

cd /D "%~dp0"

echo === Step 1: Creating required directories... ===
mkdir "%APPDATA%\interview-coder-v1\temp" 2>nul
mkdir "%APPDATA%\interview-coder-v1\cache" 2>nul
mkdir "%APPDATA%\interview-coder-v1\screenshots" 2>nul
mkdir "%APPDATA%\interview-coder-v1\extra_screenshots" 2>nul

echo === Step 2: Cleaning previous builds... ===
echo Removing old build files to ensure a fresh start...
rmdir /s /q dist dist-electron 2>nul
del /q .env 2>nul

echo === Step 3: Building application... ===
echo This may take a moment...
call npm run build
if errorlevel 1 (
  echo.
  echo Build failed. Fix the errors above and try again.
  if "%SILENT_MODE%"=="1" exit /b 1
  pause
  exit /b 1
)

echo === Step 4: Launching in stealth mode... ===
echo Remember: Press Ctrl+B to make it visible, Ctrl+[ and Ctrl+] to adjust opacity!
echo.

set NODE_ENV=production
set "ELECTRON_EXE=%~dp0node_modules\electron\dist\electron.exe"
set "MAIN_JS=%~dp0dist-electron\main.js"

if not exist "%ELECTRON_EXE%" (
  echo ERROR: Electron not found. Run 'npm install' first.
  if "%SILENT_MODE%"=="1" exit /b 1
  pause
  exit /b 1
)

if not exist "%MAIN_JS%" (
  echo ERROR: Build output missing. Expected: %MAIN_JS%
  if "%SILENT_MODE%"=="1" exit /b 1
  pause
  exit /b 1
)

rem Launch in a detached process so closing this terminal does NOT stop the app
start "" /D "%~dp0" "%ELECTRON_EXE%" "%MAIN_JS%"

echo App is now running invisibly! Press Ctrl+B to make it visible.
echo.
echo You can safely CLOSE THIS TERMINAL - the app will keep running.
echo To quit the app, use Ctrl+Q or end it from Task Manager.
echo.
echo Tip: Double-click stealth-run-silent.vbs to build and launch with no terminal window.
echo.
if "%SILENT_MODE%"=="1" exit /b 0
echo This window will close in 5 seconds...
timeout /t 5 /nobreak >nul
exit