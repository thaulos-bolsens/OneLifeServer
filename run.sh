#!/bin/sh

# create sqlite files on /ohol/data
#   these files will be available under ./data on this repository
mkdir /ohol/data
touch /ohol/data/biome.db && touch /ohol/data/curseCount.db && touch /ohol/data/curses.db && touch /ohol/data/eve.db && touch /ohol/data/floor.db && touch /ohol/data/floorTime.db && touch /ohol/data/grave.db && \
    touch /ohol/data/lookTime.db && touch /ohol/data/map.db && touch /ohol/data/mapTime.db && touch /ohol/data/meta.db && touch /ohol/data/playerStats.db && touch /ohol/data/trust.db
ln -s /ohol/data/biome.db biome.db
ln -s /ohol/data/curseCount.db curseCount.db
ln -s /ohol/data/curses.db curses.db
ln -s /ohol/data/eve.db eve.db
ln -s /ohol/data/floor.db floor.db
ln -s /ohol/data/floorTime.db floorTime.db
ln -s /ohol/data/grave.db grave.db
ln -s /ohol/data/lookTime.db lookTime.db
ln -s /ohol/data/map.db map.db
ln -s /ohol/data/mapTime.db mapTime.db
ln -s /ohol/data/meta.db meta.db
ln -s /ohol/data/playerStats.db playerStats.db
ln -s /ohol/data/trust.db trust.db


# move ini files to /ohol/settings
#   these files will be available under ./settings on this repository
cd /ohol/OneLife/server/settings

mkdir /ohol/settings
for file in /ohol/OneLife/server/settings/*; do mv -nv $file /ohol/settings/$(basename $file); echo $(basename $file); done
rm /ohol/OneLife/server/settings/*
for file in /ohol/settings/*; do ln -s $file $(basename $file); done

cd /ohol/OneLife/server

./OneLifeServer
