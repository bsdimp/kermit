26-Mar-86 14:25:12-EST,2680;000000000001
Received: from CUVMA by CU20B with HASP; 26 Mar 86 14:25:08 EST
Received: from UORDBV(DPVC) by CUVMA (Mailer X1.23a) id 7646;
          Wed, 26 Mar 86 14:24:12 EST
Date: 26 MAR 86 14:22-EST
From: DPVC@UORDBV
To: SY.FDC@CU20B.COLUMBIA.EDU
Subject: Adding the fonts to MacKermit


Frank:

Well, we're getting there!  The only thing left to do is to out the VT100
fonts and the mouse cursor (used by mouse movement mode) into the resource
fork of the file.  I am sending you a HQX version of a file that contains
only the fonts and the cursor resource.  This will make it easier to add
them to the final product.  You ask if these can be added to the resource
source file.  Technically, yes, but I don't know hoe to decompile a font
(origianally made it by hand, in the Resource Editor).  The cursor resource
is just a temporary patch until I find out how to get HideCurosr and
ShowCursor to work (I have an idea about it now that I've been using C for a
while).  If I can get rid of the cursor, that leaves only the fonts to
worry about.  It would be possible to send them out in hexified format and
have the users place them in their system folder with FONT/DA MOVER.  This
would work, but I don't think it's the best way, because the fonts would
appear in MACWRITE font menus, for instance, and if you ran MacKermit on
a system without the font, you'd see the same small font that you saw.

I think that the following procedure is easy enough that most people who
are going to be recompiling the sources should be able to follow it;
therefor, I suggest that you send the CKMFNT.HQX as part of the MacKermit
source distribution.

Procedure:

        1)  Move the CKMFNT.HQX file to the Mac, and use BINHEX to de-hex
            it.  You will get a file called CKMFNT.RSRC.

        2)  Open the Resource Editor application so that it is showing the
            disk that contains the CKMFNT.RSRC and MACKERMIT files.

        3)  Open the CKMFNT.RSRC file (double click it).  You should
            see two resource types listed:  CURS and FONT.

        4)  Hold down the command key and drag accross both resources.
            Both should be selected.

        5)  Choose COPY from the EDIT menu.

        6)  Close the CKMFNT.RSRC file.

        7)  Open the MACKERMIT file.

        8)  Choose PASTE from the EDIT menu.

        9)  Close the MACKERMIT file.  You will be asked whether you want
            to save the changes  to the file.  Click YES.

       10)  QUIT from the Resource Editor.


That's it.  Not too hard, really.  I hope this is last of the problems!

                                Davide

