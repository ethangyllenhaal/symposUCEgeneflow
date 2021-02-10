###################
#
# By: Ethan Gyllenhaal
# Last updated: 4Feb2021
#
# Script for calculating ABBA/BABA values for Symposiachrus (only D statistic here).
# Uses "bootstrapping_fuctions.R" by me and "jacknife.R" by Simon Martin.
## (found at https://github.com/simonhmartin/genomics_general)
# This includes all the comparison found in Table .
# This will output raw values, ranges of values from bootstrapping, bootstrapped distribution, and bootstrapped p value.
# Naming scheme is messy, but looks like: *_[P1][P2][P3], where each "P" is a population.
# Positive values of D indicate gene flow between P2 and P3, and negative between P1 and P3.
# First chunk is ones in figure 4, second is the additional comparisons in Table2
#
##################

setwd('/path/to/directory')
# Load jacknife.R file to get block indices, from https://github.com/simonhmartin/genomics_general
source('path/to/jackknife.R')
# Load bootstrapping function
source("bootstrap_functions.R")
freq_table = read.table("sympos_ABBABABA_input.tsv.gz", header=T, as.is=T)

### For overlapping graphs figure
par(mfrow=c(4,2), mar = c(4, 2, 2, 1), oma = c(0, 0, 2, 0))

# Panel A
D_boot_TNomTGutGutt <- calc_D_stat(freq_table, "trivirgatus_nom", "trivirgatus_gutt_mtDNA", "guttula_S", 1000)
title(main = "(triv_nom, triv_gutt-mtDNA), guttula_S")
D_boot_GGagGuttTGut <- calc_D_stat(freq_table, "guttulaGAG", "guttula_S", "trivirgatus_gutt_mtDNA", 1000)
title(main = "(guttGAG, gutt_S), triv_gutt_mtDNA")

# Panel B
D_all_NigDiaGGag <- calc_D_stat(freq_table, "nigrimentium", "diadematus", "guttulaGAG", 100)
title(main = "(nigrimentum, diadematus), guttulaGAG")
D_all_GuttGGagDia <- calc_D_stat(freq_table, "guttula_S", "guttulaGAG", "diadematus", 100)
title(main = "(gutt_S, guttGAG), diadematus")

# Panel C
D_boot_TNomTMelGLou <- calc_D_stat(freq_table, "trivirgatus_nom", "melanopterus", "guttula_Loui", 1000)
title(main = "(triv_nom, melanopterus), guttula_Loui")
D_boot_GNorGLouTMel <- calc_D_stat(freq_table, "guttula_Norm", "guttula_Loui", "melanopterus", 1000)
title(main = "(gutt_Norm, gutt_Loui), melanopterus")

# Panel D
D_boot_TNomTMelDia <- calc_D_stat(freq_table, "trivirgatus_nom", "melanopterus", "diadematus", 1000)
title(main = "(triv_nom, melanopterus), diadematus")
D_boot_NigDiaTMel <- calc_D_stat(freq_table, "nigrimentium", "diadematus", "melanopterus", 1000)
title(main = "(nigrimentum, diadematus), melanopterus")


### For additional comparisons

# Panel A
D_boot_TNomTTrivGutt <- calc_D_stat(freq_table, "trivirgatus_nom", "trivirgatus_triv_mtDNA", "guttula_S", 1000)
D_boot_GGagGuttTTriv <- calc_D_stat(freq_table, "guttulaGAG", "guttula_S", "trivirgatus_triv_mtDNA", 1000)

# Panel B
D_boot_NigBimGGag <- calc_D_stat(freq_table, "nigrimentium", "bimaculatus", "guttulaGAG", 1000)

# Panel C
D_boot_TNomTMelGNor <- calc_D_stat(freq_table, "trivirgatus_nom", "melanopterus", "guttula_Norm", 1000)
D_boot_TNomTMelGGutt <- calc_D_stat(freq_table, "trivirgatus_nom", "melanopterus", "guttula_S", 1000)

# Panel D
D_boot_TNomTMelBim <- calc_D_stat(freq_table, "trivirgatus_nom", "melanopterus", "bimaculatus", 1000)
D_boot_NigBimTMel <- calc_D_stat(freq_table, "nigrimentium", "bimaculatus", "melanopterus", 1000)