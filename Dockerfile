FROM python:3.11-slim-bullseye

WORKDIR /app

RUN apt-get update && apt-get install -y git && pip install poetry

RUN git clone https://github.com/mhdzumair/mediaflow-proxy.git .

RUN poetry config virtualenvs.create false && poetry install --no-root --no-dev

EXPOSE 10000
# Render usa la variabile d'ambiente $PORT, non una porta fissa
CMD ["poetry", "run", "uvicorn", "mediaflow_proxy.main:app", "--host", "0.0.0.0", "--port", "${PORT:-10000}"]
