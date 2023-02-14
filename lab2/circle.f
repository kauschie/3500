C ********************************************************************
C * EXAMPLE OF A FORTRAN PROGRAM
C * CMPS 3500
C * THIS CODE CALCULATES THE CIRCUMFERENCE AND AREA OF A CIRCLE WITH
C * RADIUS R.
C ********************************************************************
C DEFINE VARIABLE NAMES:
C     R: RADIUS OF CIRCLE
C     PI: 3.14159
C     CIRCUM: CIRCUMFERENCE = 2*PI*R
C     AREA: AREA OF THE CIRCLE = PI*R*R
C ********************************************************************
C
      REAL R,CIRCUM,AREA
C
      PI = 3.14159
C
C SET VALUE OF R:
      R = 4.0
C
C CALCULATIONS:
      CIRCUM = 2.*PI*R
      AREA = PI*R*R
C
C WRITE RESULTS:
      WRITE(6,*)  '  FOR A CIRCLE OF RADIUS', R,
     +            '  THE CIRCUMFERENCE IS', CIRCUM,
     +            '  AND THE AREA IS ', AREA
      END