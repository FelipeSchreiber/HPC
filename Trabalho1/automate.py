import os
import numpy as np
x = np.arange(10,17)
y = np.power(2,x)
modes = [0,1]
for mode in modes:
    for n in y:
        command = f"./matmul_c {str(n)} {mode}"
        os.system(command)