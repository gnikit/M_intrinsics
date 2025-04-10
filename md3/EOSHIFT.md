## eoshift

### **Name**

**eoshift**(3) - \[ARRAY:TRANSFORMATIONAL\] End-off shift of elements of an array

### **Synopsis**
```fortran
  result = eoshift( array, shift [,boundary] [,dim] )
```
```fortran
   type(TYPE(kind=KIND)) function eoshift(array,shift,boundary,dim)

    type(TYPE(kind=KIND)),intent(in) :: array(..)
    integer(kind=**),intent(in)      :: shift(..)
    type(TYPE(kind=KIND)),intent(in) :: boundary(..)
    integer(kind=**),intent(in)      :: dim
```
### **Characteristics**

 - **array** an array of any type
 - **shift** is an integer of any kind. It may be a scalar.
   If the rank of **array** is greater than one, and **dim** is
   specified it is the same shape as **array** reduced by removing
   dimension **dim**.
 - **boundary** May be a scalar of the same type and kind as **array**.
   It must be a scalar when **array** has a rank of one. Otherwise, it
   may be an array of the same shape as **array** reduced by dimension
   **dim**. It may only be absent for certain types, as described below.
 - **dim** is an integer of any kind. It defaults to one.
 - the result has the same type, type parameters, and shape as **array**.
 - a kind designated as ** may be any supported kind for the type

 - The result is an array of same type, kind and rank as the **array**
   argument.

### **Description**

  **eoshift**(3) performs an end-off shift on elements of **array**
  along the dimension of **dim**.

  Elements shifted out one end of each rank one section are dropped.

  If **boundary** is present then the corresponding value from
  **boundary** is copied back in the other end, else default values
  are used.

### **Options**

- **array**
  : array of any type whose elements are to be shifted.
  If the rank of **array** is one, then all elements of **array** are
  shifted by **shift** places. If rank is greater than one, then all
  complete rank one sections of **array** along the given dimension
  are shifted.

- **shift**
  : the number of elements to shift. A negative value shifts to the
  right, a positive value to the left of the vector(s) being shifted.

- **boundary**
  : the value to use to fill in the elements vacated by the shift.
  If **boundary** is not present then the following are copied in
  depending on the type of **array**.
```text
    Array Type    | Boundary Value
    -----------------------------------------------------
    Numeric       | 0, 0.0, or (0.0, 0.0) of the type and kind of "array"
    Logical       | .false.
    Character(len)|  LEN blanks
```
  These are the only types for which **boundary** may not be present.
  For these types the kind is converted as neccessary to the kind of
  **array**.
- **dim**
  :  **dim** is in the range of
```fortran
    1 <= DIM <= n
```
  where **"n"** is the rank of **array**. If **dim** is omitted it
  is taken to be **1**.

### **Result**

 Returns an array of the same characteristics as the input with the
 specified number of elements dropped off along the specified direction
 indicated, backfilling the vacated elements with a value indicated by
 the **boundary** value.

### **Examples**

Sample program:

```fortran
program demo_eoshift
implicit none
integer, dimension(3,3) :: a
integer :: i

   write(*,*)'original'
   a = reshape( [ 1, 2, 3, 4, 5, 6, 7, 8, 9 ], [ 3, 3 ])
   call printi(a)

   write(*,*)'shift each row differently'
   a = eoshift(a, SHIFT=[1, 2, -2], BOUNDARY=-5, DIM=2)
   call printi(a)

   write(*,*)'shift each column differently'
   a = eoshift(a, SHIFT=[1, 2, -2], BOUNDARY=-5, DIM=1)
   call printi(a)

   write(*,*)'original'
   call printi(reshape([(i,i=1,12)],[3,4]))
   write(*,'(*(g0))')'shift=+2,dim=1'
   call printi(eoshift(reshape([(i,i=1,12)],[3,4]),+2,dim=1))
   write(*,'(*(g0))')'shift=+2,dim=2'
   call printi(eoshift(reshape([(i,i=1,12)],[3,4]),+2,dim=2))
   write(*,'(*(g0))')'shift=-2,dim=1'
   call printi(eoshift(reshape([(i,i=1,12)],[3,4]),-2,dim=1))
   write(*,'(*(g0))')'shift=-2,dim=2'
   call printi(eoshift(reshape([(i,i=1,12)],[3,4]),-2,dim=2))
contains
subroutine printi(arr)
!@(#) print small 2d integer arrays in row-column format
integer,intent(in) :: arr(:,:)
integer            :: i
character(len=40)  :: biggest
   write(biggest,'(*(g0))')'(1x,*(i',                   &
   & ceiling(log10(max(1.0,real(maxval(abs(arr))))))+2, &
   & ':,","))'
   do i=1,size(arr,dim=1)
      write(*,fmt=biggest)arr(i,:)
   enddo
end subroutine printi

end program demo_eoshift
```
Results:
```text
 >  original
 >    1,  4,  7
 >    2,  5,  8
 >    3,  6,  9
 >  shift each row differently
 >    4,  7, -5
 >    8, -5, -5
 >   -5, -5,  3
 >  shift each column differently
 >    8, -5, -5
 >   -5, -5, -5
 >   -5, -5, -5
 >  original
 >     1,   4,   7,  10
 >     2,   5,   8,  11
 >     3,   6,   9,  12
 > shift=+2,dim=1
 >     3,   6,   9,  12
 >     0,   0,   0,   0
 >     0,   0,   0,   0
 > shift=+2,dim=2
 >     7,  10,   0,   0
 >     8,  11,   0,   0
 >     9,  12,   0,   0
 > shift=-2,dim=1
 >    0,  0,  0,  0
 >    0,  0,  0,  0
 >    1,  4,  7, 10
 > shift=-2,dim=2
 >    0,  0,  1,  4
 >    0,  0,  2,  5
 >    0,  0,  3,  6
```
### **Standard**

Fortran 95

### **See Also**

[**dshiftr**(3)](#dshiftr),
[**dshiftl**(3)](#dshiftl)

 _Fortran intrinsic descriptions (license: MIT) \@urbanjost_
