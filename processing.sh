#This script generates TRA and TRB pair results by combing the reads of alpha and beta into complete chain information in one file based on mixcr sequence IDs.

prefix=$1
rm $prefix"_TRA_all_sorted"
rm $prefix"_TRB_all_sorted"
  sort -k 1,1 $prefix"_TRA_all.txt" > $prefix"_TRA_all_sorted"
  sort -k 1,1 $prefix"_TRB_all.txt" > $prefix"_TRB_all_sorted"
  join -j 1 -o 2.1 2.2 2.3 2.4 2.5 2.6 2.7 2.8 $prefix"_TRA_all_sorted" $prefix"_TRB_all_sorted" | awk '{print $1 "\t" $2 "\t" $3 "\t" $4 "\t" $5 "\t" $6 "\t" $7}'> $prefix"_TRB_all_joined"
  join -j 1 -o 1.1 1.2 1.3 1.4 1.5 1.6 1.7 $prefix"_TRA_all_sorted" $prefix"_TRB_all_sorted" | awk '{print $1 "\t" $2 "\t" $3 "\t" $4 "\t" $5 "\t" $6}'  > $prefix"_TRA_all_joined"
  join -j 1 -o 1.1 1.2 1.3 1.4 1.5 1.6  2.2 2.3 2.4 2.5 2.6 2.7  $prefix"_TRA_all_joined" $prefix"_TRB_all_joined" | awk '{print $1 "\t" $2 "\t" $3 "\t" $4 "\t" $5 "\t" $6 "\t" $7 "\t" $8 "\t" $9 "\t" $10 "\t" $11 "\t" $12}'  > $prefix"_TRA_TRB_processed"
