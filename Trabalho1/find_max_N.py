import os
import numpy as np
x = [14,16]
y = np.power(2,x)
## Roda o programa passando n e o modo de execucao (0 determina se o loop externo é por linha)        
## O programa retorna 0 quando executa normalmente
def run_program(n, mode=0):
    command = f"./matmul_c {str(n)} {mode}"
    a = os.system(command)
    return a
def run_program2(n):
    if (n>13000):
        return 1
    else:
        return 0
def generate_m(a,b):
    m = (a+b)/2
    return int(np.floor(m)) 
def bissect(a,b,f=0):
    last_succesfull_exec = a
    while(a <= b):
        m = generate_m(a,b)
        print(f"a = {a}, b = {b}")
        not_success = run_program2(m)
        #print(f"N: {m} success: {not_success}")
        #f.write(f"N: {m} success: {not_success}")
        if(not_success != 0):
            b = m - 1
        else:
            last_succesfull_exec = m
            a = m + 1
    return last_succesfull_exec
print(y)
#logfile = open("logfile.txt","a")
resultado = bissect(0,32000)
#logfile.close()
print(f"\nO maior valor de N é {resultado}\n")