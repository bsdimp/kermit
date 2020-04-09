Date:     Wed, 16 Jul 86 16:22 N
From:        <MAESSEN%HWALHW5.BITNET@WISCVM.ARPA>
Subject:  Amiga Kermit

As I tried to install the Amiga Kermit I found out there was no real
solution for the bootstrap procedure: How could I get the CKIBOO.BAS
and CKIKER.BOO files on our Amiga?

One of the problems was, that if I used a simple BASIC program, buffer
overflows occurred and there was no reliable stop criterium.

That's why I wrote two programs, one for our Vax and one BASIC program
for the Amiga which can do the job.

Here they are:

1. The FORTRAN program (CKIBOO.FOR) for the VAX:

        CHARACTER*76    line
        CHARACTER*4     answer

        OPEN(UNIT=8,FILE='CKIKER.BOO',STATUS='OLD')
1       READ(8,'(Q,A)',END=99) l,line
        IF ( l .EQ. 0 ) GOTO 1
        ichk=0
        DO i=1,l
          ichk=ichk+ICHAR(line(i:i))
        END DO
2       TYPE *,line(:l)
        TYPE *,ichk
        ACCEPT '(Q,A)', la,answer
        IF ( answer(:la) .EQ. 'ACK') GOTO 1
        GOTO 2
99      TYPE *,'Einde'
        CLOSE(UNIT=8)
        END

2. The AMIGA Basic program (CKIGET.BAS ?):


OPEN "COM1:2400,e,7,1" AS #1
OPEN "ckiker.boo" FOR OUTPUT AS #2
PRINT#1,"run send"
INPUT#1,echo$
PRINT echo$
INPUT#1,echo$
PRINT echo$
n%=0
Newline:
INPUT#1,s$
l=LEN(s$)
IF l = 0 THEN GOTO Newline
IF LEFT$(s$,5)  = "Einde" THEN GOTO QuitProgram
n%=n%+1
INPUT#1,echo$
INPUT#1,jchk$
jchk=VAL(jchk$)
ichk=0
FOR i= 1 TO l
   ichk=ichk+ASC(MID$(s$,i,1))
NEXT i
PRINT "Checksum:","Amiga:";ichk;"Host:";jchk
IF ichk = jchk THEN GOTO Ok
PRINT#1,"NACK"
PRINT "NACK sent"
GOTO Newline
Ok:
  PRINT#2,s$
  PRINT#1,"ACK"
  GOTO Newline
QuitProgram: PRINT s$
     CLOSE #1
     CLOSE #2
END

The way to do it is:

On the Vax: $ FOR CKIBOO
            $ LINK CKIBOO
            $ SET TERM/NOANSI
            $ SET TERM/NOECHO

Enter the Amiga Basic program by hand and start it. It will start the
CKIBOO.EXE on the Vax.

I'm sure the same will work on other machines too. Take care that there's
no echo and no terminal control chars.

W. Maessen
Agricultural University,
Wageningen, The Netherlands

P.S.

I didn't have the time to create a composite program which combines
CKIBOO.BAS and this Amiga Basic program, but it sure would save some time.
