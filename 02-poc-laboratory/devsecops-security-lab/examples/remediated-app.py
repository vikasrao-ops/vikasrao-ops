# [REMEDIATED EXAMPLE - PASSES ALL SECURITY GATES]
import os
from flask import Flask, jsonify

app = Flask(__name__)

# Remediated 1: Ambient environment injection (never hardcoded in source)
AUTH_TOKEN = os.getenv("GITHUB_TOKEN")

@app.route("/")
def index():
    return jsonify({"status": "secure", "debug": False})

if __name__ == "__main__":
    # Remediated 2: Debug mode disabled
    port = int(os.getenv("PORT", 8080))
    app.run(host="0.0.0.0", port=port, debug=False)

