/*  Test.java   <= filename must be the name of the class
 *  Demonstrates some basic Java constructs, variables and I/O 
 *  Expects a file named file.in  that looks like this:
 *
 *   1 this is the first line
 *   2 this is the second line
 *   3 this is the third line
 *   
 *  When you execute a class with the Java interpreter, the runtime 
 *  system starts by calling the class's main() function. The main() function 
 *  then calls all the other functions required to run your application;
 *  since all Java functions must be inside a class - even the simplest 
 *  function requires a dummy wrapper class. This design results in deeply 
 *  nested wrapping
 */ 

import java.io.*;     // import everything having to do with I/O
import java.util.List;
import java.util.LinkedList;

public class Test
{
   // 'throws IOException' is necessary for the io stream
   public static void main (String[] args) throws IOException
   {
      final int SIZE = 30;  // final is similar to const in C++
      // SIZE = 20;  <== modifying SIZE is illegal


      Integer intObj = new Integer(30);  // Java also has Integer objects
      System.out.println ("Integer object value: " + intObj);

      System.out.println(intObj);
      char array[] = new char[SIZE];  // in Java an array is an object

      System.out.println("Enter a single character:");
      int aChar  = System.in.read();    // predefined input routine
      System.out.println ("Char read: " + aChar + " SIZE: " + SIZE);

      // display the command line arguments if any
      for (int i = 0; i < args.length; i++)
           System.out.print(i == 0 ? args[i] : " " + args[i]);
      System.out.println();

      // this creates a custom input StreamReader object 
      InputStreamReader isr = new InputStreamReader( System.in );
      BufferedReader stdin = new BufferedReader(isr);

      // prompt the user and read a string from stdin 
      System.out.println("What is your numerical ID?");
      String buff  = stdin.readLine();  // clear input buffer from earlier read 
      String ID = stdin.readLine();

      int intID = Integer.parseInt(ID);   // convert ID into an integer

      double num = 5.4; 
      System.out.print("Num: " + num + " A Literal is enclosed in quotes\n\n");

      System.out.println (intID + " = " + ID);

      // open a sequential file for buffered reading 
      FileReader fr = new FileReader( "file.in" );
      BufferedReader infile = new BufferedReader( fr, 4096 /* buffsize */ );

      // create a linked list of Strings to hold the input lines
      List<String> lines = new LinkedList<String>();      

      // read a line from infile 
      String line;
      line = infile.readLine();
      System.out.println("Line: " + line + "\n\n");


      // add the remaining lines to the linked list
      while (line != null) {
        lines.add(line);
        line = infile.readLine();
      }

      // read the EOF left in br (which should be -1)
      aChar = infile.read();
      System.out.print("EOF: " + aChar + "\n\n");

      // display the lines (for loop follows C syntax)
      for (int i=0; i<=2; i++ ) {
          System.out.print("lines[i]: " + lines.get(i) + "\n\n");
      }

      // grab a line
      String tmp = lines.get(0);

      tmp = tmp.trim();   // trim leading and trailing spaces

      // parse one of the lines using split with an RE 
      // see 'man perlrequick' for help on regexps 
      // '\s' denotes a whitespace character (must be escaped with another \) 
      // '+' means 1 or more times (i.e., at least once)
      String[] split_line = tmp.split("\\s+");

      // convert the first element in the split line into an integer
      int inum = Integer.parseInt(split_line[0]); 
      System.out.print("first integer value: " + inum + "\n\n");

      // C L O S E
      infile.close();  

   }   // end main
}
