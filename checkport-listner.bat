@echo off 
SET /A PORT = %1 

SET TOKEN="????"

rem netstat -o -n -a | find /i "listening" | findstr ":7920"
netstat -o -n -a | find /i "listening" | findstr ":%PORT%"

if %ERRORLEVEL% equ 0 goto FOUND
echo "Port %PORT% not found"
CALL :Notification "TCP listener error on %PORT% : Fail"

goto FIN

:FOUND
echo "Port %PORT% found"
CALL :Notification "TCP port is already being listened on %PORT% : Pass"

:FIN
EXIT /B %ERRORLEVEL%


REM Function notify to line channel, parameter 1 is the message sent to Line Notify.
:Notification
REM echo The value of parameter 1 is %~1
set MESSAGE=%~1
echo "Notification message = %MESSAGE%"

curl -d "message=%MESSAGE%" -H "Content-Type: application/x-www-form-urlencoded" -H "Authorization: Bearer %TOKEN%" -X POST https://notify-api.line.me/api/notify

EXIT /B 0


