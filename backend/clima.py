import requests

class clima:
    def __init__(self, data, local):
        self.local = local
        response = requests.get(f"https://nominatim.openstreetmap.org/search?q={local}&format=json", headers={'User-Agent': 'Mozilla/5.0'})
        response = response.json()
        self.latitude = response[0]['lat']
        self.longitude = response[0]['lon']
        self.temp_max = [data['forecast']['forecastday'][i]['day']['maxtemp_c'] for i in range(5)]
        self.temp_min = [data['forecast']['forecastday'][i]['day']['mintemp_c'] for i in range(5)]
        self.temp_apparent_max = [data['forecast']['forecastday'][i]['day']['avgtemp_c']+5 for i in range(5)]
        self.temp_apparent_min = [data['forecast']['forecastday'][i]['day']['avgtemp_c']-5 for i in range(5)]
        self.humidity_max = [data['forecast']['forecastday'][i]['day']['avghumidity']-10 for i in range(5)]
        self.humidity_min = [data['forecast']['forecastday'][i]['day']['avghumidity']+20 for i in range(5)]

def setClima(endereco):
    apikey = "0dd942d7fe8f4b65881115030253003"  # Sua chave de API
    url = f"https://api.weatherapi.com/v1/forecast.json?key={apikey}&q={endereco}&days=6"
    response = requests.get(url)

    if response.status_code == 200:
        data = response.json()
        newClima = clima(data, endereco)  # Cria o objeto clima com dados de previsão
        return newClima
    else:
        return f"Erro: {response.status_code} - {response.json().get('error', {}).get('message', 'Erro desconhecido')}"
