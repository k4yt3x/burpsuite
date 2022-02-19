# Burp Suite Community Container Image

This repo contains the Dockerfile and the GitHub Actions workflow to build a simple container image for Burp Suite (Community).

## Running Image (Linux w/ X11 Only)

```shell
sudo podman run \
    -d --rm \
    --name burpsuite \
    -e DISPLAY \
    -v /tmp/.X11-unix/:/tmp/.X11-unix/ \
    -p 8080:8080 \
    ghcr.io/k4yt3x/burpsuite:2022.1.1
```

## Building Container

```shell
sudo podman build \
    --build-arg VERSION=2022.1.1 \
    -t ghcr.io/k4yt3x/burpsuite:2022.1.1 \
    -f Dockerfile
```
