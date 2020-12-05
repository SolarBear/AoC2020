fichier = open("input3.txt")

lignes = fichier.readlines()
lignes = lignes[1:]

compteur = 0
position = 0
max = 31

for ligne in lignes:
    position = position + 3
    if position >= max:
        position -= max

    if ligne[position] == "#":
        compteur += 1

print("compteur " + str(compteur))