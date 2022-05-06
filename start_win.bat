@echo off

SETLOCAL

SET DEFAULT_DESIGNS=%HOMEDRIVE%%HOMEPATH%\eda\designs

IF "%DESIGNS%"=="" (
  echo Design directory auto-set to %DEFAULT_DESIGNS%
  SET DESIGNS=%DEFAULT_DESIGNS%
)
echo Using/creating designs directory: %DESIGNS%
if not exist "%DESIGNS%" mkdir "%DESIGNS%" 

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
    xhost +localhost
)

docker run -d --user %CONTAINER_USER%:%CONTAINER_GROUP% -e DISPLAY=%DISP% -v "%DESIGNS%":/foss/designs  %DOCKER_USER%/%DOCKER_IMAGE%:%DOCKER_TAG%
