#!/usr/bin/perl

#  NAME: Michael Kausch
#  ASGT: Activity 3
#  ORGN: CSUB - CMPS 3500
#  DATE: 02/25/2023


# Force good habits :}
use strict;
use warnings;

# File I/O setup
my $infile = "StackOverflow.csv";
open(INFILE, $infile);
my $tagfile = ">tags.out";
open(TAGOUTFILE, $tagfile);
my $domfile = ">web_regex.txt";
open(DOMOUTFILE, $domfile);
my $emailfile = ">email_regex.txt";
open(EMAILOUTFILE, $emailfile);

my $hq_count = 0;
my $tags="";

my %tag_hash;
my %domains_hash;
my %emails_hash;

my $domains_num = 0;
my $emails_num = 0;

# main program loop for reading lines
while (<INFILE>) {
    chomp;      # bite off newline character
    my $post_content = $_;  # grab what's left from the temp var


    # GETTING ID NUMS   # debug
    # if ( $post_content =~ /^([0-9]{8}),/ ) {
    #     $id_num = $1;
    #     # print "$id_num\n";
    #     $id_count += 1;
    #     # $found_id_flag = 1;
    #     # print OUTFILE "$id_num\t";
    #     # print "$id_num\t";

    # }

    # TAGS
    if ( $post_content =~ /,(<.*>),([0-9].*),(HQ|LQ_CLOSE|LQ_EDIT)/ ) {
    # if ( $post_content =~ /,((<[a-zA-Z0-9#_+.-]*>)+),/ ) {
    # if ( $post_content =~ /,(<.*>),/ ) {
        $tags = $1;
        $tags =~ s/</ /g;
        $tags =~ s/>/ /g;
        $tags =~ s/ +/ /g;
        my @tags_separated = split (" ",$tags);
        # all tags sepearted
        foreach (@tags_separated) {
            # print "$_\n";
            my $hkey = $_;
            next if ($hkey eq "android") ;  # skip android bc it's not a PL

            if (exists $tag_hash{$hkey}) {
                # print "$hkey already exists\n";
                # print "incrementing $hkey\n";
                $tag_hash{$hkey}++;
                # print "$hkey\'s count is now $tag_hash{$hkey}\n";
            }
            else {
                # print "adding $hkey\n";
                $tag_hash{$hkey} = 1;
                # print "$hkey\'s count is set to $tag_hash{$hkey}\n";
            }
        }
    }
        # search for http or https domains
    if ( $post_content =~ m{(https?://(www\.)?([\w-]+\.)+\w+)}) {
        my $dkey = $1;
        # print "$dkey\n";
        # split the domain on the :// 
        my @d_split = split ("://",$dkey);
        # print "$d_split[1]\n";

        # if the domain starts witha number , skip
        if ($d_split[1] =~ m/^[0-9]{1,4}\..*/) {
            ## skip
            # check if it is in the hash already
        } elsif (exists $domains_hash{$dkey}) {
            # print "$hkey already exists\n";
            # print "incrementing $hkey\n";
            $domains_hash{$dkey}++;
            # print "$hkey\'s count is now $tag_hash{$hkey}\n";
        }
        else {
            # print "adding $hkey\n";
            $domains_hash{$dkey} = 1;
            # print "$hkey\'s count is set to $tag_hash{$hkey}\n";
        }
        
    }

        # search for HQ posts
    if ( $post_content =~ /,(<.*>),([0-9].*),(HQ)/ ) {
        # print "$post_content\n";
        # $quality = $1;
        $hq_count += 1;
        # print OUTFILE "$quality\n";
        # print "$quality\n";

    }

    # trying out different regex's to see which is better

    # if ( $post_content =~ m{([\w\.-]+@([\w-]+\.)+[\w-]{2,4})}) {
    # if ( $post_content =~ m{([a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+)}) {
    
    # grabs domains with atleast 3 chars
    if ( $post_content =~ m{([\w\.-]+@([\w-]{3,}\.)+[\w-]{2,4})}) { 
        my $ekey = $1;

        # split on @
        my @e_split = split ("@",$ekey);
        # print "$e_split[1]\n";


        #  look to see if email domain starts with a number bc those are bogus
        if ($e_split[1] =~ m/^[0-9].*/) {
            ## skip
        } elsif (exists $emails_hash{$ekey}) {
            # print "$hkey already exists\n";
            # print "incrementing $hkey\n";
            $emails_hash{$ekey}++;
            # print "$hkey\'s count is now $tag_hash{$hkey}\n";
        }
        else {
            # print "adding $hkey\n";
            $emails_hash{$ekey} = 1;
            # print "$hkey\'s count is set to $tag_hash{$hkey}\n";
        }
        
    }


}

# print "There are $id_count ID's.\n";
# print "I found $tags_count Lines of tags.\n";

# var declarations that are temporarily used in file IO only
my $key;
my $value;

# mostly debug to see what tags are being printed
while ( ($key,$value) = each %tag_hash ) {
      print TAGOUTFILE "$value : $key\n";
}

$domains_num = scalar (keys %domains_hash);
print "1. There are $domains_num unique website domain in StackOverflow.csv\n";
while ( ($key,$value) = each %domains_hash ) {
      print DOMOUTFILE "$value : $key\n";
}
print "web_regex.txt has been written...\n\n";


$emails_num= scalar (keys %emails_hash);
print "2. There are $emails_num unique emails in StackOverflow.csv\n";
while ( ($key,$value) = each %emails_hash ) {
      print EMAILOUTFILE "$value : $key\n";
}
print "email_regex.txt has been written...\n\n";

print "3. There are $hq_count HQ Posts.\n\n";

# make sorted_keys list from hash
my @sorted_keys = sort { $tag_hash{$b} <=> $tag_hash{$a} } keys %tag_hash;
print "4. The five most popular programming languages mentioned in the Tags column of StackOverflow.csv are:\n";
print "\t1: $sorted_keys[0]\n";
print "\t2: $sorted_keys[1]\n";
print "\t3: $sorted_keys[2]\n";
print "\t4: $sorted_keys[3]\n";
print "\t5: $sorted_keys[4]\n\n";













close(INFILE);
close(TAGOUTFILE);
close(EMAILOUTFILE);
close(DOMOUTFILE);

# my @content_array = split /([0-9]{8}),(\w.*),("(<p>)?.*"),((<\w*>)+),(.*),(LQ_EDIT|HQ|LQ_CLOSE)/m , $file_content;
# my @content_array = split /([0-9]{8}),(\w.*),(LQ_EDIT|HQ|LQ_CLOSE)/gm , $file_content;

#     # my $inputline =~ m/([0-9]{8}.*)(LQ_CLOSE|HQ|LQ_EDIT)/s;
#     # $inputline =~ m/([0-9]{8}.*?)/s;


# # ([0-9]{8}),(\w.*),("(<p>)?.*"),((<\w*>)+),(.*),(LQ_EDIT|HQ|LQ_CLOSE)

#     # print "$1";

# }