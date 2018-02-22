#!/usr/bin/perl -w

use strict;
my $msg="usage: $0 refseq-known_genes.txt\n";


my %seen;
open(TAB, "<$ARGV[0]") or die $msg;
open(O5, ">$ARGV[0]_5UTR")or die $msg;
open(O3, ">$ARGV[0]_3UTR")or die $msg;
my $line;

$line=<TAB>;#header
print O5 "gene\ttranscript\tchr\tUTR_start\tUTR_end\tstrand\n";
print O3 "gene\ttranscript\tchr\tUTR_start\tUTR_end\tstrand\n";
while ($line=<TAB>){
  chomp $line;
  my @l=split ("\t",$line);
  my $trans=$l[1];
  if ($seen{$trans}++){
    $trans=$trans."_dup".($seen{$trans}-1);
  }
  if($l[3] ne "-"){
    print O5 "$l[12]\t$l[1]_5UTR\t$l[2]\t$l[4]\t$l[6]\t$l[3]\n";  
    print O3 "$l[12]\t$l[1]_3UTR\t$l[2]\t$l[7]\t$l[5]\t$l[3]\n";  

  }else{
    print O3 "$l[12]\t$l[1]_3UTR\t$l[2]\t$l[4]\t$l[6]\t$l[3]\n";  
    print O5 "$l[12]\t$l[1]_5UTR\t$l[2]\t$l[7]\t$l[5]\t$l[3]\n";  

  }
}
#carefull: might contain intron sequences that must be filtered seperately
close TAB;
close O3;
close O5;

