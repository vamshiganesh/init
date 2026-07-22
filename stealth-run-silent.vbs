' Builds and launches Interview Coder with no visible terminal window.
' The Electron app runs detached; closing anything else will not stop it.

Set objShell = CreateObject("WScript.Shell")
Set objFSO = CreateObject("Scripting.FileSystemObject")

strScriptDir = objFSO.GetParentFolderName(WScript.ScriptFullName)
strBatPath = strScriptDir & "\stealth-run.bat"

If Not objFSO.FileExists(strBatPath) Then
  MsgBox "Could not find stealth-run.bat in:" & vbCrLf & strScriptDir, vbCritical, "Interview Coder"
  WScript.Quit 1
End If

objShell.CurrentDirectory = strScriptDir
' Window style 0 = hidden; wait until the batch file finishes (build + detached launch)
intExitCode = objShell.Run("cmd /c """ & strBatPath & """ /silent", 0, True)

If intExitCode <> 0 Then
  MsgBox "Launch failed (exit code " & intExitCode & ")." & vbCrLf & vbCrLf & _
    "Try running stealth-run.bat from a terminal to see build errors.", vbExclamation, "Interview Coder"
End If
