@ ECHO OFF
TITLE TELNET FILTER
CLS

ECHO TELNET FILTER
ECHO.
ECHO Il Favoloso Mondo di Leo
ECHO https://ilfavolosomondodileo.wordpress.com/
ECHO.

SET DAY=%DATE:~0,2%
SET MONTH=%DATE:~3,2%
SET YEAR=%DATE:~6,4%
SET HOURS=%TIME:~0,2%
SET MINUTES=%TIME:~3,2%
SET SECONDS=%TIME:~6,2%
IF "%HOURS:~0,1%"==" " SET HOURS=0%HOURS:~1,1%

SET LOG=C:\BATCH SCRIPT\TELNET FILTER.CSV

SET URL=%1

SET LINK=%URL:~1,-1%

SET URL=%URL:~10,-2%

FOR /F "tokens=1,2 delims=:" %%A IN ("%URL%") DO (

SET HOST=%%A
SET PORT=%%B

)

IF "%HOST%"=="~10,-2" GOTO ERROR
IF "%PORT%"=="" SET PORT=23

ECHO LINK	%LINK%
ECHO HOST	%HOST%
ECHO PORT	%PORT%
ECHO.

IF NOT EXIST "%LOG%" (

	fsutil file createNew "%LOG%" 0 > NUL
	>> "%LOG%" ECHO DATE,TIME,HOST,PORT
	>> "%LOG%" ECHO %DAY%/%MONTH%/%YEAR%,%HOURS%:%MINUTES%:%SECONDS%,%HOST%,%PORT%

) ELSE (

	>> "%LOG%" ECHO %DAY%/%MONTH%/%YEAR%,%HOURS%:%MINUTES%:%SECONDS%,%HOST%,%PORT%

)

IF EXIST "C:\Program Files (x86)\PuTTY\putty.exe" ( START "TELNET FILTER" "C:\Program Files (x86)\PuTTY\putty.exe" -telnet %HOST% -P %PORT% ) ELSE ( GOTO ERROR )

GOTO EXIT

: ERROR

ECHO ERROR
ECHO.

IF "%HOST%"=="~10,-2" ECHO HOST IS NOT SPECIFIED

IF NOT EXIST "C:\Program Files (x86)\PuTTY\putty.exe" (

ECHO PuTTY IS NOT INSTALLED
START https://www.putty.org/

)

PAUSE > NUL

: EXIT

EXIT