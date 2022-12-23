#This script prepares TRB/TRA database for clustering:

#1) this script generates raw clones by collapsing identical CDRB3 nt/aa sequences and reports their reads
#2) using the output from step #1 to generate over1read database by excluding all clones with 1 read, this database is used later as an input for clustering step 

EXPTNAME=$1

awk  '{if (NF==10) print $9 "\t" $4 "\t" $6 "\t" $7 "\t" $8 "\t" length($9) "\t" $2 "\t" $3 "\t" length($4) "\t" "TRA" "\t" "TRB"; else print $8 "\t" $4 "\t" $6 "\t" "-" "\t" $7 "\t" length($8) "\t" $2 "\t" $3 "\t" length ($4) "\t" "TRA" "\t" "TRB"}' $EXPTNAME"_TRA_TRB_processed" | sort | uniq -c | sort -n -r > "$EXPTNAME"_raw_nt_pairs.txt

awk  '{if (NF==10) print $10 "\t" $5 "\t" $6 "\t" $7 "\t" $8 "\t" length($10) "\t" $2 "\t" $3"\t" length($5) "\t" "TRA" "\t" "TRB" ; else print $9 "\t" $5 "\t" $6 "\t"  "-" "\t" $7 "\t" length($9) "\t" $2 "\t" $3 "\t" length ($5) "\t" "TRA" "\t" "TRB"}' $EXPTNAME"_TRA_TRB_processed" | sort | uniq -c | sort -n -r > "$EXPTNAME"_raw_aa_pairs.txt

cat "$EXPTNAME"_raw_nt_pairs.txt |grep -E -v "^\s+\b1\b\s+" | awk '{print $1 "\t" $2 "\t" $3 "\t" $4 "\t" $5 "\t" $6 "\t" $7 "\t" $8 "\t" $9 "\t" $10 "\t" $11 "\t" $12}' > "$EXPTNAME"_nt_pairs_over1read.txt

cat "$EXPTNAME"_raw_aa_pairs.txt |grep -E -v "^\s+\b1\b\s+" | awk '{print $1 "\t" $2 "\t" $3 "\t" $4 "\t" $5 "\t" $6 "\t" $7 "\t" $8 "\t" $9 "\t" $10 "\t" $11 "\t" $12}' > "$EXPTNAME"_aa_pairs_over1read.txt
