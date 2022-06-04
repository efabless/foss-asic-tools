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

IF "%DISP%"=="" SET DISP=host.docker.internal:0

where /q xhost
IF ERRORLEVEL 1 (
    ECHO xhost is not detected / not in PATH. Please verify X-server access control!
) ELSE (
    ECHO Using xhost to enable localhost access to the X-server.
    %ECHO_IF_DRY_RUN% xhost +localhost
)

%ECHO_IF_DRY_RUN% docker run -d --user %CONTAINER_USER%:%CONTAINER_GROUP% -e DISPLAY=%DISP% -e LIBGL_ALWAYS_INDIRECT=1 -v "%DESIGNS%":/foss/designs  %DOCKER_USER%/%DOCKER_IMAGE%:%DOCKER_TAG%
