## Create and deploy services with Docker Compose
```bash
vi docker-compose.yaml
docker-compose up -d prometheus
docker-compose up -d grafana
docker-compose up -d grafana-dashboards
docker-compose up -d fastapi
docker ps


# test services
open http://127.0.0.1:8080/metrics # fastapi
open http://127.0.0.1:3000 # grafana > USER: ADMIN, PASSWORD: ADMIN
open http://127.0.0.1:9090 # prometheus

# run PromQL
- python_info
- scrape_duration_seconds

```

## Clean up
```bash
docker-compose down
colima delete
```