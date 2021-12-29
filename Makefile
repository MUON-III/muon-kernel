CASM = ./casm

all:
	make dlcasm
	$(CASM) -i kernmain.asm -o kernmain.o
	$(CASM) -i kernmain.o --emulate --fetchucode --emuprint

dlcasm:
	curl -Ls "https://jenkins.i-am.cool/job/muon-casm/job/master/lastSuccessfulBuild/artifact/casm-staticlatest" -o $(CASM)
	-chmod +x $(CASM)
