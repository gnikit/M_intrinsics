## date_and_time

### **Name**

**date_and_time**(3) - \[SYSTEM:TIME\] Gets current date and time

### **Synopsis**
```fortran
    subroutine date_and_time(date, time, zone, values)

     character(len=8),intent(out),optional :: date
     character(len=10),intent(out),optional :: time
     character(len=5),intent(out),optional :: zone
     integer,intent(out),optional :: values(8)
```
### **Characteristics**

 - **date**, **time**, and **zone** are default _character_ scalar types
 - **values** is a rank-one array of type integer with a decimal
 exponent range of at least four.

### **Description**

  **date_and_time**(3) gets the corresponding date and time information
  from the real-time system clock.

  Unavailable time and date _character_ parameters return blanks.

  Unavailable numeric parameters return **-huge(value)**.

### **Options**

- **date**
  : A character string of default kind of the form **CCYYMMDD**, of length
    8 or larger, where

     + **CCYY** is the year in the Gregorian calendar
     + **MM** is the month within the year
     + **DD** is the day within the month.

    The characters of this value are all decimal digits.

    If there is no date available, **date** is assigned all blanks.

- **time**
  : A character string of default kind of the form **HHMMSS.SSS**,
    of length 10 or larger, where

     + **HH** is the hour of the day,
     + **MM** is the minutes of the hour,
     + and **SS.SSS** is the seconds and milliseconds of the minute.

    Except for the decimal point, the characters of this value shall
    all be decimal digits.

    If there is no clock available, **time** is assigned all blanks.

- **zone**
  : A string of the form (+-)**HHMM**, of length 5 or larger, representing
    the difference with respect to Coordinated Universal Time (UTC), where

     + **HH** and **MM** are the time difference with respect to
       Coordinated Universal Time (UTC) in hours and minutes,
       respectively.

   The characters of this value following the sign character are all
   decimal digits.

   If this information is not available, **zone** is assigned all blanks.

- **values**
  : An array of at least eight elements. If there is no data
  available for a value it is set to **-huge(values)**. Otherwise,
  it contains:

  - **values**(1) : The year, including the century.
  - **values**(2) : The month of the year
  - **values**(3) : The day of the month
  - **values**(4) : Time difference in minutes between the reported time
                    and UTC time.
  - **values**(5) : The hour of the day, in the range 0 to 23.
  - **values**(6) : The minutes of the hour, in the range 0 to 59
  - **values**(7) : The seconds of the minute, in the range 0 to 60
  - **values**(8) : The milliseconds of the second, in the range 0 to 999.

 The date, clock, and time zone information might be available on some
 images and not others. If the date, clock, or time zone information is
 available on more than one image, it is processor dependent whether or
 not those images share the same information.

### **Examples**

Sample program:

```fortran
program demo_date_and_time
   implicit none
   character(len=8)     :: date
   character(len=10)    :: time
   character(len=5)     :: zone
   integer, dimension(8) :: values

   call date_and_time(date, time, zone, values)

   ! using keyword arguments
   call date_and_time(DATE=date, TIME=time, ZONE=zone)
   print '(*(g0))','DATE="',date,'" TIME="',time,'" ZONE="',zone,'"'

   call date_and_time(VALUES=values)
   write (*, '(i5,a)') &
    & values(1), ' - The year', &
    & values(2), ' - The month', &
    & values(3), ' - The day of the month', &
    & values(4), ' - Time difference with UTC in minutes', &
    & values(5), ' - The hour of the day', &
    & values(6), ' - The minutes of the hour', &
    & values(7), ' - The seconds of the minute', &
    & values(8), ' - The milliseconds of the second'

   write (*, '(a)') iso_8601()
contains
   function iso_8601()
   ! return date using ISO-8601 format at a resolution of seconds
   character(len=8)  :: dt
   character(len=10) :: tm
   character(len=5)  :: zone
   character(len=25) :: iso_8601
   call date_and_time(dt, tm, zone)
      ISO_8601 = dt(1:4)//'-'//dt(5:6)//'-'//dt(7:8) &
               & //'T'//                             &
               & tm(1:2)//':'//tm(3:4)//':'//tm(5:6) &
               & //zone(1:3)//':'//zone(4:5)
   end function iso_8601
end program demo_date_and_time
```
Results:
```text
 > DATE="20240426" TIME="111545.335" ZONE="-0400"
 >  2024 - The year
 >     4 - The month
 >    26 - The day of the month
 >  -240 - Time difference with UTC in minutes
 >    11 - The hour of the day
 >    15 - The minutes of the hour
 >    45 - The seconds of the minute
 >   335 - The milliseconds of the second
 > 2024-04-26T11:15:45-04:00
```
### **Standard**

Fortran 95

### **See Also**

  These forms are compatible with the representations defined in ISO
  8601:2004.

  UTC is established by the International Bureau of Weights
  and Measures (BIPM, i.e. Bureau International des Poids et Mesures)
  and the International Earth Rotation Service (IERS).

  [**cpu_time**(3)](#cpu_time),
  [**system_clock**(3)](#system_clock)

### **Resources**

date and time conversion, formatting and computation

- [M_time](https://github.com/urbanjost/M_time) - https://github.com/urbanjost/M_time
- [fortran-datetime](https://github.com/dongli/fortran-datetime) - https://github.com/dongli/fortran-datetime
- [datetime-fortran](https://github.com/wavebitscientific/datetime-fortran) - https://github.com/wavebitscientific/datetime-fortran

 _Fortran intrinsic descriptions (license: MIT) \@urbanjost_
