# -*- coding: utf-8 -*-
import pandas as pd
print('Find 25 Suppliers with lowest account balance.')

# csv laden und Spaltennamen vergeben:
supplier = pd.read_csv('C:/Dateien/Master/Skripte/2_Semester/Analyzing_Massive_Data_sets/Exercises/Sheet01/supplier.tbl', sep='|',
                        names=['s_Id','s_Name','Address','Nationkey','Phone','Acctbal','s_Comment','Dummy'])

supplier.drop(supplier.columns[-1], axis=1, inplace=True)

top_25 = supplier.nsmallest(25, 'Acctbal')[['s_Name','Acctbal']]
#top_25 = (supplier.sort_values(by = 'Acctbal')[['s_Name', 'Acctbal']]).head

print(top_25)