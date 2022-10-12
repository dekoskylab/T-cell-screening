
	file1=$1
	file2=$2
	prefix=$3
	barcodes=$4

	echo $file1
	echo $file2
	echo $prefix
	echo $barcodes
	echo "DONE ECHO"
	
	fastq_quality_filter -Q33 -q 20 -p 50 -i $file1 -o $file1"_q20p50.fastq"
	fastq_quality_filter -Q33 -q 20 -p 50 -i $file2 -o $file2"_q20p50.fastq"
	date
	echo "$f quality filtered"
	#fastq_to_fasta -Q33 -n -i $file1"_q20p50.fastq" -o $file1"_q20p50.fasta"
	#fastq_to_fasta -Q33 -n -i $file2"_q20p50.fastq" -o $file2"_q20p50.fasta"
	echo "$f converted to fasta"
	awk  'BEGIN {ORS="\t"};/^@M/{x=NR+3}(NR<=x){print };{if (NR%4==0) print "\n"}' $file1"_q20p50.fastq"  | sort -k 1b,1 > $file1"_q20p50.fastq_tt"
	awk  'BEGIN {ORS="\t"};/^@M/{x=NR+3}(NR<=x){print };{if (NR%4==0) print "\n"}' $file2"_q20p50.fastq" | sort -k 1b,1 > $file2"_q20p50.fastq_tt"
    awk '{if (length ($1)>0) print $0}' $file1"_q20p50.fastq_tt" > $file1"_q20p50.fastq_tt-1"
    awk '{if (length ($1)>0) print $0}' $file2"_q20p50.fastq_tt" > $file2"_q20p50.fastq_tt-2"


	echo "$f converted to temporary file for joining"
	join -j 1 -o 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8  $file1"_q20p50.fastq_tt-1" $file2"_q20p50.fastq_tt-2" | awk '{print $1 "\n" $3 "\n" $4 "\n" $5}' > $prefix"_r1_q20p50_filtered.fastq-1"
    join -j 1 -o 2.1 2.2 2.3 2.4 2.5 1.6 1.7 1.8 $file1"_q20p50.fastq_tt-1" $file2"_q20p50.fastq_tt-2" | awk '{print $1  "\n" $3  "\n" $4 "\n" $5}' > $prefix"_r2_q20p50_filtered.fastq-2"
	echo "$f joined into filtered files"
#	echo "$f splitting the reads now"
#	split -l 200000 $prefix"_r1_q20p50_filtered.fasta" $prefix"_r1_q20p50_filtered.fasta_"
#	split -l 200000 $prefix"_r2_q20p50_filtered.fasta" $prefix"_r2_q20p50_filtered.fasta_"
	
		
	#ls | grep $prefix"_r2_q20p50_filtered.fasta_" | grep -v temp | grep -v reads | awk '{print $1 " " $1}' | sed 's/_r2_q20p50/_r1_q20p50/' | awk -v barcodes=$barcodes '{print "bash CDR3motif_search_part1_v2.1.sh  " $0 " " barcodes}' > $prefix"_commands_part1"
