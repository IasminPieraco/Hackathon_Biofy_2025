import requests

class Clima:
    def __init__(self, data, local):
        self.local = local
        url = f"https://nominatim.openstreetmap.org/search?q={local}&format=json"

        response = requests.get(url, headers={'User-Agent': 'Mozilla/5.0'})
        data2 = response.json()
        self.latitude = data2[0]["lat"]
        self.longitude = data2[0]['lon']
        self.temp_max = [data['forecast']['forecastday'][i]['day']['maxtemp_c'] for i in range(5)]
        self.temp_min = [data['forecast']['forecastday'][i]['day']['mintemp_c'] for i in range(5)]
        self.humidity = [data['forecast']['forecastday'][i]['day']['avghumidity']+10 for i in range(5)]

def setClima(endereco):
    apikey = "8b2e562792014eb9806174425253003"  # Sua chave de API
    url = f"https://api.weatherapi.com/v1/forecast.json?key={apikey}&q={endereco}&days=6"
    response = requests.get(url)

    if response.status_code == 200:
        data = response.json()
        newClima = Clima(data, endereco)  # Cria o objeto clima com dados de previsão
        return newClima
    else:
        return f"Erro: {response.status_code} - {response.json().get('error', {}).get('message', 'Erro desconhecido')}"
