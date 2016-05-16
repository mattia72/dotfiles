@echo off
:: Init Script for cmd.exe
:: Sets some nice defaults
:: Created as part of cmder project
:: !!!! DONT INSTALL CLINK WITH AUTORUN WHEN CMD.EXE STARTS
:: !!!! PROFILE PATH WON'T WORK

REM @title clink

:: Find root dir
@if not defined CLINK_ROOT (
    for /d %%i in ("%programfiles%\clink\*") do @set CLINK_ROOT=%%~fi 
)

:: Change the prompt style
:: Mmm tasty lamb
:: @prompt $E[1;32;40m$P$S{git}$S$_$E[1;30;40m{lamb}$S$E[0m
:: @prompt $E[1;32;40m$P$S{git}$S$_$E[1;30;40m{arrow}$S$E[0m
:: run prompt /? for options
@prompt $E[1;32;40m%username%@%userdomain%$S$E[1;33;40m$P$S{git}$S$_$E[1;30;35mCLINK$S$E[1;30;37m$$$S$E[0m

:: Pick right version of clink
@if "%PROCESSOR_ARCHITECTURE%"=="x86" (
    set architecture=86
) else (
    set architecture=64
)

:: Run clink
@"%CLINK_ROOT%\clink_x%architecture%.exe" inject --profile "%~dp0\profile" 

:: Add aliases
@doskey /macrofile="%~dp0\profile\aliases"

@if defined HOME (
  cd %HOME%
)

