## PromQL
- Prometheus Querying Language
- PromQL uses three data types: scalars, range vectors, and instant vectors.

## RED Method
- (Request) Rate - the number of requests, per second, you services are serving.
- (Request) Errors - the number of failed requests per second.
- (Request) Duration - distributions of the amount of time each request takes.

## Metric Types
- Counter: is cumulative metrics (going up always) and resets to zero though restart of server. you can use a counter to represent the number of requests served, tasks completed, or errors.
- Gauge: is an absolute metric that represents a single numerical value and can go up and down. e.g. current memory or cpu usage
- Histogramms: samples observations (e.g. request durations or response sizes) and counts them in configurable buckets
- Summaries: summary samples observations (e.g. request durations and response sizes)

## Service Monitors

- Service Monitors define a set of targets for prometheus to monitor and scrape
- Service Monitors allow you to avoid edditing prometheus configs directly and give you a DECLARATIVE k8s syntax to define targets



