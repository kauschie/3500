-- ---------------------------------------------------------------------------
-- Name: Michael Kausch
-- Assignment: Activity 4
-- ORGN: CSUB CMPS 3500
-- File: solver.adb
-- Date: 03/12/2022
-- Original code provided by: Professor Morales

-- compile instructions:
-- compile only:            $ gcc -c solver.adb
-- compile and link:        $ gnatmake solver.adb
-- execute:                 $ ./solver
-- program will be expecing the system of equations to be in system1.txt
    -- as was specified in the project requirements
-- --------------------------------------------------------------------------
with Ada.Directories;   use Ada.Directories;
with Ada.Text_IO;       use Ada.Text_IO;
--  with Gnat.IO;           use Gnat.IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
--  with Ada.Strings.Bounded;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Text_IO; use Ada.Strings.Unbounded.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
 
procedure solver is
	Directory : String := ".";
    Pattern   : String := ""; -- empty pattern = all file names/subdirectory names
	Search    : Search_Type;
    Dir_Ent   : Directory_Entry_Type;
	smatch    : String := "txt";
    inf       : FILE_TYPE;
    type MATRIX is array(NATURAL range <>, NATURAL range <>) of FLOAT;
    type vector is array (1..6) of FLOAT;

    active_matrix    : MATRIX (1..6, 1..6) :=
                                            ((0.0, 0.0, 0.0, 0.0, 0.0, 0.0),
                                            (0.0, 0.0, 0.0, 0.0, 0.0, 0.0),
                                            (0.0, 0.0, 0.0, 0.0, 0.0, 0.0),
                                            (0.0, 0.0, 0.0, 0.0, 0.0, 0.0),
                                            (0.0, 0.0, 0.0, 0.0, 0.0, 0.0),
                                            (0.0, 0.0, 0.0, 0.0, 0.0, 0.0));

    m1    : MATRIX (1..6, 1..6);
    --  m2    : MATRIX (1..6, 1..6);

    b_matrix  : vector := (0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
    v_mat1 : vector;
    --  v_mat2 : vector;
    final_answer : vector;
    detm1 : FLOAT;
    --  detm2 : FLOAT;

    cofac_m1 : MATRIX (1..6, 1..6);
    tpose_m1 : MATRIX (1..6, 1..6);
    inv_m1 : MATRIX (1..6, 1..6);



    line : Unbounded_String;
    line_length : NATURAL;
    coefficient : FLOAT := 0.0;
    a, b, c, d, e, f : FLOAT := 0.0;
    row : Integer := 1;
    eq_count : Integer := 1;
    eq_val : Float := 0.0;
    eq_digit : Integer := 0;
    pm_val : Float := 1.0;

   --+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  -- Matrix Operations
  --+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	-- transposes matrix
	function Transpose(Matrix_1 : in MATRIX) return MATRIX is
		Result : MATRIX (1..6,1..6);
	begin
		for Row in Integer range 1..6 loop
			for Column in Integer range 1..6 loop
				Result(Row, Column) := Matrix_1(Column, Row);
			end loop;
		end loop;
		return Result;
	end Transpose;

  -- multiplies matrix by scalar
	function MultiplyScalar(Matrix_1 : in MATRIX; Scalar : in Float) return MATRIX is
		Product : Float;
		Result : MATRIX (1..6,1..6);
	begin
		for Row in Integer range 1..6 loop
			for Column in Integer range 1..6 loop
				Product := Matrix_1(Row, Column) * Scalar;
				Result(Row, Column) := Product;
			end loop;
		end loop;
		return Result;
	end MultiplyScalar;

      -- multiplies a 6x6 matrix by a vector
	function MultiplyMatrix(Matrix_1 : in MATRIX; Matrix_2 : in vector) return Vector is
		Product : Float;
		Result : Vector;
		Result_Element : Float;
	begin
		for Row in Integer range 1..6 loop
			Result_Element := 0.0;
				for col in Integer range 1..6 loop
					Product := Matrix_1(Row, col) * Matrix_2(col);
					Result_Element := Result_Element + Product;
				end loop;
				Result(row) := Result_Element;
		end loop;
		return Result;
	end MultiplyMatrix;

  --+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

	 -- prints matrix to console
	 procedure PrintMatrix6by6 (Input : in MATRIX) is
	 begin
		 Set_Output(Standard_Output);
		 for Row in Integer range 1..6 loop
			 for Column in Integer range 1..6 loop
				 Put((Input(Row,Column)), 6, Aft => 2, Exp => 0);
			 end loop;
			 New_Line;
		 end loop;
	 end PrintMatrix6by6;

    --+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

	 -- prints matrix to console
	 procedure PrintMatrix1by6 (Input : in vector) is
	 begin
		 Set_Output(Standard_Output);
		 for Row in Integer range 1..6 loop
			Put((Input(Row)), 5, Aft => 1, Exp => 0); New_Line;
		 end loop;
	 end PrintMatrix1by6;


  --Function to calculate the determinant on a matrix of Ints
	function Determinant(mdet: in out MATRIX; n: INTEGER) return FLOAT is
	i : INTEGER;
	aj : INTEGER;
	bj : INTEGER;
	k : Integer;
	det : FLOAT;
	l : FLOAT;
	sign : FLOAT;
	b : MATRIX(1..n-1, 1..n-1);

    --  exp : MATRIX (1..6, 1..6)

	begin
	i := 2;
	sign := 1.0;
	l := 0.0;
	k := 1;
	if n = 2 then
		 det := (mdet(1,1) * mdet(2,2)) - (mdet(1,2) * mdet(2,1));
		 return det;
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

  --+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  --Function to calculate the cofactors of a matrix of Ints
	function Cofactors(coeff: in out MATRIX; n: INTEGER) return MATRIX is

	--  i : INTEGER;
	aj : INTEGER;
	bj : INTEGER;
	cofac : MATRIX(1..6, 1..6);
	--  k : INTEGER;
	minor : FLOAT;
	sign : Float;
	b : MATRIX(1..n-1, 1..n-1);
	bcnt : INTEGER;

	begin
	--  i := 2;
	sign := 1.0;

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
				sign := (-1.0)**(row+k);
				cofac(row,k) := sign * minor;
				--  l := l + (sign * mdet(1, k) * Determinant(b, n-1));

		 end loop;
	end loop;

	

	return cofac;

	end Cofactors;

  --+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--    searching for matrix files that end in txt
  --+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
begin
    Start_Search (Search, Directory, Pattern);
    --searchs each file in current folder
    while More_Entries (Search) loop
        Get_Next_Entry (Search, Dir_Ent);
      
	    if Tail (Simple_Name (Dir_Ent), smatch'Length) = smatch then
            Open(inf, In_File, Simple_Name(Dir_Ent));       -- open file for reading 
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                -- read in file and parse lines into matrix
  --+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            
            loop
                exit when End_Of_File(inf);
                line := Get_Line(inf);  -- read unbounded string into line
                line_length := Length(line);
                
                --  Put_Line(line);         -- write line ((debug))
                --  Put_line("writing where i find indices...");
                for i in 1 .. line_length loop
                    --  Put(Element(line, I));
                    if Element(line, I) = 'a' then
                        -- get index
                        --  a := I;

                        -- parse coefficient
                        if I = 1 then   -- check if it's the first letter on the line
                            coefficient := 1.0;   -- set coefficient to 1
                        elsif I = 2 and then Slice(line,I-1,I-1) = "-" then -- -1 coefficient
                            coefficient := 1.0;
                        elsif I = 3 and then Slice(line,I-2,I-2) = "-" then -- -n coefficient
                            coefficient := Float'value(Slice(line,I-1,I-1));
                            --  coefficient := coefficient * (-1);
                        elsif Slice(line,I-1,I-1) = " " then -- coefficient is 1
                            coefficient := 1.0;
                        else    -- account for 2 or 3 digit numbers??
                            coefficient := Float'value(Slice(line,I-1,I-1));
                        end if;

                        -- parse sign
                        if I = 1 then
                            coefficient := coefficient * 1.0; -- positive
                        elsif I = 2 then 
                            if Slice(line,I-1,I-1) = "-" then -- first coeff is neg
                                coefficient := coefficient * (-1.0);
                            end if;
                        elsif I = 3 and then Slice(line,I-2,I-2) = "-" then -- - n coefficient
                            coefficient := Float'value(Slice(line,I-1,I-1));
                            coefficient := coefficient * (-1.0);
                        elsif Slice(line,I-2,I-2) = "+" then
                            coefficient := coefficient * 1.0;
                        elsif slice(line,I-2,I-2) = "-" then
                            coefficient := coefficient * (-1.0);
                        elsif slice(line,I-2,I-2) = " " then
                            if Slice(line,I-3,I-3) = "+" then
                                    coefficient := coefficient * 1.0;
                            elsif slice(line,I-3,I-3) = "-" then
                                    coefficient := coefficient * (-1.0);
                            end if;
                        end if;

                        a := coefficient;
                        --  Put("a: Index: " ); Put(Integer'image(a)); 
                        --  Put("a: " ); Put(Integer'image(a)); New_Line;
                    elsif Element(line, I) = 'b' then
                        --  b := I;

                        -- parse coefficient
                        if I = 1 then   -- check if it's the first letter on the line
                            coefficient := 1.0;   -- set coefficient to 1
                        elsif I = 2 and then Slice(line,I-1,I-1) = "-" then -- -1 coefficient
                            coefficient := 1.0;
                        elsif I = 3 and then Slice(line,I-2,I-2) = "-" then -- -n coefficient
                            coefficient := Float'value(Slice(line,I-1,I-1));
                            --  coefficient := coefficient * (-1);
                        elsif Slice(line,I-1,I-1) = " " then -- coefficient is 1
                            coefficient := 1.0;
                        else    -- account for 2 or 3 digit numbers??
                            coefficient := Float'value(Slice(line,I-1,I-1));
                        end if;

                        -- parse sign
                        if I = 1 then
                            coefficient := coefficient * 1.0; -- positive
                        elsif I = 2 then -- coefficient positive
                            if Slice(line,I-1,I-1) = "-" then -- first coeff is neg
                                coefficient := coefficient * (-1.0);
                            end if;
                        elsif I = 3 and then Slice(line,I-2,I-2) = "-" then -- - n coefficient
                            coefficient := Float'value(Slice(line,I-1,I-1));
                            coefficient := coefficient * (-1.0);
                        elsif Slice(line,I-2,I-2) = "+" then
                                coefficient := coefficient * 1.0;
                        elsif slice(line,I-2,I-2) = "-" then
                                coefficient := coefficient * (-1.0);
                        elsif slice(line,I-2,I-2) = " " then
                            if Slice(line,I-3,I-3) = "+" then
                                    coefficient := coefficient * 1.0;
                            elsif slice(line,I-3,I-3) = "-" then
                                    coefficient := coefficient * (-1.0);
                            end if;
                        end if;
                        
                        b := coefficient;
                        --  Put("b: Index: " ); Put(Integer'image(b)); 
                        --  Put("b: " ); Put(Integer'image(b)); New_Line;
                    elsif Element(line, I) = 'c' then
                        --  c := I;

                        -- parse coefficient
                        if I = 1 then   -- check if it's the first letter on the line
                            coefficient := 1.0;   -- set coefficient to 1
                        elsif I = 2 and then Slice(line,I-1,I-1) = "-" then -- -1 coefficient
                            coefficient := 1.0;
                        elsif I = 3 and then Slice(line,I-2,I-2) = "-" then -- -n coefficient
                            coefficient := Float'value(Slice(line,I-1,I-1));
                            --  coefficient := coefficient * (-1);
                        elsif Slice(line,I-1,I-1) = " " then -- coefficient is 1
                            coefficient := 1.0;
                        else    -- account for 2 or 3 digit numbers??
                            coefficient := Float'value(Slice(line,I-1,I-1));
                        end if;

                        -- parse sign
                        if I = 1 then
                            coefficient := coefficient * 1.0; -- positive
                        elsif I = 2 then -- coefficient positive
                            if Slice(line,I-1,I-1) = "-" then -- first coeff is neg
                                coefficient := coefficient * (-1.0);
                            end if;
                        elsif I = 3 and then Slice(line,I-2,I-2) = "-" then -- - n coefficient
                            coefficient := Float'value(Slice(line,I-1,I-1));
                            coefficient := coefficient * (-1.0);
                        elsif Slice(line,I-2,I-2) = "+" then
                                coefficient := coefficient * 1.0;
                        elsif slice(line,I-2,I-2) = "-" then
                                coefficient := coefficient * (-1.0);
                        elsif slice(line,I-2,I-2) = " " then
                            if Slice(line,I-3,I-3) = "+" then
                                    coefficient := coefficient * 1.0;
                            elsif slice(line,I-3,I-3) = "-" then
                                    coefficient := coefficient * (-1.0);
                            end if;
                        end if;

                        c := coefficient;
                        --  Put("c: Index: " ); Put(Float'image(c)); 
                        --  Put("c: " ); Put(Float'image(c)); New_Line;
                    elsif Element(line, I) = 'd' then
                        --  d := I;

                        -- parse coefficient
                        if I = 1 then   -- check if it's the first letter on the line
                            coefficient := 1.0;   -- set coefficient to 1
                        elsif I = 2 and then Slice(line,I-1,I-1) = "-" then -- -1 coefficient
                            coefficient := 1.0;
                        elsif I = 3 and then Slice(line,I-2,I-2) = "-" then -- -n coefficient
                            coefficient := Float'value(Slice(line,I-1,I-1));
                            --  coefficient := coefficient * (-1);
                        elsif Slice(line,I-1,I-1) = " " then -- coefficient is 1
                            coefficient := 1.0;
                        else    -- account for 2 or 3 digit numbers??
                            coefficient := Float'value(Slice(line,I-1,I-1));
                        end if;

                        -- parse sign
                        if I = 1 then
                            coefficient := coefficient * 1.0; -- positive
                        elsif I = 2 then -- coefficient positive
                            if Slice(line,I-1,I-1) = "-" then -- first coeff is neg
                                coefficient := coefficient * (-1.0);
                            end if;
                        elsif I = 3 and then Slice(line,I-2,I-2) = "-" then -- - n coefficient
                            coefficient := Float'value(Slice(line,I-1,I-1));
                            coefficient := coefficient * (-1.0);
                        elsif Slice(line,I-2,I-2) = "+" then
                                coefficient := coefficient * 1.0;
                        elsif slice(line,I-2,I-2) = "-" then
                                coefficient := coefficient * (-1.0);
                        elsif slice(line,I-2,I-2) = " " then
                            if Slice(line,I-3,I-3) = "+" then
                                    coefficient := coefficient * 1.0;
                            elsif slice(line,I-3,I-3) = "-" then
                                    coefficient := coefficient * (-1.0);
                            end if;
                        end if;
                        
                        d := coefficient;
                        --  Put("d: Index: " ); Put(Float'image(d)); 
                        --  Put("d: " ); Put(Float'image(d)); New_Line;
                    elsif Element(line, I) = 'e' then
                        --  e := I;
                        
                        -- parse coefficient
                        if I = 1 then   -- check if it's the first letter on the line
                            coefficient := 1.0;   -- set coefficient to 1
                        elsif I = 2 and then Slice(line,I-1,I-1) = "-" then -- -1 coefficient
                            coefficient := 1.0;
                        elsif I = 3 and then Slice(line,I-2,I-2) = "-" then -- -n coefficient
                            coefficient := Float'value(Slice(line,I-1,I-1));
                            --  coefficient := coefficient * (-1);
                        elsif Slice(line,I-1,I-1) = " " then -- coefficient is 1
                            coefficient := 1.0;
                        else    -- account for 2 or 3 digit numbers??
                            coefficient := Float'value(Slice(line,I-1,I-1));
                        end if;

                        -- parse sign
                        if I = 1 then
                            coefficient := coefficient * 1.0; -- positive
                        elsif I = 2 then -- coefficient positive
                            if Slice(line,I-1,I-1) = "-" then -- first coeff is neg
                                coefficient := coefficient * (-1.0);
                            end if;
                        elsif I = 3 and then Slice(line,I-2,I-2) = "-" then -- - n coefficient
                            coefficient := Float'value(Slice(line,I-1,I-1));
                            coefficient := coefficient * (-1.0);
                        elsif Slice(line,I-2,I-2) = "+" then
                                coefficient := coefficient * 1.0;
                        elsif slice(line,I-2,I-2) = "-" then
                                coefficient := coefficient * (-1.0);
                        elsif slice(line,I-2,I-2) = " " then
                            if Slice(line,I-3,I-3) = "+" then
                                    coefficient := coefficient * 1.0;
                            elsif slice(line,I-3,I-3) = "-" then
                                    coefficient := coefficient * (-1.0);
                            end if;
                        end if;

                        e := coefficient;
                        --  Put("e: Index: " ); Put(Float'image(e)); 
                        --  Put("e: " ); Put(Float'image(e)); New_Line;
                    
                    elsif Element(line, I) = 'f' then
                        --  f := I;

                        -- parse coefficient
                        if I = 1 then   -- check if it's the first letter on the line
                            coefficient := 1.0;   -- set coefficient to 1
                        elsif I = 2 and then Slice(line,I-1,I-1) = "-" then -- -1 coefficient
                            coefficient := 1.0;
                        elsif I = 3 and then Slice(line,I-2,I-2) = "-" then -- -n coefficient
                            coefficient := Float'value(Slice(line,I-1,I-1));
                            --  coefficient := coefficient * (-1);
                        elsif Slice(line,I-1,I-1) = " " then -- coefficient is 1
                            coefficient := 1.0;
                        else    -- account for 2 or 3 digit numbers??
                            coefficient := Float'value(Slice(line,I-1,I-1));
                        end if;

                        -- parse sign
                        if I = 1 then   -- coefficient positive
                            coefficient := coefficient * 1.0; -- positive
                        elsif I = 2 then 
                            if Slice(line,I-1,I-1) = "-" then -- first coeff is neg
                                coefficient := coefficient * (-1.0);
                            end if;
                        elsif I = 3 and then Slice(line,I-2,I-2) = "-" then -- - n coefficient
                            coefficient := Float'value(Slice(line,I-1,I-1));
                            coefficient := coefficient * (-1.0);
                        elsif Slice(line,I-2,I-2) = "+" then
                                coefficient := coefficient * 1.0;
                        elsif slice(line,I-2,I-2) = "-" then
                                coefficient := coefficient * (-1.0);
                        elsif slice(line,I-2,I-2) = " " then
                            if Slice(line,I-3,I-3) = "+" then
                                    coefficient := coefficient * 1.0;
                            elsif slice(line,I-3,I-3) = "-" then
                                    coefficient := coefficient * (-1.0);
                            end if;
                        end if;

                        f := coefficient;
                        --  Put("f: Index: " ); Put(Float'image(f)); 
                        --  Put("f: " ); Put(Float'image(f)); New_Line;

                    --  get the values after the equals sign
                    elsif Element(line, I) = '=' then
                        eq_digit := i;
                        if (Slice(line,eq_digit+2,eq_digit+2) = "-") then
                            pm_val := -1.0;
                            eq_digit := eq_digit + 1;
                        end if;
                        eq_val := Float'value(Slice(line,eq_digit+2,eq_digit+2));
                        if (eq_digit /= line_length) then
                            for num in 1..3 loop
                                --  I := I + 1;
                                --  Put(I + num);
                                eq_digit := eq_digit + num + 2;
                                --  Put(" eq_dig: " ); Put(Float'image(eq_digit)); New_Line;
                                if (eq_digit <= line_length) then
                                    --  Put(" next val: " ); Put(Float'value(Slice(line,eq_digit,eq_digit))); New_Line;
                                    eq_val := eq_val * 10.0 + Float'value(Slice(line,eq_digit,eq_digit));
                                    
                                end if;
                                eq_val := eq_val * pm_val;
                                --  exit when I+num+2 = line_length;
                            end loop;
                        end if;
                        --  end loop;

                        --  Put("eq_val: " ); Put(Float'image(eq_val)); New_Line;
                    --  end if;
                        b_matrix(eq_count) := eq_val;
                        eq_count := eq_count + 1;


                    end if;

                    pm_val := 1.0;

                end loop;
                --  New_Line;

                --  fill the matrix row
                active_matrix(row,1) := a;
                active_matrix(row,2) := b;
                active_matrix(row,3) := c;
                active_matrix(row,4) := d;
                active_matrix(row,5) := e;
                active_matrix(row,6) := f;

                row := row + 1;


                -- will be used if there's more than one system to solve
                -- reset index variables
                a := 0.0; b:= 0.0; c := 0.0; d := 0.0; e := 0.0; f := 0.0;


            end loop;
            --  New_Line;

            if (Simple_Name (Dir_Ent)) = "system1.txt" then
                --  put("hello");
                m1 := active_matrix;
                v_mat1 := b_matrix;
            --  elsif (Simple_Name (Dir_Ent)) = "system2.txt" then
            --      m2 := active_matrix;
            --      v_mat2 := b_matrix;
            end if;

            -- will be used if there's more than one system to solve
            active_matrix :=    ((0.0, 0.0, 0.0, 0.0, 0.0, 0.0),
                                (0.0, 0.0, 0.0, 0.0, 0.0, 0.0),
                                (0.0, 0.0, 0.0, 0.0, 0.0, 0.0),
                                (0.0, 0.0, 0.0, 0.0, 0.0, 0.0),
                                (0.0, 0.0, 0.0, 0.0, 0.0, 0.0),
                                (0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
            eq_count := 1;
            b_matrix := (0.0, 0.0, 0.0, 0.0, 0.0, 0.0);

            row := 1;

            Close(inf);
        end if;

    end loop;
   
    End_Search (Search);

    Put_Line("Matrix 1:"); New_Line;
    PrintMatrix6by6(m1);
    New_Line; Put_Line("Values: "); New_Line;
    PrintMatrix1by6(v_mat1); New_Line;
	detm1 := Determinant(m1, 6);
    Put_Line("determinent(m1):"); New_Line;
    Put((detm1), 5, Aft => 1, Exp => 0); New_Line;
    cofac_m1 := Cofactors(m1, 6);
    New_Line; Put_Line("Cofactors:"); New_Line;
    PrintMatrix6by6(cofac_m1);
    New_Line; Put_Line("Transpose of Cofactors:");
    tpose_m1 := Transpose(cofac_m1);
    New_Line; PrintMatrix6by6(tpose_m1);
    New_Line; Put_Line("Inverse of M1:");
    inv_m1 := MultiplyScalar(tpose_m1, (1.0/detm1));
    New_Line; PrintMatrix6by6(inv_m1);

    final_answer := MultiplyMatrix(inv_m1, v_mat1);
    New_Line; Put_Line("Answer:"); New_Line;
    Put("a: "); Put(final_answer(1), 3, Aft => 1, Exp => 0); New_Line;
    Put("b: "); Put(final_answer(2), 3, Aft => 1, Exp => 0); New_Line;
    Put("c: "); Put(final_answer(3), 3, Aft => 1, Exp => 0); New_Line;
    Put("d: "); Put(final_answer(4), 3, Aft => 1, Exp => 0); New_Line;
    Put("e: "); Put(final_answer(5), 3, Aft => 1, Exp => 0); New_Line;
    Put("f: "); Put(final_answer(6), 3, Aft => 1, Exp => 0); New_Line;

   
end solver;