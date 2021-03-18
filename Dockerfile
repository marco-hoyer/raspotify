FROM debian:stretch

ENV INSIDE_DOCKER_CONTAINER 1

# Install git and compilers, let's toss gnupg and reprepro in there so we can
# use this container to make the apt repo as well
RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get install -y --no-install-recommends \
        build-essential \
        curl \
        git \
        gnupg \
        pandoc \
        pkg-config \
        python-pip \
        python-setuptools \
        python-wheel \
        reprepro \
        alsa-utils \
        libasound2-dev \
    && rm -rf /var/lib/apt/lists/*

RUN pip install \
        jinja2-cli  \
        unidecode

RUN mkdir /toolchain
WORKDIR /toolchain

# Install 1.0.x alsa-utils which is needed for compilation
ENV PKG_CONFIG_ALLOW_CROSS 0

RUN mkdir /build
