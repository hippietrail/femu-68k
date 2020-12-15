SRCDIR	= src
OBJDIR	= obj
BINDIR	= bin
SRCFILES = $(wildcard src/*.ASM) $(wildcard src/ops/*.ASM) $(wildcard src/utils/*.ASM)
ASM = vasmm68k_mot_os3 -Fhunk -I$(SRCDIR) 
LINK = vlink -S -s

all: femu

femu: femu.020 femu.040

femud: femu.020d femu.040d

femu.020: $(SRCFILES)
	$(ASM) -m68020 -DSTACK020 -o $(OBJDIR)/$@.o $(SRCDIR)/femu.asm 
	$(LINK) -bamigahunk -o $(BINDIR)/$@ $(OBJDIR)/$@.o 
	
femu.020d: $(SRCFILES)
	$(ASM) -m68020 -DSTACK020 -DDEBUG -o $(OBJDIR)/$@.o $(SRCDIR)/femu.asm 
	$(LINK) -bamigahunk -o $(BINDIR)/$@ $(OBJDIR)/$@.o -ldebug
	
femu.040: $(SRCFILES)
	$(ASM) -m68020 -DSTACK040 -DSTACKEA -o $(OBJDIR)/$@.o $(SRCDIR)/femu.asm 
	$(LINK) -bamigahunk -o $(BINDIR)/$@ $(OBJDIR)/$@.o
	
femu.040d: $(SRCFILES)
	$(ASM) -m68020 -DSTACK040 -DSTACKEA -DDEBUG -o $(OBJDIR)/$@.o $(SRCDIR)/femu.asm 
	$(LINK) -bamigahunk -o $(BINDIR)/$@ $(OBJDIR)/$@.o -ldebug
	
genccc: $(SRCFILES)
	vasmm68k_mot_os3 -m68020 -m68881 -Fhunkexe $(SRCDIR)/$@.ASM -o $(BINDIR)/$@
	
gentruth: $(SRCFILES)
	vasmm68k_mot_os3 -m68020 -m68881 -Fhunkexe $(SRCDIR)/$@.ASM -o $(BINDIR)/$@
	
fdebug: $(SRCFILES)
	$(ASM) -m68040 -m68881 -no-opt -o $(OBJDIR)/$@.o $(SRCDIR)/fdebug.asm 
	$(LINK) -bamigahunk -o $(BINDIR)/$@ $(OBJDIR)/$@.o
	
ftest: $(SRCFILES)
	$(ASM) -m68040 -m68881 -no-opt -o $(OBJDIR)/$@.o $(SRCDIR)/ftest.asm 
	$(LINK) -bamigahunk -o $(BINDIR)/$@ $(OBJDIR)/$@.o
	
clean:
	delete '$(OBJDIR)/#?' '$(BINDIR)/#?'

force: