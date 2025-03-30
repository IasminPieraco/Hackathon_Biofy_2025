indices = ["Bacteria", "Fungi", "Nematode", "Pest", "Phytopthora", "Virus"]

defaut_pic = ["Foto da parte de cima da folha de forma mais aproximada", "Foto da parte superior da planta tentando pegar o máximo de folhas",
"Foto do caule lateralmente, de forma mais aproximada", "Foto da lateral do caule, de forma mais aproximada", "Foto da lateral do caule, de forma mais afastada",
"Foto da parcela inicial da raiz"]

extra = [["Foto da parte inferior da folha de forma aproximada", "Foto do ramo que conecta a folha ao caule",
"Foto da lateral de folha", "Foto do solo próximo a raiz", "Foto da raiz após suave escavação"], ["Foto da parte inferior da folha de forma aproximada", 
"Foto do ramo que conecta a folha ao caule"], ["Foto da lateral de folha"], ["Fotos da parte de cima das folhas aproximadas", "Fotos da parte de baixo das folhas aproximadas", 
"Foto do ramo que conecta a folha ao caule", "Foto da raiz após escavação suave", "Foto do caule mais aproximada"], ["Foto da lateral de folha"], ["Foto da lateral de folha"]]

def getPics(plagues):
    pic = defaut_pic
    for i in plagues:
        for j in extra[indices.index(i)]:
            pic.append(j)
    return pic
