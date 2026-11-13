const test = require('node:test');
const assert = require('node:assert');
const http = require('node:http');
const server = require('../server');

test('API Service Integration Tests', async (t) => {
  await new Promise((resolve) => server.listen(8081, resolve));

  await t.test('GET /health returns HTTP 200 with UP status', async () => {
    const res = await fetch('http://localhost:8081/health');
    assert.strictEqual(res.status, 200);
    const body = await res.json();
    assert.strictEqual(body.status, 'UP');
  });

  await t.test('Response includes enterprise security headers', async () => {
    const res = await fetch('http://localhost:8081/health');
    assert.strictEqual(res.headers.get('x-content-type-options'), 'nosniff');
    assert.strictEqual(res.headers.get('x-frame-options'), 'DENY');
  });

  server.close();
});
