#!/usr/bin/perl -w

use strict;
my $msg="usage: $0 refseq-known_genes.txt\n";


my %seen;
open(TAB, "<$ARGV[0]") or die $msg;
my $line;

$line=<TAB>;#header
print "chr\tstart\tend\tstrand\tgene\ttranscript\tgene_length\texonic_lenght\tcoding_length\n";
while ($line=<TAB>){
  chomp $line;
  my @l=split ("\t",$line);
  my @exon_start=split(",",$l[9]);
  my @exon_end=split(",",$l[10]);
  my $trans=$l[1];
  if ($seen{$trans}++){
    $trans=$trans."_dup".($seen{$trans}-1);
  }
  my $g_len = $l[5]-$l[4];
  my $e_len=0;
  my $c_len=0;
  for(my $i =0;$i<$l[8];$i++){
    $e_len+=($exon_end[$i]-$exon_start[$i]);
    if($exon_end[$i] > $l[6] && $exon_start[$i] < $l[7]){
        $c_len+=($exon_end[$i]-$exon_start[$i]);
        if($exon_start[$i] < $l[6] ){ $c_len -=  $l[6] -$exon_start[$i]}
        if($exon_end[$i] > $l[7]){ $c_len -= $exon_end[$i] - $l[7]}
    }
  }  
  print "$l[2]\t$l[4]\t$l[5]\t$l[3]\t$l[12]\t$trans\t$g_len\t$e_len\t$c_len\n";  

}
close TAB
#./table2coding_length.pl RefSeq_GRCh38_known_genes_170124.txt>RefSeq_GRCh38_known_genes_length_170124.txt
