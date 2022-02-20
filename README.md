# Burp Suite Community Container Image

This repo contains the Dockerfile and the GitHub Actions workflow to build a simple container image for Burp Suite (Community).

## Running in Docker/Podman

Requires:

- Linux
- X11
- OCI runtime (e.g., Docker, Podman)

```shell
sudo podman run \
    -d --rm \
    --name burpsuite \
    -e DISPLAY \
    -v /tmp/.X11-unix/:/tmp/.X11-unix/ \
    -p 8080:8080 \
    ghcr.io/k4yt3x/burpsuite:2022.1.1
```

## Running in Minikube

Requires:

- Linux
- X11
- OCI runtime (e.g., Docker, Podman)
- minikube
- kubectl

First start the minikube cluster with X11 mounted into minikube and apply the resource.

```shell
minikube start --mount --mount-string="/tmp/.X11-unix:/tmp/.X11-unix"
kubectl apply -k base
```

Then get the service's URL. Use this URL as the HTTP proxy address in the host's browser.

```shell
minikube service burpsuite --url
```

## Building Container

The container is automatically built and pushed to GHCR with this repository's Github Actions workflow. Use the following command to build the image manually:

```shell
sudo podman build \
    --build-arg VERSION=2022.1.1 \
    -t ghcr.io/k4yt3x/burpsuite:2022.1.1 \
    -f Dockerfile
```
