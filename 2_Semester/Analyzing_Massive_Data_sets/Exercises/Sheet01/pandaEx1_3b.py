# -*- coding: utf-8 -*-
import pandas as pd
print('Wieviele Supps haben positive Balance?')

# csv laden und Spaltennamen vergeben:
supplier = pd.read_csv('C:/Dateien/Master/Skripte/2_Semester/Analyzing_Massive_Data_sets/Exercises/Sheet01/supplier.tbl', sep='|',
                        names=['s_Id','s_Name','Address','Nationkey','Phone','Acctbal','s_Comment','Dummy'])

supplier.drop(supplier.columns[-1], axis=1, inplace=True)

supplier_pos_bal = supplier[supplier['Acctbal'] > 0.0][['s_Name']].count()

print(supplier_pos_bal)

supplier_pos_bal = supplier[supplier['Acctbal'] > 0.0]

print(supplier_pos_bal.shape[0])

