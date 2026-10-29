@echo off
setlocal
echo ===================================================================
echo   TaskBridge - Quick Refresh and Sync Utility
echo ===================================================================

set "TOMCAT_DIR=C:\Users\%USERNAME%\Downloads\apache-tomcat-11.0.24-windows-x64\apache-tomcat-11.0.24"
set "WEBAPPS_DEST=%TOMCAT_DIR%\webapps\StudentAssignmentSystem"

echo [1/3] Syncing updated JSP and Web files to target...
if exist "StudentAssignmentSystem\src\main\webapp" (
    xcopy /E /I /Y "StudentAssignmentSystem\src\main\webapp" "StudentAssignmentSystem\target\StudentAssignmentSystem" > nul
)

if exist "%TOMCAT_DIR%\bin\catalina.bat" (
    echo [2/3] Syncing files to Tomcat webapps...
    if not exist "%WEBAPPS_DEST%" mkdir "%WEBAPPS_DEST%"
    xcopy /E /I /Y "StudentAssignmentSystem\src\main\webapp" "%WEBAPPS_DEST%" > nul
    
    echo [3/3] Clearing Tomcat JSP work cache...
    if exist "%TOMCAT_DIR%\work\Catalina\localhost\StudentAssignmentSystem" (
        rmdir /S /Q "%TOMCAT_DIR%\work\Catalina\localhost\StudentAssignmentSystem" > nul 2>&1
    )
    echo [SUCCESS] Tomcat files and JSP cache refreshed!
) else (
    echo [NOTE] Standalone Tomcat not found in Downloads. (Eclipse WTP will read from workspace directly).
)

echo ===================================================================
echo DONE! Now in your browser, press Ctrl + F5 to reload.
echo ===================================================================
pause
endlocal
