import os
import sys
import base64
from classes.Prompts import Prompts
from OracleStorage import OracleObjectStorage
from OracleVisionAI import OracleVisionAI
from selectStrings import getInsetos
from flask import Flask, request, jsonify
import json


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

@app.route("/classify", methods=["POST"])
def classify():
    data = request.get_json()
    image_base64 = data.get("image_base64")
    
    imageData = base64.b64decode(image_base64)
    with open("temp_image.jpg", "wb") as file:
        file.write(imageData)
    
    if not image_base64:
        return jsonify({"error": "No image data provided"}), 400
    
    config_path = "C:\\Users\\vinic\\.oci\\config"
    profile = "DEFAULT"
    model_id = "ocid1.aivisionmodel.oc1.sa-vinhedo-1.amaaaaaaygpx5uqah35oneddik4salah7yqeykjlzfy5ibvzshqz4c5zgpqa"
    compartment_id = "ocid1.tenancy.oc1..aaaaaaaaqaxx44eeznnzf7ow5vmnqijyfsrafjukh4cfas3nkhiook4wlipa"
    ai_vision = OracleVisionAI(config_path, profile, model_id, compartment_id)
    # image = ai_vision.decode_and_display_base64(image_base64)
    results = ai_vision.classify_image("temp_image.jpg")
    # results = [
    #         {'name': 'Bacteria', 'confidence': 0.926},
    #         {'name': 'Fungos', 'confidence': 0.381},
    #         {'name': 'Saudavel', 'confidence': 0.093},
    #         {'name': 'Peste', 'confidence': 0.027},
    #     ]
    print(results)

    response_data = [{"category": item.name, "percentual": +(item.confidence )} for item in results]

    # Converte para JSON formatado
    return json.dumps(response_data, indent=2)

@app.route('/avisos')
def get_avisos():
    return getInsetos('Uberaba, Brasil')
    

@app.route('/database')
def get_images():
    storage = OracleObjectStorage(config_file='C:\\Users\\vinic\\.oci\\config')
    return storage.download_files('ocid1.tenancy.oc1..aaaaaaaaqaxx44eeznnzf7ow5vmnqijyfsrafjukh4cfas3nkhiook4wlipa','ocid1.bucket.oc1.sa-vinhedo-1.aaaaaaaatwgzwxf2qf7n7j7onidv6xn7dbdnzpy5aptzdwrhb76f5dl2gd5a')

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)