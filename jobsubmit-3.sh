file=$1
prefix=$2


mixcr align --save-description  -f -g  -b imgt -s hsa -r $prefix"_TRB_alignmentReport.txt" --not-aligned-R1 $prefix"_TRB_nt_R1.fastq"  -OvParameters.geneFeatureToAlign=VRegion $file       $prefix"_TRB_alignments.vdjca" 

mixcr assemble -f -r $prefix"_TRB_assembleReport.txt" --index $prefix"_TRB_index_file" -OcloneClusteringParameters=null -OassemblingFeatures=CDR3 -OseparateByV=true -OseparateByJ=true -OseparateByC=true  -OmaxBadPointsPercent=1.0  -ObadQualityThreshold=0 $prefix"_TRB_alignments.vdjca" $prefix"_TRB_clones.clns"

mixcr exportClones -f -c TRB -o -t --preset-file Fields-1.txt -readIds $prefix"_TRB_index_file"  $prefix"_TRB_clones.clns" $prefix"_TRB_clones.txt"

mixcr exportAlignments -f  -cloneId $prefix"_TRB_index_file" -descrR1 $prefix"_TRB_alignments.vdjca" $prefix"_TRB_alignments.txt"
