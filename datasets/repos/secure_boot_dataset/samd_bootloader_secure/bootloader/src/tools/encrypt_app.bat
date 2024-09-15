@echo off
echo encrypting app ...
del app.bin.enc
copy ..\..\..\app\src\make\build\app.bin .
python encrypt.py -f app.bin -o 0x1000
del app.bin
