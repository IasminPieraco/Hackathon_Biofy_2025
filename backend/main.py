import os
import sys
from classes.Prompts import Prompts
from flask import Flask


# def main():
#     prompt = Prompts(
#         praga="Praga Teste",
#         temInfestacao=True,
#         output="Resultado Teste"
#     )
#     prompt.salvar_em_arquivo("prompt.json")
#     prompt_lido = Prompts.ler_do_arquivo("prompt.json")
#     if prompt_lido:
#         print(prompt_lido)
#     else:
#         print("Falha ao ler o arquivo.")

# if __name__ == "__main__":
#     main()
#     sys.exit(main())

app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Olá, Mundo!'

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)