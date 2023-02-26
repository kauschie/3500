#!/usr/bin/perl

# filename: test.perl

# run with 
#    $ perl test.perl  
# or 
#    $ ./test.perl with execute permission on test.perl
# or  $ perl -d test.perl for debugging 

# uncomment if you want perl not to let you be sloppy 
# use strict;
# use warnings;

# demonstrates some of the basic elements of Perl : type, scope, primitive
# variables, basic control structures, functions, I/O 

# Perl can dynamically coerce a scalar number to a string (or vice versa)
# through implicit heap-dynamic deallocation and allocation of memory storage
# ( this is automatic memory management )

# Perl has dynamic typing (duck-typing)
my $var = 5.3;  # '$' means this a a scalar 
                # $var = 5.3 is dynamic typing to number type
print "float: $var\n";
$var = 7;
print "int: $var\n";

print "\nvar (an implicit scalar) begins as a number: $var\n";

$var = "hello there";             # a string is a primitive scalar type 
print "becomes a string: $var\n"; 
$var = 7;
print "now var is a number: $var\n";
$var = "".$var;
if ($var eq "7"){
   print "now var is coerced to a string with concatenation op: $var\n";
}

$var = 5;
my $catvar = $var + 'a';
print "5 + 'a' is: $catvar\n";    # perl coerces 'a' into an int of value zero 
$catvar = "hello" + " there";
print "hello+there=$catvar\n";    # perl does NOT overload +
$catvar = "hello" . " there";
print "hello.there=$catvar\n";    # use . to concatentate

if ($var)   {                     # if and else requires {} to enclose block
   print "true\n";
}
else {
   print "false\n";
}

my $var2 = 0;
my @var2 = ('c','d','e','b','f','a',);   # denote array with sigil @
my @sorted = sort(@var2);        # sort the array
print "Sorted array:\n@sorted";  # print all elements in sorted array
print "\nvar2[0]:\t$var2[0]\n";  # access element in array
$var2[0] = $var2[0] + 10;        # coerce 'c' into an integer with value zero 
print "var2[0]+10:\t$var2[0]\n"; # should display 10 
$var2[0] = 3.4e-7;               # coerce to a very small real number 
print "3.4e-7:\t\t$var2[0]\n";
$var2[0] = $var2[0] * 1e7;       # scientific notation example 
print "*10^7:\t\t$var2[0]\n";

# Demonstrate scope:
{                                  # all variables are global unless in block
   my $var = "inner";              # 'my' variable is local to enclosing block
   print "\ninner var: $var\n";
} 
print "outer var: $var\n";

# Demonstrate the primitive associative array type with implicit type % 
# a associative array represents a set of key/value pairs (e.g. hash table)

my %hi_temps = ("Mon" => 77, "Tue" => 79, "Wed" => 65, "Thu" => 56,);        
print "Monday: $hi_temps{Mon}\n"; # access scalar elements by the key

$hi_temps{Wed} = 83;              # modify hash elements 
$hi_temps{Fri} = 99;              # add a new element to the hash
my @days = keys%hi_temps;         # grab the keys 
print "Keys: @days\n";            # print keys
delete $hi_temps{Tue};            # remove keys with delete
@days = keys%hi_temps;            # grab the keys
print "Keys: @days\n";

# 'each' returns a two-element array of key and value for each hash entry
my $key;
my $value;
while ( ($key,$value) = each %hi_temps ) {
      print "$key = $value\n";
}

print "Enter stuff: ";
my $stuff = <stdin>;             # read string from the keyboard
chomp($stuff);                   # remove the CR
print "1st stuff: $stuff\n";
print "Enter more stuff: ";
$stuff = <stdin>;                # read a longer string 
chomp($stuff);                   # remove the CR
print "more stuff: $stuff\n";

# demonstrate dynamic parameter lists for function calls
&test($stuff, 'the hat');         
&test(5, 10);
&test(15, 20, 30);                 # no worries if you pass too many args

my $foo = +(6/2).".".0.0;          # 3.00
my $bar = 3;                       # 3.00
if ($foo == $bar) {
   print "$foo equals $bar\n";                     
}
print (7/2);                       # print 3.5 perl does not do integer division
print "\n";

#  open a file for writing ; use '>' to write new and '>>' for append mode  
my $outfile = ">outfile";
if (!open(outf, $outfile)) { 
   print "unable to open output file\n";
}
print outf "this is log file...\n";
close(outf); 

# demonstrate function definition with implicit parameters
# parameters are passed as array @_ 
# $_ is a default scalar variable
# @_ is a default array variable
# Passed scalars are referenced as $_[0], $_[1], $_[2], ...
sub test { 
   my $first = $_[0];
   my $second = $_[1];
   print "$first and $second\n";
   my $result =  $first + $second;     # strings are coerced to '0' 
   print "first + second: $result\n";
}
