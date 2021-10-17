#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Apr  5 11:38:29 2021

@author: catalina
"""

##Load the data
import pandas as pd
import re

df= pd.read_csv('/Users/catalina/Dropbox/UVA/CareyLab/cryto_models/figure2/GenesByTaxon_Summary.csv')

descriptions = pd.read_csv('/Users/catalina/Dropbox/UVA/CareyLab/cryto_models/figure2/not_annotated_descriptions.txt', header = None, names=['definition'])


#%%
color = "blue"
cata = str(descriptions["definition"])
data_cp = pd.DataFrame(columns=['chr', 'start', 'end', 'gene', 'state', 'chromosome', 'value', 'color'])
for i in range(len(df)):
    gene = df["Gene ID"][i]
    loc = df["Genomic Location (Gene)"][i]
    start = int((re.split('\(|:|\..',loc)[1]).replace(',', ''))
    end = int((re.split('\(|:|\..',loc)[2]).replace(',', ''))
    description = df["Product Description"][i]
    answer = description in cata
    if answer == True:
        state = "Unknown function" 
        feature = "1"
    else: 
        state = "Known function"
        feature = "7"
    chromosome = df["Chromosome"][i]
    data_cp.loc[i] = ["chr"+str(chromosome), start, end, gene, state, chromosome, feature, color]

data_cparvum= data_cp.sort_values('chr')
data_cparvum.to_csv("/Users/catalina/Dropbox/UVA/CareyLab/cryto_models/figure2/data.csv")


known = data_cparvum[data_cparvum['color'] == "b"]
unknown = data_cparvum[data_cparvum['color'] == "a"]






