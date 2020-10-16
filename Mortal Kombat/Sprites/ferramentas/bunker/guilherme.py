import os
import subprocess
FOLDER_PATH = 'C:/Users/lucas/Documents/Programação/JoaoKombat/Mortal Kombat/Sprites/ferramentas/bunker'

os.chdir(FOLDER_PATH)
imgNames = os.listdir(FOLDER_PATH)

f = open("list.txt", 'w')

print(imgNames)

for imgNames in imgNames:
    if imgNames[-1] == 'p':
        imgNames = imgNames[:-4]
        x = 'bmp2oac2 ' + imgNames
        os.system(x)

        x = 'del ' + imgNames + '.mif'
        os.system(x)

        x = 'del ' + imgNames + '.bin'
        os.system(x)

        x = 'rename ' + imgNames + ".s " + imgNames + 'N.s'
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
    print(x)
    os.system(x)
    temp = archive.rsplit('N')
    x = 'move ' + ''.join(temp) + ' S'
    print(x)
    os.system(x)

f.close()
# x = 'move list.txt S'
# print(x)
# os.system(x)
