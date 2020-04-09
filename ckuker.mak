# CKUKER.MAK, Version 2.00
#
# Makefile to build C-Kermit for various Unix and Unix-like systems
#
# Rename to "makefile" or "Makefile" before using, then:
#
# for Berkeley Unix 4.x, "make bsd"
# for Berkeley Unix 2.9 (PDP-11), "make bsd29"
# for AT&T 3Bx systems, "make 3bx"
# for AT&T generic System III/System V, "make sys3"
# for Bell Unix Version 7 (aka 7th Edition), "make v7"
# for Microsoft Xenix (/286, PC/AT, etc), "make xenix"
# for Interactive (PC/IX) on PC/XT, "make pcix"
# for Interactive on other systems, "make is3"
# for DEC Pro-350 with Pro/Venix V1.x, "make provx1"
# for DEC Pro-350 with Pro/Venix V2.0 (Sys V), "make sys3nid" 
# for DEC Pro-380 with Pro/Venix V2.0 (Sys V), "make sys3" or "make sys3nid"
# for NCR Tower 1632, OS 1.02, "make tower1"
#
##############################################################################
#
# Notes:
#
#  In many cases, the -O (optimize) compiler switch is omitted.  Feel free
#  to add it if you trust your optimizer.
#
#  "make bsd" should produce a working C-Kermit for both 4.1 and 4.2bsd
#  on VAX, SUN, and Pyramid computers.
#
#  "make sys3" seems to produce a working version on any ATT System III
#  or System V system, including Motorola Four Phase, Callan Unistar, Cadmus,
#  NCR Tower, HP9836 Series 200, Plexus,  Masscomp/RTU, etc etc (for
#  exceptions, see below; AT&T 3Bx systems have their own entry).
#
#  For version 7, several variables must be defined to the values
#  associated with your system.  BOOTNAME=/edition7 is the kernel image on
#  okstate's Perkin-Elmer 3230.  Others will probably be /unix.  PROCNAME=proc
#  is the name of the structure assigned to each process on okstate's system.
#  This may be "_proc" or some other variation.  See <sys/proc.h> for more info
#  on your systems name conventions.  NPROCNAME=nproc is the name of a
#  Kernal variable that tells how many "proc" structures there are.  Again
#  this may be different on your system, but nproc will probably be somewhere.
#  The variable NPTYPE is the type of the nproc variable -- int, short, etc.
#  which can probably be gleaned from <sys/param.h>.
#  The definition of DIRECT is a little more in depth.  If nlist() returns,
#  for "proc" only, the address of the array, then you should define DIRECT
#  as it is below.  If however, nlist() returns the address of a pointer to
#  the array, then you should give DIRECT a null definition (DIRECT= ).  The
#  extern declaration in <sys/proc.h> should clarify this for you.  If it
#  is "extern struct proc *proc", then you should NOT define DIRECT.  If it
#  is "extern struct proc proc[]", then you should probably define DIRECT as
#  it is below.  See ckuv7.hlp for further information.
#
#  For 2.9bsd, the makefile uses pcc rather than cc for compiles; that's what
#  the CC and CC2 definitions are for.  2.9 support basically follows the 4.2
#  path, except with a normal file system (file names 14 chars max).
#
#  The v7 and 2.9bsd versions assume I&D space on a PDP-11.  When building
#  C-Kermit for v7 on a PDP-11, you should probably add the -i option to
#  the link flags.  Without I&D space, overlays would probably have to be
#  used (or code mapping a`la Pro/Venix if that's available).
#
#  For HP9000 series 500, use "make sys3nid", but
#  1. In ckutio.c, don't #include <sys/file.h> or ioctl.h.
#  2. In ckufio.c, don't #include <sys/file.h>.
#
#  For Ridge32 (ROS3.2), use "make sys3", but
#  1. Use "CFLAGS = -DUXIII -i -O" "LNKFLAGS = -i"
#  2. Don't #include <sys/file.h> in cku[tf]io.c.
#
##############################################################################
#
#  V7-specific variables.
#  These are set up for Perkin-Elmer 3230 V7 Unix:
# 
PROC=proc
DIRECT=
NPROC=nproc
NPTYPE=int
BOOTFILE=/edition7
#
# ( For TRS-80 Xenix, use PROC=_proc, DIRECT=-DDIRECT, NPROC=_Nproc, 
#   NPTYPE=short, BOOTFILE=/xenix )
#
###########################################################################
#
#  Compile and Link variables:
#
LNKFLAGS=
CC= cc
CC2= cc
#
###########################################################################
#
make: 
	@echo 'Make what?  You must tell which system to make C-Kermit for.'

wermit: ckcmai.o ckucmd.o ckuusr.o ckuus2.o ckuus3.o ckcpro.o ckcfns.o \
		 ckcfn2.o ckucon.o ckutio.o ckufio.o ckudia.o ckuscr.o
	$(CC2) $(LNKFLAGS) -o wermit ckcmai.o ckutio.o ckufio.o ckcfns.o \
		 ckcfn2.o ckcpro.o ckucmd.o ckuus2.o ckuus3.o ckuusr.o \
		 ckucon.o ckudia.o ckuscr.o

ckcmai.o: ckcmai.c ckcker.h ckcdeb.h

ckuusr.o: ckuusr.c ckucmd.h ckcker.h ckuusr.h ckcdeb.h

ckuus2.o: ckuus2.c ckucmd.h ckcker.h ckuusr.h ckcdeb.h

ckuus3.o: ckuus3.c ckucmd.h ckcker.h ckuusr.h ckcdeb.h

ckucmd.o: ckucmd.c ckucmd.h ckcdeb.h

ckcpro.o: ckcpro.c ckcker.h ckcdeb.h

ckcpro.c: ckcpro.w wart
	./wart ckcpro.w ckcpro.c

ckcfns.o: ckcfns.c ckcker.h ckcdeb.h

ckcfn2.o: ckcfns.c ckcker.h ckcdeb.h

ckufio.o: ckufio.c ckcker.h ckcdeb.h

ckutio.o: ckutio.c ckcdeb.h

ckucon.o: ckucon.c ckcker.h ckcdeb.h

wart: ckwart.o
	$(CC) $(LNKFLAGS) -o wart ckwart.o

ckwart.o: ckwart.c

ckudia.o: ckudia.c ckcker.h ckcdeb.h

ckuscr.o: ckuscr.c ckcker.h ckcdeb.h

#Version 7 Unix
v7:
	make wermit "CFLAGS=-DV7 -DDEBUG -DTLOG -DPROCNAME=\\\"$(PROC)\\\" \
	-DBOOTNAME=\\\"$(BOOTFILE)\\\" -DNPROCNAME=\\\"$(NPROC)\\\" \
	-DNPTYPE=$(NPTYPE) $(DIRECT)"

#Berkeley Unix 4.1 or 4.2
bsd:
	make wermit "CFLAGS= -DBSD4 -DDEBUG -DTLOG"


#Berkeley Unix 2.9 for PDP-11s with I&D space
bsd29:
	make wermit "CFLAGS= -DV7 -DDEBUG -DTLOG" "LNKFLAGS= -i" "CC= pcc " \
		"CC2= cc"

#Microsoft "Xenix/286" e.g. for IBM PC/AT
xenix:
	make wermit "CFLAGS= -DXENIX -DUXIII -DDEBUG -DTLOG -F 3000 -i" \
		"LNKFLAGS = -F 3000 -i"

#PC/IX, Interactive Corp System III for IBM PC/XT
pcix:
	make wermit \
	"CFLAGS= -DPCIX -DUXIII -DISIII -DDEBUG -DTLOG -Dsdata=sdatax -O -i" \
		"LNKFLAGS = -i"

#Interactive Corp System III port in general --
is3:
	make wermit \
		"CFLAGS = -DISIII -DUXIII -DDEBUG -DTLOG -Ddata=datax -O -i" \
		"LNKFLAGS = -i"

#AT&T 3B-series computers running System V
#...only difference from sys3 is lock file stuff...
#
3bx:
	make wermit "CFLAGS = -DUXIII -D3BX -DDEBUG -DTLOG -i -O" \
		"LNKFLAGS = -i"

#plain old Bell System III or System V without strange things (with I&D space)
sys3:
	make wermit "CFLAGS = -DUXIII -DDEBUG -DTLOG -i -O" "LNKFLAGS = -i"

#plain old Bell System III or System V without strange things (no I&D space)
sys3nid:
	make wermit "CFLAGS = -DUXIII -DDEBUG -DTLOG -O" "LNKFLAGS ="

#DEC Pro-3xx with Pro/Venix V1.0 or V1.1
provx1:
	make wart "CFLAGS= -DPROVX1" "LNKFLAGS= "
	make wermit "CFLAGS = -DPROVX1 -DDEBUG -DTLOG -md780" \
		"LNKFLAGS= -u _sleep -lc -md780"

#NCR Tower 1632, OS 1.02
tower1:
	make wermit "CFLAGS = -DDEBUG -DTLOG -DTOWER1"
