#!/bin/sh
echo encrypting app ...
rm -f app.bin.enc
cp ../../../app/src/make/build/app.bin .
python encrypt.py -f app.bin -o 0x1000
rm app.bin
