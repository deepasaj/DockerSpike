#!/usr/bin/env bash

./gradlew clean shadowJar

docker build -t sajani/oraclewithseed --shm-size=1g .