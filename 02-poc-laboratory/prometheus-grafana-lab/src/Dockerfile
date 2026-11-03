FROM python:3.12-alpine
WORKDIR /app
RUN pip install --no-cache-dir prometheus-client
COPY metrics_emitter.py .
EXPOSE 8000
CMD ["python", "metrics_emitter.py"]

