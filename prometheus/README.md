# Prometheus

## Architecture and Components
![Screenshot](pics/architecture.png)


## Reference 
- https://github.com/prometheus-community/helm-charts

## About
Prometheus collects and stores its log-metrics as time series data, i.e. metrics information is stored with the timestamp at which it was recorded, alongside optional key-value pairs called labels.

## Main Components (Severs)
- Data Retrieval Worker (for Pulling metrics)
- Time Series Database (for Storing metrics)
- HTTP Server (for Accepting PromQL queries / Connect to visualizataion tools like Grafana)

## What does Prometheus monitor?
- Linux / Windows Server
- Apache Server
- Single Application
- Database Service

## Which metrics are monitored?
- CPU Status
- Memory/Disk Space Usage
- Requests Counts
- Exeptions Count
- Request Duration

## Pros and Cons
- Stand-alone and self-containing / Limits monitoring
- Reliable / Difficult to scale
- Less complex

## Getting Started

## Setup Prometheus

`/install`

## Setup Grafana

`/grafana`

## Scrape Applications with Exporter

`/mongodb`

`/fastapi`