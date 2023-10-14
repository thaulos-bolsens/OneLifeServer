FROM ubuntu:22.04

# update system package
RUN apt-get update -y && apt-get upgrade -y


# install dependencies
RUN apt install git make build-essential -y


# get the latest release versions of minorGems, OneLife and OneLifeData7
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


#  build the server
WORKDIR /ohol/OneLife/server

RUN ./configure 1
RUN make
RUN ln -s ../../OneLifeData7/objects .
RUN ln -s ../../OneLifeData7/transitions .
RUN ln -s ../../OneLifeData7/categories .
RUN ln -s ../../OneLifeData7/tutorialMaps .
RUN ln -s ../../OneLifeData7/dataVersionNumber.txt .
RUN git for-each-ref --sort=-creatordate --format '%(refname:short)' --count=2 refs/tags | grep "OneLife_v" | sed -e 's/OneLife_v//' > serverCodeVersionNumber.txt
COPY run.sh run.sh


# connect to this server via localhost:8005
EXPOSE 8005


# run server
ENTRYPOINT  ["./run.sh"]
