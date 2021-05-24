import os
import numpy as np

programs = ["teste","teste_vec","teste_omp","teste_omp_vec"]
nx = [512,1024,2048]
for program in programs:
    for n in nx:
        command = f"./{program} {str(n)} 1000 {1e-16}"
        a = os.system(command)
