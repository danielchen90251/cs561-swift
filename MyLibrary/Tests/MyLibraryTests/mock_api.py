from fastapi import FastAPI
import json
app = FastAPI()
@app.get("/data/2.5/weather/lat={lat}&lon={lon}&appid={apikey}")
async def root():
    weather_json_string ={
    "coord": {
        "lon": -123.2722,
        "lat": 44.5904
    },
    "weather": [
        {
        "id": 800,
        "main": "Clear",
        "description": "clear sky",
        "icon": "01d"
        }
    ],
    "base": "stations",
    "main": {
        "temp": 293.68,
        "feels_like": 293.49,
        "temp_min": 292,
        "temp_max": 295.18,
        "pressure": 1008,
        "humidity": 65
    },
    "visibility": 10000,
    "wind": {
        "speed": 3.58,
        "deg": 360,
        "gust": 6.26
    },
    "clouds": {
        "all": 1
    },
    "dt": 1664646106,
    "sys": {
        "type": 2,
        "id": 2005452,
        "country": "US",
        "sunrise": 1664633458,
        "sunset": 1664675656
    },
    "timezone": -25200,
    "id": 5720727,
    "name": "Corvallis",
    "cod": 200
    }
    return weather_json_string


# uvicorn mock_api:app --reload