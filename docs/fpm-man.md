NAME
====

**fpm-man**(1f) - \[DEVELOPER\] output descriptions of Fortran
intrinsics (LICENSE:PD)

SYNOPSIS
========

fpm-man **NAME**(*s*) \[\[-ignorecase\]\[-**-regex**
Regular\_Expression\]\]\|\[-topic\_only\] \[-**-color**\]\[-**-demo**\]

fpm-man \[ **--help**\| **--version**\]

DESCRIPTION
===========

**fpm-man**(1) prints descriptions of Fortran intrinsics as simple flat
text.

The text is formatted in the **txt2man**(1) markdown language so one can
easily generate man-pages on ULS (Unix-Like Systems).

OPTIONS
=======

****TOPIC**(*s*)**

:   A list of Fortran intrinsic names or the special names "toc" and
    "manual" (which generate a table of contents and the entire set of
    documents respecively). The default is "toc" and to ignore case.

****--regex**,**-e****

:   Search all output per the provided Regular Expression. Output is
    prefixed with the topic it was found in.

****--itopic\_only**,**-t****

:   Only show topic names. Other switches are ignored.

****--ignorecase**,**-i****

:   Ignore case when searching for a Regular Expression.

****--demo**,**-d****

:   extract first demo program found for a topic (starting with "program
    demo\_" and ending with "end program demo\_").

****--color****

:   Use ANSI in-line escape sequences to display the text in set colors.
    Does not work with all terminal emulators or terminals. Must use the
    **-r** switch with **less**(1) for **less**(1) to display colors.

****--help****

:   Display this help and exit

****--version****

:   Output version information and exit

EXAMPLES
========

Sample commands

       fpm-man                 # list table of contents
       fpm-man -e character    # check TOC for string. try "trigo","size","complex"
       fpm-man tan|less        # display a description of tan(3f)

       fpm-man --regex ''character'' # look for string in the TOC ignoring case

       fpm-man manual>fortran.txt    # create a copy of all descriptions

       # list the topic "scan" if found and lines containing "scan" from the entire
       # manual, prefixing the lines with the section name, while ignoring case.
       fpm-man -e scan -i manual

       fpm-man -d verify >demo_verify.f90 # get sample program to try VERIFY(3f).
