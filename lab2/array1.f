C ********************************************************************
C * EXAMPLE OF A FORTRAN PROGRAM
C * CMPS 3500
C ********************************************************************
C Demonstrates use of arrays for data analysis-max, min, and
C average and use of formatted output.
      IMPLICIT NONE
C
C     Declare A, B, and C to be arrays each containing 10 elements
C
      REAL A(10),B(10),C(10)
      INTEGER I
C
C     A, B, and C could have been declared arrays in the REAL statement
C     below  as "      REAL CSUM,CMAX,CMIN,AVERAGE,A(10),B(10),C(10)"
C
      REAL CSUM,CMAX,CMIN,AVERAGE
C
C     The DATA statement below as a way of initializing
C     A and B.  Note that the values are loaded into A and B at Compile
C     time, and involve no computational work when the program is executed.
C
      DATA  A/1.,2.,3.,4.,5.,6.,7.,8.,9.,10./,B/3*1.,4*2.,3*3./
C
C     Now we set up a loop to set each element of C to be the sum of the
C     corresponding elements in A and B.  At the same time we will be summing
C     the elements in C to get an average value, and obtaining the maximum
C     and minimum values of all elements in C.
C
      CSUM=0.
      CMAX=-1.E38
      CMIN=1.E38

      DO 100 I=1,10
         C(I)=A(I)+B(I)

         CMAX=MAX(C(I),CMAX)
         CMIN=MIN(C(I),CMIN)
         CSUM=CSUM+C(I)
 100  CONTINUE
      AVERAGE=CSUM/10
C
C     The next write statement illustrates use of * for the unit number.
C     It represents the default unit, which is the terminal.
C
      WRITE(*,*) ' RESULTS FOR FULL C ARRAY'
C
C     The format associated with the following write spreads the output
C     of the three values (AVERAGE, CMIN, and CMAX) over 3 output lines.
C
      WRITE(6,2000)AVERAGE,CMIN,CMAX
c
 2000 FORMAT(' AVERAGE OF ALL ELEMENTS IN C = ', F8.3,/,
     &       ' MINIMUM OF ALL ELEMENTS IN C = ', F8.3,/,
     &       ' MAXIMUM OF ALL ELEMENTS IN C = ', F8.3)
C
C     Look carefully at the results of the following formatted write.  After
C     the first 8 elements of C are printed on one line, the end of the format
C     specification is reached, so a new line is started.  Format information
C     for the remaining 2 elements is obtained by looping back to the last left
C     parenthesis and in this case reusing the 8E10.2 format.  Fortran is
C     undisturbed by the fact that you run out of elements in C before you use
C     all of the 8E10.2.  It just stops writing, and moves on to the next
C     statement in the program.
C
      WRITE(6,2001) C
 2001 FORMAT(' C = ',/,(8E10.2))
C
C     Often you do not want to work with all elements of an array.  This is
C     simple for our case.  The bounds on "I" are simply altered in the DO
C     statement.
C
      CSUM=0.
      CMAX=-1.E38
      CMIN=1.E38
      C(1)=0.
      C(10)=0.

      DO 200 I=2,9
         C(I)=A(I)+B(I)
         CMAX=MAX(C(I),CMAX)
         CMIN=MIN(C(I),CMIN)
         CSUM=CSUM+C(I)
  200 CONTINUE

      AVERAGE=CSUM/8
C
C     Below is another example of imbedding a format in a WRITE statement.
C     Note the effect of the double slashes (//).  Also note the doubled
C     single quotes surrounding the character string "RESULTS FOR EL...".
C     This practice is necessary when using a quoted character string within
C     another quoted string.
C
      WRITE(*,'(//,'' RESULTS FOR ELEMENTS 2 THROUGH 9 OF C'')')
C
      WRITE(6,2002)AVERAGE,CMIN,CMAX
 2002 FORMAT(' AVERAGE OF SELECTED ELEMENTS IN C = ', F8.3,/,
     &       ' MINIMUM OF SELECTED ELEMENTS IN C = ', F8.3,/,
     &       ' MAXIMUM OF SELECTED ELEMENTS IN C = ', F8.3)
c
C     The write below is an example of the use of what is called an implied
C     do loop.  In this case it is equivalent to using:
C     WRITE(6,2003)C(1),C(2),C(3),C(4),C(5),C(6),C(7),C(8),C(9)
C     Included a "1P" here, but didn't the first time we printed C.  Note
C     the difference.
c
      WRITE(6,2003) (C(I),I=2,9)
 2003 FORMAT(' C = ',/,(1P,8E10.2))
C
C     Very frequently it is necessary to take special action depending on the
C     value of an array elements.  No real surprises here, but take a look at
C     how this is handled in "array2.f".
C     To see what Fortran does if you replace "LOG(A(I))" with "LOG(I)".
C     For intrinsic functions it warns you if you mess up argument types.
C
      A(4)=-1.0
      DO 300 I=1,10
         IF(A(I).GT.1.0) THEN
                C(I)=LOG(A(I))
         ELSE
            C(I)=0.
         ENDIF
  300    CONTINUE
C
C     Another way to get a blank line is given below.
C
      PRINT *
      WRITE(6,*) ' RESULTS OF LOG(A)'
      WRITE(6,2004) C
 2004 FORMAT(' C = ',/,(1P,8E10.2))
      STOP

      END
