# Ubuntu 20.04 minimal dependencies for Arcane.
# Version with GCC 11 / CUDA 11.6 / CMake 3.21.3.

# Based on https://github.com/arcaneframework/alien/blob/main/docker/base/ubuntu-20.04/Dockerfile

FROM nvidia/cuda:11.6.0-devel-ubuntu20.04

ARG DEBIAN_FRONTEND=noninteractive
ARG TZ=Europe/Paris

# On update puis installe add-apt-repository.
# On ajoute le repo pour avoir gcc-11.
# On installe les packages pour compiler Arcane.
# On met la version par défaut du compiler gcc en version 11.
RUN apt-get update -y \
    && apt-get install -y software-properties-common \
    && add-apt-repository ppa:ubuntu-toolchain-r/test -y \
    && apt-get update -y \
    && apt-get install -y --no-install-recommends \
    apt-utils \
    build-essential \
    gcc-11 \
    g++-11 \
    ccache \
    ninja-build \
    iputils-ping \
    python3 \
    git \
    gfortran \
    libglib2.0-dev \
    libxml2-dev \
    libhdf5-openmpi-dev \
    libparmetis-dev \
    wget \
    rsync \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/* \
    && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-11 100 \
    && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-11 100 \
    && update-alternatives --install /usr/bin/cpp cpp-bin /usr/bin/cpp-11 100 \
    && update-alternatives --set g++ /usr/bin/g++-11 \
    && update-alternatives --set gcc /usr/bin/gcc-11 \
    && update-alternatives --set cpp-bin /usr/bin/cpp-11

# On installe dotnet 6.
RUN wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
    && dpkg -i packages-microsoft-prod.deb \
    && apt-get update \
    && apt-get install -y apt-transport-https dotnet-sdk-6.0 \
    && rm -rf /var/lib/apt/lists/*

# On installe la version 3.21 de CMake.
RUN cd /tmp \
    && wget https://github.com/Kitware/CMake/releases/download/v3.21.3/cmake-3.21.3-Linux-x86_64.tar.gz \
    && tar xf cmake-3.21.3-Linux-x86_64.tar.gz \
    && cd /tmp/cmake-3.21.3-linux-x86_64/ \
    && rsync -au . /usr/local \
    && cd .. && rm -rf /tmp/*

# On installe CLang 12.
RUN cd /tmp \
    && wget https://apt.llvm.org/llvm.sh \
    && chmod +x llvm.sh \
    && ./llvm.sh 12 \
    && rm -rf /tmp/* \
    && update-alternatives --install /usr/bin/clang clang /usr/bin/clang-12 90 \
    && update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-12 90 \
    && update-alternatives --set clang /usr/bin/clang-12 \
    && update-alternatives --set clang++ /usr/bin/clang++-12