/**
 * Enterprise Monolithic Application Service
 * Demonstrates Zero-Trust Managed Identity authentication to Azure Key Vault
 * and serves traffic behind Azure Application Gateway WAF v2.
 */

const http = require('http');
const { DefaultAzureCredential } = require('@azure/identity');
const { SecretClient } = require('@azure/keyvault-secrets');

const PORT = process.env.PORT || 8080;
const KEY_VAULT_URI = process.env.KEY_VAULT_URI;

let cachedSecrets = {
  dbPassword: 'LOADED_ON_DEMAND',
  jwtSecret: 'LOADED_ON_DEMAND',
  lastRefreshed: null
};

// Asynchronously load secrets from Azure Key Vault via Managed Identity
async function loadKeyVaultSecrets() {
  if (!KEY_VAULT_URI) {
    console.log('[WARN] KEY_VAULT_URI not configured. Operating in local fallback mode.');
    return;
  }

  try {
    const credential = new DefaultAzureCredential();
    const client = new SecretClient(KEY_VAULT_URI, credential);

    const dbSecret = await client.getSecret('database-password');
    const jwtSecret = await client.getSecret('jwt-secret-key');

    cachedSecrets.dbPassword = dbSecret.value ? '***ACTIVE_SECRET_RETRIEVED***' : 'EMPTY';
    cachedSecrets.jwtSecret = jwtSecret.value ? '***ACTIVE_SECRET_RETRIEVED***' : 'EMPTY';
    cachedSecrets.lastRefreshed = new Date().toISOString();
    console.log('[INFO] Successfully authenticated to Key Vault via Managed Identity Private Link.');
  } catch (err) {
    console.error('[ERROR] Failed retrieving Key Vault secrets:', err.message);
  }
}

// Initial secret warm-up
loadKeyVaultSecrets();

const server = http.createServer((req, res) => {
  const url = req.url;

  // Liveness & Readiness health probe for Application Gateway
  if (url === '/health' || url === '/ready') {
    res.writeHead(200, { 'Content-Type': 'application/json' });
    return res.end(JSON.stringify({
      status: 'UP',
      uptime_seconds: process.uptime(),
      timestamp: new Date().toISOString()
    }));
  }

  // Application diagnostic endpoint
  if (url === '/api/info') {
    res.writeHead(200, { 'Content-Type': 'application/json' });
    return res.end(JSON.stringify({
      application: 'Azure Landing Zone Monolith',
      environment: process.env.NODE_ENV || 'production',
      architecture: 'Hub-and-Spoke 3-Tier Enterprise Monolith',
      vault_integrated: Boolean(KEY_VAULT_URI),
      vault_status: cachedSecrets,
      security: {
        public_ip: 'NONE (Private App Subnet)',
        ingress: 'Azure Application Gateway WAF v2',
        credentials: 'Azure Managed Identity (Key Vault Secrets User)'
      }
    }));
  }

  // Default web landing
  res.writeHead(200, { 'Content-Type': 'application/json' });
  res.end(JSON.stringify({
    message: 'Welcome to Enterprise Monolithic Application on Azure Landing Zone',
    status: 'Running securely in private subnet',
    docs: '/api/info',
    health: '/health'
  }));
});

server.listen(PORT, '0.0.0.0', () => {
  console.log(`[START] Monolith server listening on port ${PORT}`);
});
