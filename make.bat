@ECHO OFF
util\casm.exe -i src/stdlib.asm -o bin/stdlibpre.o --binary --quiet --mulink lnk/stdlibpre.o.lnk --mulinksec stdlib --org 0xC000
util\mulink.exe -i bin/stdlibpre.o~lnk/stdlibpre.o.lnk --org 0xC000 -l stdlib -o bin/stdlib.lib
util\casm.exe -i src/kernmain.asm -o bin/kernmain.pre.o --binary --quiet --mulink lnk/kernmainpre.o.lnk --mulinksec kernel
util\mulink.exe -i bin/kernmain.pre.o~lnk/kernmainpre.o.lnk -i LINKONLY~bin/stdlib.lib.mulink --org 0 -o bin/kernmain.o
python3 util/assemblerom.py bin/kernmain.o:0 bin/stdlib.lib:0xC000 rom.bin
util\casm.exe -i rom.bin --ucrom util\ucode.bin --emulate --binary --emuprint
