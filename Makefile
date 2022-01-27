CASM = ./casm
MULINK = ./mulink
UCODE = ./ucode.bin

all:
	make dlcasm
	make build
	make test

build:
	mkdir -p lnk
	mkdir -p bin

	$(CASM) -i src/stdlib.asm -o bin/stdlibpre.o --binary --quiet --mulink lnk/stdlibpre.o.lnk --mulinksec stdlib --org 0xC000
	$(MULINK) -i bin/stdlibpre.o~lnk/stdlibpre.o.lnk --org 0xC000 -l stdlib -o bin/stdlib.lib

	$(CASM) -i src/kernmain.asm -o bin/kernmain.pre.o --binary --quiet --mulink lnk/kernmainpre.o.lnk --mulinksec kernel
	$(MULINK) -i bin/kernmain.pre.o~lnk/kernmainpre.o.lnk -i LINKONLY~bin/stdlib.lib.mulink --org 0 -o bin/kernmain.o

	util/assemblerom.py bin/kernmain.o:0 bin/stdlib.lib:0xC000 rom.bin

	xxd -g 3 -l 48 -c 12 rom.bin

test:
	$(CASM) -i rom.bin --ucrom $(UCODE) --emulate --emuprint --binary

dlcasm:
	curl -Ls "https://jenkins.i-am.cool/job/muon-casm/job/master/lastSuccessfulBuild/artifact/casm-staticlatest" -o $(CASM)
	curl -Ls "https://jenkins.i-am.cool/job/mulink/job/master/lastSuccessfulBuild/artifact/mulink" -o $(MULINK)
	#curl -Ls "https://jenkins.i-am.cool/job/muon-ucode/job/master/lastSuccessfulBuild/artifact/ucode.bin" -o $(UCODE)
	-mkdir uctemp
	curl -Ls "https://github.com/MUON-III/muon-ucode/raw/master/ucode.txt" -o uctemp/ucode.txt
	-chmod +x $(CASM) $(MULINK)
	$(CASM) -i uctemp/ucode.txt -o $(UCODE) --binary --ucode
	rm -r uctemp
