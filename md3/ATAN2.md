## atan2

### **Name**

**atan2**(3) - \[MATHEMATICS:TRIGONOMETRIC\] Arctangent (inverse tangent)
function

### **Synopsis**
```fortran
    result = atan2(y, x)
```
```fortran
     elemental real(kind=KIND) function atan2(y, x)

      real,kind=KIND)            :: atan2
      real,kind=KIND),intent(in) :: y, x
```
### **Characteristics**

 - **x** and **y** must be reals of the same kind.
 - The return value has the same type and kind as **y** and **x**.

### **Description**

  **atan2**(3) computes in radians a processor-dependent approximation of
  the arctangent of the complex number ( **x**, **y** ) or equivalently
  the principal value of the arctangent of the value **y/x** (which
  determines a unique angle).

  If **y** has the value zero, **x** shall not have the value zero.

  The resulting phase lies in the range

      -PI <= ATAN2 (Y,X) <= PI

  and is equal to a processor-dependent approximation to a value of
  arctan(Y/X).

### **Options**

- **y**
  : The imaginary component of the complex value **(x,y)** or the **y**
  component of the point **\<x,y\>**.

- **x**
  : The real component of the complex value **(x,y)** or the **x**
  component of the point **\<x,y\>**.

### **Result**

The value returned is by definition the principal value of the complex
number **(x, y)**, or in other terms, the phase of the phasor x+i\*y.

The principal value is simply what we get when we adjust a radian value
to lie between **-PI** and **PI** inclusive,

The classic definition of the arctangent is the angle that is formed
in Cartesian coordinates of the line from the origin point **\<0,0\>**
to the point **\<x,y\>** .

Pictured as a vector it is easy to see that if **x** and **y** are both
zero the angle is indeterminate because it sits directly over the origin,
so **atan(0.0,0.0)** will produce an error.

Range of returned values by quadrant:
```text
>                   +PI/2
>                     |
>                     |
>     PI/2 < z < PI   |   0 > z < PI/2
>                     |
>   +-PI -------------+---------------- +-0
>                     |
>     PI/2 < -z < PI  |   0 < -z < PI/2
>                     |
>                     |
>                   -PI/2
>
   NOTES:

   If the processor distinguishes -0 and +0 then the sign of the
   returned value is that of Y when Y is zero, else when Y is zero
   the returned value is always positive.
```
### **Examples**

Sample program:
```fortran
program demo_atan2
real    :: z
complex :: c
 !
 ! basic usage
  ! ATAN2 (1.5574077, 1.0) has the value 1.0 (approximately).
  z=atan2(1.5574077, 1.0)
  write(*,*) 'radians=',z,'degrees=',r2d(z)
 !
 ! elemental : arrays
  write(*,*)'elemental',atan2( [10.0, 20.0], [30.0,40.0] )
 !
 ! elemental : arrays and scalars
  write(*,*)'elemental',atan2( [10.0, 20.0], 50.0 )
 !
 ! break complex values into real and imaginary components
 ! (note TAN2() can take a complex type value )
  c=(0.0,1.0)
  write(*,*)'complex',c,atan2( x=c%re, y=c%im )
 !
 ! extended sample converting cartesian coordinates to polar
  COMPLEX_VALS: block
  real                :: ang, radius
  complex,allocatable :: vals(:)
  integer             :: i
 !
  vals=[ &
    !     0            45            90           135
    ( 1.0, 0.0 ), ( 1.0, 1.0 ), ( 0.0, 1.0 ), (-1.0, 1.0 ), &
    !    180           225          270
    (-1.0, 0.0 ), (-1.0,-1.0 ), ( 0.0,-1.0 ) ]
  do i=1,size(vals)
     call cartesian_to_polar(vals(i), radius,ang)
     write(*,101)vals(i),ang,r2d(ang),radius
  enddo
  101 format( 'X=',f5.2,' Y=',f5.2,' ANGLE=',g0, &
  & T38,'DEGREES=',g0.4, T54,'DISTANCE=',g0)
 endblock COMPLEX_VALS
!
contains
!
elemental real function r2d(radians)
! input radians to convert to degrees
doubleprecision,parameter :: DEGREE=0.017453292519943d0 ! radians
real,intent(in)           :: radians
   r2d=radians / DEGREE ! do the conversion
end function r2d
!
subroutine cartesian_to_polar(xy,radius,inclination)
! return angle in radians in range 0 to 2*PI
implicit none
complex,intent(in)  :: xy
real,intent(out) :: radius,inclination
   radius=abs( xy )
   ! arbitrarily set angle to zero when radius is zero
   inclination=merge(0.0,atan2(x=xy%re, y=xy%im),radius==0.0)
   ! bring into range 0 <= inclination < 2*PI
   if(inclination < 0.0)inclination=inclination+2*atan2(0.0d0,-1.0d0)
end subroutine cartesian_to_polar
!
end program demo_atan2

Results:

 >  radians=   1.00000000     degrees=   57.2957802
 >  elemental  0.321750551      0.463647604
 >  elemental  0.197395563      0.380506366
 >  complex             (0.00000000,1.00000000)   1.57079637
 > X= 1.00 Y= 0.00 ANGLE= 0.00000000  DEGREES= 0.000 DISTANCE=1.00000000
 > X= 1.00 Y= 1.00 ANGLE= 0.785398185 DEGREES= 45.00 DISTANCE=1.41421354
 > X= 0.00 Y= 1.00 ANGLE= 1.57079637  DEGREES= 90.00 DISTANCE=1.00000000
 > X=-1.00 Y= 1.00 ANGLE= 2.35619450  DEGREES= 135.0 DISTANCE=1.41421354
 > X=-1.00 Y= 0.00 ANGLE= 3.14159274  DEGREES= 180.0 DISTANCE=1.00000000
 > X=-1.00 Y=-1.00 ANGLE= 3.92699075  DEGREES= 225.0 DISTANCE=1.41421354
 > X= 0.00 Y=-1.00 ANGLE= 4.71238899  DEGREES= 270.0 DISTANCE=1.00000000

### **Standard**

FORTRAN 77

### **See Also**

- [**atan**(3)](#atan)
- [**tan**(3)](#tan)
- [**tan2**(3)](#tan2)

### **Resources**

- [arctan:wikipedia]
  (https://en.wikipedia.org/wiki/Inverse_trigonometric_functions)
 _Fortran intrinsic descriptions (license: MIT) \@urbanjost_
