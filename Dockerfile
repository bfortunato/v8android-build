FROM ubuntu:14.04
MAINTAINER Bruno Fortunato, bruno.fortunato@applica.guru

RUN apt-get update
RUN apt-get install -q -y build-essential curl libc6-dev-i386 g++-multilib git make python wget bzip2 unzip
RUN mkdir /v8
WORKDIR /v8

RUN git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
ENV PATH=/v8/depot_tools:${PATH}

RUN wget https://dl.google.com/android/repository/android-ndk-r11c-linux-x86_64.zip
RUN unzip android-ndk-r11c-linux-x86_64.zip

RUN fetch v8
WORKDIR /v8/v8
RUN echo "target_os = ['android']" >> ../.gclient
RUN gclient sync --nohooks
RUN git config --global user.name "yourname"
RUN git config --global user.email "you@example.com"
RUN git pull -X theirs origin branch-heads/5.6
RUN git checkout branch-heads/5.6

RUN make android_arm.release snapshot=off i18nsupport=off android_ndk_root=/v8/android-ndk-r11c -j4
RUN make android_arm64.release snapshot=off i18nsupport=off android_ndk_root=/v8/android-ndk-r11c -j4
RUN make android_ia32.release snapshot=off i18nsupport=off android_ndk_root=/v8/android-ndk-r11c -j4
RUN make android_x64.release snapshot=off i18nsupport=off android_ndk_root=/v8/android-ndk-r11c -j4
RUN make android_mipsel.release snapshot=off i18nsupport=off android_ndk_root=/v8/android-ndk-r11c -j4