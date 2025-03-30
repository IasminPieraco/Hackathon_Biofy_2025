import json

class Prompts:
    def __init__(self, praga, temInfestacao, output):
        self.praga = praga
        self.temInfestacao = temInfestacao
        self.output = output

    def __str__(self):
        return f"Praga: {self.praga}, Tem Infestação: {self.temInfestacao}, Output: {self.output}"

    # Método para salvar os dados do objeto no arquivo de texto
    def salvar_em_arquivo(self, arquivo):
        # Convertendo o objeto para um dicionário
        dados = {
            'praga': self.praga,
            'temInfestacao': self.temInfestacao,
            'output': self.output
        }
        # Salvando os dados no arquivo em formato JSON
        with open('database/'+arquivo, 'w') as f:
            json.dump(dados, f, indent=4)

    # Método para ler os dados de um arquivo e criar um novo objeto
    @classmethod
    def ler_do_arquivo(cls, arquivo):
        try:
            with open(arquivo, 'r') as f:
                dados = json.load(f)
                # Criando o objeto a partir dos dados lidos
                return cls(dados['praga'], dados['temInfestacao'], dados['output'])
        except FileNotFoundError:
            print(f"Erro: O arquivo {arquivo} não foi encontrado.")
            return None
        except json.JSONDecodeError:
            print("Erro: O arquivo não contém dados válidos.")
            return None