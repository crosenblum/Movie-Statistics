@echo off
setlocal enabledelayedexpansion

rem movie statistics - phase one
rem group movies by decade
rem by Craig M. Rosenblum on 01/06/2024

REM Create an associative array to store the count of movies for each decade
for /l %%i in (1900, 10, 2020) do set "decades[%%i]=0"

:MENU
rem menu for statistics script
cls
echo +===============================================+
echo . Movies Statistics                             .
echo . How many movies in each decade                .
echo +===============================================+
echo.
echo.

:PATH_PROMPT
rem step one prompt for drive + folder
set /p path=Enter drive and folder path: 

rem check if valid folder path
if exist %path% (
	GOTO :FIND_FOLDERS
) else (
	GOTO :PATH_PROMPT
)

:FIND_FOLDERS
for /d /r "%path%" %%f in (*) do (

	rem Full file path
	set "fullpath=%%f"

	rem Extract path from full path
	for %%F in ("!fullpath!") do set "filepath=%%~dpF"

	rem Remove trailing slash
	if "!filepath:~-1!"=="\" (
		set "filepath=!filepath:~0,-1!"
	)

	rem Get the last four characters from the string
	set "year=!filepath:~-5,4!"
	
	rem store year into decade array
	set /a "decade=!year! / 10 * 10"
	set /a "decades[!decade!]+=1"

)

REM Display the count of movies for each decade
echo.
echo Movies by Decade:
echo.
for /l %%i in (1900, 10, 2020) do echo %%i: !decades[%%i]!

GOTO :EOF
rem test sort array and display summary
:EOF
endlocal
