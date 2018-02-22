#!/usr/bin/perl -w
use Getopt::Long;

use strict;
my $msg="usage: $0 [-rm0] source refseq-known_genes.txt\n";
my $rm=0;
GetOptions("rm0"=>\$rm);  


my %seen;
my $source=$ARGV[0];
@ARGV==2 or die $msg;
open(TAB, "<$ARGV[1]") or die $msg;
my $line;

$line=<TAB>;#header

while ($line=<TAB>){
  chomp $line;
  my @l=split ("\t",$line);
  my @exon_start=split(",",$l[9]);
  my @exon_end=split(",",$l[10]);
  my $trans=$l[1];
  if ($seen{$trans}++){
    $trans=$trans."_dup".($seen{$trans}-1);
  }
  if($rm && $exon_start[0]<=0) {warn "skipping gene $l[12] on $l[2]:$exon_start[0]\n"; next;}
  for(my $i =0;$i<$l[8];$i++){
    my $enr=$l[3] eq "+" ? $i+1: $l[8]-$i;
    print "$l[2]\t$source\texon\t$exon_start[$i]\t$exon_end[$i]\t0.000000\t$l[3]\t.\tgene_id \"$l[12]\"; transcript_id \"$trans\"; exon_number \"$enr\"; exon_id \"${trans}_$enr\";\n";  
  }
  
}
close TAB
