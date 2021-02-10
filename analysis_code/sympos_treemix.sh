#!/bin/bash

# Unsupervised run
~/Desktop/treemix-1.13/src/treemix -i sympos_Treemix-input.treemix.gz -root verticalis -o sympos_all_UG_base0 -m 0 -se &&
~/Desktop/treemix-1.13/src/treemix -i sympos_Treemix-input.treemix.gz -root verticalis -o sympos_all_UG_base1 -m 1 -se &&
~/Desktop/treemix-1.13/src/treemix -i sympos_Treemix-input.treemix.gz -root verticalis -o sympos_all_UG_base2 -m 2 -se &&
~/Desktop/treemix-1.13/src/treemix -i sympos_Treemix-input.treemix.gz -root verticalis -o sympos_all_UG_base3 -m 3 -se &&

# Forcing edge between Gag and Diadematus
~/Desktop/treemix-1.13/src/treemix -i sympos_Treemix-input.treemix.gz -root verticalis  -cor_mig GagDia_edge -climb -o sympos_all_UG_GagDia0 -m 0 -se &&
~/Desktop/treemix-1.13/src/treemix -i sympos_Treemix-input.treemix.gz -root verticalis  -cor_mig GagDia_edge -climb -o sympos_all_UG_GagDia1 -m 1 -se &&
~/Desktop/treemix-1.13/src/treemix -i sympos_Treemix-input.treemix.gz -root verticalis  -cor_mig GagDia_edge -climb -o sympos_all_UG_GagDia2 -m 2 -se &&
~/Desktop/treemix-1.13/src/treemix -i sympos_Treemix-input.treemix.gz -root verticalis  -cor_mig GagDia_edge -climb -o sympos_all_UG_GagDia3 -m 3 -se &&

# Forcing edge between Melanopterus and Diadematus
~/Desktop/treemix-1.13/src/treemix -i sympos_Treemix-input.treemix.gz -root verticalis  -cor_mig MelDia_edge -climb -o sympos_all_UG_MelDia0 -m 0 -se &&
~/Desktop/treemix-1.13/src/treemix -i sympos_Treemix-input.treemix.gz -root verticalis  -cor_mig MelDia_edge -climb -o sympos_all_UG_MelDia1 -m 1 -se &&
~/Desktop/treemix-1.13/src/treemix -i sympos_Treemix-input.treemix.gz -root verticalis  -cor_mig MelDia_edge -climb -o sympos_all_UG_MelDia2 -m 2 -se &&
~/Desktop/treemix-1.13/src/treemix -i sympos_Treemix-input.treemix.gz -root verticalis  -cor_mig MelDia_edge -climb -o sympos_all_UG_MelDia3 -m 3 -se &&

# Forcing edge between Melanopterus and Louisade Guttula
~/Desktop/treemix-1.13/src/treemix -i sympos_Treemix-input.treemix.gz -root verticalis  -cor_mig MelLouiGutt_edge -climb -o sympos_all_UG_MelLouiGutt0 -m 0 -se &&
~/Desktop/treemix-1.13/src/treemix -i sympos_Treemix-input.treemix.gz -root verticalis  -cor_mig MelLouiGutt_edge -climb -o sympos_all_UG_MelLouiGutt1 -m 1 -se &&
~/Desktop/treemix-1.13/src/treemix -i sympos_Treemix-input.treemix.gz -root verticalis  -cor_mig MelLouiGutt_edge -climb -o sympos_all_UG_MelLouiGutt2 -m 2 -se &&
~/Desktop/treemix-1.13/src/treemix -i sympos_Treemix-input.treemix.gz -root verticalis  -cor_mig MelLouiGutt_edge -climb -o sympos_all_UG_MelLouiGutt3 -m 3 -se &&

# Forcing edge between AU Trivirgatus and NG Guttula
~/Desktop/treemix-1.13/src/treemix -i sympos_Treemix-input.treemix.gz -root verticalis  -cor_mig TrivGutt_edge -climb -o sympos_all_UG_TrivGutt0 -m 0 -se &&
~/Desktop/treemix-1.13/src/treemix -i sympos_Treemix-input.treemix.gz -root verticalis  -cor_mig TrivGutt_edge -climb -o sympos_all_UG_TrivGutt1 -m 1 -se &&
~/Desktop/treemix-1.13/src/treemix -i sympos_Treemix-input.treemix.gz -root verticalis  -cor_mig TrivGutt_edge -climb -o sympos_all_UG_TrivGutt2 -m 2 -se &&
~/Desktop/treemix-1.13/src/treemix -i sympos_Treemix-input.treemix.gz -root verticalis  -cor_mig TrivGutt_edge -climb -o sympos_all_UG_TrivGutt3 -m 3 -se &&