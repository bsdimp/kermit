/*  C K I S T U  --  Stubs for functions not yet implemented on Amiga */
 
/*
 Author: Jack Rouse
 Contributed to Columbia University for inclusion in C-Kermit.
 Copyright (C) 1986, Jack J. Rouse, 106 Rubin Ct. Apt. A-4, Cary NC 27511
 Permission is granted to any individual or institution to use, copy, or
 redistribute this software so long as it is not sold for profit, provided this
 copyright notice is retained. 
*/

#include "ckcdeb.h"
#include <stdio.h>
#include <ctype.h>
#include "ckcker.h"
#include "ckucmd.h"

char *dialv = "Dial Command unimplemented";
struct keytab mdmtab[] = {
	"direct", 	0, 	0,	/* no modem control */
	"generic", 	1, 	0	/* use 7 wire modem control */
};

int nmdm = sizeof(mdmtab) / sizeof(struct keytab);
 
dial()
{
	printf("Sorry, DIAL command not implemented yet.\n");
	return(-2);
}

char *loginv = "Script Command unimplemented";
login()
{
	printf("Sorry, SCRIPT command not implemented yet\n");
	return(-2);
}
