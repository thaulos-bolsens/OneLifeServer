FROM ubuntu:22.04

RUN dpkg --add-architecture i386
RUN apt-get update -y && apt-get upgrade -y
RUN apt install git make build-essential mingw-w64-common g++-mingw-w64 libfreetype-dev:i386 git nano -y

WORKDIR /ohol

RUN git clone https://github.com/jasonrohrer/minorGems.git
RUN git clone https://github.com/jasonrohrer/OneLife.git
RUN git clone https://github.com/jasonrohrer/OneLifeData7.git

WORKDIR /ohol/minorGems
RUN git fetch --tags
RUN latestTaggedVersion=`git for-each-ref --sort=-creatordate --format '%(refname:short)' --count=1 refs/tags/OneLife_v* | sed -e 's/OneLife_v//'` && git checkout -q OneLife_v$latestTaggedVersion

WORKDIR /ohol/OneLifeData7
RUN git fetch --tags
RUN latestTaggedVersionB=`git for-each-ref --sort=-creatordate --format '%(refname:short)' --count=1 refs/tags/OneLife_v* | sed -e 's/OneLife_v//'` && git checkout -q OneLife_v$latestTaggedVersionB

WORKDIR /ohol/OneLife
RUN git pull --tags
RUN git checkout OneLife_liveServer

WORKDIR /ohol/include

RUN cp /ohol/include/SDL-devel-1.2.15-mingw32.tar.gz .
RUN tar -xvzf SDL-devel-1.2.15-mingw32.tar.gz
RUN rm SDL-devel-1.2.15-mingw32.tar.gz
RUN ln -s SDL-1.2.15/include SDL

RUN ln -s /usr/i686-w64-mingw32/include/winsock.h /usr/i686-w64-mingw32/include/Winsock.h
#RUN ln -s /usr/x86_64-w64-mingw32/include/winsock.h /usr/x86_64-w64-mingw32/include/Winsock.h
#RUN ln -s /usr/x86_64-w64-mingw32/include/windows.h /usr/x86_64-w64-mingw32/include/Windows.h
#RUN sed -i 's/windres/x86_64-w64-mingw32-windres/' /ohol/minorGems/game/platforms/SDL/Makefile.MinGW
RUN sed -i 's/windres/\/usr\/bin\/i686-w64-mingw32-windres/' /ohol/minorGems/game/platforms/SDL/Makefile.MinGW
RUN ./configure 3

RUN make \
    -e PLATFORM=Win32 \
    -e PLATFORM_PATH=win32 \
    -e TIME_PLATFORM=Win32 \
    -e TIME_PLATFORM_PATH=win32 \
    -e DIRECTORY_PLATFORM=Win32 \
    -e DIRECTORY_PLATFORM_PATH=win32 \
    -e POLL_PLATFORM=Unix \
    -e POLL_PLATFORM_PATH=unix \
    -e GXX="g++" \
    -e PLATFORM_LIBJPEG_FLAG="-ljpeg" \
    -e PLATFORM_LIBPNG_FLAG="-lz -lpng" \
    -e PLATFORM_COMPILE_FLAGS="-DWIN_32 -DSTATICLIB" \
    -e PLATFORM_LINK_FLAGS="-LSD\lib -lopengl32 -lglu32 -lmingw32 -lSDLmain -lSDL -mwindows -lwsock32 -lwinmm -static-libstdc++ -static-libgcc ${CUSTOM_MINGW_LINK_FLAGS}" \
    -e PLATFORM_LINK_FLAGS_HEADLESS="-LSD\lib -lmingw32 -mconsole -mwindows -lwsock32 -static-libstdc++ -static-libgcc ${CUSTOM_MINGW_LINK_FLAGS}" \
    -e APP_NAME="OneLifeServer.exe"

ENTRYPOINT ["tail", "-f", "/dev/null"]
