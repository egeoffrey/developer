# Building an eGeoffrey Package

In eGeoffrey, what eventually the end user will consume is a Docker image. This means once the code is ready and the changes committed to the Github repository, a Docker image has to be built and pushed to Dockerhub for making it eventually available for download.

The naming convention of the Docker image is the following:

    <egeoffrey-package-name>:<branch>-<architecture>

In addition, the same image has to be tagged with `<egeoffrey-package-name>:<version>-<architecture>` so to provide always an updated image of the latest version.
    
It is the developer's responsibility to keep aligned the code in Github and the image in Dockerhub. 

To build your package you can use:

    egeoffrey-cli build amd64,arm
    
which will create the docker images for your and push them to your Dockerhub account. You can build for one or the two architectures for each run.

## Supported Architectures

Developers are strongly encouraged to build the same image for both `amd64` and `arm` architecture so to allow users to have the same functionalities a traditional computer/server (usually `amd64`) and a device like a Raspberry Pi (`arm`)

## The Dockerfile

To speed up the building process, the eGeoffrey SDK provides also a pre-built docker runtime environment developers should leverage for building their own modules. This base docker images, from which you can derive yours, already includes the SDK package and all its required dependencies. Furthermore, provide the following functionalities:

* Include already any operating system and Python requirements for running the SDK
* Set the workdir to `/egeoffrey`
* Print out the module's and the SDK's version information upon start
* Allow the developer to run custom commands before starting the eGeoffrey modules by runing `/egeoffrey/docker-init.sh`, if exists
* Start the an eGeoffrey watchdog service by running `python -m sdk.python.module.start`

The following SDK docker images are available:

* `egeoffrey-sdk-alpine`: light-weighted image based on Alpine
* `egeoffrey-sdk-raspbian`: light-weighted image based on Alpine

Developers can use the one which fits best their requirements. Usually, if no Raspberry Pi specific requirements are needed (e.g. GPIO), go with the eGeoffrey SDK alpine-based image.

SDK images follow the same naming convention of any other image `egeoffrey-sdk-<os>:<branch>-<architecture>`.

When building for both amd64 and arm it is recommended to pass the architecture as a build argument so to leverage the same Dockerfile for both (when building with `egeoffrey-cli` this is done automatically)
