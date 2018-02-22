#!/usr/bin/perl -w

use strict;
my $msg="usage: $0 refseq-known_genes.txt\n";


my %seen;
open(TAB, "<$ARGV[0]") or die $msg;
my $line;

$line=<TAB>;#header
print "gene\ttranscript\tchr\tstart\tend\tstrand\tlength\n";
while ($line=<TAB>){
  chomp $line;
  my @l=split ("\t",$line);
  my @exon_start=split(",",$l[9]);
  my @exon_end=split(",",$l[10]);
  my $trans=$l[1];
  if ($seen{$trans}++){
    $trans=$trans."_dup".($seen{$trans}-1);
  }
  my $length=0;
  for(my $i =0;$i<$l[8];$i++){
    #print "$l[2]\t$exon_start[$i]\t$exon_end[$i]\t$l[3]\t$l[12]\t$trans\t$enr\n";  
    $length+=$exon_end[$i]-$exon_start[$i];
  }
  print "$l[12]\t$l[1]\t$l[2]\t$l[4]\t$l[5]\t$l[3]\t$length\n";
  
}
close TAB
