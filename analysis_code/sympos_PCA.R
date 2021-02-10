##########
# By: Ethan Gyllenhaal
# Updated 4Feb2021
#
# R script used for generating PCAs for assorted Symposiachrus.
# Makes each PCA used in the paper, not that recoloring was done by JMM in Illustrator.
# Then has one section for each relevant PCA.
# Per-section process described in the first section.
# Last section includes statistical tests for association betweens mtDNA haplotype and nuclear cluster.
# Note that PDFs were made manually, not output to a file.
########

# Packages! adegenet and ade4 are for the PCAs, vcfR is file conversion, scales is colors
library("adegenet")
library("ade4")
library("vcfR")
setwd('path/to/directory')

### All susbpecies, maximum of 4 individuals/subsp. Each step is described here.
# loads VCF using vcfR
sympos_max4_vcf <- read.vcfR("sympos_100_rand_max4.vcf")
# converts vcf to genlight
sympos_max4_gl <- vcfR2genlight(sympos_max4_vcf)
# assigns populations, in VCF order
pop(sympos_max4_gl) <- c("gut", "gut", "gut", "gut", "gag", "gag", "gag", "gag", "nom", "nom", "bimac", "bimac", "bimac", "diadem", "diadem", "melano", "melano", "melano", "melano",  "nigri", "nigri", "au_triv_trivMito", "au_triv_trivMito", "au_triv_guttMito", "au_triv_guttMito", "au_triv_guttMito", "au_triv_guttMito", "au_triv_trivMito", "au_triv_trivMito")
# runs PCA, retaining "nf" components
pca_max4 <- glPca(sympos_max4_gl, nf=20)
# plots PCA with colors
s.class(pca_max4$scores[,1:2], pop(sympos_max4_gl), col=c("blue","green","yellow","orange","red","purple", "black", "brown", "gray"), clab=1, cell=2.5)
# output barplot of eigenvalues to evaluate PCs
barplot(pca_max4$eig/sum(pca_max4$eig), main="eigenvalues", col=heat.colors(length(pca_max4$eig)))


# PCA for one population each of trivirgatus and guttla
sympos_TG_vcf <- read.vcfR("sympos_trivGutt_PCA-input")
sympos_TG_gl <- vcfR2genlight(sympos_TG_vcf)
pop(sympos_TG_gl) <- c("gut", "gut", "gut", "gut", "gut", "gut", "gut", "gut", "triv", "triv", "triv", "triv", "triv", "triv", "triv", "triv", "triv", "triv", "triv", "triv", "triv", "triv", "triv", "triv")
pca_TG <- glPca(sympos_TG_gl, nf=20)
s.class(pca_TG$scores[,1:2], pop(sympos_TG_gl), col=c("blue","green","yellow","orange","red","purple", "black", "brown"), clab=1)
barplot(pca_TG$eig/sum(pca_TG$eig), main="eigenvalues", col=heat.colors(length(pca_TG$eig)))


# PCA for guttula
sympos_gutt_vcf <- read.vcfR("sympos_gutt_PCA-input.vcf")
sympos_gutt_gl <- vcfR2genlight(sympos_gutt_vcf)
pop(sympos_gutt_gl) <- c("gut_S", "gut_N", "gut_N", "gut_S", "gut_S", "gut_N", "gut_Louisiade", "gut_Louisiade", "gut_Normanby", "gut_Normanby", "gut_Nw", "gut_Sw", "gut_Sw", "gut_S", "gut_S", "gut_N", "gut_Nw", "gut_Sw", "gut_Nw", "gut_N")
pca_gutt <- glPca(sympos_gutt_gl, nf=20)
s.class(pca_gutt$scores[,1:2], pop(sympos_gutt_gl), col=c("blue","green","yellow","orange","red","purple", "black", "brown"), clab=1)
barplot(pca_gutt$eig/sum(pca_gutt$eig), main="eigenvalues", col=heat.colors(length(pca_gutt$eig)))

# PCA for trivirgatus
sympos_triv_vcf <- read.vcfR("sympos_triv_PCA-input.vcf")
sympos_triv_gl <- vcfR2genlight(sympos_triv_vcf)
# First population assignment is apriori, shown in Figure S5
pop(sympos_triv_gl) <- c("triv_mtDNA", "gutt_mtDNA", "triv_mtDNA", "gutt_mtDNA", "gutt_mtDNA", "gutt_mtDNA", "gutt_mtDNA", "gutt_mtDNA", "gutt_mtDNA", "gutt_mtDNA", "gutt_mtDNA", "triv_mtDNA", "triv_mtDNA", "triv_mtDNA", "gutt_mtDNA", "gutt_mtDNA", "gutt_mtDNA", "triv_mtDNA", "triv_mtDNA", "triv_mtDNA", "albiventris", "albiventris", "albiventris", "gutt_mtDNA", "gutt_mtDNA", "gutt_mtDNA", "triv_mtDNA", "gutt_mtDNA", "gutt_mtDNA", "triv_mtDNA", "triv_mtDNA", "triv_mtDNA", "triv_mtDNA", "albiventris", "albiventris", "triv_mtDNA", "albiventris", "albiventris", "albiventris", "albiventris", "albiventris", "albiventris", "albiventris", "gutt_mtDNA")
# Second population assignment takes out notable individuals, including hybrids and mismatches, shown in Figure 3C
pop(sympos_triv_gl) <- c("triv_mtDNA", "B28832", "triv_mtDNA", "gutt_mtDNA", "gutt_mtDNA", "gutt_mtDNA", "gutt_mtDNA", "gutt_mtDNA", "B31273", "gutt_mtDNA", "gutt_mtDNA", "B31374", "triv_mtDNA", "triv_mtDNA", "gutt_mtDNA", "gutt_mtDNA", "gutt_mtDNA", "triv_mtDNA", "triv_mtDNA", "triv_mtDNA", "albiventris", "albiventris", "B43114", "gutt_mtDNA", "gutt_mtDNA", "gutt_mtDNA", "B43719", "gutt_mtDNA", "gutt_mtDNA", "triv_mtDNA", "triv_mtDNA", "triv_mtDNA-NG", "triv_mtDNA-NG", "albiventris", "albiventris", "triv_mtDNA", "albiventris", "albiventris", "albiventris", "albiventris", "albiventris", "albiventris", "albiventris", "gutt_mtDNA")
pca_triv <- glPca(sympos_triv_gl, nf=20)
s.class(pca_triv$scores[,1:2], pop(sympos_triv_gl), col=c("blue","green","brown","orange","red","purple", "black", "gray", "goldenrod"), clab=1, cell=2.5)
barplot(pca_triv$eig/sum(pca_triv$eig), main="eigenvalues", col=heat.colors(length(pca_triv$eig)))


## Tests for signficant associations between mtDNA haplogroups and nuclear clusters
## Note that apriori includes the hybrids, and is based on mtDNA haplogroup/range alone

# initialize pairs of variables (x,Y), where X = # triv mtDNA in cluster and Y = # gutt mtDNA in cluster
triv_apriori <- c(12,1)
triv_noHybrids <- c(12,0)
gutt_apriori <- c(2,17)
gutt_noHybrids <- c(2,16)
albi_apriori <- c(2,10)
albi_noHybrids <- c(1,10)

# Fisher's test, showing non-independence of data
fisher.test(rbind(triv_apriori, gutt_apriori))$p.value
fisher.test(rbind(triv_noHybrids, gutt_noHybrids))$p.value
fisher.test(rbind(albi_apriori, gutt_apriori))$p.value
fisher.test(rbind(albi_noHybrids, gutt_noHybrids))$p.value
fisher.test(rbind(albi_apriori, triv_apriori))$p.value
fisher.test(rbind(albi_noHybrids, triv_noHybrids))$p.value

# Chi squared test showing difference from expectation of equal mtDNA haplogroups
chisq.test(gutt_apriori)$p.value
chisq.test(gutt_noHybrids)$p.value
chisq.test(triv_apriori)$p.value
chisq.test(triv_noHybrids)$p.value
chisq.test(albi_apriori)$p.value
chisq.test(albi_noHybrids)$p.value



