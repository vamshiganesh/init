@echo off
setlocal EnableExtensions EnableDelayedExpansion

rem Copies the packaged portable app to the local machine and launches it
rem from there so the USB drive can be removed immediately afterward.

cd /D "%~dp0"

set "APP_NAME=Interview Coder"
set "TARGET_DIR=%LOCALAPPDATA%\InterviewCoderPortable"
set "LOG_FILE=%TARGET_DIR%\launcher.log"
set "PORTABLE_EXE="

if not exist "%TARGET_DIR%" mkdir "%TARGET_DIR%" >nul 2>&1

for %%F in ("%~dp0*.exe") do (
  set "FILE_NAME=%%~nxF"
  if /I not "!FILE_NAME!"=="setup.exe" (
    echo !FILE_NAME! | findstr /I /C:"Windows" >nul
    if not errorlevel 1 (
      echo !FILE_NAME! | findstr /I /C:"Portable" >nul
      if not errorlevel 1 (
        set "PORTABLE_EXE=%%~fF"
      )
    )
  )
)

if not defined PORTABLE_EXE (
  for %%F in ("%~dp0*.exe") do (
    set "FILE_NAME=%%~nxF"
    echo !FILE_NAME! | findstr /I /C:"Portable" >nul
    if not errorlevel 1 set "PORTABLE_EXE=%%~fF"
  )
)

if not defined PORTABLE_EXE (
  >"%LOG_FILE%" echo Portable executable not found beside this launcher.
  exit /b 1
)

copy /Y "%PORTABLE_EXE%" "%TARGET_DIR%\" >nul
if errorlevel 1 (
  >"%LOG_FILE%" echo Failed to copy portable executable to %TARGET_DIR%.
  exit /b 1
)

for %%F in ("%PORTABLE_EXE%") do set "COPIED_EXE=%TARGET_DIR%\%%~nxF"

set "NODE_ENV=production"
start "" /MIN "%COPIED_EXE%"
exit /b 0
