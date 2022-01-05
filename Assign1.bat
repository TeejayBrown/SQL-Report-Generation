@ECHO OFF
REM ************************************************
REM Title: Assignment 1 - A batch file that implements a simple menu system.
REM Author: Taiwo Omoleye
REM Date:   Sept 16, 2020
REM ************************************************

:Menu
SET firstname=Taiwo
SET lastname=Omoleye
SET menutitle=Movie Rentals
ECHO %firstname% %lastname% %menutitle%
ECHO.

SET menu1=Generate Report
SET menu2=Exit
ECHO 1. %menu1%
ECHO 2. %menu2%
ECHO.

SET input=
SET /P input=Enter your choice: 
ECHO.
IF “%input%”==“1” GOTO Option1
IF “%input%”==“2” GOTO Option2
IF “%input%”==“” GOTO Option3

ECHO Error - Invalid choice entered. Please choose a valid option.
GOTO Return

:Option1
IF NOT EXIST "C:\DBMSDBII\A1\Reports" MKDIR C:\DBMSDBII\A1\Reports
sqlplus /nolog @Assign1.sql
GOTO Return

:Option2
EXIT

:Option3
ECHO Error - No choice entered. Please choose an option displayed.
GOTO Return

:Return
ECHO.
PAUSE
CLS
GOTO Menu

