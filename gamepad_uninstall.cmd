@echo off
NET SESSION >nul 2>&1 && goto noUAC
set CMDUAC=%tmp%\cmdUAC.vbs
set n=%0 %*
set n=%n:"=" ^& Chr(34) ^& "%
echo Set objShell = CreateObject("Shell.Application")>%CMDUAC% && echo objShell.ShellExecute "cmd.exe", "/c start " ^& Chr(34) ^& "." ^& Chr(34) ^& " /d " ^& Chr(34) ^& "%CD%" ^& Chr(34) ^& " cmd /c %n%", "", "runas", ^1>>%CMDUAC%
echo Not Admin, Attempting to elevate...
cscript "%CMDUAC%" //Nologo
del %CMDUAC%
exit /b
:noUAC

:: 자동실행 등록
set HKLM_RUN="HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run"
%SystemRoot%\system32\reg.exe delete %HKLM_RUN% /v GlovePIE_gamepad /f > nul

pause