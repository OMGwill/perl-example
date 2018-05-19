 #!usr/bin/perl          Author: Will Luttmann
use warnings;
$|=1;


my @field;
my $passFail = "NULL";
my $lineNumber = "0";
my $errorInput = "0";
my $errorField = "0";

#user input file
# print "Please enter 'filename.txt': \n";
# $filename = <STDIN>;
# print "\n\n";
# open (FH, $filename);

#Open file and print its contents
open (FH, "in.txt");



while (<FH>){

@field = split(/\|/);     #puts each 'word' separated by | into an array 'field'
$lineNumber++;            #count what line we are on

                                             #field N check to pass
  if ($field[4] =~ /N/ && $field[5] =~ /^-?\d+(\.|\.\d+)?$/ &&
           $field[6] =~ /\s/ && $field[7] =~ /\s/){
        $passFail = "OK";
  }
                                            #field C check to pass
  elsif ($field[4] =~ /C/ && $field[5] =~ /\s/ &&
             $field[6] =~ /^[a-zA-Z]$/ && $field[7] =~ /\s/){
       $passFail = "OK";

  }
                                            #field D check to pass
  elsif ($field[4] =~ /D/ && $field[5] =~ /\s/ && $field[6] =~ /\s/ &&
             $field[7] =~ /^(0[1-9]|1[012])[\/](0[1-9]|[12][0-9]|3[01])[\/][0-9]{4}/){
       $passFail = "OK";

  }

  else {
      $passFail = "NO";
                                         #error checks
      print STDERR "Error on line $lineNumber \t";
      if ($field[4] =~ /N/ && $field[6] =~ /\s/ && $field[7] =~ /\s/) {
            $errorInput++;
           print STDERR "Invalid input in |numeric_value| field \n";

      }elsif ($field[4] =~ /N/ && $field[5] =~ /\s/){
            $errorField++;
            print STDERR "Numeric input is in wrong field \n";

       }elsif ($field[4] =~ /C/ && $field[5] =~ /\s/ && $field[7] =~ /\s/){
            $errorInput++;
            print STDERR "Invalid input in |character_value| field \n";

      }elsif ($field[4] =~ /C/ && $field[6] =~ /\s/){
            $errorField++;
            print STDERR "Character input is in wrong field \n";

      }elsif ($field[4] =~ /D/ && $field[5] =~ /\s/ && $field[6] =~ /\s/){
            $errorInput++;
            print STDERR "Invalid input in |date_value| field \n";

       }elsif ($field[4] =~ /D/ && $field[7] =~ /\s/){
            $errorField++;
            print STDERR "Date input is in wrong field \n";
      }
  }

print "$passFail --- "; #prints ok/no if it pass/fail
print $_; #prints current line


}
close FH;
print "\n\n";  #space between summary

print "There are $errorInput invalid inputs. \n";      #prints number of each
print "There are $errorField invalid field entries. \n";  #error
