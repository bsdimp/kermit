1    'Use this BASIC program on the Amiga if you have the printable
2    'file CKIKER.BOO already on the Amiga to convert it to an
3    'executable file.  This program takes about an hour to run.
4    ' Bill Catchings, June 1984
5    ' Columbia University Center for Computing Activities
6    ' Amiga Support
7    ' Andy Hollander, April 1986
8    ' University of Notre Dame

20   DEFINT a-z    ' Integer to gain some speed.
30   n$ = CHR$(0)
40   z = ASC("0")
50   t = ASC("~")-z
60   DEF FNuchr%(a$)=ASC(a$)-z
70   OPEN "CKIKER.BOO" FOR INPUT AS #1

100  INPUT#1,f$    ' Is this the right file?
110  f$ = "KERMIT:" + f$
120  OPEN f$ FOR OUTPUT AS #2
130  PRINT "Outputting to "+f$

200  IF EOF(1) THEN GOTO 800  ' Exit nicely on end of file.
210  INPUT#1,x$    ' Get a line.
220  y$ = ""    ' Clear the output buffer.
230  GOTO 400

300  PRINT#2,y$;   ' Print output buffer to file.
310  GOTO 200    ' Get another line.

400  IF LEN(x$) < 2 GOTO 300  ' Is the input buffer empty?
410  a = FNuchr%(x$)
420  IF a = t THEN GOTO 700  ' Null repeat character?
430  IF LEN(x$) < 3 GOTO 300  ' Is the input buffer empty?
440  q$=MID$(x$,2,3)   ' Get the quadruplet to decode.
450  x$=MID$(x$,5)
460  b = FNuchr%(q$)
470  q$ = MID$(q$,2)
480  c = FNuchr%(q$)
490  q$ = MID$(q$,2)
500  d = FNuchr%(q$)

600  y$ = y$ + CHR$(((a * 4) + (b \ 16)) AND 255) ' Decode the quad.
610  y$ = y$ + CHR$(((b * 16) + (c \ 4)) AND 255)
620  y$ = y$ + CHR$(((c * 64) + d) AND 255)
630  GOTO 400    ' Get another quad.

700  x$ = MID$(x$,2)   ' Expand the nulls.
710  r = FNuchr%(x$)   ' Get the number of nulls.
715 PRINT " Null: ",r
720  x$ = MID$(x$,2)
730   FOR i=1 TO r   ' Loop, adding nulls to string.
740   y$ = y$ + n$
750   NEXT
760  PRINT#2,y$;   ' Output the nulls to the file.
770  y$ = ""    ' Clear the output buffer.
780  GOTO 400

800  PRINT "Processing complete!"
810  PRINT "Output in "+f$
820  CLOSE #1,#2
830  GOTO 9999

900  PRINT "?The version of the CKIKER.BOO file is incorrect"
910  GOTO 820

9999 END
