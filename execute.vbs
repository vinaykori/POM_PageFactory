Dim qtpApp,xlsApp,myFile,suiteSheet,rNum,testSuiteName,projectPath,logFilePath
Const testSuiteSheet = "TestSuites"


' remove harcoding of paths
' VB to find the current Directory location

Set ws = CreateObject("Wscript.Shell")
projectPath =  ws.CurrentDirectory & "\"
'msgbox projectPath
REM 'projectPath="E:\Tools\QTP\Recording Scripts\HybridFramework\"


REM ' generate log file path
REM logFilePath = projectPath &"logs\"&replace(replace(replace(formatdatetime(date,1) &"_"& time,",","_"),":","_")," ","_")&".txt"

resultpath = projectPath &"results"
'msgbox resultpath 
CreateZip projectPath &"results.zip", projectPath &"results"




REM ' open QTP
REM openQTP

REM 'check the runmodes of test Suites
REM executeScript
REM ' execute the test suite scripts

REM ' screenshots of errors

REM ' Logging in a txt file




REM Function openQTP
REM Set qtpApp = CreateObject("QuickTest.Application")
REM qtpApp.Visible=True

	REM If NOT qtpApp.Launched Then
			REM qtpApp.launch
	REM End if
REM End function


REM Function executeScript
REM Set xlsApp = CreateObject("Excel.Application")
REM xlsApp.visible=false
REM Set myFile =  xlsApp.Workbooks.Open(projectPath&"Test Cases\TestSuite.xlsx")
REM Set suiteSheet = myFile.sheets(testSuiteSheet)
REM rNum=2

REM While suiteSheet.cells(rNum,1) <> "" 
		REM testSuiteName = suiteSheet.cells(rNum,1)
		REM If suiteSheet.cells(rNum,2) = "Y" Then
			REM loadAndRunTestSuite  ' calling for execution of the test Suite
		REM End if
		REM rNum = rNum + 1
REM Wend 


REM myFile.close
REM xlsApp.quit

REM Set xlsApp = nothing
REM Set myFile = Nothing
REM Set suiteSheet = Nothing
REM End Function


REM Function loadAndRunTestSuite

REM ' open the driverscript corresponding to test suite
REM msgbox projectPath &"drivers\Driver - "&testSuiteName
REM qtpApp.open projectPath &"drivers\Driver - "&testSuiteName

REM ' Set the path env var in the test
REM qtpApp.Test.Environment("Project_Path") = projectPath
REM qtpApp.Test.Environment("logFilePath") = logFilePath

REM qtpApp.Test.Run

REM End Function


Sub CreateZip(pathToZipFile, dirToZip)
 
   'WScript.Echo "Creating zip  (" & pathToZipFile & ") from (" & dirToZip & ")"
			
   Dim fso
   Set fso= Wscript.CreateObject("Scripting.FileSystemObject")
 
   pathToZipFile = fso.GetAbsolutePathName(pathToZipFile)
   msgbox pathToZipFile
   dirToZip = fso.GetAbsolutePathName(dirToZip)
 
   If fso.FileExists(pathToZipFile) Then
       'WScript.Echo "That zip file already exists - deleting it."
       fso.DeleteFile pathToZipFile
   End If
 
   If Not fso.FolderExists(dirToZip) Then
       'WScript.Echo "The directory to zip does not exist."
       Exit Sub
   End If
 
   NewZip pathToZipFile
 
   dim sa
   set sa = CreateObject("Shell.Application")
 
   Dim zip
   Set zip = sa.NameSpace(pathToZipFile)
 
   'WScript.Echo "opening dir  (" & dirToZip & ")"
 
   Dim d
   Set d = sa.NameSpace(dirToZip)
 
	WScript.Echo "copying files..."
 
   ' Look at http://msdn.microsoft.com/en-us/library/bb787866(VS.85).aspx
   ' for more information about the CopyHere function.
   zip.CopyHere d.items, 4
 
   Do Until d.Items.Count <= zip.Items.Count
       Wscript.Sleep(200)
   Loop
 
End Sub


Sub NewZip(pathToZipFile)
 
   'WScript.Echo "Newing up a zip file (" & pathToZipFile & ") "
	msgbox pathToZipFile
   Dim fso
   Set fso = CreateObject("Scripting.FileSystemObject")
   Dim file
   Set file = fso.CreateTextFile(pathToZipFile)
 
   file.Write Chr(80) & Chr(75) & Chr(5) & Chr(6) & String(18, 0)
 
   file.Close
   Set fso = Nothing
   Set file = Nothing
 
   WScript.Sleep 500
 
End Sub