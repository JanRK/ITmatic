@echo off
md %temp%\WindowsUpdate
cd /D %temp%\WindowsUpdate
if not exist "C:\ProgramData\chocolatey\choco.exe" powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin
if not exist "C:\ProgramData\chocolatey\lib\Wget\tools\wget.exe" "C:\ProgramData\chocolatey\choco.exe" install wget 7zip -y
"C:\ProgramData\chocolatey\lib\Wget\tools\wget.exe" https://raw.githubusercontent.com/JanRK/ITmatic/master/WindowsUpdate/MicrosoftUpdate.bat
"C:\ProgramData\chocolatey\lib\Wget\tools\wget.exe" https://raw.githubusercontent.com/JanRK/ITmatic/master/WindowsUpdate/StopSilverlight.js
"C:\ProgramData\chocolatey\lib\Wget\tools\wget.exe" https://raw.githubusercontent.com/JanRK/ITmatic/master/WindowsUpdate/DoWindowsUpdate.ps1

call "%temp%\WindowsUpdate\MicrosoftUpdate.bat"
cscript "%temp%\WindowsUpdate\StopSilverlight.js"
powershell -NoProfile -ExecutionPolicy Bypass "%temp%\WindowsUpdate\DoWindowsUpdate.ps1"