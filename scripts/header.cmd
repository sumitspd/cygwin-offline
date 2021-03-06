@echo on

REM This script defines common variables.

REM Cygwin distribution directory is one level up from the directory of this script.
set CYGWIN_DISTRIB_DIR=%~dp0..\distrib

REM Define drive where Cygwin is supposed to be installed
IF DEFINED CYGWIN_DRIVE (
	REM Use drive provieded by %CYGWIN_DRIVE%
) ELSE (
	set CYGWIN_DRIVE=C
)
echo CYGWIN_DRIVE=%CYGWIN_DRIVE%

REM Cygwin root directory is hardcoded/fixed (it's a convention)
IF DEFINED PROGRAMFILES(x86) (
    echo "64 bit"
    set CYGWIN_SETUP_EXE=setup-x86_64.exe
    set CYGWIN_ROOT_DIR=%CYGWIN_DRIVE%:\cygwin64
) ELSE (
    echo "32 bit"
    set CYGWIN_SETUP_EXE=setup-x86.exe
    set CYGWIN_ROOT_DIR=%CYGWIN_DRIVE%:\cygwin32
    echo "32 bit is not supported"
    EXIT /B 1
)
echo CYGWIN_SETUP_EXE=%CYGWIN_SETUP_EXE%
echo CYGWIN_ROOT_DIR=%CYGWIN_ROOT_DIR%

set CYGWIN_BIN_DIR=%CYGWIN_ROOT_DIR%\bin

