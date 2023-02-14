C********************************************************************
C ORGN: CSUB - CMPS 3500
C FILE: circleinput.f
C DATE: 09/10/2021
C********************************************************************
C THIS PROGRAM CALCULATES THE CIRCUMFERENCE AND AREA OF A CIRCLE WITH
C RADIUS R INPUTTED BY THE USER.
C DEFINE VARIABLE NAMES:
C     R: RADIUS OF CIRCLE
C     PI: VALUE OF PI=3.14159
C     CIRCUM: CIRCUMFERENCE = 2*PI*R
C     AREA: AREA OF THE CIRCLE = PI*R*R
C ********************************************************************
C
      REAL R,CIRCUM,AREA
C
      PI = 3.14159
C
C ASK USER FOR A RADIUS, R:
100   WRITE(6,*) 'INPUT A VALUE FOR THE RADIUS, R NOW',
     +           '... INPUT -1 TO END THE PROGRAM'
      READ (5,*) R

C CONDITIONAL TO END THE PROGRAM AND HANDLE NEGATIVE NUMBERS     
      IF (R .EQ. -1.0) THEN
            WRITE(6,*) 'GOOD BYE'
            GO TO 200 
      ELSE IF (R .LT. 0.0) THEN
            WRITE(6,*) 'PLEASE INPUT A POSITIVE RADIUS, TRY AGAIN...'
            GO TO 100
      END IF
C
C CALCULATIONS:
      CIRCUM = 2.*PI*R
      AREA = PI*R*R
C
C WRITE RESULTS:
      WRITE(6,*)  'FOR A CIRCLE OF RADIUS', R,
     +            'THE CIRCUMFERENCE IS', CIRCUM,
     +            'AND THE AREA IS ', AREA
C
      GO TO 100
200   END
