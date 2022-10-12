prefix=$1
sort -n -k 1b,1 $prefix"_TRA_alignments.txt" > $prefix"_TRA_alignments.txt_sorted"
sort -n -k 1b,1 $prefix"_TRB_alignments.txt" > $prefix"_TRB_alignments.txt_sorted"
sort -n -k 1b,1 $prefix"_TRA_clones.txt" > $prefix"_TRA_clones.txt_sorted"
sort -n -k 1b,1 $prefix"_TRB_clones.txt" > $prefix"_TRB_clones.txt_sorted"
join -j 1 -o 2.2 1.3 1.4 1.5 1.6 $prefix"_TRA_clones.txt_sorted" $prefix"_TRA_alignments.txt_sorted" > $prefix"_TRA_all.txt"
 awk '{if (NF==7) print $1 "\t" $3 "\t" "-" "\t" $4 "\t" $5 "\t" $6;else print $1 "\t" $3 "\t" $4 "\t" $5 "\t" $6 "\t" $7}' $prefix"_TRB_clones.txt_sorted" >  $prefix"_TRB_clones.txt_sorted_reformatted"

join -j 1 -o 2.2 1.2 1.3 1.4 1.5 1.6 $prefix"_TRB_clones.txt_sorted_reformatted" $prefix"_TRB_alignments.txt_sorted" > $prefix"_TRB_all.txt"
