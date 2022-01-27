@ECHO OFF
util\casm.exe -i src\stdlib.asm -o bin\stdlib.o --gotout lnk\stdlib.got --org 0xC000 --binary --quiet
util\casm.exe -i src\kernmain.asm -o bin\kernmain.o --gotin lnk\stdlib.got --binary --quiet 
python3 util\assemblerom.py bin\kernmain.o:0 bin\stdlib.o:0xC000 rom.bin
util\casm.exe -i rom.bin --ucrom util\ucode.bin --emulate --binary --emuprint