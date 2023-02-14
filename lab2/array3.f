C ********************************************************************
C * EXAMPLE OF A FORTRAN PROGRAM
C * CMPS 3500
C ********************************************************************
C Program very similar to array3.f but examines the input data file to
C determine the size of the input array. Examines input file array3.in.
      IMPLICIT NONE
      INTEGER I,J,IERR,N,NDAT
c
c    Declare A, B, and C to be arrays to be ALLOCATABLE
c
      REAL, ALLOCATABLE :: A(:),B(:),C(:)
      REAL CSUM,CMAX,CMIN,AVERAGE,DUMMY
c
c   One way to decide on how much space you need is to count information
c   in the input.  Be sure to include options for error conditions.
c
      OPEN(11,FILE='array3.in',ERR=400)
      NDAT=0
  10  READ(11,*,END=20) DUMMY
      NDAT=NDAT+1
      GO TO 10
  20  CONTINUE
      IF(NDAT.EQ.0) GO TO 400
c
c    Having gone through Unit 11, I need to reposition it at the beginning
c
      REWIND(11)
c
c   I've dropped the STAT optional argument this time.  The program will
c   stop at the ALLOCATE statement if any problems develop.
c
      ALLOCATE (A(1:NDAT),B(NDAT),C(NDAT))
      PRINT *, 'ERROR FLAG =', IERR
c
c   Set values of A and B
c
      DO 30 I=1,NDAT
      READ(11,*) A(I), B(I)
  30  CONTINUE
c
c   Process as before
c
      C(1:NDAT)=A(1:NDAT)+B(1:NDAT)
      CSUM=SUM(C(1:NDAT))
      CMIN=MINVAL(C(1:NDAT))
      CMAX=MAXVAL(C(1:NDAT))
C
      AVERAGE=CSUM/NDAT
      WRITE(*,'(//,'' RESULTS FOR ELEMENTS 1 THROUGH '',I3,'' OF C'')')
     & NDAT
      WRITE(6,2002)AVERAGE,CMIN,CMAX
 2002 FORMAT(' AVERAGE OF SELECTED ELEMENTS IN C = ', F8.3,/,
     &       ' MINIMUM OF SELECTED ELEMENTS IN C = ', F8.3,/,
     &       ' MAXIMUM OF SELECTED ELEMENTS IN C = ', F8.3)
      WRITE(6,2003) C(1:NDAT)
 2003 FORMAT(' C = ',/,(1P,8E10.2))
c
      STOP
 400  PRINT *,' Empty or missing input file: array3a.in'
      STOP
      END
