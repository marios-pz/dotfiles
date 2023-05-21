#!/usr/bin/bash

jar_file="paper.jar"
jar_link="https://api.papermc.io/v2/projects/paper/versions/1.19.4/builds/538/downloads/paper-1.19.4-538.jar"

if [[ ! -f "$jar_file" ]]; then
	curl -o "$jar_file" -O $jar_link
fi

java -Xms4G -Xmx4G -jar "$jar_file" --nogui
