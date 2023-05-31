from fastapi import FastAPI
from prometheus_client import make_asgi_app, Counter, Gauge, Histogram, Summary

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


@app.get("/counter")
def test_prom_counter():
    c = Counter('my_failures', 'Description of counter')
    c.inc()     # Increment by 1
    c.inc(1.6)  # Increment by given value
    return {"response": "created prometheus counter"}


@app.get("/gauge")
def test_prom_gauge():
    g = Gauge('my_inprogress_requests', 'Description of gauge')
    g.inc()      # Increment by 1
    g.dec(10)    # Decrement by given value
    g.set(4.2)   # Set to a given value
    return {"response": "create prometheus gauge"}


@app.get("/histogram")
def test_prom_histogram():
    h = Histogram('my_request_latency_seconds', 'Description of histogram')
    h.observe(4.7)    # Observe 4.7 (seconds in this case)
    return {"response": "created prometheus histogram"}


@app.get("/summary")
def test_prom_summary():
    s = Summary('my_request_latency_seconds', 'Description of summary')
    s.observe(4.7)    # Observe 4.7 (seconds in this case)
    return {"response": "created prometheus summary"}


@app.post("/predict_train")
def predict():
    return {"response": "run predict train"}


@app.get("/predict_predict")
def predict():
    return {"response": "get predict result"}
