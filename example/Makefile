SRCS := $(wildcard *.f90)
PROGRAMS := $(patsubst %.f90,%,$(SRCS))
#Vary the command to your liking with make FC90=f90 F90FLAGS=-g  F90LDFLAGS=-s 

FC90=ifort 
F90FLAGS=
F90LDFLAGS=

FC90=gfortran 
F90FLAGS=-std=f2018 -fcoarray=single -Wall
F90LDFLAGS=

# For this unusual case, where each executable has a single source file
# with a .f90 extension, all you need is 
.SUFFIXES: .f90

all: $(PROGRAMS)
#	echo $(SRCS)
#	echo $(PROGRAMS)
	: that is all, folks!

# The built-in default rules for make then work already
# Behind the scenes, make(1) is using the POSIX-mandated built-in single suffix rule

.f90:
	[ -s $< ] && $(FC90) $(F90FLAGS) $(LDFLAGS) $(TARGET_ARCH) -o $@ $< || echo $@ 

.phony : clean
clean:
	rm -f $(PROGRAMS) *.mod
