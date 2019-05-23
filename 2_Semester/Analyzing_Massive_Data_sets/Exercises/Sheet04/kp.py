# -*- coding: utf-8 -*-
"""
Created on Thu May 23 12:39:15 2019

@author: Marc
"""

from pysparkling import Context 

def mr_simulator(inputseq, mapfunc, reducefunc, debug=False):
    
    def identity(x):
        if debug:
            print(x)
            
        return x
    
    