@ECHO OFF
@CLS

SET DEST_DIR=C:\KNN\ReactDevBup

REM -- Get today's date
for /f "skip=1" %%x in ('wmic os get localdatetime') do if not defined MyDate set MyDate=%%x
for /f %%x in ('wmic path win32_localtime get /format:list ^| findstr "="') do set %%x
set fmonth=00%Month%
set fday=00%Day%
set today=%Year%-%fmonth:~-2%-%fday:~-2%
echo %today%

REM -- Get unique file name
SET STARTTIME=%time%
SET HOUR=(1%STARTTIME:~0,2%)
SET HOUR=%HOUR: =0%
SET /A STARTTIME=(%HOUR%-100)*360000 + (1%STARTTIME:~3,2%-100)*6000 + (1%STARTTIME:~6,2%-100)*100 + (1%STARTTIME:~9,2%-100)

REM -- Get directory name
for %%I in (.) do set CurrDirName=%%~nxI
echo %CurrDirName%

SET ARCHIVE_NAME=%CurrDirName%-backup-%today%-%STARTTIME%.7z

REM -- Create the backup zip file
"C:\Program Files\7-Zip\7z" a %ARCHIVE_NAME% public src .env package.json *.bat *.txt

REM -- Move to the archive directory
MOVE /Y %ARCHIVE_NAME% %DEST_DIR%
