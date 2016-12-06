@echo off

REM # Original Author 
REM #          Matt Little (http://matthewjlittle.com)
REM #          Adam Caudill (http://adamcaudill.com)

REM # Example:
REM # 
REM # Backup.bat "F:\Backup\AKShare" "\\Fileserver\c$\Share" Share
REM # 
REM # 
REM # 


set year=%date:~-4,4%
set month=%date:~-10,2%
set day=%date:~-7,2%
set hour=%time:~-11,2%
set hour=%hour: =0%
set min=%time:~-8,2%

set zipfilename=%year%.%month%.%day%-%3.zip
set destination=%~1
set dest="%destination%\%zipfilename%"

set source="%~2\*"

set AppExePath="%ProgramFiles%\7-Zip\7z.exe"
if not exist %AppExePath% set AppExePath="%ProgramFiles(x86)%\7-Zip\7z.exe"
if not exist %AppExePath% goto notInstalled

echo Backing up %source% to %dest%

%AppExePath% a -rtzip %dest% %source%

echo %source% backed up to %dest% is complete!

goto end

:notInstalled

echo Can not find 7-Zip, please install it from:
echo  http://7-zip.org/

:end
PAUSE
