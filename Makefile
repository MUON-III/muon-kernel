CASM = ./casm
UCODE = ./ucode.bin

all:
	make dlcasm
	make build
	make test

build:
	$(CASM) -i kernmain.asm -o kernmain.o
	
test:
	$(CASM) -i kernmain.o --ucrom $(UCODE) --emulate --emuprint

dlcasm:
	curl -Ls "https://jenkins.i-am.cool/job/muon-casm/job/master/lastSuccessfulBuild/artifact/casm-staticlatest" -o $(CASM)
	curl -Ls "https://jenkins.i-am.cool/job/muon-ucode/job/master/lastSuccessfulBuild/artifact/ucode.bin" -o $(UCODE)
	-chmod +x $(CASM)
