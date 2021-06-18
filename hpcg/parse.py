import os
import re

def get_gflops(file):
    with open(file) as fp:
        for i, line in enumerate(fp):
            if str(line).find("GFLOP/s rating") != -1:
                return line.split("=")[1]
with open("performance.csv","w") as p:
    for file in os.listdir('./outputs'):
        gflops = get_gflops('./outputs/'+file)
        print(gflops)
        match = re.match(r"([a-zA-Z_]+)([0-9]+)(.txt)",file, re.I)
        if match:
            items = match.groups()
            new_line = f"{items[0]},{items[1]},{gflops}"
            p.write(new_line)

