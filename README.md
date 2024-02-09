# docker-golang-multi-platform

## Description

**docker-golang-multi-platform** is variant of the official 
[GoLang Docker Image](https://hub.docker.com/_/golang) that includes all 
dependencies required to build multi-platform binaries for Linux ARM64 and
Windows on Linux x64 machines using CGO.

If you do not need CGO to build your packages, we strongly recommend you to
stick with the original Go Docker Image.

It also includes **zip** to allow the creation of zip packages with all binaries
inside.

## How to build the image

Just execute `docker build -f Dockerfile -t docker-golang-multi-platform .` inside
this directory and wait until the image is ready to be used.

## How to use this image

This image is expected to be used on the same way the original image is:

```
docker run --rm -v "$PWD":/usr/src/myapp -w /usr/src/myapp docker-golang-multi-platform go build -v -buildvcs=false -ldflags "-s -w" 
```

You can also use it to build binaries for other platforms by setting additional
environment variables such as `GOOS`, `GOARCH` and specially `CC` that will be 
used to build packages that also depend on C/C++ code to run.

```
docker run --rm -v "$PWD":/usr/src/myapp -w /usr/src/myapp docker-golang-multi-platform -e GOOS=windows -e GOARCH=386 -e CC=aarch64-linux-gnu-gcc go build -v -buildvcs=false -ldflags "-s -w" 
```

This is a list of combinations that can be used in this image:

Platform | GOOS | GOARCH 
--- | --- | --- | --- | ---
Linux AMD64 | linux | amd64 | - 
Linux AARCH64 | linux | arm64 | aarch64-linux-gnu-gcc 
Windows 64 | windows | amd64 | x86_64-w64-mingw32-gcc-win32 

## Vendor packages

In order to speed-up your build process, we strongly recommend you to run 
`go mod vendor` prior to compile the code with this Docker image, specially if 
you are using private repositories to build your program.

If you don't do that, your build will fail when the build process tries to access
your private repositories without the proper credentials.
