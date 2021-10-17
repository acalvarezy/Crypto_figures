#!/usr/bin/env python3

#1. Before starting activate the cobra environment
#source /Users/catalina/python-virtual-environments/cobra_py/bin/activate

#2. Edit and run the script
import cobra
from os.path import join

models_list=open("/Users/catalina/Dropbox/UVA/CareyLab/models/models", "r")
models = models_list.read().splitlines()
models_list.close()
data_dir='/Users/catalina/Dropbox/UVA/CareyLab/models/'

print('Model\t', 'Total reactions\t', 'Blocked reactions\t', '% Blocked rxns\n')

for cryp in models:
	model=cobra.io.read_sbml_model(join(data_dir, cryp))
	blocked=cobra.flux_analysis.find_blocked_reactions(model)
	print(model.id, '\t', len(model.reactions), '\t', len(blocked), '\t', (len(blocked)*100)/(len(model.reactions)), '\n')

print('Completed')
