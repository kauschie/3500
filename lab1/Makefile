#  NAME: Michael Kausch
#   ASGT: Activity 1
#   ORGN: CSUB - CMPS 3500
#   FILE: Makefile
#   DATE: 02/05/2023
#
# Makefile: 
#        It uses the GNU C++ Compiler with debugging
#        will create executalbe for 2 programs called clock1 and clock2
# ----------------------------------------------------------------------
# 
# the compiler
CPP = g++ 
#
# compiler flags
CFLAGS = -L/usr/lib/cmplrs/cxx -DPOSIX_4D9   -w -g
#
# this linker flag will link in the math library libm.a 
LFLAGS = -lm
#
RM = rm -f
#
# -----------------------------------------------------------------------
# Explanation of macros:
#     $< is any dependent file which is out of file1
#     $@ is the target's fullname
#
# add suffix .cpp since it is not a default with make utility 
.SUFFIXES:	.cpp .o
#
#
all:	fixme fixed
#
#clock1:	clock1.cpp 
#	g++ -g -o clock1 clock1.cpp 
#
#clock2:	clock2.cpp 
#	g++ -g -o clock2 clock2.cpp 
#
fixme:	fixme.cpp
	$(CPP) $(CFLAGS) -o $@ $<

fixed:	fixed.cpp
	$(CPP) $(CFLAGS) -o $@ $<

clean:
	$(RM) fixme fixed
