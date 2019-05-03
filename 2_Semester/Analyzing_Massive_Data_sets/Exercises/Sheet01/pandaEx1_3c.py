# -*- coding: utf-8 -*-
"""
Created on Thu May 02 13:16:30 2019

@author: Marc
"""

import pandas as pd
print('Find out all brands produced by the same manufacturer and calculate the items number and thte total sales price for each')

# csv laden und Spaltennamen vergeben:
part = pd.read_csv('C:/Dateien/Master/Skripte/2_Semester/Analyzing_Massive_Data_sets/Exercises/Sheet01/part.tbl', sep='|',
                        names=['p_Id','p_Name','Mfgr','Brand','Type','Size','Container','Retailprice','p_Comment','Dummy'])


part.drop(part.columns[-1], axis=1, inplace=True)

brand_manufacturer = part.groupby(['Mfgr','Brand']).agg({'p_Name': 'count','Retailprice': 'sum'})

print(brand_manufacturer)