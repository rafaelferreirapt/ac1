from os import listdir
from os.path import isfile, join

mypath = "."
extension = ".s"
line = "	# Rafael Ferreira https://github.com/gipmon/ac1\n"

onlyfiles = [f for f in listdir(mypath) if isfile(join(mypath,f)) and extension in f]

print onlyfiles

for f in onlyfiles:
    with file(f, 'r') as original: data = original.read()
    with file(f, 'w') as modified: modified.write(line + "\n" + data)
