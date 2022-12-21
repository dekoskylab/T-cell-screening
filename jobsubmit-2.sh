# This script is a wrapper for mixcr. It will annotate the reverse reads that map to TRAV genes. 

file=$1
prefix=$2


mixcr align --save-description  -f -g  -b imgt -s hsa -r $prefix"_TRA_alignmentReport.txt" --not-aligned-R1 $prefix"_TRA_nt_R2.fastq"  -OvParameters.geneFeatureToAlign=VRegion $file  $prefix"_TRA_alignments.vdjca" 

mixcr assemble -f -r $prefix"_TRA_assembleReport-2.txt" --index $prefix"_TRA_index_file" -OcloneClusteringParameters=null -OassemblingFeatures=CDR3 -OseparateByV=true -OseparateByJ=true -OseparateByC=true  -OmaxBadPointsPercent=1.0  -ObadQualityThreshold=0 $prefix"_TRA_alignments.vdjca" $prefix"_TRA_clones.clns"

mixcr exportClones -f -c TRA -o -t -s --preset-file Fields-1.txt -readIds $prefix"_TRA_index_file"  $prefix"_TRA_clones.clns" $prefix"_TRA_clones.txt"

mixcr exportAlignments -f  -cloneId $prefix"_TRA_index_file" -descrR1 $prefix"_TRA_alignments.vdjca" $prefix"_TRA_alignments.txt"
