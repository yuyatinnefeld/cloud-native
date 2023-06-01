# Simple Prometheus Setup Guide

## Use Prometheus
```bash
# go into setup dir
cd stepup

# start servers
docker-compose up

 # create metrics
open http://localhost:9100/metrics

# open prometheus
open http://localhost:9090/targets

# stop
docker-compose down
```

## Add Alert Rule
```bash
# go alert rule dir
cd alert-rule

# create rules
vi rules.yml

# update prometheus file
vi prometheus.yml

# update docker-compose file
vi docker-compose.yml

# restart docker
docker-compose up -d

# verify alert
open http://localhost:9090/alerts

# test alert
docker stop exporter
open http://localhost:9090/alerts
# Status: INACTIVE > FIRING

# stop
docker-compose down
```

## Add Alertmanager
```bash
cd alertmanager

# add alertmanager prometheus.yml
vi prometheus.yml

# add alertmanager server
vi docker-compose.yml

# start all servers
docker-compose up -d

# stop exporter to check alerting
docker stop exporter

# check alert status
open http://localhost:9090/alerts

# check alertmanager
open http://localhost:9093/#/alerts

docker-compose down
```

## Use PushGateway
```bash
cd pushgateway

# run prometheus
docker-compose up -d

# run python app to push message
python app.py

# open prometheus and check batch job
open http://localhost:9091/
```