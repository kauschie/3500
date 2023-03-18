-- ---------------------------------------------------------------------------
-- CMPS 3500
-- matdet.adb (filename must match outer procedure name)
-- compile only:            $ gcc -c matdet.adb
-- compile and link:        $ gnatmake matdet.adb
-- execute:                 $ ./matdet
-- --------------------------------------------------------------------------

with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Directories;   use Ada.Directories;
with Ada.Text_IO;       use Ada.Text_IO;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;


procedure matdet is

	MAX_ROW : INTEGER; -- Number of rows
	MAX_COL : INTEGER; -- Number of Columns
	N : INTEGER;

 --type myArray is array(positive range <>, positive range <>) of LONG_FLOAT;
 type MATRIX is array(NATURAL range <>, NATURAL range <>) of LONG_FLOAT;

	m1: MATRIX (1..7,1..7);
	m2: MATRIX (1..7,1..7);
	m3: MATRIX (1..7,1..7);

	cofac_m1: MATRIX (1..7,1..7);
	cofac_m2: MATRIX (1..7,1..7);
	cofac_m3: MATRIX (1..7,1..7);

	--Definfifn some constants
	Directory : String := ".";
	Pattern   : String := "";
	Search    : Search_Type;
	Dir_Ent   : Directory_Entry_Type;
	smatch    : String := "in";
	Inf 		  : FILE_TYPE;

	detm1 		: LONG_FLOAT;
	detm2 		: LONG_FLOAT;
	detm3 		: LONG_FLOAT;

   --+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  -- Matrix Red and write methods
  --+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  --Procedure to populate Matrix (Reaed Long Float --> Populates Long Float)
		procedure PopulateMatrixLF(Inf : in FILE_TYPE; Result : out MATRIX) is
		begin
			for Row in Integer range 1..MAX_ROW loop
				for Column in Integer range 1..MAX_COL loop
					Ada.Integer_Text_IO.Get(inf,N);
					Result(Row, Column) := LONG_FLOAT(N);
				end loop;
			end loop;
		end PopulateMatrixLF;

	 -- prints matrix to console (Reaed Long Float --> Prints Long Integer)
	 procedure PrintMatrixLI (Input : in MATRIX) is
	 begin
		 Set_Output(Standard_Output);
		 for Row in Integer range 1..MAX_ROW loop
			 for Column in Integer range 1..MAX_COL loop
				 -- ugly format due to long ints and lack of width
				 	Ada.Text_IO.Put(Long_Integer'Image(Long_Integer(Input(Row, Column))));
				 Put(" ");
			 end loop;
			 New_Line;
		 end loop;
	 end PrintMatrixLI;

	 -- prints matrix to console (Reaed Long Float --> Prints Long Float)
	 procedure PrintMatrixLF (Input : in MATRIX) is
	 begin
		 Set_Output(Standard_Output);
		 for Row in Integer range 1..MAX_ROW loop
			 for Column in Integer range 1..MAX_COL loop
				 -- ugly format due to long ints and lack of width
					Ada.Text_IO.Put(Long_Float'Image(Input(Row, Column)));
				 Put(" ");
			 end loop;
			 New_Line;
		 end loop;
	 end PrintMatrixLF;

  --+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  -- Matrix Operations
  --+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

 -- adds two 7x7 matricies
  function AddMatrix(Matrix_1 : in MATRIX; Matrix_2 : in MATRIX) return MATRIX is
    Sum : Long_Float;
    Result : MATRIX (1..7,1..7);
  begin
    for Row in Integer range 1..MAX_ROW loop
      for Column in Integer range 1..MAX_COL loop
        Sum := Matrix_1(Row, Column) + Matrix_2(Row, Column);
        Result(Row, Column) := Sum;
      end loop;
    end loop;
    return Result;
  end AddMatrix;

  -- multiplies matrix by scalar
	function MultiplyScalar(Matrix_1 : in MATRIX; Scalar : in Long_Float) return MATRIX is
		Product : Long_Float;
		Result : MATRIX (1..7,1..7);
	begin
		for Row in Integer range 1..MAX_ROW loop
			for Column in Integer range 1..MAX_COL loop
				Product := Matrix_1(Row, Column) * Scalar;
				Result(Row, Column) := Product;
			end loop;
		end loop;
		return Result;
	end MultiplyScalar;

	-- transposes matrix
	function Transpose(Matrix_1 : in MATRIX) return MATRIX is
		Result : MATRIX (1..7,1..7);
	begin
		for Row in Integer range 1..MAX_ROW loop
			for Column in Integer range 1..MAX_COL loop
				Result(Row, Column) := Matrix_1(Column, Row);
			end loop;
		end loop;
		return Result;
	end Transpose;

  -- multiplies two 7x7 matricies
	function MultiplyMatrix(Matrix_1 : in MATRIX; Matrix_2 : in MATRIX) return MATRIX is
		Product : Long_Float;
		Result : MATRIX (1..7,1..7);
		Result_Element : Long_Float;
	begin
		for Row in Integer range 1..MAX_ROW loop
			Result_Element := 0.0;
			for Column in Integer range 1..MAX_COL loop
				Result_Element := 0.0;
				for K in Integer range 1..MAX_COL loop
					Product := Matrix_1(Row, K) * Matrix_2(K, Column);
					Result_Element := Result_Element + Product;
				end loop;
				Result(Row, Column) := Result_Element;
			end loop;
		end loop;
		return Result;
	end MultiplyMatrix;

  --Function to calculate the determinant om a matrix of Long Floats
	function Determinant(mdet: in out MATRIX; n: INTEGER) return LONG_FLOAT is
	i : INTEGER;
	aj : INTEGER;
	bj : INTEGER;
	k : LONG_FLOAT;
	d : LONG_FLOAT;
	l : LONG_FLOAT;
	sign : LONG_FLOAT;
	b : MATRIX(1..n-1, 1..n-1);

	begin
	i := 2;
	sign := 1.0;
	l := 0.0;
	k := 1.0;
	if n = 2 then
		 d := (mdet(1,1) * mdet(2,2)) - (mdet(1,2) * mdet(2,1));
		 return d;
	end if;

		 for k in 1..n loop
				aj := 1;
				bj := 1;
				for i in 2..n loop
					 bj := 1;
					 for aj in 1..n loop
							if aj = k then
								 goto endofloop;
							end if;
								 if bj = n then
										goto endofloop;
								 end if;
								 b(i-1, bj) := mdet(i, aj);
								 bj := bj + 1;
							<<endofloop>>
					 end loop;
				end loop;
				l := l + (sign * mdet(1, k) * Determinant(b, n-1));
				sign := sign * (-1.0);

		 end loop;
		 return l;
	end Determinant;

  --+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  --Function to calculate the cofactors of a matrix of Long Floats
	function Cofactors(coeff: in out MATRIX; det: LONG_FLOAT; n: INTEGER) return MATRIX is

	i : INTEGER;
	aj : INTEGER;
	bj : INTEGER;
	cofac : MATRIX(1..7, 1..7);
	k : LONG_FLOAT;
	minor : LONG_FLOAT;
	l : LONG_FLOAT;
	sign : LONG_FLOAT;
	b : MATRIX(1..n-1, 1..n-1);
	bcnt : INTEGER;

	begin
	i := 2;
	sign := 1.0;
	l := 0.0;
	k := 1.0;

	for row in 1..n loop
		 for k in 1..n loop
				aj := 1;
				bj := 1;
				bcnt := 1;
				for i in 1..n loop
					if i = row then
					 	goto nextloop;
					end if;
					 bj := 1;
					 for aj in 1..n loop
							if aj = k then
								 goto endofloop;
							end if;
								 if bj = n then
										goto endofloop;
								 end if;
								 b(bcnt, bj) := coeff(i, aj);
								 bj := bj + 1;
							<<endofloop>>
					 end loop;
					bcnt := bcnt + 1;
					<<nextloop>>
				end loop;

				minor := Determinant(b, n-1);
				cofac(row,k) := sign * minor;
				--  l := l + (sign * mdet(1, k) * Determinant(b, n-1));
				sign := sign * (-1.0);

		 end loop;
	end loop;

	PrintMatrixLF(cofac);

	return cofac;

	end Cofactors;

begin

	MAX_ROW := 7;
	MAX_COL := 7;

 --Reading all matrices stores in files into matrices
	--**************************************************
		Start_Search (Search, Directory, Pattern);

		--searchs each file in current folder
		while More_Entries (Search) loop
			Get_Next_Entry (Search, Dir_Ent);
			if Tail (Simple_Name (Dir_Ent), smatch'Length) = smatch then
				Open(Inf, In_File, Simple_Name (Dir_Ent));

				--identify each mtrix and stores it accordingly
				if (Simple_Name (Dir_Ent)) = "m1.in" then
					PopulateMatrixLF(Inf, m1);
					Put_Line("m1");
					PrintMatrixLF(m1);
					New_Line;

				elsif (Simple_Name (Dir_Ent)) = "m2.in" then
					PopulateMatrixLF(Inf, m2);
					Put_Line("m2");
					PrintMatrixLF(m2);
					New_Line;

				elsif (Simple_Name (Dir_Ent)) = "m3.in" then
					PopulateMatrixLF(Inf, m3);
					Put_Line("m3");
					PrintMatrixLF(m3);
					New_Line;
				end if;

				Close(Inf);
			end if;
		end loop;
	End_Search (Search);

	--**************************************************
  ---output
	Put_Line("Operations");
	Put_Line("**************");


	Put_Line("det(m1)");
	detm1 := Determinant(m1, 7);
	Put_Line(Long_Float'image(detm1)); New_Line;
	cofac_m1 := Cofactors(m1,detm1,7);
	Put_Line("");

  Put_Line("det(m2)");
	detm2 := Determinant(m2, 7);
	Put_Line(Long_Float'image(detm2));
	Put_Line("");

  Put_Line("det(m3)");
	detm3 := Determinant(m3, 7);
	Put_Line(Long_Float'image(detm3));
	Put_Line("");

end matdet;
