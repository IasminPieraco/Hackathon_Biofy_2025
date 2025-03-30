import numpy as np
import Clima

class IA:
    def __init__(self, entradas, ocultas, saidas, taxa_aprendizado=0.01):
        self.entradas = entradas
        self.ocultas = ocultas
        self.saidas = saidas
        self.taxa_aprendizado = taxa_aprendizado
        
        self.pesos_ih = np.random.uniform(-0.5, 0.5, (ocultas, entradas))
        self.pesos_ho = np.random.uniform(-0.5, 0.5, (saidas, ocultas))
        
        self.bias_oculta = np.random.uniform(-0.5, 0.5, (ocultas, 1))
        self.bias_saida = np.random.uniform(-0.5, 0.5, (saidas, 1))
    
    def sigmoid(self, x):
        x = np.clip(x, -500, 500)
        return 1 / (1 + np.exp(-x))
    
    def dsigmoid(self, y):
        return y * (1 - y)
    
    def treinar(self, entrada, alvo):
        entrada = np.array(entrada, ndmin=2).T
        alvo = np.array(alvo, ndmin=2).T
        
        # Forward
        entrada_oculta = np.dot(self.pesos_ih, entrada) + self.bias_oculta
        saida_oculta = self.sigmoid(entrada_oculta)
        
        entrada_saida = np.dot(self.pesos_ho, saida_oculta) + self.bias_saida
        saida_final = self.sigmoid(entrada_saida)
        
        # Erro
        erro_saida = alvo - saida_final
        gradiente_saida = self.dsigmoid(saida_final) * erro_saida * self.taxa_aprendizado
        
        erro_oculta = np.dot(self.pesos_ho.T, erro_saida)
        gradiente_oculta = self.dsigmoid(saida_oculta) * erro_oculta * self.taxa_aprendizado
        
        # Atualização dos pesos
        self.pesos_ho += np.dot(gradiente_saida, saida_oculta.T)
        self.bias_saida += gradiente_saida
        
        self.pesos_ih += np.dot(gradiente_oculta, entrada.T)
        self.bias_oculta += gradiente_oculta
    
    def prever(self, endereco):
        clima = Clima.setClima(endereco)

        entrada = [[clima.temp_min[0]], [clima.temp_min[1]], [clima.temp_min[2]], [clima.temp_min[3]], [clima.temp_min[4]], 
                   [clima.temp_max[0]], [clima.temp_max[1]], [clima.temp_max[2]], [clima.temp_max[3]], [clima.temp_max[4]],
                   [clima.humidity[0]], [clima.humidity[1]], [clima.humidity[2]], [clima.humidity[3]], [clima.humidity[4]],
                   [clima.latitude] , [clima.longitude]]

        entrada = np.array(entrada, dtype=np.float32, ndmin=2)

        entrada_oculta = np.dot(self.pesos_ih, entrada) + self.bias_oculta
        saida_oculta = self.sigmoid(entrada_oculta)
        
        entrada_saida = np.dot(self.pesos_ho, saida_oculta) + self.bias_saida
        saida_final = self.sigmoid(entrada_saida)
        
        return saida_final.flatten()
    
    def preverTest(self, entrada):

        entrada = np.array(entrada, dtype=np.float32, ndmin=2).T

        entrada_oculta = np.dot(self.pesos_ih, entrada) + self.bias_oculta
        saida_oculta = self.sigmoid(entrada_oculta)
        
        entrada_saida = np.dot(self.pesos_ho, saida_oculta) + self.bias_saida
        saida_final = self.sigmoid(entrada_saida)
        
        return saida_final.flatten()
    
    def guarda(self):
        with open("pesos.txt", "w") as arquive:
            arquive.write(f"{len(self.pesos_ho)} {len(self.pesos_ho[0])}\n")
            for i in self.pesos_ho:
                for j in i:
                    arquive.write(f'{j} ')
                arquive.write("\n")
            arquive.write(f"{len(self.pesos_ih)} {len(self.pesos_ih[0])}\n")
            for i in self.pesos_ih:
                for j in i:
                    arquive.write(f'{j} ')
                arquive.write("\n")
            arquive.write(f"{len(self.bias_oculta)}\n")
            for i in self.bias_oculta:
                arquive.write(f'{i[0]} ')
            arquive.write(f"\n{len(self.bias_saida)}\n")
            for i in self.bias_saida:
                arquive.write(f'{i[0]} ')

    def carregar_pesos_bias(self, caminho_arquivo):
        with open(caminho_arquivo, 'r') as f:
            linhas = f.readlines()
        
        index = 0

        # Carregar pesos da camada de saída
        saidas, ocultas = map(int, linhas[index].split())
        index += 1
        self.pesos_ho = np.array([list(map(float, linhas[i].split())) for i in range(index, index + saidas)])
        index += saidas

        # Carregar pesos da camada oculta
        ocultas, entradas = map(int, linhas[index].split())
        index += 1
        self.pesos_ih = np.array([list(map(float, linhas[i].split())) for i in range(index, index + ocultas)])
        index += ocultas

        # Carregar bias da camada oculta
        self.bias_oculta = np.array([float(x) for x in linhas[index].split()]).reshape(-1, 1)
        index += 2  # Pula a linha em branco

        # Carregar bias da camada de saída
        self.bias_saida = np.array([float(x) for x in linhas[index].split()]).reshape(-1, 1)

# Criando a Rede Neural
# AI = IA(17, 10, 10, 0.1)

# # Listas para armazenar dados
# inputVal = []
# outputVal = []
# inputTest = []
# outputTest = []

# # Carregamento dos Dados de Entrada
# count = 0
# with open("InputFim.txt", "r", encoding="utf-8") as arquivo:
#     for linha in arquivo:
#         valores = list(map(float, linha.strip().split()))
#         if count < 1500:
#             inputVal.append(valores)
#         else:
#             inputTest.append(valores)
#         count += 1
 
# # Carregamento dos Dados de Saída
# count = 0
# with open("OutputFim.txt", "r", encoding="utf-8") as arquivo:
#     for linha in arquivo:
#         valores = list(map(float, linha.strip().split()))
#         if count < 1500:
#             outputVal.append(valores)
#         else:
#             outputTest.append(valores)
#         count += 1

# # Normalização dos Dados (Opcional, mas recomendável)
# inputVal = np.array(inputVal) / np.max(inputVal)
# inputTest = np.array(inputTest) / np.max(inputTest)

# # Loop de Treinamento até atingir 90% de acurácia

# acc = 0
# try:
#     while acc < 1:

#         for i in range(len(inputVal)):
#             AI.treinar(inputVal[i], outputVal[i])
#         acc = 0
#         count = 0
        
#         for i in range(len(inputTest)):
#             out = AI.preverTest(inputTest[i])

#             for j in range(10):
#                 acc += 1 - np.abs(out[j] - outputTest[i][j])  # Corrigindo índice

#             count += 1

#         acc /= count * 10  # Média da acurácia
#         print(f"Acurácia: {acc:.4f}")
# except:
#     print("exit")

# # AI.carregar_pesos_bias("backend/pesos.txt")

# # print(AI.prever("Uberaba, Brasil"))

# AI.guarda()

# # Teste Interativo
# while True:
#     try:
#         ina = int(input("Digite um índice para prever (-1 para sair): "))
#         if ina == -1:
#             break
#         print(inputVal[ina])
#         print("Saída prevista:", AI.preverTest(inputVal[ina]))
#     except Exception as e:
#         print("Erro:", e)
