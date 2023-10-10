FROM ubuntu:22.04

RUN apt-get update -y && apt-get upgrade -y
RUN apt install git make build-essential mingw-w64-common g++-mingw-w64 git wine wget -y

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


WORKDIR /ohol/OneLife/server
RUN ./configure 1
RUN make
RUN ln -s ../../OneLifeData7/objects .
RUN ln -s ../../OneLifeData7/transitions .
RUN ln -s ../../OneLifeData7/categories .
RUN ln -s ../../OneLifeData7/tutorialMaps .
RUN ln -s ../../OneLifeData7/dataVersionNumber.txt .

RUN git for-each-ref --sort=-creatordate --format '%(refname:short)' --count=2 refs/tags | grep "OneLife_v" | sed -e 's/OneLife_v//' > serverCodeVersionNumber.txt

RUN mkdir /ohol/data
RUN touch /ohol/data/biome.db && touch /ohol/data/curseCount.db && touch /ohol/data/curses.db && touch /ohol/data/eve.db && touch /ohol/data/floor.db && touch /ohol/data/floorTime.db && touch /ohol/data/grave.db && \
    touch /ohol/data/lookTime.db && touch /ohol/data/map.db && touch /ohol/data/mapTime.db && touch /ohol/data/meta.db && touch /ohol/data/playerStats.db && touch /ohol/data/trust.db

RUN ln -s /ohol/data/biome.db biome.db
RUN ln -s /ohol/data/curseCount.db curseCount.db
RUN ln -s /ohol/data/curses.db curses.db
RUN ln -s /ohol/data/eve.db eve.db
RUN ln -s /ohol/data/floor.db floor.db
RUN ln -s /ohol/data/floorTime.db floorTime.db
RUN ln -s /ohol/data/grave.db grave.db
RUN ln -s /ohol/data/lookTime.db lookTime.db
RUN ln -s /ohol/data/map.db map.db
RUN ln -s /ohol/data/mapTime.db mapTime.db
RUN ln -s /ohol/data/meta.db meta.db
RUN ln -s /ohol/data/playerStats.db playerStats.db
RUN ln -s /ohol/data/trust.db trust.db

WORKDIR /ohol/OneLife/server/settings
RUN mkdir /ohol/settings
RUN for file in /ohol/OneLife/server/settings/*; do mv -vn $file /ohol/settings/$(basename $file); done
RUN for file in /ohol/settings/*; do ln -s $file $(basename $file); done

WORKDIR /ohol/OneLife/server

RUN ./configure 3
RUN wget https://www.libsdl.org/release/SDL-devel-1.2.15-mingw32.tar.gz
RUN tar -xvzf SDL-devel-1.2.15-mingw32.tar.gz
RUN rm SDL-devel-1.2.15-mingw32.tar.gz
RUN ln -s ../SDL-1.2.15/include/SDL .
RUN ln -s /usr/i686-w64-mingw32/include/winsock.h Winsock.h


EXPOSE 8005

ENTRYPOINT  ["./OneLifeServer"]
