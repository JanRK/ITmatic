$preclean = Get-WmiObject Win32_LogicalDisk -ComputerName remotecomputer -Filter "DeviceID='C:'" |
Select-Object Size,FreeSpace

<#
$preclean.Size
$preclean.FreeSpace
#>

net stop bits
net stop wuauserv

del "%windir%\SoftwareDistribution\Download\*" /F /Q
for /d %%i in ("%windir%\SoftwareDistribution\Download\*") do rmdir /s /q "%%i" 

del "C:\Windows\ccmcache\*" /F /Q
for /d %%i in ("C:\Windows\ccmcache\*") do rmdir /s /q "%%i" 

del "%windir%\temp\*" /F /Q
for /d %%i in ("%windir%\temp\*") do rmdir /s /q "%%i" 

net start bits
net start wuauserv
compact /c /s:"%windir%\system32\LogFiles"

Rem 2008 and up

for /d %%i in ("c:\$Recycle.Bin\*") do rmdir /s /q "%%i" 

for /d %%i in ("c:\programdata\microsoft\windows\wer\reportqueue\*") do rmdir /s /q "%%i" 

Dism.exe /online /Cleanup-Image /SPSuperseded
Dism.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase


IF EXIST "C:\Users\" (
 for /D %%x in ("C:\Users\*") do (               
  forfiles /p "%%x\AppData\Local\Temp" /s /m *.* /D -7 /C "cmd /c del /Q @path"
  forfiles /p "%%x\AppData\Local\Microsoft\Windows\Temporary Internet Files" /s /m *.* /D -7 /C "cmd /c del /Q @path"
  forfiles /p "%%x\AppData\Local\Microsoft\Windows\WER\ReportQueue" /s /m *.* /C "cmd /c del /Q @path"
 )
)

:SystemRestore
echo powershell "disable-computerrestore -drive 'C:\'"


$postclean = Get-WmiObject Win32_LogicalDisk -ComputerName remotecomputer -Filter "DeviceID='C:'" |
Select-Object Size,FreeSpace

write-host Space saved
$preclean.FreeSpace-$postclean.FreeSpace
pause

