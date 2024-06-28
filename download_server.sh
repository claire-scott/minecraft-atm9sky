#!/bin/sh

FORGE_VERSION=1.20.1-47.2.20

# URL to the modded Minecraft server jar file
#SERVER_URL="https://edge.forgecdn.net/files/5478/251/server-1.0.6.zip"
SERVER_URL="https://mediafilez.forgecdn.net/files/5478/251/server-1.0.6.zip"

mkdir /server
cd /server

rm -fr config defaultconfigs kubejs mods packmenu *.zip forge*
curl -Lo 'server-1.0.6.zip' $SERVER_URL || exit 9
unzip -u -o 'server-1.0.6.zip' -d /server
if [[ -d $(echo server-1.0.6.zip | sed 's/.zip//') ]]; then
	mv -f $(echo server-1.0.6.zip | sed 's/.zip//')/* /server
	rm -fr $(echo server-1.0.6.zip | sed 's/.zip//')
fi
curl -Lo forge-${FORGE_VERSION}-installer.jar http://files.minecraftforge.net/maven/net/minecraftforge/forge/$FORGE_VERSION/forge-$FORGE_VERSION-installer.jar
java -jar forge-${FORGE_VERSION}-installer.jar --installServer

sed -i 's/server-port.*/server-port=25565/g' server.properties
chmod 755 startserver.sh