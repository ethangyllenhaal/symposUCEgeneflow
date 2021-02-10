# symposUCEgeneflow

README by: Ethan Gyllenhaal

Last updated: 10 February 2021

Repository for scripts and some input files used in a study investigating gene flow in a subset of the members in the genus Symposiachrus, focusing on interactions in the S. trivirgatus complex and S. guttula. If you use something here, please cite us, or contact EFG on who is best to cite (and remind him if he forgets to update the citation):

Andersen MJ, McCullough JM, Gyllenhaal EF, Mapel XM, Haryoko T, Jønsson KA, Joseph L. Complex demographic histories and multiple mitochondrial capture events in a non-sister pair of monarch-flycatchers. Accepted.

This README describes the scripts and data files used for a project assessing multiple aspects of gene flow in the Symposiachrus trivirgatus/guttula complex. The data were collected using Illumina sequencing for target capture of ultraconserved elements, with three main pipelines used for downstream processing. For phylogenetics, we roughly followed phyluce (https://phyluce.readthedocs.io/en/latest/). For anything involving a VCF, we used a pipeline based on seqcap_pop (https://github.com/mgharvey/seqcap_pop). For mitogenome analyses, MJA aligned reads to a reference mitogenome in Geneious and manually checked for inconsistencies. Note that phylogenetic input files are excluded here, but can be found on Dryad (https://doi.org/10.5061/dryad.hx3ffbgd7).

_______________________________
------ PopGen Input Files -----

-- (sympos_popgen_input.zip) --
_______________________________

OVERALL NOTE: All of these input files are a 100% complete matrix with one random SNP selected per locus to avoid issues with LD.

sympos_*_PCA-input.vcf - Input files for various PCAs run. The second "word" represents the subset of individuals used (with "triv" and "gutt" short for trivirgatus and guttula respectively. Used in sympos_PCA.R.

sympos_*_sNMF-input.str - Input files for sNMF runs, named like PCA inputs (see above). Used in sympos_sNMF.R Note that all of these have singletons removed.

sympos_ABBABABA_input.tsv.gz - Input file for ABBA/BABA. Used in sympos_ABBABABA.R.

sympos_treemix-input.treemix.gz - Input file for TreeMix analyses, used in sympos_treemix.sh

treemix_edges.zip - Zipped directory of files defining edges used in Supervised TreeMix analyses.

guttula_S-trivirgatus_G-down.sfs - Site frequency spectrum for southern guttula and trivirgatus with guttula haplotypes, downsampled to 16 samples. Generated using easySFS (https://github.com/isaacovercast/easySFS).

symposiachrus_mtDNA_inputs.zip - Fasta files for each mitochondrial region, used as input for assorted mtDNA population genetic analyses. Often subset or slightly altered for certain anlyses, but sequences should remain the same.

________________________________
------------ Scripts -----------

-- (sympos_analysis_code.zip) --
________________________________

sympos_PCA.R - R script for generating genomic PCAs using input vcf files (sympos_*_PCA-input.vcf). Locations of PCAs: "all-max4" in Figure 2B; "triv" in Figure 3C and S5; "trivGutt" in Figure S4C; "gutt" in Figure S7C. PCs described in Table S3. Also includes a section for assessing the significance of association between nuclear clusters and mtDNA haplogroup.

sympos_sNMF.R - R script for running sNMF for four tests in paper using input structure-like files (sympos_*_sNMF-input.str). Locations of sNMF plots: "all-max4" in Figure 2A; "triv" in Figure 3B; "trivGutt" in Figure S4B; "gutt" in Figure S7B. PCs described in Table S3.

sympos_ABBABABA.R - Script for running ABBA/BABA analyses. This takes in a gzipped, tab delimited format of derived allele freqs made using a script from https://github.com/simonhmartin/genomics_general. Does all combinations in paper, using bootstrap_functions.R to actually run the calculations. Separates ones in Figure 4 from Table S2.

bootstrap_functions.R - Script for running ABBA/BABA bootstraps. This contains f and D statistics, but only D is used here. It generates the value of the statistics, a range of bootstrapped values, bootstrapped p-value, Z value, and a density graph of the values of the bootstraps.

sympos_treemix.sh - Shell script for running TreeMix, assumes you are in directory all the input files, some of which are in treemix_edges.zip. Runs up to three migration edges for the unsupervised and all four supervised analyses.

sympos_treemixPlot.R - R script for plotting all the afformentioned TreeMix functions. Most aren't included, but Figure S3 includes "base0", "base1", and "GagDia2". The others resulted in no major changes in topology.

snapp_input_maker.sh - Driver script for converting a VCF to diploid SNAPP input (i.e. Nexus input for processing in Beauti). Converts from VCF to haploid SNAPP using https://github.com/BEAST2-Dev/SNAPP/tree/master/script, then to diploid SNAPP using a custom python script (SNAPP_haploid_to_diploid.py), and finally adding lines for a new nexus file using sed commands. Requires a lot of manual file/value entering by user, but you should get the idea of it!

SNAPP_haploid_to_diploid.py - Script for converting a tab-delimited set of haploid nexus SNP data to diploid data. Takes and outputs "middle" lines, header and footer done by "snapp_input_maker.sh". Note that it's "dumb" and needs the input to be named "snapp_dip.txt" and outputs "snapp_out.txt".

sympos_dadi_models.py - File specifying dadi models, based on the twoPop model set included in dadi. Notable additions are the admixture event models.

sympos_dadi_run.py - Script made for running dadi models. Process is described in the file, essentially loads SFS, specifies parameters, and uses a function and driver for loop to conduct each run and output a messy file of parameters for each model and each run.

process_dadi_output.py - Script made for turning the messy output from "sympos_dadi_run.py" into more concise output files (*.out). Then uses those files to output the best run for each model based on log likelihoods calculated by dadi.
______________________________
--------- Tree Files ---------

-- (sympos_phylo_trees.zip) --
______________________________

sympos_BEAST_mtDNA.tre - Mitochondrial phylogeny made in BEAST for all of our samples, with some genbank samples added. A supermatrix of our mitogenomes and assorted additions from genbank additions. Used in Figure 1B. Input was sympos_BEAST_input.nex.

sympos_RAxML_UCE.tre - Phylogenetic tree for all samples in this study plus an outgroup (Myiagra ruficollis), made using a concatenated matrix of ultraconserved elements in RAxML. Used in Figure 1A. Input was sympos_UCE-RAxML_input.phylip and charset used for partitioning was sympos_UCE-RAxML_chars.charsets.

sympos_SVDQ_UCE.tre - Phylogenetic tree for major populations in this study, made using the species tree approach SVDQuartets. Used in Figure 2c. Input was sympos_UCE-SVDQ_input.nex. Loci identified using sympos_UCE-RAxML_chars.charsets.
