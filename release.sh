#!/bin/bash

DATE=$(date '+%y%m%d')

## Debian
for i in buster bullseye bookworm; do
  gh release create debian-$i-$DATE --notes ''
done

## Ubuntu
# for i in trusty xenial bionic focal jammy lunar mantic noble devel; do
for i in focal jammy lunar mantic noble; do
  gh release create ubuntu-$i-$DATE  --notes ''
done