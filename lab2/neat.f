C ********************************************************************
C Name: Michael Kausch
C ASGT: Activity 2
C ORGN: CSUB - CMPS 3500
C FILE: neat.f
C DATE: 02/14/23
C ********************************************************************
C           
C****************    Program  Documentation      **********************
C     This program performs a bubble sort on 15 values input by the user
C     - only works with 3 digit positiv numbers or 2 digit neg numbers
C     - prints the values out in order back to the user
C ********************************************************************

C     **********        VARIABLE DEFINITIONS          *****************

      IMPLICIT NONE     ! Force explicit variable definitions
      INTEGER NUMS(20) ! array to store input
      INTEGER N ! counter used for user input
      INTEGER I, J ! counters used for Bubble Sort
      INTEGER INPUT ! variable to accept user input

      INTEGER I_SWAP ! flag that's set if a swap occurs in the sort
C        Note: need to use integer or use with an arithmetic if stmnt

      INTEGER ISCAN  ! scanning variable for bubble sort
      INTEGER ISTOP  ! index to stop iteration of bubble sort
      INTEGER ISTART ! starting index of the buble sort

      ISTART = 1  ! note: this was left out of the original version
C                       which i believe caused a bug
C     ******************************************************************

C     Declare an 20 variable array, begins with N so they're integers      
C      DIMENSION NUMS(20)
      WRITE(6,*) 'PLEASE INPUT 15 INTEGERS, ONE AT THE TIME....'
      WRITE(6,*) 'YOU CAN STOP BY INPUTTING -1'

C     Declare variable N which is initialized to 1      
      N = 1

C     Gets user 3 digit integer user input
10    READ 15, INPUT
15    FORMAT(I3)

C     IF the value is -1, go to the sort sequence, otherwise
C     continue gather numbers into the nums array
      IF(INPUT + 1) 20,40,20
20    NUMS(N) = INPUT

C     If this is the 15th variable entered (max) then begin sort
      IF(N - 15) 25,70,70
25    N = N + 1
      GOTO 10

C     Bubble sorting sequence
C     Set indices accordingly      
40    N = N - 1
70    ISCAN = 1
      I_SWAP = 1 ! var was swapped flag
      ISTOP = N

C     IF sorting is done begin printing
      IF(ISTART - ISTOP) 50, 110, 110

C     If left num is less than right num swap them
C     J is a temp variable used for the swap
50    IF(NUMS(ISCAN) - NUMS(ISCAN+1)) 90,90,60
60    J = NUMS(ISCAN)
      NUMS(ISCAN) = NUMS(ISCAN+1)
      NUMS(ISCAN+1) = J
      I_SWAP = 0

C     If stop point was reached, begin bubble sort again      
90    IF(ISCAN - (ISTOP - 1)) 80,100,100
80    ISCAN = ISCAN + 1
      GOTO 50
      
C     If the swap flag was still used then the array still needs sorting
100   IF(I_SWAP) 105,105,110
105   ISTOP = ISTOP - 1
      GOTO 70

C     DO loop to print nums
110   DO 120 I=1, N
120   PRINT 130, NUMS(I)
C      PRINT *, ISTART ! debug code
130   FORMAT(I10)
      STOP
      END
