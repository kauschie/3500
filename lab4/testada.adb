-- ---------------------------------------------------------------------------
-- CMPS 3500
-- testada.adb (filename must match outer procedure name)
-- compile only:            $ gcc -c testada.adb
-- compile and link:        $ gnatmake testada.adb
-- execute:                 $ ./testada
-- --------------------------------------------------------------------------
-- Demonstrate Ada's strong typing, static scoping rules, support for arrays, 
-- abstract data types (ADTs), I/O, and parameter passing mechanisms

with Ada.Text_IO;                 -- similar to include
use Ada.Text_IO;                  -- similar to namespace 
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure Testada is             -- outermost procedure is entry point 

  --  start of declaration section 
  package Flt_IO is new Ada.Text_IO.Float_IO(FLOAT); -- a package is like class
  use Flt_IO;

  str : STRING(1..5);            -- 5 characters
  z : FLOAT;
  b : BOOLEAN := FALSE;          -- values are true/false only
  I : INTEGER;                   -- 32-bit signed int  Ada is case-insensitive 
  n:  NATURAL := 0;              -- NATURAL = {0...2147483647}            
  DOZEN : constant := 12;        -- constant denotes immutable value
  FIRST : constant := 1;         -- first index in array  
  LAST : constant := 10;         -- last index in array  
  MAX_ROW : constant := 3;
  MAX_COL : constant := 4;
  
  subtype SUB_INT is INTEGER range 1..50;  -- an ADT
  one2fifty : SUB_INT;            -- used to set range constraints 

  type AN_ARRAY is array(FIRST..LAST) of SUB_INT; -- an ADT of an ADT
  type LOGIC_ARRAY is array(INTEGER range -1..n) of BOOLEAN; --rich ADT support 
  myArray, yourArray : AN_ARRAY;

  -- 2-dimensional array 
  type MATRIX is array(INTEGER range 1..MAX_ROW, INTEGER range 1..MAX_COL) 
                                                                  of INTEGER; 
  -- example of aggregate initialization
  grid  : MATRIX := ((4, 7, 3, 5),
                    (3, 8, 2, 0),
                    (1, 5, 9, 9));

  --+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  -- demonstrate parameter passing, file I/O, scoping, no compiler coercions 

 procedure nestedTest(z: out FLOAT; flag: in BOOLEAN; stuff: in out INTEGER) is

    i : INTEGER := 5;        -- outer procedure can't see i
    outf, inf : FILE_TYPE;   -- declare two file handlers
  begin
    -- printing a "hello"
    str := "hello"; 
    Put( str ); New_Line; 
    stuff := 5;         -- inout mode parameters are bound to address in caller 
    z := FLOAT(i);      -- all conversions must be explicit
    -- i := z;          -- implicit narrowing coercion not supported
    -- z := i;          -- implicit widening coercion not supported either
    i := n;             -- n from outer procedure (you can see out but not in)
    z := 99.99;         -- 'out' parameter modifies back in calling routine
    -- flag := false;   -- assignment of 'in' parameter not allowed 

    Create(outf, Out_File, "outfile.txt");  -- create and open file for writing
    Open(inf, In_File, "infile.txt");       -- open file for reading 
	New_Line;
    loop                   -- read one int at a time and display it
      exit when End_Of_File(inf);
      Get(inf, n);
      Put(n);
    end loop;
    New_Line;
   
    Put_Line (outf, "NESTED PROCEDURE...");
    New_Line(outf,2);
    Put( "   From nested procedure scope: " );
    Put( "i: " ); 
    Put(i,6);             -- 6 is column width; default width is 11
    Put( " z: "); 
    Put(z,6,2,0);         -- Put(item,fore,aft,exception) 
    New_Line;

    Set_Output(outf);                        -- make outf the default output   
    Put_Line("Now I can write to outfile without the handle");
    Set_Output(Standard_Output);             -- return to stdout

    Put( "   Looking out to outer procedure scope: " ); 
    Put( "n: " ); 
    Put(n,6);
    New_Line;

    Close(inf);
    Close(outf);

  end nestedTest;
  --+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  begin

    i := abs((-((2**3)+10)-3)/2);   -- supports extensive arithmetic operations
    z := 3.5;                       -- z from Inner is not visible 
    nestedTest(z,b,i);              -- will change the value of z to 99.99 

    i := 25 mod DOZEN;    
    i := 25 rem DOZEN;  
    New_Line;                       
    Put_line ("OUTER PROCEDURE....");
    Put( "   From outer procedure scope: " ); 
    Put("i: "); Put(i,6);                
    Put( " n: " ); Put(n,6);
    Put( " z: " ); 
    Put(z,6,2,0);  -- z is real formatted 6 width with 
    New_Line;                       

    Put("   NATURAL={");Put(NATURAL'FIRST,1); -- first element in NATURAL type
    Put("...");Put(NATURAL'LAST);             -- last element in NATURAL type
    Put("}");
    New_Line;                       

    -- test one-dimensional array - index starts and stops where you specify 

    for index in FIRST..LAST loop       -- index is implicitly declared 
      myArray(index) := 2 * index + 1;  -- range constraint checked at runtime
    end loop;

    Put("   1st array element should be 3: ");
    Put(myArray(1),6);
    -- the next line will compile but will trigger runtime exception
    -- uncomment to test it
    -- Put(myArray(99),6);  
    New_Line;       
    myArray(1..4) := MyArray(5..8); -- can grab and assign slices of arrays 
    yourArray := myArray;           -- can assign arrays of like structure 

    -- working with two-dimensional arrays
    Put("Enter a number greater than ");
    Put(MAX_ROW);
    Put(": ");
    Get(Standard_Input, i); 
    for row in 1..MAX_ROW loop    
       for col in 1..MAX_COL loop
          grid(row, col) := row;
          --grid(i, i) := row; -- doing this will cause a constraint error 
          Put(grid(row, col), 3);
          Put(",");
          Put(col, 1);
       end loop;
       New_Line;
    end loop;

    i := -1;
    n := i;      -- INT and NATURAL are both integers - will compile w/ warning
                 -- will raise a range error exception at runtime 

    one2fifty := i;  -- this would raise a range error exception also

end Testada; 
