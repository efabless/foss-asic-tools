# IIC-OSIC-TOOLS Known Issues

## Container

### Starting the Container

If you run into problems when starting the container (mostly in combination with SELinux), try to run the container with the following environment variable set to `DOCKER_EXTRA_PARAMS='--security-opt seccomp=unconfined'`. This will overwrite the Docker Default security settings so use with care!

Example:

```DOCKER_EXTRA_PARAMS='--security-opt seccomp=unconfined' ./start_x.sh```

### OpenEMS

The visualization tool "AppCSXCAD" will not work in the container with our default settings (`vtkXOpenGLRenderWindow (0x....): Cannot create GLX context.  Aborting.`). The issue has been located to be connected with the environment variable "LIBGL_ALWAYS_INDIRECT". As a workaround, we suggest to either unset the variable or set it to 0 (`unset LIBGL_ALWAYS_INDIRECT` or `export LIBGL_ALWAYS_INDIRECT=0`) which is persistent for the running terminal, or run AppCSXCAD with the variable set to zero inline: `LIBGL_ALWAYS_INDIRECT=0 AppCSXCAD`.

## Build

### Boost

Boost is currently installed from the package sources of Ubuntu and from a manual install/build. This is currently required, as there are some dependencies from packages, but also, some of the manually built tools require a newer boost version. This issue will be resolved in the future when switching to a more modern Ubuntu release.