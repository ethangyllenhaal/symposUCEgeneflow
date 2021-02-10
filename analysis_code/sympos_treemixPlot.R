# the source is the path to the plotting_funcs.R file
# (see TreemixManual for more info: 
## http://gensoft.pasteur.fr/docs/treemix/1.12/treemix_manual_10_1_2012.pdf)
# the input for "plot_tree" is the path to the folder your treemix output
## with the stem of the output file names (e.g. sympos for me)
# includes the 
source("D:/Documents/Projects/Symposiachrus/treemix/plotting_funcs.R")
setwd("D:/Documents/Projects/Symposiachrus/treemix")

# Unsupervised run
plot_tree("sympos_all_UG_base0")
plot_tree("sympos_all_UG_base1")
plot_tree("sympos_all_UG_base2")
plot_tree("sympos_all_UG_base3")

# Forcing edge between Gag and Diadematus
plot_tree("sympos_all_UG_GagDia0")
plot_tree("sympos_all_UG_GagDia1")
plot_tree("sympos_all_UG_GagDia2")
plot_tree("sympos_all_UG_GagDia3")

# Forcing edge between Melanopterus and Diadematus
plot_tree("sympos_all_UG_MelDia0")
plot_tree("sympos_all_UG_MelDia1")
plot_tree("sympos_all_UG_MelDia2")
plot_tree("sympos_all_UG_MelDia3")

# Forcing edge between Melanopterus and Louisade Guttula
plot_tree("sympos_all_UG_MelLouiGutt0")
plot_tree("sympos_all_UG_MelLouiGutt1")
plot_tree("sympos_all_UG_MelLouiGutt2")
plot_tree("sympos_all_UG_MelLouiGutt3")

# Forcing edge between AU Trivirgatus and NG Guttula
plot_tree("sympos_all_UG_TrivGutt0")
plot_tree("sympos_all_UG_TrivGutt1")
plot_tree("sympos_all_UG_TrivGutt2")
plot_tree("sympos_all_UG_TrivGutt3")
