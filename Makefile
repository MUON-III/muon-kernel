CASM = ./casm
UCODE = ./ucode.bin

all:
	make dlcasm
	make build
	make test

build:
	mkdir -p lnk
	mkdir -p bin
	$(CASM) -i src/stdlib.asm -o bin/stdlib.o --gotout lnk/stdlib.got --org 0xC000 --binary
	$(CASM) -i src/kernmain.asm -o bin/kernmain.o --gotin lnk/stdlib.got --binary
	util/assemblerom.py bin/kernmain.o:0 bin/stdlib.o:0xC000 rom.bin
	
test:
	$(CASM) -i rom.bin --ucrom $(UCODE) --emulate --emuprint --binary

dlcasm:
	curl -Ls "https://jenkins.i-am.cool/job/muon-casm/job/master/lastSuccessfulBuild/artifact/casm-staticlatest" -o $(CASM)
	#curl -Ls "https://jenkins.i-am.cool/job/muon-ucode/job/master/lastSuccessfulBuild/artifact/ucode.bin" -o $(UCODE)
	mkdir uctemp
	curl -Ls "https://github.com/MUON-III/muon-ucode/raw/master/ucode.txt" -o uctemp/ucode.txt
	-chmod +x $(CASM)
	$(CASM) -i uctemp/ucode.txt -o $(UCODE) --binary --ucode
	rm -r uctemp