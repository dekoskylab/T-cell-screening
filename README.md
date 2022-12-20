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

`bash qualityfilter_script_human_v1.1.sh forward_reads reverse_reads prefix`

2. Anotate reads using `jobsubmit-2.sh` for TRAV and `jobsubmit-3.sh` for TRBV genes. These scripts require MiXCR v2.1.12. 

