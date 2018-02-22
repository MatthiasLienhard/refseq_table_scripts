# refseq_table_scripts
Collection of scripts to parse the Refseq known_genes text format. 

*table2UTRs.pl*
* produces 2 files, containing 5' and 3' UTRs of all genes
* usage: table2UTRs.pl refseq-known_genes.txt

*table2coding_length.pl*
* computes 3 gene lengths for each transcript:
  * gene_length: length in the genome
  * exonic length: combined lenght of all exons
  * coding length: length of protein coding part of the gene
* usage: ./table2coding_length.pl refseq-known_genes.txt

*table2csv.pl*
* produces exon table 
* usage: ./table2csv.pl refseq-known_genes.txt

*table2genebody.pl*
* produces gene body table 
* usage: ./table2genebody.pl refseq-known_genes.txt

*table2gtf.pl*
* produces gtf file
* usage: ./table2gtf.pl source refseq-known_genes.txt



