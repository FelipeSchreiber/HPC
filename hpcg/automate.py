import os
import numpy as np
import fnmatch

def write_datfile(nx):
    f = open("bin/hpcg.dat", "w")
    content = f"""HPCG benchmark input file
Sandia National Laboratories;
University of Tennessee, Knoxville
{nx} 104 104
120"""
    f.write(content)
    f.close()

def move_output_file(arch,nx):
    new_name = f"{arch}_{nx}.txt"
    for file in os.listdir('.'):
        if fnmatch.fnmatch(file, 'HPCG-Benchmark*'):
            os.rename(file,new_name)
            command = f"mv {new_name} ./outputs/"
            os.system(command)
            break

programs = ["GCC_OMP","Linux_Serial","Linux_MPI","MPI_GCC_OMP"]
nx = [16,64,128,256,512,1024,2048]
for program in programs:
    command = "make arch="+program
    os.system(command)
    for n in nx:
        write_datfile(n)
        command = "mpirun -np 2 bin/xhpcg"
        os.system(command)
        move_output_file(program,n)
        command = "rm -f *.txt"
        os.system(command)
    command = "make clean"
    os.system(command)