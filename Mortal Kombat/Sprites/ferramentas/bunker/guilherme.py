import os
import subprocess
FOLDER_PATH = 'C:/Users/lucas/Documents/Programação/JoaoKombat/Mortal Kombat/Sprites/ferramentas/bunker'

os.chdir(FOLDER_PATH)
imgNames = os.listdir(FOLDER_PATH)

for imgNames in imgNames:
    if imgNames[-1] == 'g':
        imgNames = imgNames[:-4]
        x = 'png2bmpcmd -i ' + imgNames + '.png --bmp-bpp=24'
        print(x)
        os.system(x)

        x = 'del '  + imgNames + '.png'
        os.system(x)

f = open("list.txt", 'w')

x = 'mkdir imagens'
os.system(x)

imgNames = os.listdir(FOLDER_PATH)

for imgNames in imgNames:
    if imgNames[-1] == 'p':
        imgNames = imgNames[:-4]
        x = 'bmp2isc ' + imgNames
        print(x)
        os.system(x)

        x = 'rename ' + imgNames + ".data " + imgNames + 'N.s'
        os.system(x)

        x = 'move ' + imgNames + '.bmp imagens'
        os.system(x)

        f.write(imgNames + 'N.s\n')

f.close()

x = "resizer"
os.system(x)

f = open("list.txt", "r")

text = f.read()
text = text.strip().split('\n')
newText = []

x = 'mkdir S'
os.system(x)

for archive in text:
    x = 'del ' + archive
    os.system(x)
    temp = archive.rsplit('N')
    x = 'move ' + ''.join(temp) + ' S'
    os.system(x)

f.close()

x = 'del list.txt'
os.system(x)