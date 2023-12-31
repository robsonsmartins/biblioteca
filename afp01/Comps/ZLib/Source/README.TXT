-- notes ---------------------------------------------------------------------

  the zlibex.pas unit included in this archive will work with both delphi
  5 and delphi 6.  if you previously downloaded my delphi 5 unit, you
  will notice that the unit has been renamed.  this was done because
  borland included in its lib directory a zlib.dcu file; and i felt it
  was more correct to rename my unit and force developers to have to
  update their code than to make developers worry about the possible
  file contention in delphi 6.

  please contact me if you find any errors, make any changes, add new
  functionality, or have any general suggestions so that i may incorporate
  them into my version.  i can be reached via my website at
  http://www.base2ti.com.

  thanks.

-- acknowledgements ----------------------------------------------------------

  this unit includes some enhancements and recommendations from erik turner.
  (i apologize for the delay in getting these in here.)

-- installation --------------------------------------------------------------

  first, copy all of the files into a folder (for example, c:\delphi\zlib).
  next, include the folder in the library path in the environment options.
  finally, "use" the zlibex unit as needed.

-- contents ------------------------------------------------------------------

  delphi 5/6 files

    zlibex.pas

  objects files used by zlibex.pas

    adler32.obj
    infutil.obj
    deflate.obj
    infblock.obj
    infcodes.obj
    inffast.obj
    inflate.obj
    inftrees.obj
    trees.obj

  c++ Builder 5 files

    delphizlib.bpr
    delphizlib.cpp

  zlib 1.1.3 source files (http://www.info-zip.org/pub/infozip/zlib)

    adler32.c
    compress.c
    crc32.c
    deflate.c
    gzio.c
    infblock.c
    infcodes.c
    inffast.c
    inflate.c
    inftrees.c
    infutil.c
    maketree.c
    minigzip.c
    trees.c
    uncompr.c
    zutil.c
    deflate.h
    infblock.h
    infcodes.h
    inffast.h
    inffixed.h
    inftrees.h
    infutil.h
    trees.h
    zconf.h
    zlib.h
    zutil.h

