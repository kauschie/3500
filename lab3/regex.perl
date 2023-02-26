#!/usr/bin/perl

# regex.perl

# demonstrate Perl's support for regular expressions
# inputfile format:
# 7776 ACN Accenture,Ltd.

$infile = "nyse.in";
$outfile = ">nyse.out";

# use '>' to overwrite existing file; use '>>' to append

open(INFILE, $infile);
open(OUTFILE, $outfile);

while(<INFILE>) {
  # remove CR or LF from $_
  chomp;                        

  # assign the default current line $_ to another string
  $line = $_;                   

  # ensure that only one space separates words
  $line =~ s/ +/ /g;            

  # create three substrings and reverse the order of the first two 
  # also add quotes around the company name
  $line =~ s/(^[0-9]*) ([A-Z]{3}) (.*$)/$2 $1 "$3"/;

  print "$line\n";

  # remove anything past a comma to the end of the line - add back the 
  # closing quote
  $line =~ s/,.*$/"/;

  # add a space between words in the company name that are collapsed
  $line =~ s/([a-z])([A-Z])/$1 $2/;

  # repeat the same command in case there are more than 2 collapsed words
  $line =~ s/([a-z])([A-Z])/$1 $2/;

  # remove '&' and '-' and ''' from file
  $line =~ s/&/ and /;
  $line =~ s/-/ /;
  $line =~ s/'/ /;

  # remove dots (BE CAREFUL - the dot must be escaped)
  $line =~ s/\./ /g;

  # tr can also be used to translate one ASCII character into another
  # this command replaces DOS linefeeds with the null character.
  $line =~ tr/\15/\00/;

  # split the line into 3 fields using a space as the delimiter
  ($field1,$field2,$field3) = split ' ', $line;

  # print fields of those lines that match a regular expression
   if ($line =~ /7[1-5]/ ){ 
      print "field1: $field1 field2: $field2 \n";
   }

   # write all lines to the output file
   print OUTFILE "$line \n";  
}
close(INFILE);        
close(OUTFILE);   


