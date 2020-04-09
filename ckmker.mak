.SUFFIXES:  .b .c

MACOBJECTS = ckmsav.b ckmusr.b ckmutl.b ckmcon.b ckmtio.b ckmfio.b ckmrem.b \
		ckmsfp.b ckmscr.b ckmpro.b ckmsum.a
MACSOURCES = ckmsav.c ckmusr.c ckmutl.c ckmcon.c ckmtio.c ckmfio.c ckmrem.c \
		ckmsfp.c ckmscr.c ckmpro.c ckmsum.c
MACHEADERS = ckmres.h ckmdef.h ckmkkc.h
MACOTHER = ckmker.mak ckmker.rc ckmpro.sed

GENOBJECTS = ckcmai.b ckcfns.b ckcfn2.b
GENSOURCES = ckcmai.c ckcfns.c ckcfn2.c
GENHEADERS = ckcdeb.h ckcker.h
GENOTHER = ckcpro.c ckcpro.w

KEYSOURCES = ckmkey.c ckmke2.c ckmke3.c
KEYOBJECTS = ckmkey.b ckmke2.b ckmke3.b
KEYHEADERS = ckmkey.h ckmkkc.h
KEYOTHER = ckmkey.rc

DOCFILES = ckmker.doc ckmker.bwr ckmker.bld ckmker.upd ckmkey.upd
HQXFILES = ckmker.hqx ckmkey.hqx

MACLIB = /usr/mac/lib/
MACOPTIONS = -O -DMAC

.c.b:
	cc68 ${MACOPTIONS}  -c $<

all:	ckmker.rsrc ckmkey.rsrc
ker:	ckmker.rsrc
key:	ckmkey.rsrc

ckmker.rsrc:	ckmker.rc ckmker.out 
		rmaker ckmker.rc

ckmker.out:	${MACOBJECTS} ${GENOBJECTS}
		cc68  -o ckmker.out -z -m ${MACOBJECTS} ${GENOBJECTS}

# Make a libaray file for our own mactrap call to getitem

ckmsum.a:	ckmsum.c
		cc68 -DCODE -S ckmsum.c
		mv ckmsum.s ckmsum.sl
		cat ckmsum.sl | sed -f ${MACLIB}libmac.sed | \
		${MACLIB}libmake ckmsum.a

# Make a ckmpro.c for ourselves, use MAC only changes

ckmpro.c:	ckmpro.sed ckcpro.c
		cat ckcpro.c | sed -f ckmpro.sed > ckmpro.c

lker:
	lint -n -lmac ${MACSOURCES} ${GENSOURCES} | tee ckmker.lint

# ckmkey - kermit keyboard configurator program

lkey:	
	lint -n -lmac ${KEYSOURCES} | tee ckmkey.lint

ckmkey.rsrc:	ckmkey.rc ckmkey.out
		rmaker ckmkey.rc

ckmkey.out:	${KEYOBJECTS}
		cc68  -o ckmkey.out -z -m ${KEYSOURCES}

shar:	
	cp /usr/fdc/ck4c/ckmker.doc .
	cp Makefile ckmker.mak
	echo "This shar file contains C-Kermit generic modules" > ckmker1.shar
	echo >> ckmker1.shar
	shar ${GENSOURCES} ${GENHEADERS} ${GENOTHER} >> ckmker1.shar
	echo "This shar file contains Mac Kermit modules" > ckmker2.shar
	echo >> ckmker2.shar	
	shar ${MACSOURCES} >> ckmker2.shar
	echo "This shar file also contains Mac kermit modules" > ckmker3.shar
	echo >> ckmker3.shar
	shar ${MACHEADERS} ${MACOTHER} >> ckmker3.shar
	echo "This shar file contains Kermit\'s Keyboard Configurator"\
		 > ckmker4.shar
	echo >> ckmker4.shar
	shar ${KEYSOURCES} ${KEYHEADERS} ${KEYOTHER} >> ckmker4.shar
	echo "This shar file contains Mac Kermit documentation" > ckmker5.shar
	echo >> ckmker5.shar
	shar ${DOCFILES} >> ckmker5.shar
	echo "This shar file contains HQX files for Kermit, Mac Key"\
		 > ckmker6.shar
	echo >> ckmker6.shar
	shar ${HQXFILES} >> ckmker6.shar

