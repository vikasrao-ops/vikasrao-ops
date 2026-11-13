const http = require('http');

const PORT = process.env.PORT || 8080;

const server = http.createServer((req, res) => {
  if (req.url === '/health' || req.url === '/ready') {
    res.writeHead(200, { 'Content-Type': 'application/json' });
    return res.end(JSON.stringify({ status: 'HEALTHY', timestamp: new Date().toISOString() }));
  }

  if (req.url === '/api/v1/orders') {
    res.writeHead(200, { 'Content-Type': 'application/json' });
    return res.end(JSON.stringify({
      service: 'orders-microservice',
      pod: process.env.HOSTNAME || 'local-pod',
      orders: [
        { id: 'ORD-101', status: 'PROCESSING', total: 149.99 },
        { id: 'ORD-102', status: 'COMPLETED', total: 89.50 }
      ]
    }));
  }

  res.writeHead(200, { 'Content-Type': 'application/json' });
  res.end(JSON.stringify({ microservice: 'Orders API Gateway', platform: 'AKS Microservices Pipeline' }));
});

if (require.main === module) {
  server.listen(PORT, '0.0.0.0', () => {
    console.log(`Orders microservice listening on port ${PORT}`);
  });
}

module.exports = server;
