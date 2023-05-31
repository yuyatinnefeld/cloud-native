# PromQL

- Cheat Sheet: https://promlabs.com/promql-cheat-sheet/
- Examples: https://prometheus.io/docs/prometheus/latest/querying/examples/
## Metric Types
- counters
- gauges
- histograms
- summaries

## Data Types
- PromQL subsequently has four data types: Floats (mostly scalars), Range vectors, Instant vectors, Time
- Floats Exp: `prometheus_http_requests_total{code=~"2.*", job="prometheus"}`
- Instant Exp: `some_key {some_label="THATLABEL",another_label="THISLABEL"} [#value]` like `http_total_requests{job=”prometheus”, method=”post”, code=”404”} [5m]`
- Range Exp: `<<metric name>>{<<label>>=”<<value>>”}[duration]` like `node_scrape_collector_duration_seconds{job=”node”}[2m]`

## PromQL Operators

### Arithmetic Operators

```bash
+ (add)
– (subtract)
* (multiply)
/ (divide)
% (percentage)
^ (exponents)
```

### Comparison Binary Operators

```bash
== (equal to)
!= (does not equal)
> (greater than)
< (less than)
>= (greater than or equal to)
<= (less than or equal to)
```

### Aggregation Operators

```bash
sum 
avg
min 
max
group 
count 
count_values 
topk (k = the number of elements; this selects the largest values among those elements)
bottomk (like topk but for lowest values)
quantile (calculate a quantile over dimensions)
stddev (standard deviation over dimensions)
stdvar (standard variance over dimensions)
```

### PromQL Functions
```bash
abs(instant-vector)
absent(instant-vector)
absent_over_time(range-vector)
ceil(instant-vector)
changes(range-vector)
clamp_max(instant-vector, scalar)
clamp_min(instant-vector, scalar)
day_of_month(some vector(time()) instant-vector)
day_of_week(some vector(time()) instant-vector)
days_in_month(some vector(time()) instant-vector)
delta(range-vector) #for use with gauge metrics
deriv(range-vector) #for use with gauge metrics
exp(instant-vector)
floor(instant-vector)
histogram_quantile(scalar, instant-vector)
holt_winters(range-vector, scalar, scalar)
hour(some vector(time()) instant-vector)
idelta(range-vector)
increase(range-vector)
irate(range-vector)
label_join()
label_replace()
ln(instant-vector)
log2(instant-vector)
log10(instant-vector)
minute(some vector(time()) instant-vector)
month(some vector(time()) instant-vector)
predict_linear() #for use with gauge 
rate(range-vector)
resets(range-vector) #for use with counter metrics
round((instant-vector, to_nearest=## scalar)
scalar(instant-vector)
sort(instant-vector)
sort_desc()
sqrt(instant-vector)
time()
timestamp(instant-vector)
vector()
year(some vector(time()) instant-vector)
avg_over_time(range-vector)
min_over_time(range-vector)
max_over_time(range-vector)
sum_over_time(range-vector)
count_over_time(range-vector)
quantile_over_time(scalar, range-vector) #φ-quantile (0 ≤ φ ≤ 1) of an interval’s values
stddev_over_time(range-vector) #standard deviation
stdvar_over_time(range-vector) #standard variance
```
