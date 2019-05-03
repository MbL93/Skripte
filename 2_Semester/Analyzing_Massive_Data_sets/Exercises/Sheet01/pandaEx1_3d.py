# -*- coding: utf-8 -*-
"""
Created on Thu May 02 13:21:44 2019

@author: Marc
"""
import numpy as np
import pandas as pd
print('How many items have 3 words in their name?')

# csv laden und Spaltennamen vergeben:
part = pd.read_csv('C:/Dateien/Master/Skripte/2_Semester/Analyzing_Massive_Data_sets/Exercises/Sheet01/part.tbl', sep='|',
                        names=['p_Id','p_Name','Mfgr','Brand','Type','Size','Container','Retailprice','p_Comment','Dummy'])


part.drop(part.columns[-1], axis=1, inplace=True)

partNameSeries = part['p_Name']

print(partNameSeries[(partNameSeries.str.split()).map(len) == 5].aggregate('count'))

#print(np.sum(partNameSeries.str.split().map(len) == 3))