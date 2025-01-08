FROM python:3.9-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

RUN apt-get update && apt-get install -y \
    git \
    git-lfs \
    && git lfs install \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . /app

RUN git lfs pull

RUN pip install --no-cache-dir -r requirements.txt

RUN chmod +x setup.sh

EXPOSE 8501

CMD ["streamlit", "run", "app.py", "--server.port", "$PORT", "--server.headless", "true"]
