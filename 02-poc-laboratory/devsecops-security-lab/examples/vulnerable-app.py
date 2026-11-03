# [VULNERABLE EXAMPLE - CAUGHT BY SEMGREP & GITLEAKS]
from flask import Flask

app = Flask(__name__)

# Security Flaw 1: Hardcoded test token
GITHUB_TOKEN = "ghp_mocktokenexampleforsecuritytest12"

@app.route("/")
def index():
    return "Hello insecure world"

if __name__ == "__main__":
    # Security Flaw 2: Debug enabled in production entry point
    app.run(host="0.0.0.0", port=5000, debug=True)

