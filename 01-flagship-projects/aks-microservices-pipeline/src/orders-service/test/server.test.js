const test = require('node:test');
const assert = require('node:assert');
const server = require('../server');

test('Orders Microservice Health Checks', async (t) => {
  await new Promise((resolve) => server.listen(8089, resolve));

  await t.test('GET /health returns HTTP 200 HEALTHY', async () => {
    const res = await fetch('http://localhost:8089/health');
    assert.strictEqual(res.status, 200);
    const body = await res.json();
    assert.strictEqual(body.status, 'HEALTHY');
  });

  server.close();
});
