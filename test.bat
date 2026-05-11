@echo off
if "%~2"=="" (
    echo Usage: run.bat INPUTFILE OUTPUTFILE
    exit /b 1
)
del forth.blk
java -jar ..\rars1_6.jar nc sm forth.s < "%~1" > "%~2"