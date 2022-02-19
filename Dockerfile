# Name: Burp Suite Community Container Image
# Creator: K4YT3X
# Date Created: February 19, 2022
# Last Modified: February 19, 2022
FROM openjdk:11-jre-slim-bullseye
LABEL maintainer="K4YT3X <i@k4yt3x.com>" \
      org.opencontainers.image.source="https://github.com/k4yt3x/burpsuite" \
      org.opencontainers.image.description="Burp Suite Community"
ENV DEBIAN_FRONTEND=noninteractive

# the version of Burp Suite to download
ARG VERSION=2022.1.1

# aria2 is used to download the JAR file since ADD is too slow
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        aria2 \
        font-manager \
        libfreetype6 \
        libxext6 \
        libxrender1 \
        libxtst6 \
    && aria2c -x10 -s10 -j10 \
        "https://portswigger-cdn.net/burp/releases/download\
?product=community&version=${VERSION}&type=Jar" \
        -o /usr/local/bin/burpsuite.jar \
    && apt-get autoremove --purge -y aria2 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && useradd burpsuite

USER burpsuite
EXPOSE 8080
ENTRYPOINT ["/usr/local/openjdk-11/bin/java", \
            "-jar", \
            "/usr/local/bin/burpsuite.jar"]
