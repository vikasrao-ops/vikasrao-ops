const http = require('http');

const PORT = process.env.PORT || 8080;

const server = http.createServer((req, res) => {
  // Security response headers
  res.setHeader('X-Content-Type-Options', 'nosniff');
  res.setHeader('X-Frame-Options', 'DENY');
  res.setHeader('Content-Security-Policy', "default-src 'self'");
  res.setHeader('Strict-Transport-Security', 'max-age=31536000; includeSubDomains');

  if (req.url === '/health' || req.url === '/ready') {
    res.writeHead(200, { 'Content-Type': 'application/json' });
    return res.end(JSON.stringify({
      status: 'UP',
      service: 'enterprise-api-service',
      timestamp: new Date().toISOString()
    }));
  }

  if (req.url === '/api/v1/data') {
    res.writeHead(200, { 'Content-Type': 'application/json' });
    return res.end(JSON.stringify({
      message: 'Secure data payload',
      pipeline: 'Enterprise DevSecOps Automation',
      scanners: ['Gitleaks', 'SonarQube', 'Aqua Trivy', 'OWASP ZAP']
    }));
  }

  res.writeHead(200, { 'Content-Type': 'application/json' });
  res.end(JSON.stringify({
    service: 'Enterprise DevSecOps API Gateway',
    version: '1.0.0',
    status: 'Operational'
  }));
});

if (require.main === module) {
  server.listen(PORT, '0.0.0.0', () => {
    console.log(`Server listening securely on port ${PORT}`);
  });
}

module.exports = server;
