@echo off

:: Check if an argument (file) is provided
if "%~1"=="" (
    echo No file provided.
    pause
    exit /b
)

if "%~2"=="" (
    echo No algorithm provided.
    pause
    exit /b
)

:: Calculate SHA-256 checksum
set "file=%~1"
set "algorithm=%~2"

echo %algorithm% of "%file%":
for /f %%i in ('certutil -hashfile "%file%" %algorithm% ^| findstr /i /v "hash"') do set "hash=%%i"
echo %hash%
echo.

set /p "userHash=Enter Correct %algorithm% Hash: "
if "%userHash%"=="" (
    echo No input provided. Exiting...
    exit /b
)

if "%userHash%"=="%hash%" (
    echo [92mHashes match![0m File is authentic.
) else (
    echo [91mHashes do not match![0m File may be corrupted or tampered with.
)

:: Pause to see the result
pause