#!/usr/bin/env python2.7
# note that this is in python 2.7! (sorry)

'''
Made by Ethan Gyllenhaal (egyllenhaal@unm.edu)
Last updated 9 February 2021

Script for processing janky dadi output made by "sympos_dadi_run.py".
This will output the best run for a given model, with each model output to a different ".out" file.
Note that I processed the output so all parameters were on one line, for some reason newlines would be inserted in output.
Note that parameters aren't automatically labeled, but are in the order output by the model.
So user beware, hopefully more of a general guide than anything else!
'''

import sys, getopt, random, numbers, os

def main(argv):
    # initializing variables
    in_path = ''
    out_path = ''
    # read command line input
    # -h or --help for basic usage info
    # -i or --input for input janky output
    # -o or --output path for processed files
    try:
        opts, args = getopt.getopt(argv,"hi:o:",["input=","output="])
    except:
        print 'process_dadi_output.py -i [input] -o [output]'
        sys.exit(2)
    for opt, arg in opts:
        if opt in ("-help", "-h"):
            print 'process_dadi_output.py -i [input]  -o [output]'
            print 'Input is my janky dadi output.'
        elif opt in ("-i", "--input"):
            in_path = arg
        elif opt in ("-o", "--output"):
            out_path = arg            
    # sets up input and output files
  	input = open("{0}".format(in_path), 'r')
    lines = input.readlines()
    
    ## First, we go through the raw output and make a bunch of model-specific *.out files
    ## This helps future analysis
    
    # works through lines of the input file
    for line in lines:
        # If the line starts with "Model", open a new *.out file.
        if line.startswith("Model"):
            temp = line.split(' ')
            model_name = temp[2]
            model_name = model_name[:-1]
            model_out = open("{0}/{1}.out".format(out_path,model_name), 'wg')
        # If the line is a parameter, write the tab delimited contents of that to the *.out file
        elif line.startswith("Parameters"):
            # splits the lines on a space
            split_line = line.split(' ')
            # loops through the newly split line, writing each parameter to the file.
            for i in range(1,len(split_line)):
                if split_line[i].startswith("["):
                    model_out.write("{0}".format(split_line[i].replace("[", "")))
                if split_line[i].endswith("]"):
                    model_out.write("\t{0}".format(split_line[i].replace("]", "")))
                try:
                    float(split_line[i])
                    model_out.write("\t{0}".format(split_line[i].replace("\n", "")))
                except:
                    pass
            # makes a newline with the number of parameters in the model at the end (the length-5)
            model_out.write("\t{0}\n".format(len(split_line)-5))
    
    ## After all the *.out files are made, the best models are output
    
    # opens a file to write the best models to
    best_models = open("{0}/best_models.txt".format(out_path), 'wg')
    # loops through every file in directory
    for file in os.listdir(out_path):
        # only deals with *.out files
        if file.endswith(".out"):
            # write the model name
            best_models.write("#{0}\n".format(file[:-4]))
            # makes temporary raw data array from the file for convenience
            raw_data = open("{0}/{1}".format(out_path, file), 'r')
            raw_lines = raw_data.readlines()
            # "best" array has the line number first, then the LLikelihood output by dadi
            # this initializes it to known bad values, but -99999999 can be lowered if you have awful model fit and a huuuge SFS
            best = [-1,-99999999]
            # for each run in the raw lines
            for j in range(0,len(raw_lines)-1):
                # split up the line
                line = raw_lines[j].split('\t')
                # checks if likelihood is the new best one
                if float(line[len(line)-3]) > float(best[1]):
                    best[0] = j
                    best[1] = line[len(line)-3]
            # writes the parameters for the run with the best likelihood
            best_models.write(raw_lines[best[0]])

if __name__ == '__main__':
    main(sys.argv[1:])