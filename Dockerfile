FROM golang:1.22-bullseye

# Update and install cross compilers
RUN apt update && apt upgrade -y && apt install -y mingw-w64 crossbuild-essential-arm64 zip

# Enable CGO by default.
ENV CGO_ENABLED=1
