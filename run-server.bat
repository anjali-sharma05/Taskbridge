@echo off
setlocal
echo ===================================================================
echo   TaskBridge – Smart Academic Task Management System
echo   Server Launcher (Apache Tomcat 11 + Java 17+)
echo ===================================================================

if exist "C:\Program Files\Java\jdk-26.0.2" (
    set "JAVA_HOME=C:\Program Files\Java\jdk-26.0.2"
) else (
    set "JAVA_HOME=C:\Program Files\Java\jdk-21"
)

set "CATALINA_HOME=C:\Users\asus\Downloads\apache-tomcat-11.0.24-windows-x64\apache-tomcat-11.0.24"
if not exist "%CATALINA_HOME%\bin\catalina.bat" (
    set "CATALINA_HOME=C:\Users\%USERNAME%\Downloads\apache-tomcat-11.0.24-windows-x64\apache-tomcat-11.0.24"
)
set "CATALINA_BASE=%CATALINA_HOME%"

echo   Java:   %JAVA_HOME%
echo   Tomcat: %CATALINA_HOME%
echo   URL:    http://localhost:8080/StudentAssignmentSystem/
echo ===================================================================

if not exist "%CATALINA_HOME%\bin\catalina.bat" (
    echo [ERROR] Tomcat 11 not found at: %CATALINA_HOME%
    echo Please make sure your Tomcat 11 folder is located in your Downloads folder.
    pause
    goto end
)

set "WEBAPPS_DEST=%CATALINA_HOME%\webapps\StudentAssignmentSystem"
echo Deploying latest TaskBridge files to Tomcat webapps...
if not exist "%WEBAPPS_DEST%" mkdir "%WEBAPPS_DEST%"

REM Clear Tomcat JSP compilation cache so updated JSPs are compiled fresh
if exist "%CATALINA_HOME%\work\Catalina\localhost\StudentAssignmentSystem" (
    echo Clearing Tomcat JSP cache...
    rmdir /S /Q "%CATALINA_HOME%\work\Catalina\localhost\StudentAssignmentSystem" > nul 2>&1
)

if exist "StudentAssignmentSystem\target\StudentAssignmentSystem" (
    xcopy /E /I /Y "StudentAssignmentSystem\target\StudentAssignmentSystem" "%WEBAPPS_DEST%" > nul
) else if exist "target\StudentAssignmentSystem" (
    xcopy /E /I /Y "target\StudentAssignmentSystem" "%WEBAPPS_DEST%" > nul
)

echo [SUCCESS] Deployment synced to %WEBAPPS_DEST%!
echo Starting Apache Tomcat 11 on http://localhost:8080/StudentAssignmentSystem/ ...
echo (Press Ctrl+C in this window to stop the server)
echo -------------------------------------------------------------------

cd /d "%CATALINA_HOME%\bin"
call catalina.bat run

:end
pause
endlocal
