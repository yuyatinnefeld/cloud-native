from fastapi import FastAPI
from prometheus_client import CollectorRegistry, make_asgi_app

# Create app
app = FastAPI(debug=False)

# Add prometheus asgi middleware to route /metrics requests
metrics_app = make_asgi_app()
app.mount("/metrics", metrics_app)

@app.get("/")
def home():
    return {"response": "hello world"}
