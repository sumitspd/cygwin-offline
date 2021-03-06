@echo on
REM This script quietly downloads Cygwin and its components.

REM Call script which defines common variables.
REM "~dp0" is directory of the currently called script.
call "%~dp0header.cmd"
IF NOT %errorlevel%==0 (
    echo "Command returned: " %errorlevel%
    REM This is not a top-level script. Use `/B` for `EXIT`.
    EXIT /B 1
)

REM Show hint for user.
echo Specified distribution directory: "%CYGWIN_DISTRIB_DIR%"
echo Specified installation directory: "%CYGWIN_ROOT_DIR%"

REM Set URL to Cygwin online distributive.
set MIRROR_URL="http://mirrors.kernel.org/sourceware/cygwin/"

REM Switch into installer directory (to avoid creating logs in the current one).
cd "%CYGWIN_DISTRIB_DIR%"
IF NOT %errorlevel%==0 (
    echo "Command returned: " %errorlevel%
    REM This is not a top-level script. Use `/B` for `EXIT`.
    EXIT /B 1
)

REM Read contents of first line in the file into environment variable.
REM See: http://stackoverflow.com/a/3069068/441652
SET /p SELECTED_PACKAGES=<"%CYGWIN_DISTRIB_DIR%\packages.line.conf"

REM Run the setup providing list of all required components.
REM Note: the `^` character makes `cmd` interpreter concatenate lines.
REM TODO: Take list of packages from configuration file (instead of hardcoding it).
"%CYGWIN_DISTRIB_DIR%\%CYGWIN_SETUP_EXE%" ^
 --packages "%SELECTED_PACKAGES%" ^
 --quiet-mode ^
 --download ^
 --wait ^
 --local-package-dir "%CYGWIN_DISTRIB_DIR%" ^
 --root "%CYGWIN_ROOT_DIR%" ^
 --only-site ^
 --site "%MIRROR_URL%"
IF NOT %errorlevel%==0 (
    echo "Command returned: " %errorlevel%
    REM This is not a top-level script. Use `/B` for `EXIT`.
    EXIT /B 1
)

REM Switch to original directory (where the current script was called)
cd "%~dp0"
IF NOT %errorlevel%==0 (
    echo "Command returned: " %errorlevel%
    REM This is not a top-level script. Use `/B` for `EXIT`.
    EXIT /B 1
)

REM This is not a top-level script. Use `/B` for `EXIT`.
EXIT /B 0

