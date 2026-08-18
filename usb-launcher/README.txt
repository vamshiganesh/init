Interview Coder USB Launcher
============================

What this folder is for
-----------------------
This folder supports a portable Windows workflow. It does not replace the
existing installer or development scripts.

What to copy to the USB drive
-----------------------------
1. Copy all files from this folder to the root of the USB drive.
2. Copy the generated portable app .exe from the release folder to the same
   USB drive root.

Recommended build commands
--------------------------
- npm run package-portable
  Builds only the Windows portable executable.

- npm run package-win
  Builds both the Windows installer and the portable executable.

How to use on another Windows computer
--------------------------------------
1. Plug in the USB drive.
2. If AutoPlay offers "Launch Interview Coder in stealth mode", click it.
3. Otherwise, double-click launch-stealth-portable.vbs.
4. Wait about 10 seconds, then remove the USB drive.

What the launcher does
----------------------
- Copies the portable executable to:
  %LOCALAPPDATA%\InterviewCoderPortable
- Launches the copied app from the local machine
- Exits immediately so the USB drive can be removed

Important limitation
--------------------
Modern Windows versions do not allow USB drives to auto-run software
completely hands-free. The autorun.inf file only helps Windows show a launch
option on systems where AutoPlay presents it. In most cases you should expect
one manual double-click on launch-stealth-portable.vbs.

Notes
-----
- The application itself remains responsible for stealth behavior, invisibility,
  and hiding from the taskbar.
- If you build a new version, replace the portable .exe on the USB drive with
  the new one.
