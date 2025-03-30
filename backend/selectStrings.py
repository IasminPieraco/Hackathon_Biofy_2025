import AI
indices = ["Escaravelho-da-batata", "Lagarta-militar", "Mosca-branca", "Minador de folhas sul-americano", "Minador de folhas de vegetais"]

def getInsetos(endereco):
    ia = AI.IA(17, 10, 10, 0.1)
    ia.carregar_pesos_bias("pesos.txt")
    out = ia.prever(endereco)
    saida = []
    for i in range(5):
        if out[i*2] >= 0.1:
            if out[i*2+1]-0 > 1-out[i*2+1]:
                saida.append(f'{indices[i]} chegando na região')
            else:
                saida.append(f'{indices[i]} presentes na região')
    return saida

