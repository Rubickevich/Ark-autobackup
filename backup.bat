@echo off
setlocal enabledelayedexpansion

if exist config.bat (
    call config.bat
    echo Configuration loaded from config.bat. Delete the config.bat file if you wish to change the configuration.
    goto preloop
) else (
  goto prompt
)

:prompt
set /p map=Enter the name of the map to backup:

rem Open Windows Explorer to select the save path
echo Select the path to the SavedArks folder (*Your server folder*\ShooterGame\Saved\SavedArks)
set "savePath="
set "savePathTitle=Select the SavedArks folder"
for /f "tokens=* delims=" %%a in ('powershell -Command "Add-Type -AssemblyName System.Windows.Forms; $f = New-Object System.Windows.Forms.FolderBrowserDialog; $f.Description = '%savePathTitle%'; $f.RootFolder = [System.Environment+SpecialFolder]::MyComputer; $f.SelectedPath = '%cd%'; $f.ShowDialog(); $f.SelectedPath"') do set "savePath=%%a"
if not defined savePath (
  echo No path selected. Exiting.
  goto :eof
)

rem Open Windows Explorer to select the backup path
echo Select the path to the backup folder (Any folder of your choice)
set "backupPath="
set "backupPathTitle=Select the backup folder"
for /f "tokens=* delims=" %%a in ('powershell -Command "Add-Type -AssemblyName System.Windows.Forms; $f = New-Object System.Windows.Forms.FolderBrowserDialog; $f.Description = '%backupPathTitle%'; $f.RootFolder = [System.Environment+SpecialFolder]::MyComputer; $f.SelectedPath = '%cd%'; $f.ShowDialog(); $f.SelectedPath"') do set "backupPath=%%a"
if not defined backupPath (
  echo No path selected. Exiting.
  goto :eof
)

echo set map=!map!>config.bat
echo set savePath=!savePath!>>config.bat
echo set backupPath=!backupPath!>>config.bat

:preloop
echo Listening for save file changes...
for %%F in ("%savePath%\%map%.ark") do set "timeChanged=%%~tF"
:loop
for %%F in ("%savePath%\%map%.ark") do (
    if not "%%~tF" == "%timeChanged%" (
	  echo Detected change of the save file, attempting backup...
        REM Get the modified timestamp of the file in the format YYYY.MM.DD_HH.MM
        for /f "tokens=1-2 delims= " %%a in ('echo %%~tF') do (
            set "datestamp=%%a"
            set "timestamp=%%b"
        )
        set "timestamp=!timestamp::=.!"
        set "filename=!map!_!datestamp!_!timestamp!.ark"
        copy "!savePath!\!map!.ark" "!backupPath!\!filename!"
	  echo Succesfully backed up to !backupPath!\!filename!
        set "timeChanged=%%~tF"
    )
)
timeout /t 60 > nul

goto loop