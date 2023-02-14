C********************************************************************
C ORGN: CSUB - CMPS 3500
C FILE: matrix1.f
C********************************************************************
C This program implements matrix operations:
C    - Addition and subtraction
C    - Multiplication, dotproduct
C    - scalar times x
C ********************************************************************
C     Define variables as arrays of 2 and 1 dimensions
      REAL matrix1(4,4), matrix2(4,4) 
      REAL mat_sum(4,4), mat_subs(4,4), mat_prod1(4,4)
      REAL vector1(4),mat_prod2(4)
      REAL dotprod
      INTEGER SIZE1, SIZE2, SIZE3, I
      REAL, ALLOCATABLE :: mtemp1(:), mtemp2(:), mtemp3(:)

C     ****************************************
C     Reading matrix1.in
C     ****************************************
      OPEN(1,FILE='matrix1.in',ERR=2002)
      SIZE1=0 
C     Getting size of matrix in file
  10  READ(1,*,END=20) 
      SIZE1 = SIZE1 + 1
      GO TO 10

C     if empty exit file
  20  CONTINUE
      IF(SIZE1.EQ.0) GO TO 2002

C     Reposition array to beginning
      REWIND(1)

C     Allocating size of new matrix
      ALLOCATE (mtemp1(1:SIZE1))

C   Set values of A and B
      DO 30 I=1,SIZE1
      READ(1,*) mtemp1(I)
  30  CONTINUE

C     Reshape function from a 1D to 2D array         
      matrix1 = RESHAPE(mtemp1,(/4, 4/))

C     ****************************************
C     Reading matrix2.in
C     ****************************************
      OPEN(2,FILE='matrix2.in',ERR=2002)
      SIZE2=0 

C     Getting size of matrix in file
  40  READ(2,*,END=50) 
      SIZE2 = SIZE2 + 1
      GO TO 40

C     if empty exit file
  50  CONTINUE
      IF(SIZE2.EQ.0) GO TO 2002

C     Reposition array to beginning
      REWIND(2)

C     Allocating size of new matrix
      ALLOCATE (mtemp2(1:SIZE2))

C   Set values of A and B
      DO 60 I=1,SIZE2
      READ(2,*) mtemp2(I)
  60  CONTINUE

C     Reshape function from a 1D to 2D array         
      matrix2 = RESHAPE(mtemp2,(/4, 4/))

C     ****************************************
C     Reading vector1.in
C     ****************************************
      OPEN(3,FILE='vector1.in',ERR=2002)
      SIZE3=0 

C     Getting size of matrix in file
  70  READ(3,*,END=80) 
      SIZE3 = SIZE3 + 1
      GO TO 70

C     if empty exit file
  80  CONTINUE
      IF(SIZE3.EQ.0) GO TO 2002

C     Reposition array to beginning
      REWIND(3)

C     Allocating size of new matrix
      ALLOCATE (mtemp3(1:SIZE3))

C   Set values of A and B
      DO 90 I=1,SIZE3
      READ(3,*) mtemp3(I)
  90  CONTINUE

      vector1 = mtemp3

C     ****************************************
C     Performing Operations
C     ****************************************

C     Perform matrix addition and subtraction
      mat_sum  = matrix1 + matrix2
      mat_subs = matrix1 - matrix2

C     MATMUL will perform matrix multiplication
      mat_prod1 = matmul(matrix1, matrix2)
      mat_prod2 = matmul(matrix1, vector1)

C     Performing dot product      
      dot_prod = dot_product(vector1, mat_prod2)

C     ****************************************
C     Writing Outputs
C     ****************************************

C     Printing outputs
      print *
      write(*,*) 'Program to show some matrix and vector operations'
      write(*,*) '*************************************************'
      print *

      write(*,*) ' matrix1 = '
      write( *, 2000) ((matrix1(i,j),j=1,4),i=1,4)
      print *

      write(*,*) ' matrix2 = '
      write( *, 2000)  ((matrix2(i,j),j=1,4),i=1,4)
      print *

      write(*,*) ' vector1 = '
      write( *, 2001) vector1
      print *

      write(*,*) ' mat_sum = matrix1 + matrix2 ='
      write( *, 2000)  ((mat_sum(i,j),j=1,4),i=1,4)
      print *

      write(*,*) ' mat_subs = matrix1 - matrix2 ='
      write( *, 2000)  ((mat_subs(i,j),j=1,4),i=1,4)
      print *

      write(*,*) ' mat_prod2 = matrix1 * vector1 '
      write(*,2001) mat_prod2
      print *

      write(*,*) ' dot_prod = vector1 . mat_prod2 '
      write(*,*) ' dot_prod = ', dot_prod
      print *

C     Format output arrays
C     Format output for 4x4 array
 2000 format(4x,4f8.1)

C    Format output for 4x1 array
 2001 format ((5x,f8.1))
      stop

C     Erroring out of the file cannot be open or empty
 2002 PRINT *,' Empty or missing input file: array3a.in'
      STOP
      END
