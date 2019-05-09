# -*- coding: utf-8 -*-

def mr_simulator(inputseq, mapfunc, reducefunc, debug=False):
    intermediate = []
    
    for k,v in inputseq:
        mapres = mapfunc(k,v)
        intermediate = intermediate + mapres
    if debug:     
        print(intermediate)
    
    groups = dict()
    
    for ki,vi in intermediate:
        if (ki in groups):
            groups[ki].append(vi)
        else:
            vallist = [vi]
            groups[ki] = vallist
    if debug:        
        print(groups)
    
    res = []        
    
    for ki,vl in groups.items():
        res= res + reducefunc(ki,vl)    
    return res