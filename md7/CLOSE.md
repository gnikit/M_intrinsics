## close

### **Name**
   CLOSE(7f) - [FORTRAN:IO] terminate the connection of a specified unit
   to an external file.
   
### **Synopsis**
```fortran
   CLOSE ( [UNIT= ] file-unit-number,

    [IOSTAT= scalar-int-variable,]
    [IOMSG= iomsg-variable,] 
    [ERR= label,] 
    [STATUS= scalar-default-char-expr]
   )
```
### **Description**

   The CLOSE statement is used to terminate the connection of a specified
   unit to an external file.

   Execution of a CLOSE statement for a unit may occur in any program
   unit of a program and need not occur in the same program unit as the
   execution of an OPEN statement referring to that unit.

   Execution of a CLOSE statement performs a wait operation for any
   pending asynchronous data transfer operations for the specified unit.

   Execution of a CLOSE statement specifying a unit that does not exist or
   has no file connected to it is permitted and affects no file or unit.

   After a unit has been disconnected by execution of a CLOSE statement,
   it may be connected again within the same program, either to the same
   file or to a different file. After a named file has been disconnected
   by execution of a CLOSE statement, it may be connected again within
   the same program, either to the same unit or to a different unit,
   provided that the file still exists.

   The input/output statements are the OPEN, CLOSE, READ, WRITE, PRINT,
   BACKSPACE, ENDFILE, REWIND, FLUSH, WAIT, and INQUIRE statements.

   OPEN, CLOSE, BACKSPACE, ENDFILE, and REWIND statements shall not be
   executed while a parent data transfer statement is active.

   A pure subprogram shall not contain a print-stmt, open-stmt,
   close-stmt, backspace-stmt, endfile-stmt, rewind-stmt, flush-stmt,
   wait-stmt, or inquire-stmt.

   The READ statement is a data transfer input statement. The
   WRITE statement and the PRINT statement are data transfer output
   statements. The OPEN statement and the CLOSE statement are file
   connection statements. The INQUIRE statement is a file inquiry
   statement. The BACKSPACE, ENDFILE, and REWIND statements are file
   positioning statements.

   All input/output statements may refer to files that exist. An INQUIRE,
   OPEN, CLOSE, WRITE, PRINT, REWIND, FLUSH, or ENDFILE statement
   also may refer to a file that does not exist. Execution of a WRITE,
   PRINT, or ENDFILE statement referring to a preconnected file that
   does not exist creates the file. This file is a different file from
   one preconnected on any other image.

   AT PROGRAM TERMINATION
   During the completion step of termination of execution of a program,
   all units that are connected are closed. Each unit is closed with
   status KEEP unless the file status prior to termination of execution
   was SCRATCH, in which case the unit is closed with status DELETE.

   The effect is as though a CLOSE statement without a STATUS=
   specifier were executed on each connected unit.

### **Options**
  No specifier shall appear more than once in a given close-spec-list.

  UNIT=file-unit-number
  : A file-unit-number shall be specified in a close-spec-list; if the
    optional characters UNIT= are omitted, the file-unit-number shall
    be the first item in the close-spec-list.
  IOSTAT=scalar-int-variable
  : 0 means no error occurred
  IOMSG=iomsg-variable
  : Character variable to hold message if an error occurred.
  ERR=label
  : The label used in the ERR= specifier shall be the statement label
    of a branch target statement that
    appears in the same scoping unit as the CLOSE statement.
  STATUS=scalar-default-char-expr
  : The expression has a limited list of
    character values. Any trailing blanks are ignored. The value specified
    is without regard to case.

    The scalar-default-char-expr shall evaluate to KEEP or DELETE. The
    STATUS= specifier determines the disposition of the file that
    is connected to the specified unit. KEEP shall not be specified
    for a file whose status prior to execution of a CLOSE statement
    is SCRATCH. If KEEP is specified for a file that exists, the file
    continues to exist after the execution of a CLOSE statement. If KEEP
    is specified for a file that does not exist, the file will not exist
    after the execution of a CLOSE statement. If DELETE is specified,
    the file will not exist after the execution of a CLOSE statement. If
    this specifier is omitted, the default value is KEEP, unless the
    file status prior to execution of the CLOSE statement is SCRATCH,
    in which case the default value is DELETE.

### **Examples**
sample program:

   program demo_close
   implicit none
   character(len=256) :: message
   integer            :: ios
      open (10, file='employee.names', action='read', iostat=ios,iomsg=message)
      if (ios < 0) then
         ! perform end-of-file processing on the file connected to unit 10.

         close (10, status='keep',iostat=ios,iomsg=message)
         if(ios.ne.0)then
            write(*,'(*(a))')'*demo_close* close error: ',trim(message)
            stop 1
         endif
      elseif (ios > 0) then
         ! perform error processing on open
         write(*,'(*(a))')'*demo_close* open error: ',trim(message)
         stop 2
      endif
   end program demo_close
```
### **See Also**

[**backspace**(3)](#backspace),
[**close**(3)](#close),
[**endfile**(3)](#endfile),
[**flush**(3)](#flush),
[**inquire**(3)](#inquire),
[**open**(3)](#open),
[**print**(3)](#print),
[**read**(3)](#read),
[**rewind**(3)](#rewind),
[**wait**(3)](#wait),
[**write**(3)](#write)
