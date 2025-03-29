import requests

class clima:
    def __init__(self, data, local):
        self.local = local
        self.temp_max = data['daily']['temperature_2m_max']
        self.temp_min = data['daily']['temperature_2m_min']
        self.precipitation = data['daily']['precipitation_sum']
        self.temp_apparent_max = data['daily']['apparent_temperature_max']
        self.temp_apparent_min = data['daily']['apparent_temperature_min']
        self.humidity_max = data['daily']['relative_humidity_2m_max']
        self.humidity_min = data['daily']['relative_humidity_2m_min']

def setClima(endereco):
    url = f"https://nominatim.openstreetmap.org/search?q={endereco}&format=json"

    response = requests.get(url, headers={'User-Agent': 'Mozilla/5.0'})
    data = response.json()

    if data:
        latitude = data[0]["lat"]
        longitude = data[0]["lon"]

        url = f"https://api.open-meteo.com/v1/forecast?latitude={latitude}&longitude={longitude}&past_days=3&forecast_days=2&daily=temperature_2m_max,temperature_2m_min,precipitation_sum,apparent_temperature_max,apparent_temperature_min,relative_humidity_2m_max,relative_humidity_2m_min&timezone=auto"
        response = requests.get(url)
        data = response.json()

        newClima = clima(data, endereco)
        return newClima
    else:
        return "ERROR - Address not found!"

test = setClima("Uberaba, Brasil")