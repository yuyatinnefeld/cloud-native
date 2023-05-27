from fastapi import FastAPI
from prometheus_client import make_asgi_app

from app.monitoring import instrumentator

# Create app
app = FastAPI(debug=False)
instrumentator.instrument(app).expose(app, include_in_schema=False, should_gzip=True)

# Add prometheus asgi middleware to route /metrics requests
metrics_app = make_asgi_app()
app.mount("/metrics", metrics_app)

@app.get("/")
def home():
    return {"response": "simple fastapi service"}


@app.post("/predict_train")
def predict():
    return {"response": "run predict train"}


@app.get("/predict_predict")
def predict():
    return {"response": "get predict result"}