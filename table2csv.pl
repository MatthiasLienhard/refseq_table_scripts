#!/usr/bin/perl -w

use strict;
my $msg="usage: $0 refseq-known_genes.txt\n";


my %seen;
open(TAB, "<$ARGV[0]") or die $msg;
my $line;

$line=<TAB>;#header
print "chr\tstart\tend\tstrand\tgene\ttranscript\texon_nr\n";
while ($line=<TAB>){
  chomp $line;
  my @l=split ("\t",$line);
  my @exon_start=split(",",$l[9]);
  my @exon_end=split(",",$l[10]);
  my $trans=$l[1];
  if ($seen{$trans}++){
    $trans=$trans."_dup".($seen{$trans}-1);
  }
  for(my $i =0;$i<$l[8];$i++){
    my $enr=$l[3] eq "+" ? $i+1: $l[8]-$i;
    print "$l[2]\t$exon_start[$i]\t$exon_end[$i]\t$l[3]\t$l[12]\t$trans\t$enr\n";  
  }
  
}
close TAB
#./table2csv.pl RefSeq_GRCh37_hg19_known_genes_150812.txt>RefSeq_GRCh37_hg19_known_genes_150812.tab
