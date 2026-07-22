' Relaunch Interview Coder without rebuilding and without a visible terminal.

Set objShell = CreateObject("WScript.Shell")
Set objFSO = CreateObject("Scripting.FileSystemObject")

strScriptDir = objFSO.GetParentFolderName(WScript.ScriptFullName)
strElectronExe = strScriptDir & "\node_modules\electron\dist\electron.exe"
strMainJs = strScriptDir & "\dist-electron\main.js"

If Not objFSO.FileExists(strElectronExe) Then
  MsgBox "Electron not found. Run 'npm install' in the project folder first.", vbCritical, "Interview Coder"
  WScript.Quit 1
End If

If Not objFSO.FileExists(strMainJs) Then
  MsgBox "App is not built yet." & vbCrLf & vbCrLf & _
    "Run stealth-run-silent.vbs once to build and launch.", vbExclamation, "Interview Coder"
  WScript.Quit 1
End If

objShell.Environment("Process")("NODE_ENV") = "production"
objShell.CurrentDirectory = strScriptDir
objShell.Run """" & strElectronExe & """ """ & strMainJs & """", 0, False
