#!/usr/bin/env python2.7
# note that this is in python 2.7! (sorry)

'''
Made by Ethan Gyllenhaal (egyllenhaal@unm.edu)
Last updated 9 February 2021

Script for running all dadi models in the paper.
First, I import libraries and load the two-dimensional SFS.
Second, I set up a function to run data.
Third, I set universal starting values.
Fourth, I initialize parameter arrays for each model.
Fifth, I set up arrays that contain all relevant data to run....
Sixth, the driver for loop for doing everything!
'''

import dadi
from numpy import array
import twoPop_models
import pylab

# load in SFS, mask corners, and initialize output file (note the set name)
data = dadi.Spectrum.from_file('guttula_S-trivirgatus_G-down.sfs')
data.mask_corners()
ns = data.sample_sizes
output = open("sympos_dadi_output.txt", "w+")

# function for running data, as per dadi reccomendations
def runDadi(params, upper, lower, points, model_name):
    # prints model name to standard output
    print("Model name: ", model_name)
    # dadi running details, with parameter perturbation
    fn = dadi.Numerics.make_extrap_log_func(model_name)
    params = dadi.Misc.perturb_params(params, fold=2, upper_bound=upper, lower_bound=lower)
    opt = dadi.Inference.optimize_log(params, data, fn, points, lower_bound=lower, upper_bound=upper, verbose=10)
    # writes parameters to output file
    output.write("Parameters: {0}".format(opt[0]))
    model = fn(opt[0], ns, points)
    ll = dadi.Inference.ll_multinom(model,data)
    theta = dadi.Inference.optimal_sfs_scaling(model, data)
    # writes likelihood and theta to output file
    output.write(" LLikelihood: {0}".format(ll))
    output.write(" Theta: {0}\n".format(theta))

# Setting universal starting, upper, and lower parameter values.
# Determined using dadi manual instructions so upper and lower weren't hit in any model

size_upper = 70
size_lower = 1
size_start = 10

div_upper = 50
div_lower = 1e-2
div_start = 1

mig_upper = 1
mig_lower = 1e-6
mig_start = 1e-1

admix_upper = 1e-1
admix_lower = 1e-3
admix_start = 5e-2

Tmix_upper = 5
Tmix_lower = 1e-3
Tmix_start = 1e-1

# Setting up parameter arrays

params_nomig = [size_start, size_start, div_start]
upper_nomig = [size_upper, size_upper, div_upper]
lower_nomig = [size_lower, size_lower, div_lower]

params_mig = [size_start, size_start, div_start, mig_start, mig_start]
upper_mig = [size_upper, size_upper, div_upper, mig_upper, mig_upper]
lower_mig = [size_lower, size_lower, div_lower, mig_lower, mig_lower]

params_m12 = [size_start, size_start, div_start,mig_start]
upper_m12 = [size_upper, size_upper, div_upper, mig_upper]
lower_m12 = [size_lower, size_lower, div_lower, mig_lower]

params_m21 = [size_start, size_start, div_start, mig_start]
upper_m21 = [size_upper, size_upper, div_upper, mig_upper]
lower_m21 = [size_lower, size_lower, div_lower, mig_lower]

params_mix = [size_start, size_start, div_start-Tmix_start, Tmix_start, admix_start]
upper_mix = [size_upper, size_upper, div_upper-Tmix_upper, Tmix_upper, admix_upper]
lower_mix = [size_lower, size_lower, div_lower-Tmix_lower, Tmix_lower, admix_lower]

params_mix_mig = [size_start, size_start, div_start-Tmix_start, Tmix_start, admix_start, mig_start, mig_start]
upper_mix_mig = [size_upper, size_upper, div_upper-Tmix_upper, Tmix_upper, admix_upper, mig_upper, mig_upper]
lower_mix_mig = [size_lower, size_lower, div_lower-Tmix_lower, Tmix_lower, admix_lower, mig_lower, mig_lower]

params_mixBi = [size_start, size_start, div_start-Tmix_start, Tmix_start, admix_start, admix_start]
upper_mixBi = [size_upper, size_upper, div_upper-Tmix_upper, Tmix_upper, admix_upper, admix_upper]
lower_mixBi = [size_lower, size_lower, div_lower-Tmix_lower, Tmix_lower, admix_lower, admix_lower]

params_mixBiMig = [size_start, size_start, div_start-Tmix_start, Tmix_start, admix_start, admix_start, mig_start, mig_start]
upper_mixBiMig = [size_upper, size_upper, div_upper-Tmix_upper, Tmix_upper, admix_upper, admix_upper, mig_upper, mig_upper]
lower_mixBiMig = [size_lower, size_lower, div_lower-Tmix_lower, Tmix_lower, admix_lower, admix_lower, mig_lower, mig_lower]

# Setting points, per dadi manual
points = [20, 30, 40]

# sets up an array for each model with starting, upper bound, lower bound, points, and model
run_nomig = [params_nomig, upper_nomig, lower_nomig, points, twoPop_models.split_nomig]
run_mig = [params_mig, upper_mig, lower_mig, points, twoPop_models.split_mig]
run_m12 = [params_m12, upper_m12, lower_m12, points, twoPop_models.split_m12]
run_m21 = [params_m21, upper_m21, lower_m21, points, twoPop_models.split_m21]
run_mix12 = [params_mix, upper_mix, lower_mix, points, twoPop_models.admix12]
run_mix21 = [params_mix, upper_mix, lower_mix, points, twoPop_models.admix21]
run_mixBidir = [params_mixBi, upper_mixBi, lower_mixBi, points, twoPop_models.admixBidir]
run_mix12mig = [params_mix_mig, upper_mix_mig, lower_mix_mig, points, twoPop_models.admix12_mig]
run_mix21mig = [params_mix_mig, upper_mix_mig, lower_mix_mig, points, twoPop_models.admix21_mig]
run_mixBiMig = [params_mixBiMig, upper_mixBiMig, lower_mixBiMig, points, twoPop_models.admixBidirMig]

# Setting up an array of models to run
runs = [run_nomig, run_mig, run_m12, run_m21, run_mix12, run_mix21, run_mixBidir, run_mix12mig, run_mix21mig, run_mixBiMig]

# Driver for loop for running everything
for run_param in runs:
    # writes model name to file and says it's starting it
    output.write("Model name: %s\n" % run_param[5][5:-4])
    print("Starting: %s\n" % run_param[5][5:-4])
    # runs model however many times, here 50
    # change this as needed
    for i in range(50):
        # pulls run parameters from array, then runs dadi
        p1, p2, p3, p4, p5= run_param
        runDadi(p1, p2, p3, p4, p5)
        # optional, prints X's so you can keep track of how far along you are
        print "X", "X " * i







