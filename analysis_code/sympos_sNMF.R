###################
#
# By: Ethan Gyllenhaal
# Last updated: 4 February 2021
#
# Script for running sNMFs for Symposiachrus, run for each of the 4 plots in the paper.
# Sets up sNMF plotting function, loads the input files, runs sNMF, and finally plots for different K values.
#
##################

# load additional sNMF tools
source("http://membres-timc.imag.fr/Olivier.Francois/Conversion.R")
source("http://membres-timc.imag.fr/Olivier.Francois/POPSutilities.R")
# loads the LEA library
library(LEA)
setwd('path/to/directory')

# Plotting function used to plot sNMF output.
# Input is sNMF object, the k value, and optionally an array of colors (has default of 10).
plot_sNMF <- function(input, k_val, colors = c("green", "red", "yellow", "blue", "orange", "purple", "tan", "gray", "dark green", "pink")){
  # picks best run best on cross entropy
  best_run <- which.min(cross.entropy(input, K = k_val))
  # makes q matrix of ancestry coeffs
  q_matrix <- Q(input, K = k_val, run = best_run)
  # plots the output, space makes blank between indivs
  barplot(t(q_matrix), col = colors, border = NA, space = 0.25, xlab = "Individuals", ylab = "Admixture coefficients", horiz=FALSE)
}

# convert .str file to a .geno file, with first column being sample name and second being population #
# If no population column (they aren't really used anyways), set extra.col to 0
struct2geno(file = "sympos_all-max4_sNMF-input.str", 
            TESS = FALSE, diploid = TRUE, FORMAT = 2,
            extra.row = 0, extra.col = 1, output = "path/to/sNMF_sympos_max4.geno")
struct2geno(file = "sympos_triv_sNMF-input.str", 
            TESS = FALSE, diploid = TRUE, FORMAT = 2,
            extra.row = 0, extra.col = 1, output = "path/to/sNMF_sympos_triv.geno")
struct2geno(file = "sympos_gutt_sNMF-input.str", 
            TESS = FALSE, diploid = TRUE, FORMAT = 2,
            extra.row = 0, extra.col = 1, output = "path/to/sNMF_sympos_gutt.geno")
struct2geno(file = "sympos_trivGutt_sNMF-input.str", 
            TESS = FALSE, diploid = TRUE, FORMAT = 2,
            extra.row = 0, extra.col = 1, output = "path/to/sNMF_sympos_TG.geno")

# Runs sNMF for all values of K (K=1:12 in my case) and 10 repetitions. The entropy = T is how you estimate best K.
# Note that alpha is the "cost" of introducing admixture, and higher values = less admixture
sympos_max4 = snmf("path/to/sNMF_sympos_max4.geno", ploidy=2, 
                   K = 1:8, alpha = 10, project = "new", entropy = T, repetitions = 100)
sympos_triv = snmf("path/to/sNMF_sympos_triv.geno", ploidy=2, 
                   K = 1:4, alpha = 10, project = "new", entropy = T, repetitions = 100)
sympos_gutt = snmf("path/to/sNMF_sympos_gutt.geno", ploidy=2, 
                   K = 1:6, alpha = 10, project = "new", entropy = T, repetitions = 100)
sympos_TG = snmf("path/to/sNMF_sympos_TG.geno", ploidy=2, 
                 K = 1:4, alpha = 10, project = "new", entropy = T, repetitions = 100)

# plots values of K, choose K as per structure 
par(mfrow=c(2,2), mar = c(4, 2, 2, 1))
plot(sympos_max4, col = "blue", pch = 1, type = "o", main="All Populations")
plot(sympos_gutt, col = "blue", pch = 1, type = "o", main="Australian S. trivirgatus")
plot(sympos_triv, col = "blue", pch = 1, type = "o", main="New Guinea S. guttula")
plot(sympos_TG, col= "blue", pch = 1, type = "o", main="AU Blue S. trivirgatus and NG South S. guttula")

### Plotting values of K used in paper
## Note that we changed colors manually after exporting these as PDFs.

##plot TG
plot_sNMF(sympos_TG, 2)

## plot all taxa with maximum of 4 individuals
plot_sNMF(sympos_max4, 5)
plot_sNMF(sympos_max4, 6)
plot_sNMF(sympos_max4, 7)
plot_sNMF(sympos_max4, 8)


## plot triv
plot_sNMF(sympos_triv, 2)
plot_sNMF(sympos_triv, 3)

## plot guttula
plot_sNMF(sympos_gutt, 2)
plot_sNMF(sympos_gutt, 3) 
plot_sNMF(sympos_gutt, 4)
plot_sNMF(sympos_gutt, 5)
