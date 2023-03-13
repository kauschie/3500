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
-- --------------------------------------------------------------------------
with Ada.Directories;   use Ada.Directories;
with Ada.Text_IO;       use Ada.Text_IO;
--  with Gnat.IO;           use Gnat.IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
--  with Ada.Strings.Bounded;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Text_IO; use Ada.Strings.Unbounded.Text_IO;
 
procedure solver is
	Directory : String := ".";
    Pattern   : String := ""; -- empty pattern = all file names/subdirectory names
	Search    : Search_Type;
    Dir_Ent   : Directory_Entry_Type;
	smatch    : String := "txt";
    inf       : FILE_TYPE;
    matrix    : array (1..6, 1..6) of Integer :=
                                                    ((0, 0, 0, 0, 0, 0),
                                                    (0, 0, 0, 0, 0, 0),
                                                    (0, 0, 0, 0, 0, 0),
                                                    (0, 0, 0, 0, 0, 0),
                                                    (0, 0, 0, 0, 0, 0),
                                                    (0, 0, 0, 0, 0, 0));



    line : Unbounded_String;
    line_length, arr_index : NATURAL;
    coefficient : Integer := 0;
    a, b, c, d, e, f : Integer := 0;


    --  fname     : String (1 .. 100);  need to make unbounded string -- look up if you need
begin
    Start_Search (Search, Directory, Pattern);
    --searchs each file in current folder
    while More_Entries (Search) loop
        Get_Next_Entry (Search, Dir_Ent);
      
	    if Tail (Simple_Name (Dir_Ent), smatch'Length) = smatch then
            --  Put_Line (Simple_Name (Dir_Ent));
            Open(inf, In_File, Simple_Name(Dir_Ent));       -- open file for reading 

            -- read in file
            loop
                exit when End_Of_File(inf);
                line := Get_Line(inf);  -- read unbounded string into line
                line_length := Length(line);
                
                Put_Line(line);         -- write line ((debug))
                Put_line("writing where i find indices...");
                for i in 1 .. line_length loop
                    --  Put(Element(line, I));
                    if Element(line, I) = 'a' then
                        -- get index
                        a := I;

                        -- parse coefficient
                        if I = 1 then   -- check if it's the first letter on the line
                            coefficient := 1;   -- set coefficient to 1
                        elsif Slice(line,I-1,I-1) = " " then -- coefficient is 1
                            coefficient := 1;
                        else    -- account for 2 or 3 digit numbers??
                            coefficient := Integer'value(Slice(line,I-1,I-1));
                        end if;

                        -- parse sign
                        if I = 1 then
                            coefficient := coefficient * 1; -- positive
                        elsif I = 2 then 
                            if Slice(line,I-1,I-1) = "-" then -- first coeff is neg
                                coefficient := coefficient * (-1);
                            end if;
                        elsif Slice(line,I-2,I-2) = "+" then
                                coefficient := coefficient * 1;
                        elsif slice(line,I-2,I-2) = "-" then
                                coefficient := coefficient * (-1);
                        elsif slice(line,I-2,I-2) = " " then
                            if Slice(line,I-3,I-3) = "+" then
                                    coefficient := coefficient * 1;
                            elsif slice(line,I-3,I-3) = "-" then
                                    coefficient := coefficient * (-1);
                            end if;
                        end if;

                        Put("a: Index: " ); Put(Integer'image(a)); 
                        Put(" val: " ); Put(Integer'image(coefficient)); New_Line;
                    elsif Element(line, I) = 'b' then
                        b := I;

                        -- parse coefficient
                        if I = 1 then   -- check if it's the first letter on the line
                            coefficient := 1;   -- set coefficient to 1
                        elsif Slice(line,I-1,I-1) = " " then -- coefficient is 1
                            coefficient := 1;
                        else    -- account for 2 or 3 digit numbers??
                            coefficient := Integer'value(Slice(line,I-1,I-1));
                        end if;

                        -- parse sign
                        if I = 1 then
                            coefficient := coefficient * 1; -- positive
                        elsif I = 2 then -- coefficient positive
                            if Slice(line,I-1,I-1) = "-" then -- first coeff is neg
                                coefficient := coefficient * (-1);
                            end if;
                        elsif Slice(line,I-2,I-2) = "+" then
                                coefficient := coefficient * 1;
                        elsif slice(line,I-2,I-2) = "-" then
                                coefficient := coefficient * (-1);
                        elsif slice(line,I-2,I-2) = " " then
                            if Slice(line,I-3,I-3) = "+" then
                                    coefficient := coefficient * 1;
                            elsif slice(line,I-3,I-3) = "-" then
                                    coefficient := coefficient * (-1);
                            end if;
                        end if;

                        Put("b: Index: " ); Put(Integer'image(b)); 
                        Put(" val: " ); Put(Integer'image(coefficient)); New_Line;
                    elsif Element(line, I) = 'c' then
                        c := I;

                        -- parse coefficient
                        if I = 1 then   -- check if it's the first letter on the line
                            coefficient := 1;   -- set coefficient to 1
                        elsif Slice(line,I-1,I-1) = " " then -- coefficient is 1
                            coefficient := 1;
                        else    -- account for 2 or 3 digit numbers??
                            coefficient := Integer'value(Slice(line,I-1,I-1));
                        end if;

                        -- parse sign
                        if I = 1 then
                            coefficient := coefficient * 1; -- positive
                        elsif I = 2 then -- coefficient positive
                            if Slice(line,I-1,I-1) = "-" then -- first coeff is neg
                                coefficient := coefficient * (-1);
                            end if;
                        elsif Slice(line,I-2,I-2) = "+" then
                                coefficient := coefficient * 1;
                        elsif slice(line,I-2,I-2) = "-" then
                                coefficient := coefficient * (-1);
                        elsif slice(line,I-2,I-2) = " " then
                            if Slice(line,I-3,I-3) = "+" then
                                    coefficient := coefficient * 1;
                            elsif slice(line,I-3,I-3) = "-" then
                                    coefficient := coefficient * (-1);
                            end if;
                        end if;

                        Put("c: Index: " ); Put(Integer'image(c)); 
                        Put(" val: " ); Put(Integer'image(coefficient)); New_Line;
                    elsif Element(line, I) = 'd' then
                        d := I;

                        -- parse coefficient
                        if I = 1 then   -- check if it's the first letter on the line
                            coefficient := 1;   -- set coefficient to 1
                        elsif Slice(line,I-1,I-1) = " " then -- coefficient is 1
                            coefficient := 1;
                        else    -- account for 2 or 3 digit numbers??
                            coefficient := Integer'value(Slice(line,I-1,I-1));
                        end if;

                        -- parse sign
                        if I = 1 then
                            coefficient := coefficient * 1; -- positive
                        elsif I = 2 then -- coefficient positive
                            if Slice(line,I-1,I-1) = "-" then -- first coeff is neg
                                coefficient := coefficient * (-1);
                            end if;
                        elsif Slice(line,I-2,I-2) = "+" then
                                coefficient := coefficient * 1;
                        elsif slice(line,I-2,I-2) = "-" then
                                coefficient := coefficient * (-1);
                        elsif slice(line,I-2,I-2) = " " then
                            if Slice(line,I-3,I-3) = "+" then
                                    coefficient := coefficient * 1;
                            elsif slice(line,I-3,I-3) = "-" then
                                    coefficient := coefficient * (-1);
                            end if;
                        end if;
                        
                        Put("d: Index: " ); Put(Integer'image(d)); 
                        Put(" val: " ); Put(Integer'image(coefficient)); New_Line;
                    elsif Element(line, I) = 'e' then
                        e := I;
                        
                        -- parse coefficient
                        if I = 1 then   -- check if it's the first letter on the line
                            coefficient := 1;   -- set coefficient to 1
                        elsif Slice(line,I-1,I-1) = " " then -- coefficient is 1
                            coefficient := 1;
                        else    -- account for 2 or 3 digit numbers??
                            coefficient := Integer'value(Slice(line,I-1,I-1));
                        end if;

                        -- parse sign
                        if I = 1 then
                            coefficient := coefficient * 1; -- positive
                        elsif I = 2 then -- coefficient positive
                            if Slice(line,I-1,I-1) = "-" then -- first coeff is neg
                                coefficient := coefficient * (-1);
                            end if;
                        elsif Slice(line,I-2,I-2) = "+" then
                                coefficient := coefficient * 1;
                        elsif slice(line,I-2,I-2) = "-" then
                                coefficient := coefficient * (-1);
                        elsif slice(line,I-2,I-2) = " " then
                            if Slice(line,I-3,I-3) = "+" then
                                    coefficient := coefficient * 1;
                            elsif slice(line,I-3,I-3) = "-" then
                                    coefficient := coefficient * (-1);
                            end if;
                        end if;

                        Put("e: Index: " ); Put(Integer'image(e)); 
                        Put(" val: " ); Put(Integer'image(coefficient)); New_Line;
                    
                    elsif Element(line, I) = 'f' then
                        f := I;

                        -- parse coefficient
                        if I = 1 then   -- check if it's the first letter on the line
                            coefficient := 1;   -- set coefficient to 1
                        elsif Slice(line,I-1,I-1) = " " then -- coefficient is 1
                            coefficient := 1;
                        else    -- account for 2 or 3 digit numbers??
                            coefficient := Integer'value(Slice(line,I-1,I-1));
                        end if;

                        -- parse sign
                        if I = 1 then   -- coefficient positive
                            coefficient := coefficient * 1; -- positive
                        elsif I = 2 then 
                            if Slice(line,I-1,I-1) = "-" then -- first coeff is neg
                                coefficient := coefficient * (-1);
                            end if;
                        elsif Slice(line,I-2,I-2) = "+" then
                                coefficient := coefficient * 1;
                        elsif slice(line,I-2,I-2) = "-" then
                                coefficient := coefficient * (-1);
                        elsif slice(line,I-2,I-2) = " " then
                            if Slice(line,I-3,I-3) = "+" then
                                    coefficient := coefficient * 1;
                            elsif slice(line,I-3,I-3) = "-" then
                                    coefficient := coefficient * (-1);
                            end if;
                        end if;

                        Put("f: Index: " ); Put(Integer'image(f)); 
                        Put(" val: " ); Put(Integer'image(coefficient)); New_Line;

                    end if;
                end loop;
                New_Line;


                -- reset index variables
                a := 0; b:= 0; c := 0; d := 0; e := 0; f := 0;

                -- doesn't work
                --  arr_index := Index(To_String(line), "2a", line_length);
                --  Put(arr_index);

                -- works
                -- returns the integer val of a slice
                --  coefficient := Integer'value(Slice(line,1,1));
                --  Put(coefficient);

            end loop;
            New_Line;






            --  fname := Simple_Name(Dir_Ent);
            --  Put_Line (fname);
            Close(inf);
        end if;

    end loop;
   
    End_Search (Search);  
   
end solver;