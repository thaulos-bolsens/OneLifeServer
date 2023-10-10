# OneLife Server

This repository enables the OHOL Server to be run on a docker container locally.

## Requirements

1. docker (https://docs.docker.com/desktop/install/windows-install/ or https://rancherdesktop.io/)

## Instructions

1. Clone this repository

`git clone https://github.com/thaulos-bolsens/OneLifeServer.git`

`cd OneLifeServer`

2. Build server

`make build`

3. Start Server

`make start`

4. Stop Server

`make stop`

## Additional commands

1. Rebuild server (useful when a newer version comes out)

`make rebuild`

2. Bash into the container

`make bash`

## Persistence

Data is persisted in `./data`

Settings are persisted in `./settings`
