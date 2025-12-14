import functions_framework
import requests
from google.cloud import pubsub_v1
import json
import datetime

publisher = pubsub_v1.PublisherClient()
topic_path = publisher.topic_path("mgmt-467-471819", "weather_stream")

@functions_framework.http
def stream_weather(request):
    url = (
        "https://api.open-meteo.com/v1/forecast?"
        "latitude=38.7223&longitude=-9.1393&"
        "current=temperature_2m,precipitation,wind_speed_10m"
    )

    r = requests.get(url)
    data = r.json()

    payload = {
        "timestamp": datetime.datetime.utcnow().isoformat(),
        "city": "Lisbon",
        "temperature": data["current"]["temperature_2m"],
        "precipitation": data["current"]["precipitation"],
        "wind_speed": data["current"]["wind_speed_10m"]
    }

    publisher.publish(
        topic_path,
        json.dumps(payload).encode("utf-8")
    )

    return "Lisbon weather published"
