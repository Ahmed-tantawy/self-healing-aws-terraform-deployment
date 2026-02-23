from flask import Flask
import os
import sys
import logging

app = Flask(__name__)

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(message)s",
)

@app.route("/")
def home():
    logging.info("Home endpoint accessed")
    return "Service is running!\n"

@app.route("/health")
def health():
    return {"status": "healthy"}, 200

@app.route("/crash")
def crash():
    logging.error("Crash endpoint triggered!")
    os._exit(1)  # Force container to stop

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)