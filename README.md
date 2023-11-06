# Scripts for our functional TCR screening paper: Fahad, A.S., Chung, C.Y., López Acevedo, S.N. et al. Cell activation-based screening of natively paired human T cell receptor repertoires. Sci Rep 13, 8011 (2023). https://doi.org/10.1038/s41598-023-31858-4

## Requirements

- [FASTX-Toolkit v0.0.14](http://hannonlab.cshl.edu/fastx_toolkit/commandline.html)
- [MiXCR v2.1.12](https://docs.milaboratories.com)
- [USEARCH v5.2.32](https://www.drive5.com/usearch/)
- A UNIX-like system

## Data

Raw TCRα:β MiSeq data have been deposited in the NCBI Sequence Read Archive (SRA) under accession number PRJNA827461.

## Usage

1. Perform quality control with `qualityfilter_script_human_v1.1.sh` for forward and reverse reads. This script requires FASTX-Toolkit v0.0.14. A quality threshold of q20p50 was used. A `prefix` name should be selected to match file names in the next steps. 

    `bash qualityfilter_script_human_v1.1.sh forward_reads.fastq reverse_reads.fastq prefix`

2. Anotate reads using `jobsubmit-2.sh` for TRAV and `jobsubmit-3.sh` for TRBV genes. These scripts require MiXCR v2.1.12. 

    ```
    bash jobsubmit-2.sh reverse_reads.fastq-2 prefix
    bash jobsubmit-3.sh forward_reads.fastq-1 prefix
    ```

3. Once gene annotation is complete, we can stitch paired-end reads using `stitch_TRA-TRB.sh`

    `bash stitch_TRA-TRB.sh prefix`
  
4. Generate pair results by combing the reads of alpha and beta into complete chain information in one file based on mixcr sequence IDs. This is done by `processing.sh` script.

    `processing.sh prefix`
        
6. Reads are prepared for clustering using `CDR3motif_search_v1.sh`. This will aggregate reads with the same CDR3B nt/aa sequences and reports the number of reads. Next, it filters out clones with only one read. 


    `CDR3motif_search_v1.sh prefix`
    
    
8. Next, reads are clustered based on CDR3 identity using `CDR3motif_search_analysis_v3.1.sh`. This step requires `USEARCH` 

    `bash CDR3motif_search_analysis_v3.1.sh prefix raw_reads`
    
## Example

1. Quality filter:

	`bash qualityfilter_script_human_v1.1.sh Exp-name_R1_001.fastq Exp-name_R2_001.fastq Exp-name`

2. Run MIXCR

    ```
	bash jobsubmit-3.sh Exp-name_r1_q20p50_filtered.fastq-1 Exp-name
	bash jobsubmit-2.sh Exp-name_r2_q20p50_filtered.fastq-2 Exp-name
    ```

3. Stitch paired-end reads

	`bash stitch_TRA-TRB.sh Exp-name`

4. Reformate files 

	`bash processing.sh Exp-name`

5. Prep for CDR3B clustering  

	`bash CDR3motif_search_v1.sh Exp-name`

6. Run clustering script

	`bash CDR3motif_search_analysis_v3.1.sh Exp-name Exp-name_nt_pairs_over1read.txt`

7. Exp-name_unique_final.txt contains the final estimated Alpha:beta clonotypes  

	`ls | grep unique_final | xargs wc -l`


  
