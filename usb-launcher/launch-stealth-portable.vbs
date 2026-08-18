Set objShell = CreateObject("WScript.Shell")
Set objFSO = CreateObject("Scripting.FileSystemObject")

strScriptDir = objFSO.GetParentFolderName(WScript.ScriptFullName)
strBatPath = strScriptDir & "\launch-stealth-portable.bat"

If Not objFSO.FileExists(strBatPath) Then
  MsgBox "Could not find launch-stealth-portable.bat in:" & vbCrLf & strScriptDir, vbCritical, "Interview Coder"
  WScript.Quit 1
End If

objShell.CurrentDirectory = strScriptDir
objShell.Run "cmd /c """ & strBatPath & """", 0, False
