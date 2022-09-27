@echo off

SETLOCAL

SET DEFAULT_DESIGNS=%USERPROFILE%\eda\designs

IF DEFINED DRY_RUN (
	echo This is a dry run, all commands will be printed to the shell ^(Commands printed but not executed are marked with ^$^)!
	SET ECHO_IF_DRY_RUN=ECHO $
)

IF "%DESIGNS%"=="" (
  SET DESIGNS=%DEFAULT_DESIGNS%
)
echo Using/creating designs directory: %DESIGNS%
if not exist "%DESIGNS%" %ECHO_IF_DRY_RUN% mkdir "%DESIGNS%" 

IF "%DOCKER_USER%"=="" SET DOCKER_USER=hpretl
IF "%DOCKER_IMAGE%"=="" SET DOCKER_IMAGE=iic-osic-tools
IF "%DOCKER_TAG%"=="" SET DOCKER_TAG=latest

IF "%CONTAINER_USER%"=="" SET CONTAINER_USER=1000
IF "%CONTAINER_GROUP%"=="" SET CONTAINER_GROUP=1000

IF "%CONTAINER_NAME%"=="" SET CONTAINER_NAME=iic-osic-tools_xvnc

IF "%WEBSERVER_PORT%"=="" (
  SET /a WEBSERVER_PORT=80
) ELSE (
  SET /a WEBSERVER_PORT=%WEBSERVER_PORT%
)
echo Webserver port set to %WEBSERVER_PORT%

IF "%VNC_PORT%"=="" (
  SET /a VNC_PORT=5901
) ELSE (
  SET /a VNC_PORT=%VNC_PORT%
)
echo VNC port set to %VNC_PORT%

SET PARAMS=

IF %WEBSERVER_PORT% GTR 0 (
  SET PARAMS=%PARAMS% -p %WEBSERVER_PORT%:80
)

IF %VNC_PORT% GTR 0 (
  SET PARAMS=%PARAMS% -p %VNC_PORT%:5901
)

IF "%DISP%"=="" SET DISP=host.docker.internal:0

where /q xhost
IF ERRORLEVEL 1 (
    ECHO xhost is not detected / not in PATH. Please verify X-server access control!
) ELSE (
    ECHO Using xhost to enable localhost access to the X-server.
    %ECHO_IF_DRY_RUN% xhost +localhost
)

docker container inspect %CONTAINER_NAME% 2>&1 | find "Status" | find /i "running"
IF NOT ERRORLEVEL 1 (
    ECHO Container is running! Stop if required with \"docker stop %CONTAINER_NAME%\"
) ELSE (
    docker container inspect %CONTAINER_NAME% 2>&1 | find "Status" | find /i "exited"
    IF NOT ERRORLEVEL 1 (
        echo Container %CONTAINER_NAME% exists, restarting...
        %ECHO_IF_DRY_RUN% docker start %CONTAINER_NAME%
    ) ELSE (
        echo Container does not exist, creating %CONTAINER_NAME% ...
        %ECHO_IF_DRY_RUN% docker run -d --user %CONTAINER_USER%:%CONTAINER_GROUP% %PARAMS% -v "%DESIGNS%":/foss/designs --name %CONTAINER_NAME% %DOCKER_USER%/%DOCKER_IMAGE%:%DOCKER_TAG%
    )
)
