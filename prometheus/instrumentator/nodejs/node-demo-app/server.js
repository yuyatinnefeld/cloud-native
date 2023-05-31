'use strict';

const express = require('express');

// Constants
const PORT = 5000;
const HOST = '0.0.0.0';

// App
const app = express();

// swagger-stats for prometheus /swagger-stats/metrics endpoint
var swStats = require('swagger-stats');
app.use(swStats.getMiddleware({}));

app.get('/', (req, res) => {
  res.send('Hello World YT');
});

app.listen(PORT, HOST, () => {
  console.log(`Running on http://${HOST}:${PORT}`);
});
