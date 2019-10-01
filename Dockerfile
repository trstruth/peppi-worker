FROM nvidia/opengl:base-ubuntu18.04

# install deps from https://wiki.dolphin-emu.org/index.php?title=Building_Dolphin_on_Linux#16.04_LTS
RUN apt-get update \
    && apt-get install -y \
      curl \
      wget \
      sudo \
      cmake \
      pkg-config \
      git \
      libao-dev \
      libasound2-dev \
      libavcodec-dev \
      libavformat-dev \
      libbluetooth-dev \
      libenet-dev \
      libgtk2.0-dev \
      liblzo2-dev \
      libminiupnpc-dev \
      libopenal-dev \
      libpulse-dev \
      libreadline-dev \
      libsfml-dev \
      libsoil-dev \
      libsoundtouch-dev \
      libswscale-dev \
      libusb-1.0-0-dev \
      libwxbase3.0-dev \
      libwxgtk3.0-dev \
      libxext-dev \
      libxrandr-dev \
      portaudio19-dev \
      zlib1g-dev \
      libudev-dev \
      libevdev-dev \
      "libpolarssl-dev|libmbedtls-dev" \
      libcurl4-openssl-dev \
      libegl1-mesa-dev \
      libpng-dev \
      qtbase5-private-dev

# Trick installer script into thinking Wii U adapter udev rules exist
RUN mkdir -p /etc/udev/rules.d/ && touch /etc/udev/rules.d/51-gcadapter.rules

# Slippi-FM installer script
RUN wget https://github.com/project-slippi/Slippi-FM-installer/raw/master/setup \
    && chmod +x setup \
    && ./setup -y

# Copy Dolphin config files into the image
ARG DOLPHIN_CONFIG_PATH=/Slippi-FM-r18/playback/User/Config/
COPY files/Dolphin.ini ${DOLPHIN_CONFIG_PATH}/Dolphin.ini
COPY files/GFX.ini ${DOLPHIN_CONFIG_PATH}/GFX.ini

# RUN sudo apt-get install -y mesa-utils freeglut3-dev libcanberra-gtk-module libcanberra-gtk3-module

COPY bin/entrypoint.sh /peppi-worker/bin/entrypoint.sh
ENTRYPOINT ["/peppi-worker/bin/entrypoint.sh"]
