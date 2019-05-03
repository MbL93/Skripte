# -*- coding: utf-8 -*-
"""
Created on Thu May 02 13:32:19 2019

@author: Marc
"""

import pandas as pd
print('How many items have 3 words in their name?')

# csv laden und Spaltennamen vergeben:
supplier = pd.read_csv('C:/Dateien/Master/Skripte/2_Semester/Analyzing_Massive_Data_sets/Exercises/Sheet01/supplier.tbl', sep='|',
                        names=['s_Id','s_Name','Address','Nationkey','Phone','Acctbal','s_Comment','Dummy'])

supplier.drop(supplier.columns[-1], axis=1, inplace=True)

part = pd.read_csv('C:/Dateien/Master/Skripte/2_Semester/Analyzing_Massive_Data_sets/Exercises/Sheet01/part.tbl', sep='|',
                        names=['p_Id','p_Name','Mfgr','Brand','Type','Size','Container','Retailprice','p_Comment','Dummy'])

part.drop(part.columns[-1], axis=1, inplace=True)

partsupp = pd.read_csv('C:/Dateien/Master/Skripte/2_Semester/Analyzing_Massive_Data_sets/Exercises/Sheet01/partsupp.tbl', sep='|',
                        names=['p_FK','s_FK','Availqty','Supplycost','Comment_partsupp','Dummy'])

partsupp.drop(supplier.columns[-1], axis=1, inplace=True)

supplierPS = pd.merge(supplier, partsupp, left_on = 's_Id', right_on = 's_FK')
supplierPart = pd.merge(supplierPS, part, left_on = 'p_FK', right_on = 'p_ID')

print(supplierPart.groupby('s_Name')['p_Name'].count())