# Edit the file to change the package requirements
# Command to build :  docker build -t <docker_name> . --no-cache
# Command to remove: docker image remove <docker_name>

FROM nvcr.io/nvidia/cuda:11.3.0-cudnn8-devel-ubuntu20.04
ENV DEBIAN_FRONTEND=noninteractive

ENV cwd="/home/"
WORKDIR $cwd

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
ENV TZ=Asia/Singapore
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt -y update

RUN apt-get install -y \
    software-properties-common \
    build-essential \
    checkinstall \
    cmake \
    pkg-config \
    yasm \
    git \
    vim \
    curl \
    wget \
    sudo \
    apt-transport-https \
    libcanberra-gtk-module \
    libcanberra-gtk3-module \
    dbus-x11 \
    vlc \
    iputils-ping 
    # python3-dev \
    # python3-pip

RUN add-apt-repository ppa:deadsnakes/ppa && apt-get install -y python3.9-dev python3.9-venv python3-pip
RUN apt -y update

RUN python3.9 -m venv /venv
ENV PATH=/venv/bin:$PATH

RUN apt-get clean && rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/* && apt-get -y autoremove

RUN rm -rf /var/cache/apt/archives/

### APT END ###

RUN /usr/bin/python3 -m pip install --upgrade pip
RUN python3 -m pip install --upgrade pip setuptools

RUN python3 -m pip install 'git+https://github.com/yhsmiley/yolov7.git'

COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

RUN pip3 install "uvicorn[standard]"

