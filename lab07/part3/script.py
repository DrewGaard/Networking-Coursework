import subprocess

count = 0
size = 256
size2 = 256

while(count < 16):
        if(count >= 8):
            subprocess.call('./matrix_math 2 ' + format(size2), shell=True)
            size2 = size2 + 256
            count = count + 1
        else:
            subprocess.call('./matrix_math 1 ' + format(size), shell=True)
            size = size + 256
            count = count + 1

