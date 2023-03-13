-- ---------------------------------------------------------------------------
-- CMPS 3500
-- walk_directory.adb (filename must match outer procedure name)
-- compile only:            $ gcc -c walk_directory.adb
-- compile and link:        $ gnatmake walk_directory.adb
-- execute:                 $ ./walk_directory
-- --------------------------------------------------------------------------
with Ada.Directories;   use Ada.Directories;
with Ada.Text_IO;       use Ada.Text_IO;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
 
procedure walk_directory is
	Directory : String := ".";
    Pattern   : String := ""; -- empty pattern = all file names/subdirectory names
	Search    : Search_Type;
    Dir_Ent   : Directory_Entry_Type;
	smatch    : String := "txt";
begin
    Start_Search (Search, Directory, Pattern);
    --searchs each file in current folder
    while More_Entries (Search) loop
        Get_Next_Entry (Search, Dir_Ent);
      
	    if Tail (Simple_Name (Dir_Ent), smatch'Length) = smatch then
            Put_Line (Simple_Name (Dir_Ent));
        end if;

    end loop;
   
    End_Search (Search);  
   
end walk_directory;