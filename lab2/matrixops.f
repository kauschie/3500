C********************************************************************
C Name: Michael Kausch
C ASGT: Activity 2
C ORGN: CSUB - CMPS 3500
C FILE: matrixops.f
C Date: 2/12/2023

C********************************************************************
C     Externally defined Power Function
C     - required becuase we are returning an array
C     - input1: a 5x5 2d array of reals
C     - input2: an integer power to raise the array to
C     - returns a 5x5 array
C ********************************************************************

      MODULE PFUNC
      CONTAINS
      FUNCTION Power(mat_in, exponent) result (result)
C           Variables
            DOUBLE PRECISION, dimension(5,5) :: result
            REAL, dimension(5,5), intent(in) :: mat_in
            INTEGER, intent(in) :: exponent
      
            result = mat_in
            
            DO 100 I=1,exponent-1
                  result = matmul(result, mat_in)
100         CONTINUE
      END FUNCTION Power
      END MODULE PFUNC


C********************************************************************
C This program implements matrix operations:
C     - reads 2 5x5 matrices from a file
C     - calculates the product of two matrices A*B and then B*A
C     - transposes the two matrices
C     - raises the matrix to any power
C ********************************************************************
C     use the above externally defined function so we can return 
C     the 2D array
      USE PFUNC    

C     Define variables as arrays of 2 and 1 dimensions
     
      REAL matrix1(5,5), matrix2(5,5), vector1(5)
      REAL prod1(5,5), prod2(5,5), transp1(5,5), transp2(5,5)
      DOUBLE PRECISION mat_power1(5,5), mat_power2(5,5), op1(5,5)
      INTEGER SIZE1, SIZE2, SIZE3, I
      REAL, ALLOCATABLE :: mtemp1(:), mtemp2(:), mtemp3(:)

C      REAL MatPower(5,5)

C     ****************************************
C     Reading matrix1.in
C     ****************************************
      OPEN(1,FILE='m1.in',ERR=2002)
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
      matrix1 = RESHAPE(mtemp1,(/5, 5/))

C     ****************************************
C     Reading matrix2.in
C     ****************************************
      OPEN(2,FILE='m2.in',ERR=2002)
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
      matrix2 = RESHAPE(mtemp2,(/5, 5/))

C     ****************************************
C     Reading vector1.in
C     ****************************************
      OPEN(3,FILE='v1.in',ERR=2002)
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

C     Transpose m1
      transp1  = transpose(matrix1)

C     Transpose m2
      transp2 = transpose(matrix2)

C     MATMUL will perform matrix multiplication
      prod1 = matmul(matrix1, matrix2)
      prod2 = matmul(matrix2, matrix1)

C     Power function on m1, m2    
      mat_power1 = Power(matrix1, 10)
      mat_power2 = Power(matrix2, 20)

      
      
C     Nested function calls using power function
      op1 = Power(transpose(prod1),25) 


C     ****************************************
C     Writing Outputs
C     ****************************************

C     Printing outputs
      print *
      write(*,*) 'Program to show some matrix and vector operations'
      write(*,*) '*************************************************'
      print *

      write(*,*) ' m1 = '
      write( *, 2000) ((matrix1(i,j),j=1,5),i=1,5)
      print *

      write(*,*) ' m2 = '
      write( *, 2000)  ((matrix2(i,j),j=1,5),i=1,5)
      print *

      write(*,*) ' v1 = '
      write( *, 2001) vector1
      print *

      write(*,*) ' prod1 = m1 * m2 = '
      write( *, 2000) ((prod1(i,j),j=1,5),i=1,5)
      print *

      write(*,*) ' prod2 = m2 * m1 = '
      write( *, 2000)  ((prod2(i,j),j=1,5),i=1,5)
      print *

      write(*,*) ' transp1 = transpose(m1)'
      write( *, 2000)  ((transp1(i,j),j=1,5),i=1,5)
      print *

      write(*,*) ' transp2 = transpose(m2)'
      write( *, 2000)  ((transp2(i,j),j=1,5),i=1,5)
      print *

      write(*,*) ' power1 = (m1, 10)'
      write( *, 2000)  ((mat_power1(i,j),j=1,5),i=1,5)
      print *
C
      write(*,*) ' power2 = (m1, 20)'
      write( *, 2003)  ((mat_power2(i,j),j=1,5),i=1,5)
      print *

      write(*,*) ' op1 = power(transpose(m1*m2),25)'
      write( *, 2003)  ((op1(i,j),j=1,5),i=1,5)
      print *

C     Format output arrays
C     Format output for 4x4 array
 2000 format(5x,5F8.1)

C     Format output for 4x1 array
 2001 format((5x,f8.1))
      stop

C     Format output for 4x1 array
 2003 format(5x,1P,5E10.1)


C     Erroring out of the file cannot be open or empty
 2002 PRINT *,' Empty or missing input file: array3a.in'
      STOP
      END


      
















C      FUNCTION MatPower (mat, p) result(temp)
C           Variables
C           From parameters
C            REAL mat(5,5)
C            REAL, dimension(5,5) :: mat
C            REAL, dimension(5,5), intent(out) :: mat
C            REAL, dimension(5,5) :: MatPower
C            REAL temp(5,5)
C            INTEGER p
C
C           Local/Return 
C            REAL, dimension(5,5) :: MatPower
C
C            temp = mat
C            
C            write(*,*) ' in MatPower and mat = '
C            write( *, 3000) ((mat(i,j),j=1,5),i=1,5)
C 3000       format(5x,5f8.1)
C            print *
C
C            DO 100 I=1, p-1
C                  temp = matmul(temp, mat)
C 100        CONTINUE
C            Return
C      
C      END FUNCTION MatPower

