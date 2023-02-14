C ********************************************************************
C * EXAMPLE OF A FORTRAN PROGRAM
C * CMPS 3500
C ********************************************************************
C Simple exercises in using arrays for data analysis using Fortran 90
      IMPLICIT NONE
      INTEGER I,J
c
c     Declare A, B, and C to be arrays each containing 10 elements. At
c     the same time initialize A using an implied DO loop.
c
      REAL, DIMENSION (10) :: A=(/(J,J=1,10)/), B, C
      REAL CSUM,CMAX,CMIN,AVERAGE
      DATA B/3*1.,4*2.,3*3./
C
c     DO loops are not needed with Fortran 90 for many basic operations
c     using arrays.  Compare what happens below to the loop in "array1.f".
c     The compiler has no problem adapting these statements to any vector
c     or parallel capabilities that are available to you.
c
      C=A+B
      CSUM=SUM(C)
      CMIN=MINVAL(C)
      CMAX=MAXVAL(C)
C
      AVERAGE=CSUM/10
C
      WRITE(*,*) ' RESULTS FOR FULL C ARRAY'
      WRITE(6,2000)AVERAGE,CMIN,CMAX
 2000 FORMAT(' AVERAGE OF ALL ELEMENTS IN C = ', F8.3,/,
     &       ' MINIMUM OF ALL ELEMENTS IN C = ', F8.3,/,
     &       ' MAXIMUM OF ALL ELEMENTS IN C = ', F8.3)
      WRITE(6,2001) C
 2001 FORMAT(' C = ',/,(8E10.2))
c
c     Limiting the portion of arrays that you use in Fortran 90, is
c     relatively simple once you learn the use of ":" to specify a
c     range of elements.  Here we operate on elements 2 through 9.
c
      C(1)=0.
      C(10)=0.
      C(2:9)=A(2:9)+B(2:9)
      CSUM=SUM(C(2:9))
      CMIN=MINVAL(C(2:9))
      CMAX=MAXVAL(C(2:9))
C
      AVERAGE=CSUM/8
      WRITE(*,'(//,'' RESULTS FOR ELEMENTS 2 THROUGH 9 OF C'')')
      WRITE(6,2002)AVERAGE,CMIN,CMAX
 2002 FORMAT(' AVERAGE OF SELECTED ELEMENTS IN C = ', F8.3,/,
     &       ' MINIMUM OF SELECTED ELEMENTS IN C = ', F8.3,/,
     &       ' MAXIMUM OF SELECTED ELEMENTS IN C = ', F8.3)
      WRITE(6,2003) C(2:9)
 2003 FORMAT(' C = ',/,(1P,8E10.2))
c
c     Handling conditional branches in vector processing is generally
c     difficult.  However, situations where one of two possible options
c     is chosen can be handled relatively simply (uses something called
c     a vector mask).  Fortran 90 provides a special construct for these
c     situations involving the WHERE, ELSE WHERE, and END WHERE statements.
c     Any number of Fortran 90 statements may be placed between a WHERE and
c     an END WHERE statement.  However, if the ELSEWHERE is used, only
c     one may be used with a given WHERE to cover what happens if the
c     condition associated with the WHERE is false.  If you make the
c     analogy to the IF THEN construct, ELSEWHERE is equivalent to a
c     simple ELSE statement.  There isn't an equivalent to the ELSE IF
c     construct.
c
      A(4)=-1.0
      WHERE (A.GT.0)
         C=LOG(A)
      ELSE WHERE
         C=0.
      END WHERE
C
      PRINT *
      WRITE(6,*) ' RESULTS OF LOG(A)'
            WRITE(6,2004) C
 2004 FORMAT(' C = ',/,(1P,8E10.2))
      STOP
      END
