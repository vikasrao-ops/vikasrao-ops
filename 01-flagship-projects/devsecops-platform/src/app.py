import os
from flask import Flask, jsonify

app = Flask(__name__)

# Enforce secure application configuration
app.config["ENV"] = os.getenv("ENVIRONMENT", "production")

@app.route("/", methods=["GET"])
def root():
    return jsonify({
        "service": "devsecops-secure-api",
        "status": "operational",
        "version": "1.0.0",
        "framework": "flask"
    }), 200

@app.route("/healthz", methods=["GET"])
def healthz():
    return jsonify({"status": "healthy"}), 200

@app.route("/readyz", methods=["GET"])
def readyz():
    return jsonify({"status": "ready"}), 200

@app.after_request
def apply_security_headers(response):
    response.headers["X-Content-Type-Options"] = "nosniff"
    response.headers["X-Frame-Options"] = "DENY"
    response.headers["X-XSS-Protection"] = "1; mode=block"
    response.headers["Strict-Transport-Security"] = "max-age=31536000; includeSubDomains"
    return response

if __name__ == "__main__":
    port = int(os.getenv("PORT", 8080))
    app.run(host="0.0.0.0", port=port)

