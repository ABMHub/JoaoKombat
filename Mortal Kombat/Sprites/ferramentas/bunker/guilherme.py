import os
import subprocess
FOLDER_PATH = 'C:/Users/lucas/Documents/Programação/JoaoKombat/Mortal Kombat/Sprites/ferramentas/bunker'

os.chdir(FOLDER_PATH)
imgNames = os.listdir(FOLDER_PATH)
print(os.getcwd())

# x = 'mkdir bmp'
# print(x)
# os.system(x)

x = 'mkdir S'
print(x)
os.system(x)

for imgNames in imgNames:
    if imgNames[-1] == 'p':
        imgNames = imgNames[:-4]
        x = 'bmp2oac2 ' + imgNames
        print(x)
        os.system(x)

        x = 'del ' + imgNames + '.mif'
        print(x)
        os.system(x)

        x = 'del ' + imgNames + '.bin'
        print(x)
        os.system(x)

        x = 'move ' + imgNames + '.s S'
        print(x)
        os.system(x)