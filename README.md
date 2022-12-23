# Scripts for our upcoming functional TCR screening paper "Activation-Based Screening of Natively Paired Human T Cell Receptor Repertoires"

## Requirements

- [FASTX-Toolkit v0.0.14](http://hannonlab.cshl.edu/fastx_toolkit/commandline.html)
- [MiXCR v2.1.12](https://docs.milaboratories.com)
- [USEARCH v5.2.32](https://www.drive5.com/usearch/)
- A UNIX-like system

## Data

Raw data can be found at ...

## Usage

1. Perform quality control with `qualityfilter_script_human_v1.1.sh` for forward and reverse reads. This script requires FASTX-Toolkit v0.0.14.

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
6. Reads are prepared for clustering using `CDR3motif_search_v1.sh`
7. Next, reads are clustered based on CDR3 identity using `CDR3motif_search_analysis_v3.1.sh`. This step requires `USEARCH` 

    `bash CDR3motif_search_analysis_v3.1.sh prefix raw_reads`
  
