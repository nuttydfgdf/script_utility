@echo off 
SET /A PORT = %1 

rem netstat -o -n -a | find /i "listening" | findstr ":7920"
netstat -o -n -a | find /i "listening" | findstr ":%PORT%"

if %ERRORLEVEL% equ 0 goto FOUND
echo "Port %PORT% not found"
CALL :Notification "Port %PORT% not found"

goto FIN

:FOUND

echo "Port %PORT% found"
CALL :Notification "Port %PORT% found"

:FIN
EXIT /B %ERRORLEVEL%


REM Function notify to line channel, parameter 1 is the message sent to Line Notify.
:Notification
REM echo The value of parameter 1 is %~1
set MESSAGE=%~1
echo "Notification message = %MESSAGE%"

curl -d "message=%MESSAGE%" -H "Content-Type: application/x-www-form-urlencoded" -H "Authorization: Bearer D8sndbiaV2FcjKbGFO1lY2Al0qT9rKK1QY2Weu12PBm" -X POST https://notify-api.line.me/api/notify

EXIT /B 0


