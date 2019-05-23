# -*- coding: utf-8 -*-
"""
Created on Thu May 23 12:42:21 2019

@author: Marc
"""



from pysparkling import Context

def mapper(md5hash, filename):
    return [(md5hash, filename)]

def reducer (md5hash, filenames):
    res = []
    if(len(filenames) > 1):
        filenames = list(set(filenames))
        res.append((md5hash,filenames))
    return res

#pairs of hash filname
inputs = [(123,'Name1'),(123,'Name2'),(456,'Name1'),(345,'Name3'),(456,'Name2'),
          (123,'Name1'),(123,'Name3'),(789,'Name4'),(789,'Name2'),(136,'Name5')]

hash_filename_pairs = Context().parallelize(inputs)

duplicates = (hash_filename_pairs
              .flatMap(lambda pair:mapper(*pair))
              .groupByKey()
              .FlatMap(lambda pair: reducer(*pair))
)

output = duplicates.collect()

for hash, filenames in output:
    print('{hash}:{filenames}')
  
