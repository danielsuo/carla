FROM nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04

ARG OAUTH_TOKEN

RUN apt-get update

# Install build tools and dependencies
RUN apt-get install -y \
      build-essential \
      clang-3.9 \
      git \
      cmake \
      ninja-build \
      python3-pip \
      python3-requests \
      python-dev \
      tzdata \
      sed \
      curl \
      wget \
      unzip \
      autoconf \
      libtool

# Install UE4 dependencies
RUN apt-get install -y \
      bison \
      flex \
      libz-dev \
      libglew-dev \
      libqt4-dev \
      dos2unix \
      xdg-user-dirs \
      mono-xbuild \
      mono-dmcs \
      mono-devel \
      libmono-system-data-datasetextensions4.0-cil \
      libmono-windowsbase4.0-cil \
      libmono-system-web-extensions4.0-cil \
      libmono-system-management4.0-cil \
      libmono-system-xml-linq4.0-cil \
      libmono-system-io-compression4.0-cil \
      libmono-system-io-compression-filesystem4.0-cil \
      libmono-microsoft-build-tasks-v4.0-4.0-cil \
      libmono-system-runtime4.0-cil \
      mono-reference-assemblies-4.0 \
      libfreetype6-dev \
      libgtk-3-dev \
      clang-3.8


RUN pip3 install -U pip
RUN pip3 install protobuf

# Update clang
RUN update-alternatives --install /usr/bin/clang++ clang++ /usr/lib/llvm-3.9/bin/clang++ 100
RUN update-alternatives --install /usr/bin/clang clang /usr/lib/llvm-3.9/bin/clang 100

# Create working directory
RUN mkdir /carla
WORKDIR /carla

# Install UnrealEngine
# NOTE: requires signing up at https://unrealengine.com to access repository
RUN git clone https://$OAUTH_TOKEN@github.com/EpicGames/UnrealEngine -b release deps/UnrealEngine
RUN cd deps/UnrealEngine
# RUN ./Setup.sh -exclude=Win32 -exclude=Win64 -exclude=Mac -exclude=Android -exclude=IOS -exclude=HTML5
# RUN ./GenerateProjectFiles
# RUN make
# RUN cd ../../

# Install Carla
RUN UE4_ROOT=/carla/deps/UnrealEngine
